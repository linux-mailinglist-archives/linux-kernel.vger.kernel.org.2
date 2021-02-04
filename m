Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CE830E84E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 01:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhBDAJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 19:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbhBDAJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:09:34 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964C7C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 16:08:54 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 2so957449qvd.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 16:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=139hplh3ULb4UPDyoJELaS44rqhzTKvr8VM2doSaYT4=;
        b=KNTFvYa3Zl2FJGoCd/CPe/T/xABQ15xSFlbai5LZ6xXI6P16IzdWwnzfIAGoUPOzpL
         TKvHC+j6tKgXBRziSCqqePS55rai2UsrsomvQggsRvNuP4zHK3tIihGudSJEX5eiFuie
         bBB62WwZ+nEbQgF01u0VEewwEVSgiqelzOa7Zo1giKtGor1Q2DrS6mRQ/us/JprS0yCW
         mQbjE5C19g1uUjYhlwt8SqfWeq/1xcIDH26fZYIiK2U4BBBh63K96sVSExfnPXT3Wrx3
         OqD1sksTh1gSJwr3LHtDRDwdHEX/YwjSjf0Fcq1Ot6qMSdfbU+2soFLXJQWKYay1Xfqx
         85pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=139hplh3ULb4UPDyoJELaS44rqhzTKvr8VM2doSaYT4=;
        b=or0/r4mGWSg6Sx0jupgIE7/wDzb9Xhtvl3cDghdeDC/AAve+fES4AX3/ZQd8ymGRUE
         Cx222PrY+ZYN+ZpJ7pESjQTPho6b5vmQbju1r15GFfWldbFhorzlgushYfAiu+HBtuTo
         EZj921zsB9OA6J5pcO/QcW+VcReE9U8Xq9eFv3yo+Wg27baKEJBqbBz/cis83anxQxr7
         TXAqznPwZUF59adSj/8lyRN3LCVG9Qdmx6/ZPmLiUZeWptXbvR6qq0mf34kgH2lI1nGZ
         1yCbQXZZGIDDOsVa4Rk4yT1mxPLlkCw6FtpyxB01BIjFC/OwwmUy8HMLFG3mPmvOLPwo
         8SYw==
X-Gm-Message-State: AOAM531Nb9LY1Y0l7k+KFOQBCRlp1dr66SJu1E6Kj6VAxi+CNRvcpCEZ
        GeUI8JlpePIcfUBr5chfyhg=
X-Google-Smtp-Source: ABdhPJyQdcGRhXtJVtyycCER7lcJdN1rvCboMaItzuNiASPLNcFujgShFPJlxsGyzLCGvcqeJeW2dQ==
X-Received: by 2002:a0c:e3cd:: with SMTP id e13mr5002885qvl.1.1612397333950;
        Wed, 03 Feb 2021 16:08:53 -0800 (PST)
Received: from Gentoo ([138.199.13.179])
        by smtp.gmail.com with ESMTPSA id i15sm3482948qka.103.2021.02.03.16.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 16:08:53 -0800 (PST)
Date:   Thu, 4 Feb 2021 05:38:42 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     jikos@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: x86: kernel: Mundane spelling fixes throughout the
 file apm_32.c
Message-ID: <YBs7ClcH1PkEEwC9@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, jikos@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20210203144837.30246-1-unixbhaskar@gmail.com>
 <8ee5a8bf-d9dd-d756-0522-abef96f1b062@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Hj81m05brbYhCnx4"
Content-Disposition: inline
In-Reply-To: <8ee5a8bf-d9dd-d756-0522-abef96f1b062@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Hj81m05brbYhCnx4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 08:49 Wed 03 Feb 2021, Randy Dunlap wrote:
>On 2/3/21 6:48 AM, Bhaskar Chowdhury wrote:
>>
>> s/messges/messages/
>> s/powermanagement/power management/
>> s/secodnds/seconds/
>> s/powerdown/poer down/
>>
>> Capitalize and truncate space in start of the sentence.
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  arch/x86/kernel/apm_32.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
>> index 660270359d39..04204e01ff7c 100644
>> --- a/arch/x86/kernel/apm_32.c
>> +++ b/arch/x86/kernel/apm_32.c
>> @@ -2366,7 +2366,7 @@ static int __init apm_init(void)
>>  	/*
>>  	 * Note we don't actually care if the misc_device cannot be registered.
>>  	 * this driver can do its job without it, even if userspace can't
>> -	 * control it.  just log the error
>> +	 * control it.Just log the error
>
>missing space and period:
>
>	 * control it. Just log the error.
>
>The rest of the changes look good.
>

My bad...thank you Randy!
>Thanks.
>
>>  	 */
>>  	if (misc_register(&apm_device))
>>  		printk(KERN_WARNING "apm: Could not register misc device.\n");
>> --
>> 2.26.2
>>
>
>
>--
>~Randy
>

--Hj81m05brbYhCnx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAbOwoACgkQsjqdtxFL
KRW2AAgA2At0tt5QVqefLJobU6AkZVqI5zwS57j4+GTx8gBq2Pahpxly/VMBI6L0
XnsX62cargl36Aarm88XIrPe1FW+kvmv2ge5b6Ft4sB4kNFgvAvGh9h2Z6nFGXll
/BFYu4Vn5Fp8e8It8lvEYb6URiRcm4m2MPVP4FF1ppPRhigc8fn+HOGLoupEcpOy
p2rX4RaBm+SmREY+V6NlxJqfgDxSTiwZ21XGbjHgp1ovddsu4yjmYrs9SLfLw2Un
L20dDPjDUfJMzmRxa6pgjGHRVQzb+9VlMoty+wHPio5ZNgGLJzeqAHDP336f+ZH4
whlymf8uJyZ23ifQtK6FnlI1+KE16A==
=DyeM
-----END PGP SIGNATURE-----

--Hj81m05brbYhCnx4--
