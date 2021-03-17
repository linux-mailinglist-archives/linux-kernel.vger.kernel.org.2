Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D0D33F91F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhCQT0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbhCQTZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:25:47 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45901C06174A;
        Wed, 17 Mar 2021 12:25:47 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id 73so2273891qtg.13;
        Wed, 17 Mar 2021 12:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=WXaqWuzMoz1totQrIBbWDG52hQGsMVkOaWG51drht5Q=;
        b=iXz1HcHie9mz/xZJx1tXCbijjPEARcuL+5XPPcWD/PIXGCsLMJv7s7qBqRMvH98PMs
         rDmNBIhHkDscaoB7zBg2AGBgVY0IjuXZDEmYuczG3qrsfrMZE/oqqaJhKJ4G5eR1+/g5
         +aquVQ67tSHuunD8shMQ8ZdDHqGsUIZYrdZbkLdF142YamyNfpXFvH/z4DRS5M7ok7PG
         RV7L0gIzSrZGDNDNwyMJrDSSTylDcJWRoMekbmXGt+uPc65QgKPPYe0SseH7pjVPN1GW
         Q5C8OaOkJPOk5vD/knOGVj4XP0yl6TAa2HbxDpVy59Zp3FoDmbtafgVWyc+ENnJ4obKY
         l3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=WXaqWuzMoz1totQrIBbWDG52hQGsMVkOaWG51drht5Q=;
        b=ZMBBcp6EesXStyO/z0B5jZHD6YY+vu4C/U65hwAK5JwHRqPQkT8gg90VB2OXhOM6/k
         sheCsD6Yu0sl2cNIdO+nHU2Bz6MqM4Ns3oWGtCvUuCiKEcv2WEKMCWSNWjcBrHtp4yq+
         Ux1Xn0ro5pSsiZQx8Bm+HSYwvUqzsoGfBK0wf4Nr8YZnsxTnSfkwW9kZm622leF2WaC5
         KmuLC1I6jSGyKJ2VRH1PhJzJRUf4k+TJKWyUUF2Zvm1d6Omw95YIC6NjB8EoSJMWJTKl
         rORf0loJFMqKPY7XyYqqJPQvvp22QLiNhpOdMkm2xsUqavIAeNa4SiI4eX6UbPlRo82p
         Jd9g==
X-Gm-Message-State: AOAM5328ctIe9GO1ljDhSzKJ+7YvIbHJA37YjNaIiVrTAO8mGfurXksW
        MXveR4hgyrp4umqHKogp6Kc=
X-Google-Smtp-Source: ABdhPJz54HSvekesym0du0TOqUrGBRpkZEV1JytBNZS36FFNsTVWP01tmtcD7isjCu0owrUu5OqThg==
X-Received: by 2002:ac8:6f02:: with SMTP id g2mr533218qtv.385.1616009146472;
        Wed, 17 Mar 2021 12:25:46 -0700 (PDT)
Received: from ArchLinux ([156.146.37.138])
        by smtp.gmail.com with ESMTPSA id 6sm16520923qth.82.2021.03.17.12.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 12:25:45 -0700 (PDT)
Date:   Thu, 18 Mar 2021 00:55:28 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     James.Bottomley@hansenpartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] parisc: math-emu: Few spelling fixes in the file fpu.h
Message-ID: <YFJXqBmVRfce3wvU@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210317110014.387321-1-unixbhaskar@gmail.com>
 <b72c28eb-1948-2fe5-06dc-9ea004e1b91c@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ASRImp9brVkeI0qg"
Content-Disposition: inline
In-Reply-To: <b72c28eb-1948-2fe5-06dc-9ea004e1b91c@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ASRImp9brVkeI0qg
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 10:23 Wed 17 Mar 2021, Randy Dunlap wrote:
>On 3/17/21 4:00 AM, Bhaskar Chowdhury wrote:
>> s/synopis/synopsis/
>> s/differeniate/differentiate/
>> s/differeniation/differentiation/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>   Changes from V1:
>>   As pointed out by jer, the sentence construction change inducted.
>>
>>  arch/parisc/math-emu/fpu.h | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/parisc/math-emu/fpu.h b/arch/parisc/math-emu/fpu.h
>> index 853c19c03828..b83da3d5b6d5 100644
>> --- a/arch/parisc/math-emu/fpu.h
>> +++ b/arch/parisc/math-emu/fpu.h
>> @@ -12,7 +12,7 @@
>>   *      @(#)	pa/fp/fpu.h		$Revision: 1.1 $
>>   *
>>   *  Purpose:
>> - *      <<please update with a synopis of the functionality provided by this file>>
>> + *      <<please update with a synopsis of the functionality provided by this file>>
>>   *
>>   *
>>   * END_DESC
>> @@ -50,9 +50,9 @@
>>  #define EMULATION_VERSION 4
>>
>>  /*
>> - * The only was to differeniate between TIMEX and ROLEX (or PCX-S and PCX-T)
>> + * The only change was to differentiate between TIMEX and ROLEX (or PCX-S and PCX-T)
>>   * is thorough the potential type field from the PDC_MODEL call.  The
>
>?        through
>but the sentence construction is still difficult to read/parse.
>
Sent out an V3 with the changes...

>> - * following flags are used at assist this differeniation.
>> + * following flags are used at assist this differentiation.
>
>                               to assist
>
>>   */
>>
>>  #define ROLEX_POTENTIAL_KEY_FLAGS	PDC_MODEL_CPU_KEY_WORD_TO_IO
>> --
>
>
>--
>~Randy
>

--ASRImp9brVkeI0qg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBSV6gACgkQsjqdtxFL
KRVFzAgAjpGFGOeWdmu7iqEMOFR5beuQ/F2qy53KZ+N8/6gngesqF8lv3DCLYzc1
cmixFmmwmwNgRzloRmzWw5MGsmVkfpLHw7SPIc5P1TV3+GBoieCP6dMk48MSwxWh
eX1weHR73mMUvnGyigsOttIa43PUZ28MiuzDjSSrrWl2ut/9NyX1HhpQk6hG883Y
Kn4BkLGRsXgMC6AzXxiKShYP3w63U+OQbBhAvt40HF2BSO18LYU9j2aMYb5JS+mc
66LCT91ava/4voVSM9T6efgDbOS6RPtZPl28wSUdGeSqvbNbPqSGXpn58SjcsmtA
bATgLpHcvVWZsBmSnqLffSAbHa9otA==
=P4ZU
-----END PGP SIGNATURE-----

--ASRImp9brVkeI0qg--
