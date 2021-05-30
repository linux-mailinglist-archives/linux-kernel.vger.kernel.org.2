Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627623952DB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 22:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhE3UfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 16:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhE3UfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 16:35:11 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DB7C061574
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 13:33:30 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id g11so8270250ilq.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=fpBjWbgyM64u4CBFyu0LWhuwGF2btr7PzP8oJNoJW+o=;
        b=pIluPVprOX6cFc/jUfIF8b3xK9lrev6J2MzEWl8arRQWSRmIQ9u4pC4WIiAXXTUPs0
         VU25rljSulLsDLk5rUE8Cjw6VDKak3I0e8ZcgqK66WKkwyjaUrTaCiJuOZfiO4KZ+z/j
         1WY5jmejk++q1Tj8n+/DTnIOZV0AYBYBBwWToS+PSMbEjAtnbG7hMVosUi6/txEkVMSc
         mp3k6nOjlInIcs+ft/Xp2ztArt5oAYE5D7y7JmWVICI9oftQ3B84tdCTlD12+6+OJDIA
         GmKnh2ELhzeOBtjUD3ZglD9EjEopR+fFy3dLV3J1kK9Dufdp1RJyxjkT6WfNuLgC5KoG
         FXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=fpBjWbgyM64u4CBFyu0LWhuwGF2btr7PzP8oJNoJW+o=;
        b=DJk3cBACl+B15o3M9Cb4DsaZL9lHPdjb5iih/ZFtNiDOvK4CVchHOLwM2tYcgtzm8u
         oQ7q/LABm3PFbkUqM0p4spKJc9Rt6XqYZlrBY3fqZHnS1r5B+/MxpL5StG2AMuk9BA4i
         oPMnFoJ7cLJuDucAZtvkS6yji1b0s7llOeKVkUhdpL2qsbr8+3bJb3cw+LiStNnjXh6K
         eyxtusH4S10D+xqGK9hfyPR0PshNq+U0Iv9O59+4V6PHfs7y6ZGBBHeSsiqvaMBPk4H5
         Es8Q3FRcPG027RZXHGaxLPDfyBBsDEb/Fvq0RfcUH9WnHsGIc20rfzclNueYNcd4gAtA
         2wLw==
X-Gm-Message-State: AOAM533jYTCO6RtYE+xlHBw3lypsgmGaQKqE64mqwJlblAzlI8ljyuip
        cNCMVkeIN9k7JhzwFL6VmekrSpzzYw5gcw==
X-Google-Smtp-Source: ABdhPJyFv75uyemtpOooNYoWpVHGkTyYvNNM5zpWTOEM63A7fLI3RCFPfw0B0Gu7+a3OGdrBFH2wSg==
X-Received: by 2002:a92:d689:: with SMTP id p9mr14647471iln.242.1622406810339;
        Sun, 30 May 2021 13:33:30 -0700 (PDT)
Received: from Gentoo ([154.16.192.90])
        by smtp.gmail.com with ESMTPSA id s14sm7102255iln.64.2021.05.30.13.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 13:33:29 -0700 (PDT)
Date:   Mon, 31 May 2021 02:07:30 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gkis <gabrielkis65@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] My First Patch - Gabriel e Felipe
Message-ID: <YLP3itEafpN5EacM@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        gkis <gabrielkis65@gmail.com>, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20210530174739.17066-1-gabrielkis65@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dDYDOkUSH3iJQ+cq"
Content-Disposition: inline
In-Reply-To: <20210530174739.17066-1-gabrielkis65@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDYDOkUSH3iJQ+cq
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:47 Sun 30 May 2021, gkis wrote:
>Signed-off-by: gkis <gabrielkis65@gmail.com>
>---
> init/main.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/init/main.c b/init/main.c
>index 598e278b4..bc366b166 100644
>--- a/init/main.c
>+++ b/init/main.c
>@@ -1082,6 +1082,7 @@ static int __ref kernel_init(void *unused)
> 	numa_default_policy();
>
> 	rcu_end_inkernel_boot();
>+	printk(KERN_ERR "###################################\nI can hack the Linux kernel!\n###################################\n");
>
> 	if (ramdisk_execute_command) {
> 		ret = run_init_process(ramdisk_execute_command);
>--
>2.17.1
>

Hi Gabriel,

  Thanks for your effort to and time to contribute to the project we love and
  work with.

  Two nit picking ...as you mentioned it is your "first patch" ...early heads
  up..

  1) Please write a "to the point" Changelog while submitting a patch. It is
  greatly help the maintainer to understand "motive" and "problem solving"
  stuff from it. Also Please mention "Why" the change is needed than "what" is
  changed.

  2) Kindly use your Full and Actual name in the sign off line. I believe
  "gkis" is not the legal name you will go. If it is , then pardon my
  understanding.

  I am CCing this to people , who are long attach to this project and know exactly
  what needs to be done.

  Thanks,
  Bhaskar

--dDYDOkUSH3iJQ+cq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmCz94oACgkQsjqdtxFL
KRWa/ggAse4JrRHR26IEvYcTyBYO3kUWudubzMDi9yHGrSncK0LW3AVA/NZ/aWLP
Mk515EtknfcWMGt1Z03fb9Og0dkgTAubdBleVcv+QkbYcQlcLeKpZOtCrnEXbSPQ
mPL/cagG92GY6WEq6NXDmDb1ZfoN3b+dszhLvOwzWO0e1gSmOa/DffXNSRCxSW7j
jcKooWmA4ojxtMDH6sfN9JPaKPOtRKogp/LnTiGrIfE8u3Utyl9UFN4/6JGOAAd/
/4VQQrLMipvoyjAwJh5bni74cHXist8LdnnzWD+vWHo5FsnpincS8VnhhIgRp0Vg
xPThU16bKUxE772eeLcJf0/XS30Zrg==
=QpoX
-----END PGP SIGNATURE-----

--dDYDOkUSH3iJQ+cq--
