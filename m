Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30863348BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 09:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhCYI4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 04:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhCYI4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:56:22 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538CDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 01:56:22 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y18so990346qky.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 01:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=A9Ll1rmk8Y637in8AMrmKOLeqLVtJXFpIdS35azKjQg=;
        b=bXCNa2fxKiB+0sT2ZXOjC0LlF1J8Qdl5S8Chjh41KLd/MQOZK9mU1cvV9doePy48WT
         /7mvyOjW0ePLdRNGdhgXPjzLI4539f+OUXsakPbGFJCnSfOf1amUU4k45z3yqT8BLtQf
         tyUg6Jjpd/9IAMzlasFbQfhlMmt92gjRL9b3wS3RE/FknHHbj8RnJMj/Gg0S1fwd1z6A
         XSzqkOfpyVnNiBBkbKdTehLrlTrjwkFfGcLEscTbz1KMvcdiOCuRUMALsKFTWiNP5bmK
         aq3MGzGJ8dHV/iFJ3SgArKMp1YFp2clgBbndIHvmfF1DNef7mhhCOfOKyyJPkLv85IdP
         tl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=A9Ll1rmk8Y637in8AMrmKOLeqLVtJXFpIdS35azKjQg=;
        b=Z+5pRRDvwhnSnAHC/33/40+s4D4R05qFr4e5/lrxiGIVckcBu/OalyWIXCNSR14KqQ
         yqImTEqg/003a7fFIdyvOvAoz+Xkx6T6PAr0qdPojaudu9VvPVGVVbLPQzwUIE977+YR
         L1AeB81PzwDB2Kf8RiAZUVd8HQb6xk5XexXt+LUWIVEDUkAy4gff7pDiAo7lueAlQ0gJ
         53v4LgzRH4amg3f3pKVWYMmKo/iPF4vbEczmEhQ5ftz0CnGixRNjwomoiwkmuMXesGg8
         wEuv1wTKdZkTY3yJ70imfWvDoQ6NhtUE2xrWgH15ssNbQQXzoLqM+4sF3duckzTdtS9m
         bAFQ==
X-Gm-Message-State: AOAM530SQy+jK3IJjBNs1+DpdABtv3xVPrWYRG4ZgvmFxXdzUp6FPne8
        v6ukU9WDjnZzV8vZpta5ZhM=
X-Google-Smtp-Source: ABdhPJyz3D9nry+L8EmmLGLPSFz5xyRAipEq9HRK0onj8J3Wm+qbffJQd7ybXt2YVrla7lN7aSaLjA==
X-Received: by 2002:a05:620a:b01:: with SMTP id t1mr6745203qkg.422.1616662581665;
        Thu, 25 Mar 2021 01:56:21 -0700 (PDT)
Received: from OpenSuse ([156.146.58.54])
        by smtp.gmail.com with ESMTPSA id t185sm2320878qke.83.2021.03.25.01.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 01:56:20 -0700 (PDT)
Date:   Thu, 25 Mar 2021 14:26:12 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        mirq-linux@rere.qmqm.pl, huawei@kernel.org, joe@perches.com,
        viro@zeniv.linux.org.uk, gustavoars@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH V2] ALSA: pcm: Fix couple of typos
Message-ID: <YFxQLL/9FUi1LWxZ@OpenSuse>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, perex@perex.cz, tiwai@suse.com,
        broonie@kernel.org, mirq-linux@rere.qmqm.pl, huawei@kernel.org,
        joe@perches.com, viro@zeniv.linux.org.uk, gustavoars@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210325013631.3935-1-unixbhaskar@gmail.com>
 <s5hv99fn1b8.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v4C+TDv/+3K0lmcR"
Content-Disposition: inline
In-Reply-To: <s5hv99fn1b8.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v4C+TDv/+3K0lmcR
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 08:24 Thu 25 Mar 2021, Takashi Iwai wrote:
>On Thu, 25 Mar 2021 02:36:31 +0100,
>Bhaskar Chowdhury wrote:
>>
>>
>> s/unconditonally/unconditionally/
>> s/succesful/successful/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
>The patch isn't cleanly applicable, some space was put at the
>beginning of the line incorrectly.  Possibly a MUA problem?
>Could you resubmit with git-send-email instead?
>
Whoops! let me send you a V2...
>
>thanks,
>
>Takashi
>
>
>> ---
>>  Changes from V1:
>>   Randy's finding incorporated ,plus the subject line adjusted.
>>
>>  sound/core/pcm_native.c | 82 ++++++++++++++++++++---------------------
>>  1 file changed, 41 insertions(+), 41 deletions(-)
>>
>> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
>> index 17a85f4815d5..afb670d7fd53 100644
>> --- a/sound/core/pcm_native.c
>> +++ b/sound/core/pcm_native.c
>> @@ -1425,7 +1425,7 @@ static int snd_pcm_do_stop(struct snd_pcm_substream *substream,
>>  		substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_STOP);
>>  		substream->runtime->stop_operating = true;
>>  	}
>> -	return 0; /* unconditonally stop all substreams */
>> +	return 0; /* unconditionally stop all substreams */
>>  }
>>
>>  static void snd_pcm_post_stop(struct snd_pcm_substream *substream,
>> @@ -1469,7 +1469,7 @@ EXPORT_SYMBOL(snd_pcm_stop);
>>   * After stopping, the state is changed to SETUP.
>>   * Unlike snd_pcm_stop(), this affects only the given stream.
>>   *
>> - * Return: Zero if succesful, or a negative error code.
>> + * Return: Zero if successful, or a negative error code.
>> --
>> 2.30.1
>>

--v4C+TDv/+3K0lmcR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBcUCkACgkQsjqdtxFL
KRXukAgAn0dvxJCoyiQUDrsGy0Kca1+cQdkarf3QqAnxtOArIbge+fMIDZHVA6AS
RosxNpZmrtOBkHoQTdxQUryxNn0Qo/yhS09/Ox7bZvQTTUEpwAlw8kR1wZttrxFl
+vNYVxxydUA82r7VCgT3vzY6/oO1XNu5pnikm2BviJ+jUlrT42MjEUCwoWzpU33e
HZHihfTvBDYmprBxeVJLaXKqVrVLYjSMzbCOx4KtygUM7MdYvRhjJ+4Q+6zpEv0C
M+nJeH15+bB6ytPoLGAD+kNzaYsyehAaNgB8y7lj2NHgy4oIN9yYmmcXlRfTARN5
IqTJBO/efwud7iy7eF2kBRkUUu1Kqw==
=5RR6
-----END PGP SIGNATURE-----

--v4C+TDv/+3K0lmcR--
