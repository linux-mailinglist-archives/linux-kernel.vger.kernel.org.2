Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234ED331EBF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 06:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhCIFlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 00:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhCIFk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 00:40:56 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1680FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 21:40:56 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id l4so11954444qkl.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 21:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=F2pg62KGehrqsHKKHylo86TzSMeOWcT7I/djv52P6NU=;
        b=ewEqip9hNBVzjP1ke9BqOa77pur36UIAbN2e2FwQrYVL5hKhema/QoiLda5z4eCBQ2
         VfmwSwDosVC6jrLnZixV76SdwEDwdG2TfRdG60p4iTiQunIdXU0dzeuxc0fNLZlkL+fM
         +nJTmvvHQRP3sWIORgDy7sH2/iP+asQ6vnR6dlqkJaymxHhaYYCsjFruisvFqvfomwKq
         OWoU5pZTXmmCvOv7uunAppxnNJ9Ibymh/kVDXRtPdTABX8V83rPWLDvD2jDyV+V4fbYU
         +Fw1wWtoq0gn4EjpwJXLKl/RbrJxyNgqdEI+MBtLkU+9qEcmm5vCzqnLedpFCmXdKIdO
         DUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=F2pg62KGehrqsHKKHylo86TzSMeOWcT7I/djv52P6NU=;
        b=NsAWvtEOj9cbrzr1ZET3Aadhxjzrww0mfN6kVBva00IVChB6dSFhosHtzULe/8qPh/
         Cbp3D/01yyH236r+ALTOnGm1S8P78JoHLXtspyCYq8FQIYd69WIvlgkLMKKQfpb3gGB7
         HGVFFJW3nBxO2MgTavcY+xkUeerrpL9iCh6jp01HTfhh/oJYsSGRpaFOXPjkebQKv4a9
         nZI3aOywoXRpo/DW4hWjoBPYLlZFCqoeccUBNFAxhrmnLcqp0JDjczcsdlnqxvlNpgBy
         K7ukcefFxVQYId3xxn5eo/R6owJ8cPwmpxq7Z6uNzry4uq/hv//zrLU58/HvqSdMawg7
         TnwQ==
X-Gm-Message-State: AOAM533h6XuQCljzwmsB+/RdTpcBmc6IUgDVMl9W9xuUeqeIp1WwA2iX
        P/G7CrSq2wXjei98fEIC+sQ=
X-Google-Smtp-Source: ABdhPJx8tuQe/HFoRYTXdiBXBFmIjm85iymhSAwkl3k7dyMOyxY/crt444senj1YtZgzZmOSCw9cSQ==
X-Received: by 2002:a37:dcb:: with SMTP id 194mr16872117qkn.4.1615268455050;
        Mon, 08 Mar 2021 21:40:55 -0800 (PST)
Received: from ArchLinux ([156.146.37.204])
        by smtp.gmail.com with ESMTPSA id v2sm9180127qkp.119.2021.03.08.21.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 21:40:54 -0800 (PST)
Date:   Tue, 9 Mar 2021 11:10:44 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, keescook@chromium.org, jpoimboe@redhat.com,
        jroedel@suse.de, hjl.tools@gmail.com, nivedita@alum.mit.edu,
        inglorion@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: x86: kernel: Adjust the words to suit sentences in
 the file vmlinux.lds.S
Message-ID: <YEcKXEO2/oz4Y/S0@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        keescook@chromium.org, jpoimboe@redhat.com, jroedel@suse.de,
        hjl.tools@gmail.com, nivedita@alum.mit.edu, inglorion@google.com,
        linux-kernel@vger.kernel.org
References: <20210309034144.3283899-1-unixbhaskar@gmail.com>
 <5bed08e7-ce2b-438a-5ba1-37ee27078be8@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GJDu0JN7h44LNZxN"
Content-Disposition: inline
In-Reply-To: <5bed08e7-ce2b-438a-5ba1-37ee27078be8@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GJDu0JN7h44LNZxN
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 21:10 Mon 08 Mar 2021, Randy Dunlap wrote:
>On 3/8/21 7:41 PM, Bhaskar Chowdhury wrote:
>>
>>
>> s/percpu/per CPU/
>> s/baremetal/bare metal/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
>Yeah, "bare metal" is a little better than "baremetal".
>
>OTOH, "percpu" is a kernel construct's name. It doesn't have to
>be proper English IMHO. (2 cents worth)
>

My bad ....disregard...pls...will be careful ...

>> ---
>>  arch/x86/kernel/vmlinux.lds.S | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
>> index efd9e9ea17f2..592a44ad13b1 100644
>> --- a/arch/x86/kernel/vmlinux.lds.S
>> +++ b/arch/x86/kernel/vmlinux.lds.S
>> @@ -217,7 +217,7 @@ SECTIONS
>>
>>  #if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
>>  	/*
>> -	 * percpu offsets are zero-based on SMP.  PERCPU_VADDR() changes the
>> +	 * per CPU offsets are zero-based on SMP.  PERCPU_VADDR() changes the
>>  	 * output PHDR, so the next output section - .init.text - should
>>  	 * start another segment - init.
>>  	 */
>> @@ -262,7 +262,7 @@ SECTIONS
>>  	/*
>>  	 * start address and size of operations which during runtime
>>  	 * can be patched with virtualization friendly instructions or
>> -	 * baremetal native ones. Think page table operations.
>> +	 * bare metal native ones. Think page table operations.
>>  	 * Details in paravirt_types.h
>>  	 */
>>  	. = ALIGN(8);
>> --
>
>
>--
>~Randy
>

--GJDu0JN7h44LNZxN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBHClUACgkQsjqdtxFL
KRX/ggf/ahl0BBZjasMLjuKA4IKtLsORlH84dH4DrPDFsyYwiNUSjmpI+mEYQF8+
QIxsn89tQomCIT5I8ifG9Ek+TGJ6ZkwYQ0wTUmiuy2ZkHeyzN4FIkP17iFYLb5n+
LQ5WPK+of6Hdm9ginx6rf+ZDixKnYhPDJmEt0NlWpgcl8gPr3iOVs5v8MGoiiEoC
XjdyVSXhm+WdGcylelVCrOQQTib7yDhfY6smZyAR4+jPNpZ3bqpXuHT2q5M93Q8Y
6a4ZmeVuuy398sFbib0ER9BpG60MPJJ8+Sj2V5yLO9+NXbyv84+lYDp/H40LMV9C
d0NV23Sv4X2ABd8zSAddevJyvDZNyA==
=T8tL
-----END PGP SIGNATURE-----

--GJDu0JN7h44LNZxN--
