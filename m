Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0AB348D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCYJ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhCYJ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:57:23 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAC3C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:57:23 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id i19so1183787qtv.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gdI6DcPZqtntEW0jhnI8vupfZnjL8/OD+UtlEEYlAz8=;
        b=HwDSmJt1uzWTJwLwEZ4Et40GsmLIvuZcksX9+nrnLTvA79xnsyfn+7wVNMfbWEPcD8
         28rqEVaXgDpzpg0RUQD5XI4QZxYsKtdb+FYSuEXMUz5TNfHQ3l+NS+6eJQu8+33loxvj
         zhnbte74g8HkU2gyztVzUOYSubNamX4dYP9Q4c0zvPEVl+shicg8JgFcPEi5MYxXUG6+
         k5vJ1J5qcCE+nu4sImsMIWaLzDatM66mks9D/VJsFr1rrnAgNWm9DwJ6Em3uvC62PV6t
         GnbV1py5WLGy6sko05KivMwZAhfbiSE/TkoMw7Gx3tOhy+23Wy3xBTrNanci/WyojxnH
         KEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=gdI6DcPZqtntEW0jhnI8vupfZnjL8/OD+UtlEEYlAz8=;
        b=diwg+7A/h6yCrWfx7E+61GttTlx0cuzeie2VTo0EQNx8BwREjxU/ox/S0Q3xF5o1OP
         9uj0zcl9A+qPkktdaCUL9IhYei0TiGf5po6Ap2wiXG4QUgHvFLIEWwV0AKDWb0PRuH1y
         W/RvgI1cZ2orAPDlMQZLwBBEdDKp0reJt368ypLtH51EzUtyqtIa7n9kCeXKbsM1JINl
         u1fA0+f6AlAdMpsmehNLq4aMk38LLx5wo0UrxQzkFLU2zICwZFlGf9z+wiAZjqqIMUZQ
         Bxx0TuL4T/2552vq1QhGzUbH0mRtnVWnpMps+27aRMIBWthac6pZ/zZvaZe9v1cXycLb
         nZlg==
X-Gm-Message-State: AOAM533j8N30mb8qw9ctTDraT9jRPxYXrp8r7oodVesbl769nUdi2Qda
        SUXTkJb4Z5Chg4nA6W+g6QQ=
X-Google-Smtp-Source: ABdhPJzaev2WqpummeuaYWxBVbs21kqNmQGuIWH2GatgGmkdn+ZVQTditz4XmOpdizmnTOdZC0X1DA==
X-Received: by 2002:ac8:7f16:: with SMTP id f22mr6974724qtk.2.1616666242738;
        Thu, 25 Mar 2021 02:57:22 -0700 (PDT)
Received: from debian ([37.19.198.56])
        by smtp.gmail.com with ESMTPSA id g6sm3784009qkd.62.2021.03.25.02.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 02:57:22 -0700 (PDT)
Date:   Thu, 25 Mar 2021 15:26:39 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        mirq-linux@rere.qmqm.pl, lars@metafoo.de, gustavoars@kernel.org,
        huawei@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH V3]  ALSA: pcm: Fix couple of typos
Message-ID: <20210325095617.GB32566@debian>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, perex@perex.cz, tiwai@suse.com,
        broonie@kernel.org, mirq-linux@rere.qmqm.pl, lars@metafoo.de,
        gustavoars@kernel.org, huawei@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210325090609.10372-1-unixbhaskar@gmail.com>
 <s5ho8f7mv5k.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <s5ho8f7mv5k.wl-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10:37 Thu 25 Mar 2021, Takashi Iwai wrote:
>On Thu, 25 Mar 2021 10:06:09 +0100,
>Bhaskar Chowdhury wrote:
>>
>> s/unconditonally/unconditionally/
>> s/succesful/successful/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  Changes from V2:
>>  Takashi pointed out that the patch was not applicable due to some unwan=
ted
>>  stuff get into it. Resending it with the new patch creation.
>
>Hrm, still not applicable.  Can you apply the patch from your own post
>via git-am in your side?
>
Here is what I do for this specific case :

=E2=9C=94 ~/git-linux/linux-next [patch L|=E2=9C=94]
15:18 $ sed -i 's/unconditonally/unconditionally/' sound/core/pcm_native.c
=E2=9C=94 ~/git-linux/linux-next [patch L|=E2=9C=9A 1]
15:19 $ sed -i 's/succesful/successful/' sound/core/pcm_native.c
=E2=9C=94 ~/git-linux/linux-next [patch L|=E2=9C=9A 1]
15:19 $ git add .
=E2=9C=94 ~/git-linux/linux-next [patch L|=E2=97=8F1]
15:19 $ git ci "Fix some patch error"
[patch 88d5af187dbb] Fix some patch error
 1 file changed, 2 insertions(+), 2 deletions(-)

15:21 $ git_fetch_single_file.sh sound/core/pcm_native.c
Looks alright!=E2=9C=94 ~/git-linux/linux-next [patch L|=E2=97=8F1]
15:21 $ git add .
=E2=9C=94 ~/git-linux/linux-next [patch L|=E2=97=8F1]
15:21 $ git ci "Bring for patch"
[patch 352e1ce8dacf] Bring for patch
 1 file changed, 2 insertions(+), 2 deletions(-)
=E2=9C=94 ~/git-linux/linux-next [patch L|=E2=9C=94]
15:22 $ git apply --verbose 0001-Made-patche-for-this.patch
Checking patch sound/core/pcm_native.c...
Applied patch sound/core/pcm_native.c cleanly.



>
>Takashi

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBcXkAACgkQsjqdtxFL
KRURgwf/T3lfMkAI59EaBVQhjHhqTSYHhrkLt47MgwZgs1G7DdWbqAhSObm0iWiM
1Xz6PLJ3HussXX+SnZHvcLwGaAwJc0aN7a9ytLNhkQBTJ0MLgiAqcaD5Up6Bjlvs
s4+WzSCPU/sWFM8j/HNePTxQiG3/S/UGXddwjkosbaQYQXVyQkKM9hMtouzWF28G
PTteRB14akdKAYuF748L9j6dw7UCmAiHYQAPTGojWUdWgAG3ttOQOM7YClak0p9j
Y+OWd27UKI9b+ZD/bMzo8wfPme4BCjRnD8snCwnJwH2sPQlrk1Cj2/zGUUe0uRy3
nqTW8Ik4WUfTG6OpnU7I0T4K24W9FQ==
=j7Eq
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
