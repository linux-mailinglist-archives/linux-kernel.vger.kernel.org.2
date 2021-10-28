Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F9743E012
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 13:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhJ1LgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 07:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1LgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 07:36:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C4AC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 04:33:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hg3NT1vVDz4xcC;
        Thu, 28 Oct 2021 22:33:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1635420825;
        bh=dNBPnTjY2RMV8vvPnvLBDtkCIfy9AbEEaneixRpTWmc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QKN5eSRVBHfkEVM+nW8dztlahss6nugvVcm+BHbwJvsfUP1RrZks+nKGq+w9SVCXi
         IBGf3YlJVUxZ7Z/7voMkve5GpvRlSTAWUfzHAaBepeCYuxM0FJM8YQKR9CDGUR8VXA
         Kvvc4E0MrkkSjimdujKUvxAuuYaqdrxDeUstDKVuPNZqscEWsLDmCcxtqhKqYUTch2
         ZE0nJ+ITYzmjyCOmWUJB2vfZyN49u8NstOABAeO6A9HBiYK+NyOtQ0IwA+ogfUa8SX
         yG2dVSt46VCKd801nWUzc9s8e2Cc6ZOv7N5Cfrma634+jaQQepiWAwTt3hRIV7PIGj
         VI25QXhJZKZbA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/book3e: Fix set_memory_x() and set_memory_nx()
In-Reply-To: <063e72e1-fc05-7783-9f42-f681dd08a4b2@csgroup.eu>
References: <922bdab3a220781bae2360ff3dd5adb7fe4d34f1.1635226743.git.christophe.leroy@csgroup.eu>
 <c41100f9c144dc5b62e5a751b810190c6b5d42fd.1635226743.git.christophe.leroy@csgroup.eu>
 <1635309296.3vv9pb80wz.astroid@bobo.none>
 <063e72e1-fc05-7783-9f42-f681dd08a4b2@csgroup.eu>
Date:   Thu, 28 Oct 2021 22:33:40 +1100
Message-ID: <871r459yej.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 27/10/2021 =C3=A0 06:44, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Excerpts from Christophe Leroy's message of October 26, 2021 3:39 pm:
>>> set_memory_x() calls pte_mkexec() which sets _PAGE_EXEC.
>>> set_memory_nx() calls pte_exprotec() which clears _PAGE_EXEC.
>>>
>>> Book3e has 2 bits, UX and SX, which defines the exec rights
>>> resp. for user (PR=3D1) and for kernel (PR=3D0).
>>>
>>> _PAGE_EXEC is defined as UX only.
>>>
>>> An executable kernel page is set with either _PAGE_KERNEL_RWX
>>> or _PAGE_KERNEL_ROX, which both have SX set and UX cleared.
>>>
>>> So set_memory_nx() call for an executable kernel page does
>>> nothing because UX is already cleared.
>>>
>>> And set_memory_x() on a non-executable kernel page makes it
>>> executable for the user and keeps it non-executable for kernel.
>>>
>>> Also, pte_exec() always returns 'false' on kernel pages, because
>>> it checks _PAGE_EXEC which doesn't include SX, so for instance
>>> the W+X check doesn't work.
>>>
>>> To fix this:
>>> - change tlb_low_64e.S to use _PAGE_BAP_UX instead of _PAGE_USER
>>> - sets both UX and SX in _PAGE_EXEC so that pte_user() returns
>>> true whenever one of the two bits is set
>>=20
>> I don't understand this change. Which pte_user() returns true after
>> this change? Or do you mean pte_exec()?
>
> Oops, yes, I mean pte_exec()
>
> Unless I have to re-spin, can Michael eventually fix that typo while=20
> applying ?

I did.

cheers
