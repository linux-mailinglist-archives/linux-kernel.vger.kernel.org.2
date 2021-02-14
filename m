Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195B131B277
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 21:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhBNUeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 15:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBNUbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 15:31:41 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E20C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 12:33:38 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id b24so3557521qtp.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 12:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=GcL2GbB3bO2y/3A5DqkPqgmnYoPAOvMBsTG65hDWptw=;
        b=I3K/rwxusQ6c6OrDW2zBAhiYEjzfLknjNwKaUU+oEnWFprlTUny97X5EC3E7rbQjMm
         m82mBetVBnoEIpOLBgw9lcOb+xWuRNlpYa/qKndu42aPtI3yARRNVIhDwLkAVUB+VgmX
         t+chD58QENQrQMKoF/XKQoQsZQmIo0lJVkwLtRSkairFmhwd/pDCJcHMt4PrsnElNWfe
         BFtybsuB3ecZCyG1idsnQMjpbWcgySqqUO5TPEfxLSU3m7GmDmItjHNI+ZnvhSd7F3XK
         d6SRQlRmV12aKVTMXJQfX8bxOimIrOksDWWXEs0rLlqXcGuW2mFSUJTrUl2O9RFG8X0X
         vg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=GcL2GbB3bO2y/3A5DqkPqgmnYoPAOvMBsTG65hDWptw=;
        b=qVqJWf1KS6iI54v+kAws1G2cchtZwbv1c108TE787ZFgARpEjvAl98aEm26LFkDlsd
         3JoZfsPjoBXDVfFQJxkMaaJedvnw9OKV7B8o0LsvofnhU16fOGEunyIqY9+Z8yMZroJS
         BEWMUsSGl8nRApQBTAeXgIqUdu0FN+adQT9TyKU6VHIwKTWZbjDM3boXy6zLt9n3ZRzX
         crCwAG6z1dIFHiFq3rktTzZB9Z1jUD2bwPNv2zpmFicF6G9md/9KtprItSlk+m7eQFt6
         myiksP8iJKTZ6Wsn4F+jETYWIEEp+E4YMCM+dWhzxnSheT+ZSEuf+k8bvlENSI2cYY9R
         ivRw==
X-Gm-Message-State: AOAM532c0rg9EphTDMGim9lRY74cg+7LqlwTfUS4GgKa9E2AdPkc6U2B
        TT3wYeEkperjGlgwzCMNCcv5OA==
X-Google-Smtp-Source: ABdhPJyW8ImiDWAOBJU4W3ZV2DmKRkSnZRMeKkMf1L03xwilY35LlNEIlncZhy83aKj1T5658lDpPQ==
X-Received: by 2002:ac8:5503:: with SMTP id j3mr11544026qtq.353.1613334817990;
        Sun, 14 Feb 2021 12:33:37 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61:2b0f:e860:4e22:d54f])
        by smtp.gmail.com with ESMTPSA id f8sm9681100qth.6.2021.02.14.12.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 12:33:37 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: /usr/lib/gcc/x86_64-linux-gnu/5/plugin/include/config/elfos.h:102:21: warning: invalid suffix on literal; C++11 requires a space between literal and string macro
In-Reply-To: <202102140426.0DGg79q3-lkp@intel.com>
References: <202102140426.0DGg79q3-lkp@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1613334816_4649P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sun, 14 Feb 2021 15:33:36 -0500
Message-ID: <46545.1613334816@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1613334816_4649P
Content-Type: text/plain; charset=us-ascii

On Sun, 14 Feb 2021 04:00:31 +0800, kernel test robot said:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dcc0b49040c70ad827a7f3d58a21b01fdb14e749
> commit: 67a5a68013056cbcf0a647e36cb6f4622fb6a470 gcc-plugins: fix gcc 11 indigestion with plugins...
> date:   5 weeks ago
> config: x86_64-randconfig-a001-20200622 (attached as .config)
> compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=67a5a68013056cbcf0a647e36cb6f4622fb6a470
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 67a5a68013056cbcf0a647e36cb6f4622fb6a470
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from /usr/lib/gcc/x86_64-linux-gnu/5/plugin/include/tm.h:27,
>                     from /usr/lib/gcc/x86_64-linux-gnu/5/plugin/include/gcc-pugin.h:31,
>                     from /usr/lib/gcc/x86_64-linux-gnu/5/plugin/include/plugin.h:23,
>                     from scripts/gcc-plugins/gcc-common.h:9,
>                     from scripts/gcc-plugins/latent_entropy_plugin.c:78:
> >> /usr/lib/gcc/x86_64-linux-gnu/5/plugin/include/config/elfos.h:102:21: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]
>        fprintf ((FILE), "%s"HOST_WIDE_INT_PRINT_UNSIGNED"\n",\
>                         ^

Kees: I already sent a patch for this on Jan 13, but apparently it didn't
get pushed out..



--==_Exmh_1613334816_4649P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBYCmJHwdmEQWDXROgAQJXEQ//YzQM+k/ZWcnNTT3jPcZrFDtXYUTiOEMJ
l4JKvDKLgnzoz7mVVblJslEF8SthnbfGjIbWZeQHaUNXx8ynyF6uDaqah8t4uZb8
R+MwwH6mBOSlBhRygQyzrJR6rv6iVlH74P3sFtZKW4519Hk3hNk1p+0tFPieLqZq
qUDBsnPz3SrFikoL0zYR1icppYJoNdhR2W9GWRCfZnzxY4/liGb8uJpstcW6NyEc
cAFxgsn1Cs4Z1Q45uC6p7+ZQFvf8epFzvJd4a/ojXJjyLd/+ZnhGsWb2ad9cyxhA
lqPuRgEdDPOMeMu39TpanSzQaF6Ew7H+kJ3fJ6coyxAsuSXKnvZDkJGj80lUI+PJ
8rUW+SqJLncPbWp2BpETtkkIrOKofRSKSulgBRxYMJ+Dqh293ACDHiqniRW0QcSZ
udXMNzfchcFIxIq/t1OHqkzqy1E8sotoy6MICPsWqIWx4Oh3M+x5o9rbdNHXssYW
jvkVmSDVwWvtqbQIFcYDNMkEYolttNKXtYsZ5Z6zYH3BUjiMNZhImGg9Ad5kl66f
GQ/YKD1prGRUE98S4wd+2PyDRkOyWJfHH21Ydj/0L048gYHS/U5iIkWnSZpknAg4
JqKo3gmg2OavGGYsjV+Z8i7zvQy20GucewHJJVrXY7D+jf5zxTfL8PCkvdL+j+Ed
b+p3BBO6HYc=
=TMb+
-----END PGP SIGNATURE-----

--==_Exmh_1613334816_4649P--
