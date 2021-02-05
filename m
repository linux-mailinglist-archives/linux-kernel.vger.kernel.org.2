Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02CC311799
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhBFAGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhBENhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:37:31 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCBAC06178C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 05:36:50 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id w11so3383755qvz.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 05:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=+mW6FpqAmKNeD8zGl6TjC13ZMf5E8ip1whQBn+m47Yw=;
        b=T9l/mpYX+hFDFWYFCi7BPQeSDhYrFell0kIK045Hl1dOHHuEBftPu7El5h6RqPIKzE
         LWISVwkwtYZ6zqOyqgOSLNU0Ipi7ox1/Uj+c19fuQ9pEpYJeVyHV2FeH7hA6FOJ7EieB
         PfJBFhlSwV0DId5m6z8SneBUv4CcJU+UUVgyApfQrTW2NL+IRSGhCWEBb4JiEXdT+meC
         rrpYwTIKmQG0moDFyL05IfjcQQDlqSSp5kaVJbpsR71HpltyKI0SdLSXq7jiTI0sGCC8
         1Y+fFO48gUOgMgO0xVH3/88rr8/GkkQolZ66uLeekvE54pWE/SOB4BHnx7fl8GiKYl1g
         XFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=+mW6FpqAmKNeD8zGl6TjC13ZMf5E8ip1whQBn+m47Yw=;
        b=A89zAZ/9+zEcUUfIiJMcw8zeCfhW/ti4vYuHLecADel8MekumqYQ6BLRwk+HT3D48Z
         wWG50HvfD/OsLVNBy/0QtWbGLvOYq8Na/Yu3znyH6pyRkXk5UhlA9Mg+QnR9hZ7SHeTJ
         CNLUQ/ohSd4Rx0Aky+dtrTJCVdf+e4npaLHK80ebPenzSm1/Iw9pPJrRbd3fUiAOuUCl
         SjZOsOehtgwZ/B47rhgjIRahN/EPH6J6sbKdzOa6Uc+c93QcT0x94pUbBcif7drRymeI
         pwUi+nuAmikCMDt50dZk880BCDlesTD0QxBzOTWcly9vSw8Y5hIuxNQ7M4SPJ1eBBRie
         kbuw==
X-Gm-Message-State: AOAM5330Z9V0TN1ksluM0kyXidzyv+AmQ52yzOUdqC/h3kkEjtMlN20F
        P0bEdTPX/dWMGxM0PCOKjMU=
X-Google-Smtp-Source: ABdhPJyaF3g7LIACGikT7qeW1QmsE8yC+KpfQNvX3PhX83BEhECpZWc6tt5yGPWjTX+/WnwOW0uQwg==
X-Received: by 2002:a0c:b65c:: with SMTP id q28mr4365647qvf.49.1612532209689;
        Fri, 05 Feb 2021 05:36:49 -0800 (PST)
Received: from ArchLinux ([138.199.10.106])
        by smtp.gmail.com with ESMTPSA id q22sm5225046qki.51.2021.02.05.05.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 05:36:48 -0800 (PST)
Date:   Fri, 5 Feb 2021 19:06:39 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] drivers: mtd: Better word replace a not so good word in
 the file mtd_blkdevs.c
Message-ID: <YB1J53adyW4BBK3g@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210205124151.1386271-1-unixbhaskar@gmail.com>
 <20210205142618.116852a0@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HFkQv3hX6OCe4c2R"
Content-Disposition: inline
In-Reply-To: <20210205142618.116852a0@xps13>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HFkQv3hX6OCe4c2R
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14:26 Fri 05 Feb 2021, Miquel Raynal wrote:
>Hi Bhaskar,
>
>Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote on Fri,  5 Feb 2021
>18:11:51 +0530:
>
>> s/fucking/invite/
>>
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  drivers/mtd/mtd_blkdevs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
>> index fb8e12d590a1..756a0995e474 100644
>> --- a/drivers/mtd/mtd_blkdevs.c
>> +++ b/drivers/mtd/mtd_blkdevs.c
>> @@ -523,7 +523,7 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *t=
r)
>>  	int ret;
>>
>>  	/* Register the notifier if/when the first device type is
>> -	   registered, to prevent the link/init ordering from fucking
>> +	   registered, to prevent the link/init ordering from invite
>>  	   us over. */
>
>invite us over?
>
>I'm not a native English speaker but this does not bring any value to
>my ears. Worse, I don't even get the point. Better rewrite the comment
>entirely than just swapping "fucking" with a random word, no?
>
Got your point , and I do understand "fuck" and "fucking" is so strong word
that it is really difficult to replace with something else.

But..but you suggestion to rewrite the comments sounds good Miquel ...wish I
could have that much time in hand to replace every sentence having that word
=2E..all the patched sent with that word replaces...please step forward and=
 make
and send patches .

Today I sent 10 patches replacing that word(weather that make sense or not)
you can see those in the ML ...please pick up as you wish and send patches.

I was simply replacing the word ..never bother about the meaning it
conveys..doesn't matter really.

so...

Thanks.
>Thanks,
>Miqu=C3=A8l

--HFkQv3hX6OCe4c2R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAdSeQACgkQsjqdtxFL
KRW1egf/YR9x8QUVW/w4A7gXog8v2ormOeiIwMsmh+dFQXySybFM8XSENV01zq7+
ihWte18fqmbBV4zXEuJ/fNApb5CCpfT7uUsAD3W5FGzyd+DkZN+0wL8V40tMfyyq
eU59eGg0oh4wwrNQMuAMD8the+K91ki2ozbx77ElKqlC3beaKRp3IhMWSg8iu2WK
kiRsYtWXBAM9Aa7Qnhza5w3UyHA48WWvXlk2hvujSIZasSbdHYs/gDsmQx4WsL7m
+ljY3PHCUJI3I7x1djkD2JC8Qyboq447ChWT6TUTsV1fsq4hcWRW0gfnR07R1YUK
uUGvdOJ/HxFgBEoz6A9cOUmdhyzfLQ==
=oc0N
-----END PGP SIGNATURE-----

--HFkQv3hX6OCe4c2R--
