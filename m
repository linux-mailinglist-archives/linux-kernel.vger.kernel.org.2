Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552A73D9C65
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 05:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhG2Dpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 23:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbhG2Dps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 23:45:48 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA01C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 20:45:45 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id w6so2756113qvh.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 20:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=q+M49PeUBQuimyfvlL2nW1+4dQ9ei8Trpuf8eE4YbM8=;
        b=DBHW7JbxkjNZWSm7EUDALgNEXmMWuTTxsYpEpHufG8yrRDPI/0JAnihnpTVi4ymGSJ
         omWt2yLreSfqCougJ3fc4jJKWB8W9Aa0YQEVEPDufKCrmoaPpMjSFDRJUwJFQBlC8pb6
         NpCZa21HrOocWYoXJzCALs0NHq0oVZ4X4lmp25qIhSiK2kttedFHzN4r+vrGl6FZ68Fp
         6G9IVSeE0BaYDR+eafXQSOfDNk8Z7tCeQhzD6xx7PZu92Ch+0UIlFHpIS43xwfnOj3wR
         jCDSoe92/qCoq9xom4TGwo3zLbGeCQC6kWfADH9CAo7kNvnn2axz4NBFgsJFMO1DT8+3
         zBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=q+M49PeUBQuimyfvlL2nW1+4dQ9ei8Trpuf8eE4YbM8=;
        b=HREeWHrX3+6iMTd3ef313ufjCU8HM5MbD5YQJ/Nn50V2e03rwDPVKQnmSY3wtEVYMl
         lTXREA8VlXUe5BFR7R7jd1qZGo4Va1e5x/b9NGH9lQEYvQfV2UtoWUgq0XK7ErllpEaj
         x/D/xixEG3WrZAd0/YLMfgnn2+t2YheNLg8bj9L+7eO//OYeYAEu/rxoIFNgdS6oHB/k
         ZnTQVmmxh10GhsmG6YUuSNzVEIeLxOHafhugKzGVm+U+ZGrt7zwgc8upYxyfS0PXkLCS
         RcuewSqkSWPHJHSc1gRegBAaqfv+V4HgQuYozDItjMaKnfSe6Y28iIY5mUnbH8b6dIyd
         UYBQ==
X-Gm-Message-State: AOAM531tQYoRlAJpCF9uxV19M30c7zw5KofW2kbphw9TkCJTZVOz5irE
        8lQEqPgQ6PdFEuBOcnBNJ/LaLQ==
X-Google-Smtp-Source: ABdhPJysJZIKEpENTPU/YLbX7Tm2/poR8pYLaphKwoor/Cj6xoHYNQCDaKSB+bWFBTBUPMQt7VD/Rg==
X-Received: by 2002:a05:6214:1909:: with SMTP id er9mr3484278qvb.26.1627530344263;
        Wed, 28 Jul 2021 20:45:44 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id bk3sm1071780qkb.103.2021.07.28.20.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 20:45:43 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-leds@vger.kernel.org,
        axboe@kernel.dk, pavel@ucw.cz, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [RFC PATCH 3/8] block: Add kernel APIs to create & delete block device LED triggers
In-Reply-To: <20210729015344.3366750-4-arequipeno@gmail.com>
References: <20210729015344.3366750-1-arequipeno@gmail.com>
 <20210729015344.3366750-4-arequipeno@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1627530334_13589P";
         micalg=pgp-sha256; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Jul 2021 23:45:34 -0400
Message-ID: <110419.1627530334@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1627530334_13589P
Content-Type: text/plain; charset=us-ascii

On Wed, 28 Jul 2021 20:53:39 -0500, Ian Pilcher said:
> * New file - include/linux/blk-ledtrig.h
>
> Signed-off-by: Ian Pilcher <arequipeno@gmail.com>
> ---
>  block/blk-ledtrig.c         | 152 ++++++++++++++++++++++++++++++++++++
>  include/linux/blk-ledtrig.h |  19 +++++
>  2 files changed, 171 insertions(+)
>  create mode 100644 include/linux/blk-ledtrig.h
>
> diff --git a/block/blk-ledtrig.c b/block/blk-ledtrig.c
> index 345a3b6bdbc6..c69ea1539336 100644
> --- a/block/blk-ledtrig.c
> +++ b/block/blk-ledtrig.c

> +
> +static int __blk_ledtrig_create(const char *const name, const size_t len)

(...)
+	if (blk_ledtrig_find(name, len) != NULL) {
+		pr_warn("blockdev LED trigger named %.*s already exists\n",
+			(int)len, name);

Is pr_warn() the right level for this stuff? I'd think this sort of pilot error should
be pr_info() or even pr_debug(), if mentioned at all.  pr_warn() would be for
something like an unexpected situation like trying to blink an LED but failing.
Simple syntax errors should probably just toss a -EINVAL and return.

(Among other things, this allows a userspace script to spam the
log by simply repeatedly trying to create the same entry)


--==_Exmh_1627530334_13589P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEcBAEBCAAGBQJhAiRdAAoJEI0DS38y7CIcKHMH/idwruZ9tURrsesbgrgquzXZ
yyBAlzWUAMPlJ0jWJ4OSshKeEVs60pYdHXmZyuPQaag7RiXUG0b720YIy0pSV+Fx
kbi6edyt1ZDRsEC10nLhdHn5AgxiNvMe1gP5wBZU0VUzVBbY4kICVjc0I1KIKLz6
4cTCrlAN2dqufTetLUWnvjz8aQXhubvC0Xg18p9cDAEbpCVBAb6FwZ736eC/yppy
8+V0q4mg/pyN+t2PpVbtMRL2xNwz1UtwyDBNEu872YVP+jL9wp2z7+QM/vNR8Kj7
HcumxINpEpHcviLwYyqlsd+Vylb6B3EW3xzy/q3+u/x0sobJMNjAsyirkI+5XYk=
=HwId
-----END PGP SIGNATURE-----

--==_Exmh_1627530334_13589P--
