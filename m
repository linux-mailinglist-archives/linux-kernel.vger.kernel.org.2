Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4A9343F24
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhCVLIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhCVLIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:08:14 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A312DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:08:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4F3sDT0lfsz9sS8;
        Mon, 22 Mar 2021 22:08:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1616411289;
        bh=uxa4pHHTMVzSJZOPCsz78YK8wlcYnsE951BCdVMBFh8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cFUGRWY/Qr86qwsUK1d49CiSAXP5qdPTyn3zQzF0R4HHxwcLccxcP0SLc9nzQn2+J
         9gKFUP4LO8HRRZ6KQud4YGoe+r7qHqfCG0MDFn//jYBydvWrKeEuZU8i79EIaYT9W5
         Rdmu/Md7ms21WOn2mLDRIFJFWMfe+tLCNZjioXivdjsNsbBwNiqfprfvYqBiYh3G77
         22lkMpE52ooBfNdL2474eXWjEsltIIw5ajfcF41sfwpZvEJ7XoKm2cNSfbrai8pKNm
         cZGA/OSAHRB1NYjAIYC6fT1RHoXNhFFGD0lh7u2v/QIDupcGg02EU7/UhdXk0iZ0aZ
         IsibVdS+bb0RA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Axtens <dja@axtens.net>,
        Balbir Singh <bsingharora@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v11 1/6] kasan: allow an architecture to disable inline
 instrumentation
In-Reply-To: <87r1k8av4j.fsf@dja-thinkpad.axtens.net>
References: <20210319144058.772525-1-dja@axtens.net>
 <20210319144058.772525-2-dja@axtens.net>
 <20210320014606.GB77072@balbir-desktop>
 <87r1k8av4j.fsf@dja-thinkpad.axtens.net>
Date:   Mon, 22 Mar 2021 22:08:05 +1100
Message-ID: <87v99jh2ei.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:
> Balbir Singh <bsingharora@gmail.com> writes:
>
>> On Sat, Mar 20, 2021 at 01:40:53AM +1100, Daniel Axtens wrote:
>>> For annoying architectural reasons, it's very difficult to support inline
>>> instrumentation on powerpc64.
>>
>> I think we can expand here and talk about how in hash mode, the vmalloc
>> address space is in a region of memory different than where kernel virtual
>> addresses are mapped. Did I recollect the reason correctly?
>
> I think that's _a_ reason, but for radix mode (which is all I support at
> the moment), the reason is a bit simpler.

Actually Aneesh fixed that in:

  0034d395f89d ("powerpc/mm/hash64: Map all the kernel regions in the same 0xc range")

The problem we had prior to that was that the linear mapping was at
(0xc << 60), vmalloc was at (0xd << 60), and vmemap was at (0xf << 60).

Meaning our shadow region would need to be more than (3 << 60) in size.

cheers
