Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEAE33F972
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhCQTiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhCQThy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:37:54 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E778C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:37:54 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id d20so40167968qkc.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=/MeUJsXI3vY0jmVkL6zr3AlJZBeB/3Uhk6J2sHKHMnM=;
        b=cxUtmVjiMGWSWEl9OQIaV4+m0QANUEt/HgIwSPfINPod5lcP20pI5jXuVDzAC7zsSE
         mFLBbMiAKOYTdL/b4OJLxKLcUCQQxHWOVVOUyo1Vus3mgRoiXiC49Ezzv0VZPQOScUP/
         gqU33xHYK7Rhe+JGgJB0JwsyOC9wklOlpvX/tWvNvx41vWti+ZogG80RMzVo8iFLTE8G
         cWPIu5+8q1zQRgriiZCwip0R9/5lKrtM958X0iI5O+4bnAoMYoCtr+CCIbwzLNGnLgR7
         FZsMfW/vqiqt4+nxtG5MxqU+W0WTTWvPK2ncU6eVawLF1NEvMFG76xjGlgosDzyCblQ+
         h+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=/MeUJsXI3vY0jmVkL6zr3AlJZBeB/3Uhk6J2sHKHMnM=;
        b=Z9sM3wTCAxb0Ee1pdsmaYEzvONYKGLjxdQN8mqdAIpBAOTRtdKZ60gY9PZTUic4FSs
         RO6tRBVNnFqb/aA0xOyBmWGtRsHOfwatKRy/uglQXLOxou1Bmt35ejtE/TGTaR83WRPM
         NcEldWUKHpmPqEqlvR3QB6efHh3HYWpEDIP1E4kng8FP+x/SG4lPbT/aBHhJa6WoLdHY
         8YuFkLPSS0wKYh5c9/ZLkBM8IxVoLzczfvFhQRoF2lCuqSSMxqZWcT/EA7fWKatNihHv
         XjKpfXmKmLQsdB+WpWCu7JOYCC6u9jmVmidoaaiJWzhN2SlWzQEfccgct2KR9xlWipnq
         fUUQ==
X-Gm-Message-State: AOAM531IHVBGmsJ0/TLQOfOx3NLiF2mRAycZURuROGVzPQiiplPl4jVu
        7oyPJzl5T9iQ41O1GOG+NLM=
X-Google-Smtp-Source: ABdhPJwAhAV0sOEnWkPloIiGnv1JuMXHHMQujxONTz4xfa9vJ9JBExvkKj2rAE3Ace3der2Bn+3EGA==
X-Received: by 2002:a37:8584:: with SMTP id h126mr831792qkd.41.1616009873965;
        Wed, 17 Mar 2021 12:37:53 -0700 (PDT)
Received: from ArchLinux ([156.146.37.138])
        by smtp.gmail.com with ESMTPSA id a19sm18520611qkl.126.2021.03.17.12.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 12:37:53 -0700 (PDT)
Date:   Thu, 18 Mar 2021 01:07:35 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     peter.ujfalusi@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] sound: soc: ti: Fix a typo in the file ams-delta.c
Message-ID: <YFJaf+Q1P1nnvJm/@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Mark Brown <broonie@kernel.org>, peter.ujfalusi@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210317082042.3670745-1-unixbhaskar@gmail.com>
 <20210317123411.GA5559@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jZ3NNrf+z32CQz8F"
Content-Disposition: inline
In-Reply-To: <20210317123411.GA5559@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jZ3NNrf+z32CQz8F
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 12:34 Wed 17 Mar 2021, Mark Brown wrote:
>On Wed, Mar 17, 2021 at 01:50:42PM +0530, Bhaskar Chowdhury wrote:
>>
>> s/functonality/functionality/
>
>Please submit patches using subject lines reflecting the style for the
>subsystem, this makes it easier for people to identify relevant patches.
>Look at what existing commits in the area you're changing are doing and
>make sure your subject lines visually resemble what they're doing.
>There's no need to resubmit to fix this alone.

Thanks, will remind myself next time I will try to do the same. But, I was
trying to be "As explicit as possible" , so the person in charge can struggle less and hover less to understand what it is for. Anyway, will follow.

--jZ3NNrf+z32CQz8F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBSWn8ACgkQsjqdtxFL
KRVhngf/Rn/HLqNf0yP0B0rKM2zCM+2si8XQXQyEo0b3gGDfWMMFzSijJkzoBQd8
yFG+7GqW6m4l0tzyrCrmgR1k9A4KpH2p8G/QSF9pN9zRcE7rQKf2YXhWj0ihmNEw
+F3XnFmznP/CiAUMkJbwunVqG3Q0ftBown+naXK7HN73rSfMOcG1SOV8w1pikfMw
XOJqoUl5fSCT2ZDR5l/ZYA5SjFxygKl/M4ufLwdXSqtFNjaGRfXmYS+s5JKpWTZo
0jlm90IWfBocRCTiFX+e4rvaJzvuhoYQiFWq9tPMZK2YborZHxJAGHEf7E+5TeqB
2QWShsiDR7JzR9X7Qk6FkTP88lngPQ==
=IxBi
-----END PGP SIGNATURE-----

--jZ3NNrf+z32CQz8F--
