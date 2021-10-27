Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5B043C22F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 07:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbhJ0F3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 01:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbhJ0F3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 01:29:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A31DC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 22:27:27 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a26so1617568pfr.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 22:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=9D0jLcun5ZI/bsr3yVL8rMxMwaY+QBa0l9tUPSjC5Ic=;
        b=DKLLQhcKNjwLGV9V9wxHi8sbMog3PFM0+oJJv5PFBiwmfr4CSc0pIV4UPEaDKiCTIb
         nMA7FmGnMOsw46OKf8crmsgplNRbFiBPdPVhsPWMJb/Xatlciigk3LN7wBBjtFMfi9av
         UOzcvnJbM0yTAlIET399TbY4lbyv1yvg01wn6+RZ8EioeYnaYnNcbox+N9q8MVfr7LIu
         40cEXqx/FczKurHIfbUVWzjgjQNre+oCcZhhb8PSr3uNiKqSYWY2/G+PpLviqztogYYf
         /9muwFoLb6NPLQFZotAbNgbQFrvvMSlezFhCCqwxCM/Q4+XxtqnCE90ca+UC790xexek
         Gfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=9D0jLcun5ZI/bsr3yVL8rMxMwaY+QBa0l9tUPSjC5Ic=;
        b=WnHM9GAdzu47AEnpm1b3qVQelJkLK0+KMKDtTf56v+FW94QucVpaCTwKncb5ErTzdN
         zvuhRJtaDrMcZWJlq8r0txcVZW4o2xGY8ZR1+EX+H+RVeGJgFoqVWPtoObBbQWbgTEn0
         mfzlrec6eYQxk6XC3E1N78FAJcGbjUXOyLXsKCobk2ojjOgpwerUgPoII2b7/aiLpQzK
         1x0H5Imte3uzwZSs4wwMDQr9LXVRIHZiIg8wEcPN5DNPt0YAba79BEuJSH66EmzBDX5v
         3ndIcBtmHE8sgpNa0utv18bQS7vddVZ/DAyshOEShj7OUqfuzCqPCmANasweKZP7auOl
         0Y8g==
X-Gm-Message-State: AOAM532ZUkY6OznpvcOzqLfl0SICnSwvwaTmTY7TE7mutrNDhdE2Afm/
        YTgcONLszLxwr8Oy8Vg3CUw=
X-Google-Smtp-Source: ABdhPJzWmWPSrKnARMzyMIyeaD5QJbZyMkxotLqOWj6Hc8eByAPiUIWGXRDwa5xQXW2nY9etIsh5mA==
X-Received: by 2002:a63:18d:: with SMTP id 135mr22540659pgb.78.1635312446590;
        Tue, 26 Oct 2021 22:27:26 -0700 (PDT)
Received: from localhost ([118.208.159.180])
        by smtp.gmail.com with ESMTPSA id h10sm2599610pfc.104.2021.10.26.22.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 22:27:26 -0700 (PDT)
Date:   Wed, 27 Oct 2021 15:27:21 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/3] powerpc/book3e: Fix set_memory_x() and
 set_memory_nx()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <922bdab3a220781bae2360ff3dd5adb7fe4d34f1.1635226743.git.christophe.leroy@csgroup.eu>
        <c41100f9c144dc5b62e5a751b810190c6b5d42fd.1635226743.git.christophe.leroy@csgroup.eu>
        <1635309296.3vv9pb80wz.astroid@bobo.none>
        <063e72e1-fc05-7783-9f42-f681dd08a4b2@csgroup.eu>
In-Reply-To: <063e72e1-fc05-7783-9f42-f681dd08a4b2@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1635312355.da7w1oggf1.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of October 27, 2021 2:55 pm:
>=20
>=20
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
>=20
> Oops, yes, I mean pte_exec()
>=20
> Unless I have to re-spin, can Michael eventually fix that typo while=20
> applying ?
>=20
>>=20
>> Does this filter through in some cases at least for kernel executable
>> PTEs will get both bits set? Seems cleaner to distinguish user and
>> kernel exec for that but maybe it's a lot of churn?
>=20
> Didn't understand what you mean.
>=20
> I did it like that to be able to continue using _PAGE_EXEC for checking=20
> executability regardless of whether this is user or kernel, and then=20
> continue using the generic nohash pte_exec() helper.
>=20
> Other solution would be to get rid of _PAGE_EXEC completely for book3e=20
> and implement both pte_exec() and pte_mkexec() with _PAGE_BAP_UX and=20
> _PAGE_BAP_SX, but I'm not sure it is worth the churn as you say. It=20
> would also mean different helpers for book3s/32 when it is using 32 bits=20
> PTE (CONFIG_PTE_64BIT=3Dn)

That's basically what I mean. And _PAGE_KERNEL_ROX etc would then not=20
set the UX bit. But at least for now it seems to be an improvement.

Thanks,
Nick


