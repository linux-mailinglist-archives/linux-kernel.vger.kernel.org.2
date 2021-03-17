Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEFD33EECF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhCQKvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhCQKug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:50:36 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF29C06174A;
        Wed, 17 Mar 2021 03:50:36 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x16so1136981qvk.3;
        Wed, 17 Mar 2021 03:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=gG7QPejNR60jx5sjfgi487H6qTjwVUl8kxmz90W0B1o=;
        b=G90dIH6y3T2sKTOADCltJmnjP50n0VaBhmskm8UQsQ/4XAqoqvP4vUXRYRAfdGH5Vt
         U3ob9eHClEFDxG0yx6rdHiAyp/kUSyKqydLVbHArInlSvrxAaK4oc/ZIDjqxeqaWP7/K
         GaQdJtEqg/bHyu02KAWSGPwi1BsmmCdErfS/gxYza4bXKnJwRCMWFsVcHtwbvJCRzZ+c
         elwTM5lU/OxVwti0Scq9yx4i25Mqc9wZ04aRGsILcf5AUbLT1wTqAyQ5+hH8vT2L8iWX
         yo5JHWZY0XxleeK1ENnuFEwneGsGH89Zw/lPRfclRT1faBJCPgGcd9SwEmSukx39iYgT
         z+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=gG7QPejNR60jx5sjfgi487H6qTjwVUl8kxmz90W0B1o=;
        b=SQe4goEI93aQPd/+XhGZmFG/eUWyHgSYPIaeh+boDAYjKyfAzx30FIANRAMqxB80rL
         ScRQjKT5tYWHPDl2BJ6Q+lVDYzCl9Kjf4827aqxJBgbswgN8eR/Mv1rEkUIwsA4AOA3k
         hchyMTm4aDPsNKV9j9jybrDh+r0fkyAfA7bydaaQnFpUP519b+bnMgEc1q6MmP+p9ghr
         Bh6ud20SHxWe8Y+SKLADTFGq+G1P1yIBOCQ/yty/zlBi5ydlV8eeEPOMyc5++3nB4y3+
         VetK+9F+WKRBEUhYzJLyDj0ejulnEMXxrbZhfc60mFI9oVku1ubFddASMBMtbqZ8Bdpm
         V99w==
X-Gm-Message-State: AOAM533Iyys3IprNsms7eKVwgo57ogALNmXUfW1QmRudDBQOsR8+tqZM
        Oi3R4Ut1RDsG5ksQ07ryTns=
X-Google-Smtp-Source: ABdhPJyJ8T2NLOsONSMzRgJMbaDTNc5Q+MVijzx6+YTzaIEIaDnPIkAuYVsWMDXNlfNLSDR6yuEe0A==
X-Received: by 2002:ad4:4dc6:: with SMTP id cw6mr4767509qvb.31.1615978235616;
        Wed, 17 Mar 2021 03:50:35 -0700 (PDT)
Received: from ArchLinux ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id c5sm17603184qkg.105.2021.03.17.03.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 03:50:34 -0700 (PDT)
Date:   Wed, 17 Mar 2021 16:20:18 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Jeroen Roovers <jer@xs4all.nl>
Cc:     James.Bottomley@hansenpartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] parisc: math-emu: Few spelling fixes in the file fpu.h
Message-ID: <YFHe6lv09xKD6IzQ@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Jeroen Roovers <jer@xs4all.nl>,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210317103251.3526940-1-unixbhaskar@gmail.com>
 <20210317114235.033dc0ef@del.jer>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Xd6p6z+C7AI6lGga"
Content-Disposition: inline
In-Reply-To: <20210317114235.033dc0ef@del.jer>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xd6p6z+C7AI6lGga
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 11:42 Wed 17 Mar 2021, Jeroen Roovers wrote:
>On Wed, 17 Mar 2021 16:02:51 +0530
>Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
>> s/synopis/synopsis/
>> s/differeniate/differentiate/
>> s/differeniation/differentiation/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  arch/parisc/math-emu/fpu.h | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/parisc/math-emu/fpu.h b/arch/parisc/math-emu/fpu.h
>> index 853c19c03828..1f313bc38beb 100644
>> --- a/arch/parisc/math-emu/fpu.h
>> +++ b/arch/parisc/math-emu/fpu.h
>> @@ -12,7 +12,7 @@
>>   *      @(#)	pa/fp/fpu.h		$Revision: 1.1 $
>>   *
>>   *  Purpose:
>> - *      <<please update with a synopis of the functionality provided
>> by this file>>
>> + *      <<please update with a synopsis of the functionality
>> provided by this file>> *
>>   *
>>   * END_DESC
>> @@ -50,9 +50,9 @@
>>  #define EMULATION_VERSION 4
>>
>>  /*
>> - * The only was to differeniate between TIMEX and ROLEX (or PCX-S
>> and PCX-T)
>> + * The only was to differentiate between TIMEX and ROLEX (or PCX-S
>> and PCX-T)
>
>Might as well fix "only [change] was to" here.
>
Certain. Thanks for the heads up! ....V2 on the way...

>>   * is thorough the potential type field from the PDC_MODEL call.  The
>> - * following flags are used at assist this differeniation.
>> + * following flags are used at assist this differentiation.
>>   */
>>
>>  #define ROLEX_POTENTIAL_KEY_FLAGS	PDC_MODEL_CPU_KEY_WORD_TO_IO
>> --
>> 2.30.2
>>
>
>
>Kind regards,
>     jer

--Xd6p6z+C7AI6lGga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBR3uYACgkQsjqdtxFL
KRUKOggAjhjIWEg1/IrkEdT0+9TxQ85oGcpwQfLJd2mrEL5ehR8PPNaR+TQ4g/ZZ
eYktVHq3kdhTUCagZ3gBSLlCPKAkG4V1pVT9jzkMPo8KlLQFRcQcmFxWvFOKM63w
whQ2cNbcYGDirMKGntZCh79hbecx0Egw/2kAfv9i61/0gHN0qPPp+QkM/66Q1sz4
sQkkDADuUNfXUAXh9OBFq2AIFg/oYfuqA/BbVmLKvL/wN1vGt3hGwSTNV86jPDuu
umJ6wLcfftv1stLMMvAE0qfKn6VLVY2D5EShqfj+Q0iD8JcldFSUf2lkgP6JwFl+
KQ1PTqMLuekZKBn7qnjHbGwEvJ6kIQ==
=OqRj
-----END PGP SIGNATURE-----

--Xd6p6z+C7AI6lGga--
