Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C71348676
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 02:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhCYBie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 21:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhCYBiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 21:38:25 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 18:38:25 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x14so319371qki.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 18:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=22p7hVps/LjWuOtuEANiPMyT7pKr9z7q78KN2cTKkCo=;
        b=RyzpV1OANLxsZNO31S9C5Y4xlUPrkIlyvremD4rudrE+JjgUEnT5niMqNT5MBWgA9u
         zmPdFOWXWa61tst+Bb3Nq2m9MTPedDdxNjPM0zVHYp5BXdDrAtiVIMF5l7l2TnKKwvLs
         c9S0K3UxS8s0YwGIsT6jjMrFxYBxIjQEjX80KhWn402Em7HV5prQrazZZ7ns/xiY7Khd
         ZG3X+78i5JIjEkb6+lnQr3a5hg3+FKIi+vouIZ2vV0ashEV8k2t2Glwx1XgXXNa70RZm
         ORiFtF2AR5TYz9Ij74LTCaCIEFYvjQXVq/7glyeyBPBpLoRi8AVNDQAe5ypI3pFNEB/H
         n/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=22p7hVps/LjWuOtuEANiPMyT7pKr9z7q78KN2cTKkCo=;
        b=PTDYKeWhLzqna8n92n6SeG3YO7jA/EZcg2HWOYz/CirYVzxgIhRqz9kswy4m1BrPox
         AGjJoi6n5+E5BmZ2gm2gQRM2+dQbti9gdZuB8z3dl3WAFZwOKrMF/qW0CCr8aUIj1WfJ
         PAkw0YQJjiZIB4cukXUJuhV/QMlqVY5YRhMc4aZX7RCr/SoaFmsiZf8B4fTHxaKhFVmd
         QHh0A18eMN9d6I6rGnY3pG3635BpZZyCIxT4qKGhcPZL9wix4yalAK29YXjLkWVs3Osz
         NLIoj7oC7LpKcAbx/kn8FPA+OGbXC3De+Ij5A9X9QUEJrVz28frkCQvTKU2kQ+SbEJQs
         v58A==
X-Gm-Message-State: AOAM531j6Ubj6NGN9r1fJiD/q9v1LcZHRxVklLFOnReVlHJhP0z83LnP
        bVDtSkOtH4+DWO8ktaX1aH08IDqh7KLUNePr
X-Google-Smtp-Source: ABdhPJyDGZvxR5iJ66pVH/QFNIHNDh9rZGLL+D/VKL2JDKfcm8jOR3rXKZY6QbdSAYSlpnGnonTFLQ==
X-Received: by 2002:a37:30f:: with SMTP id 15mr6139386qkd.494.1616636304932;
        Wed, 24 Mar 2021 18:38:24 -0700 (PDT)
Received: from Slackware ([156.146.55.193])
        by smtp.gmail.com with ESMTPSA id j26sm2705561qtp.30.2021.03.24.18.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 18:38:23 -0700 (PDT)
Date:   Thu, 25 Mar 2021 07:07:41 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        mirq-linux@rere.qmqm.pl, lars@metafoo.de, joe@perches.com,
        huawei@kernel.org, viro@zeniv.linux.org.uk,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: pcm: A typo fix
Message-ID: <YFvpZSTPKX4aDxGZ@Slackware>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, perex@perex.cz,
        tiwai@suse.com, broonie@kernel.org, mirq-linux@rere.qmqm.pl,
        lars@metafoo.de, joe@perches.com, huawei@kernel.org,
        viro@zeniv.linux.org.uk, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20210324065612.31362-1-unixbhaskar@gmail.com>
 <6d2e91a2-a013-c9b1-8725-1715253d0646@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LJ7YcVQXqsqt/q7E"
Content-Disposition: inline
In-Reply-To: <6d2e91a2-a013-c9b1-8725-1715253d0646@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LJ7YcVQXqsqt/q7E
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 10:51 Wed 24 Mar 2021, Randy Dunlap wrote:
>On 3/23/21 11:56 PM, Bhaskar Chowdhury wrote:
>>
>> s/unconditonally/unconditionally/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  sound/core/pcm_native.c | 80 ++++++++++++++++++++---------------------
>>  1 file changed, 40 insertions(+), 40 deletions(-)
>>
>> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
>> index 17a85f4815d5..9884961bca7d 100644
>> --- a/sound/core/pcm_native.c
>> +++ b/sound/core/pcm_native.c
>>
>> -	return 0; /* unconditonally stop all substreams */
>> +	return 0; /* unconditionally stop all substreams */
>>  }
>>
>> --
>
>Please fix line 1472 (in linux-next) while you are touching this file:
>
> * Return: Zero if succesful, or a negative error code.
>
>
Thanks, fixed in linux-next and sent a V2
>--
>~Randy
>

--LJ7YcVQXqsqt/q7E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBb6VkACgkQsjqdtxFL
KRXLoQf/ayvSvk+UYxqr+uE6cxssqzuDrobvKdODaJagQRj6jVE2QCUx9pyIfLgV
0AWTsBNCKO1mqUpqFFvw3WUJMURRwqrYau4R/kNm5EGWcaWgtAXBoP4EVN3eT663
UDYTMaUkNozfU7gAHnviI6+Y6KPPZUzPsYc+D0q968nd1llW7JpHdVn6avx/BQBw
PGLTjiYce+VwMdrJ1aNEFXoC8bEc+TaweMGY3NEX8M/u/QCuaTxCRa92TwM7gaGU
5l0fceqHWhDEJ7yq/E3/pkC2OCCCtl7d+xQCUt2st6IakMWesHcwd5Gs7WBbO3fB
ytyiPO4w7NjKX669eZhf1KRGOCbR2Q==
=aPYT
-----END PGP SIGNATURE-----

--LJ7YcVQXqsqt/q7E--
