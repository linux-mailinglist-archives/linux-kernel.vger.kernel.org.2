Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA0440C7E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhIOPKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbhIOPKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:10:21 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E40C061575
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 08:09:02 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id 88so896375uae.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 08:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RMJSUECpOrASX7O5LRnVxYeIxFzjfrmjLGpxkqAvY8k=;
        b=fG1R+ZurZZNulSU4h2FyWa8BiLThdEPNYfMegeS+bqMakGkSdanMBkE+TPOqkBZ45K
         zSj2rCbLodjCbuJ+ba+7+8wP36tkHVHGkv/X+ug2B/NBnsYDm0ES03GYQ7ltClBNLCBt
         2v0FMjTe5USxxcwcE/1XPryTf/AfNCg08HZ0wNZdYE5ugt34VBoVUM1Pe7M11SGJrtFe
         B5UZv3hgMb+9QMEWoT06Hz4zjii9wFSXH+BgCVb3SD6g8F6YRZKJuucVQ2/V7l4ck7j/
         oD3jqxnjz/a/hCE6tY/zogQ5p3iR0rolSGAhaXU+4vNA+e2cdGhZDrzPBEeRygW1TkQL
         so+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=RMJSUECpOrASX7O5LRnVxYeIxFzjfrmjLGpxkqAvY8k=;
        b=w1HGWWN2Kpso9lTAvIpt2Yt54yKnqvps+vqYJ+FH77qLonXZPgk0DTNlWwLlp+FnOG
         5oZFtB8Qyc/3otvU29tz2gj64fqHwWBJ7l/BUxRTspyIA3T6AsWPCm2/bKScChJwVqPe
         iBCIrkzqofjTDUHWF2Tfkbduc1Um7u0TD0jgS5cGPGmNJvx0ECRey7pEXa4j6E65T86/
         EU9LStzcr9NRJ2hpPuHH99Eak+K4Ey6L91Jcj4NVNiXf+OZake+ywk1ZRPdCQ4et1G4C
         0kx7pAbHK3lFqDqiBM69388lRrHqfQRDMO/+eUXuvqdhELT8mbCD6CYYveD+BxSkBPcd
         CrHw==
X-Gm-Message-State: AOAM532MPb+0hsPU+xsgD0usCGpTFCHiSjwANbbR5yYwRn+qtcHIw28f
        vmptE5u5F5HTp1PNta7Gx91rrPppX0vxoGP2LQkEsA39c5WXb2pp
X-Google-Smtp-Source: ABdhPJz+lGvkNRjznJyetIKGsh0f+EIE9yBanUGKONiFPZyfcHxk7aW8eKufEF0k707acuEIfxACcEktEQW9DrvGs18=
X-Received: by 2002:ab0:2246:: with SMTP id z6mr290058uan.31.1631718541884;
 Wed, 15 Sep 2021 08:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210913032003.2836583-1-fengli@smartx.com>
In-Reply-To: <20210913032003.2836583-1-fengli@smartx.com>
From:   Li Feng <fengli@smartx.com>
Date:   Wed, 15 Sep 2021 23:08:51 +0800
Message-ID: <CAHckoCyDULok_QLLh5Nmbx4qLCxKL43TgtFgCSAwuaPpRy1BFw@mail.gmail.com>
Subject: Re: [PATCH] md: allow to set the fail_fast on RAID1/RAID10
To:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ...

Thanks,
Feng Li

Li Feng <fengli@smartx.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8813=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8811:22=E5=86=99=E9=81=93=EF=BC=9A
>
> When the running RAID1/RAID10 need to be set with the fail_fast flag,
> we have to remove each device from RAID and re-add it again with the
> --fail_fast flag.
>
> Export the fail_fast flag to the userspace to support the read and
> write.
>
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  drivers/md/md.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index ae8fe54ea358..ce63972a4555 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -3583,6 +3583,35 @@ ppl_size_store(struct md_rdev *rdev, const char *b=
uf, size_t len)
>  static struct rdev_sysfs_entry rdev_ppl_size =3D
>  __ATTR(ppl_size, S_IRUGO|S_IWUSR, ppl_size_show, ppl_size_store);
>
> +static ssize_t
> +fail_fast_show(struct md_rdev *rdev, char *page)
> +{
> +       return sprintf(page, "%d\n", test_bit(FailFast, &rdev->flags));
> +}
> +
> +static ssize_t
> +fail_fast_store(struct md_rdev *rdev, const char *buf, size_t len)
> +{
> +       int ret;
> +       bool bit;
> +
> +       ret =3D kstrtobool(buf, &bit);
> +       if (ret)
> +               return ret;
> +
> +       if (test_bit(FailFast, &rdev->flags) && !bit) {
> +               clear_bit(FailFast, &rdev->flags);
> +               md_update_sb(rdev->mddev, 1);
> +       } else if (!test_bit(FailFast, &rdev->flags) && bit) {
> +               set_bit(FailFast, &rdev->flags);
> +               md_update_sb(rdev->mddev, 1);
> +       }
> +       return len;
> +}
> +
> +static struct rdev_sysfs_entry rdev_fail_fast =3D
> +__ATTR(fail_fast, 0644, fail_fast_show, fail_fast_store);
> +
>  static struct attribute *rdev_default_attrs[] =3D {
>         &rdev_state.attr,
>         &rdev_errors.attr,
> @@ -3595,6 +3624,7 @@ static struct attribute *rdev_default_attrs[] =3D {
>         &rdev_unack_bad_blocks.attr,
>         &rdev_ppl_sector.attr,
>         &rdev_ppl_size.attr,
> +       &rdev_fail_fast.attr,
>         NULL,
>  };
>  static ssize_t
> --
> 2.31.1
>
