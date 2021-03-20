Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B53A342F28
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 20:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCTTKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 15:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCTTKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 15:10:33 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A33C061574;
        Sat, 20 Mar 2021 12:10:32 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g15so6527918qkl.4;
        Sat, 20 Mar 2021 12:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=zxHX5iepoJkIKKyubBf5s7b/JqWY7QvHxCEPDphI65Q=;
        b=NH9NuhLOFyYodm+7Rzt4196MvKrJz7tiOjwUQB7qQrTTxFspMwPFxlkzooyhIZu7Fu
         JjIL8X4ArQTolGcR6K2KzpomSZaDnxjL6da7XsEc/I0FyuTMK6wxsEnIQa/q/BloDMJu
         LbJ+TfhG17x0WuWmo5hcS+ds1bgyhiQOZ8ta2TEkQYlde+tgmTLM+X6U5utJ9JsUQG3b
         HI6PhNjzF45omx+vLvDw8OlQwvG9TX5mReUO3LrNlXGVhOepAoIH7aWR2oGA+4Xh5ljo
         AJI7A49BtpRkn18vP3lWcOeYilQAGju42v6QfbF7SR7fE0G9tqqn9yg481qivaBCnZ6I
         kmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=zxHX5iepoJkIKKyubBf5s7b/JqWY7QvHxCEPDphI65Q=;
        b=lKmiykEUWOKZSGJBvQiNFZd+5MCY2wJsTYwpaBmYzNOI8yFTulV6714IeXRPl6shri
         wAiSKNd5dVwuZflHtCGSLUo3j0M+YoUfHpkO5ltKb2iylmQisnd/XQKBgmVxLImoxgTr
         KMMK/wDcghYcM3EY1CA83MwjqWLeWMhWA/tVXwH+3MDcHMwFqKMdt1iMLBzVMftpm2iI
         RiSrVPiyk+BXBRs4mAcVXhOTyehfW1DpYvovY6PYqQ74pV5daGVHG2Y+nedSuSsl7ddH
         70qz0VAzlO+IqX8unuU5gnXyk6OM+CmAxbgc9cgFobIhe4qgASd7Mg/GPmZvQslKztmV
         L9pw==
X-Gm-Message-State: AOAM532h6Ss0a8bVJFgZvldTAIfU2B2N3wye5HC/z3K2uImPPN2ttwgn
        ZjRDa4wHfjaY0s68V1dpxAgUlTI138P2Nqxz
X-Google-Smtp-Source: ABdhPJwNfKUGRfVnD0FYqvkoxESxOv1cTGhSFd3ygLzwYmLC0i+rtBK4n+Dhl8kh8YYPQNAz9zXkCA==
X-Received: by 2002:ae9:f719:: with SMTP id s25mr4206383qkg.42.1616267431325;
        Sat, 20 Mar 2021 12:10:31 -0700 (PDT)
Received: from Gentoo ([138.199.13.205])
        by smtp.gmail.com with ESMTPSA id k186sm1122394qkc.106.2021.03.20.12.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 12:10:29 -0700 (PDT)
Date:   Sun, 21 Mar 2021 00:40:17 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] IA64: Trivial spelling fixes
Message-ID: <YFZImRuNCpQvX5Fi@Gentoo>
Mail-Followup-To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210320182347.21440-1-unixbhaskar@gmail.com>
 <a3f98ec2-46e4-c7be-5e73-96c768a35bef@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kbt0JQJWvjyW9NQi"
Content-Disposition: inline
In-Reply-To: <a3f98ec2-46e4-c7be-5e73-96c768a35bef@physik.fu-berlin.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kbt0JQJWvjyW9NQi
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 20:01 Sat 20 Mar 2021, John Paul Adrian Glaubitz wrote:
>Hi Bhaskar!
>
>On 3/20/21 7:23 PM, Bhaskar Chowdhury wrote:
>>
>> s/seralize/serialize/ .....three different places
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  arch/ia64/kernel/pal.S | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/ia64/kernel/pal.S b/arch/ia64/kernel/pal.S
>> index d3e22c018b68..06d01a070aae 100644
>> --- a/arch/ia64/kernel/pal.S
>> +++ b/arch/ia64/kernel/pal.S
>> @@ -86,7 +86,7 @@ GLOBAL_ENTRY(ia64_pal_call_static)
>>  	mov ar.pfs = loc1
>>  	mov rp = loc0
>>  	;;
>> -	srlz.d				// seralize restoration of psr.l
>> +	srlz.d				// serialize restoration of psr.l
>>  	br.ret.sptk.many b0
>>  END(ia64_pal_call_static)
>>  EXPORT_SYMBOL(ia64_pal_call_static)
>> @@ -194,7 +194,7 @@ GLOBAL_ENTRY(ia64_pal_call_phys_static)
>>  	mov rp = loc0
>>  	;;
>>  	mov ar.rsc=loc4			// restore RSE configuration
>> -	srlz.d				// seralize restoration of psr.l
>> +	srlz.d				// serialize restoration of psr.l
>>  	br.ret.sptk.many b0
>>  END(ia64_pal_call_phys_static)
>>  EXPORT_SYMBOL(ia64_pal_call_phys_static)
>> @@ -252,7 +252,7 @@ GLOBAL_ENTRY(ia64_pal_call_phys_stacked)
>>  	mov rp = loc0
>>  	;;
>>  	mov ar.rsc=loc4			// restore RSE configuration
>> -	srlz.d				// seralize restoration of psr.l
>> +	srlz.d				// serialize restoration of psr.l
>>  	br.ret.sptk.many b0
>>  END(ia64_pal_call_phys_stacked)
>>  EXPORT_SYMBOL(ia64_pal_call_phys_stacked)
>> --
>> 2.26.2
>
>Thanks for fixing this. Btw, we usually use all-lowercase letters for architecture
>names in the Linux kernel, so it should probably be "ia64: Trivial spelling fixes".
>
>And the easiest way to get those fixes into the kernel would be through Andrew Morton's
>tree.
>

I did send it to Andrew to pick up . And I took a cue from the earlier commit
messages for the architecture ...like this :

4d5a31977cc6 [IA64] reformat pal.S to fit in 80 columns, fix typos
c12fb1885787 [IA64] remove unused PAL_CALL_IC_OFF
acb15c85de57 [IA64] Do not assume output registers be reservered.

....so followed the conventions :)

>Adrian
>
>--
> .''`.  John Paul Adrian Glaubitz
>: :' :  Debian Developer - glaubitz@debian.org
>`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
>

--Kbt0JQJWvjyW9NQi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBWSJYACgkQsjqdtxFL
KRUSagf/cRC9OjWH/SmSnMozXlsUnjuxbSJPNrKuEr1oUicUlL95jN3Rjzc8re8k
0ev7t5rVEmHt29uzBtB74dHgYtWoenfMG2sphL8/jox66NJv1WHcasoI48xSInWB
QqldjN+uSCuVMh/KU9ATpg8D/Ow1VTShJJ/2ZPDMTODoue3OcjvRxa6zGIHiFFXB
TceWnd35fkh6v5xty+qLPAZl/YobKjhatSAD9HofDFQ8yG5TSqsrXWIlyrOscDT3
fzkzsH3/phVXWQ9gB2NE5LLOYBL58COFO4To7oORZVZz4iT5+o3JDPKRHDVooqyE
bwrQSP2cN2/9r5s/EXJII/6nTd+TDA==
=lRBH
-----END PGP SIGNATURE-----

--Kbt0JQJWvjyW9NQi--
