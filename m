Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE70313E1C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhBHSxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbhBHRHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:07:43 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678CDC06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:07:03 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id a12so15079872qkh.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 09:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1oGhDlZioI/4IhmuPNoORENZJtYwROVwa2Eu/Yq2MKY=;
        b=evL/b/OtHFxEGv48CBf9AivYj/HGimawzVr2biAkibG47OfjrycLq+5x8B4eD7MltH
         +DyXjkDn/ro67yMuL2onX/LSJchsjktQmAh3lhe+6oicdZ+SY/PSG7fhJFm7FtulhHJJ
         waqzXnHb0w13uQ1M/UaR7B5g2coG4HZ8VLwVdZfRp5TkjOcQ/rVYObk7hZzPOcS6OlMP
         utiiBE9zaUccT+ElKHPNRi4HBhSyeR6B+EvZpYmuoTBmFjkRB4Zw33rSt8/0edgyTvLf
         84WJcpFS0ItY7D8KPJHs22lsdUzHmx1oFBxQYYstbkH5mnziRYt9ZA3F656MnqDzbM4g
         9WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1oGhDlZioI/4IhmuPNoORENZJtYwROVwa2Eu/Yq2MKY=;
        b=d+h3wPcOXM95NBqNQZ+U8Yzj3WFgk9h5GG5hlQP9CkAhDyypn5fdWWoI4Ta+xAdWBh
         1bftjUYFexBlIf+RhW+hascBSlwtVHNF/Y1ZlHNh6hAVyTzdPjHr7js7COFI8UKZkYsm
         le2S8o3NnxOvxO2aXeG3vqtsobD6UxQkVSR2Gn4UK3xbxU4kje7cfkhnTPa54/FIQzHW
         /aDnadp6qvf3taJUF20N+qKnhlPvU28TU48EweRTBBs3syxtc/+p7J87XYxo94k/HQPS
         3KNiWc91edM09PXbN5t/joc8wluFT+Lsi1+lrBlmgO1Uzb521/1eMDZGwf3Visivh9lc
         ZlAA==
X-Gm-Message-State: AOAM532W3imd+kYEhyjpV8QVePle/pgGR4XrY9JkGtZqzdrHVhSq2WBs
        nmFFS0Lky0AtOBeKaBj+cN1SyOu94fb6cg==
X-Google-Smtp-Source: ABdhPJznEoqgrHXPLVqPXpUAQXwj4urj/fuzcMyhxRW/39Idqc0HaJedHlfbgkXdxEfpuf486vlk8g==
X-Received: by 2002:a37:41d2:: with SMTP id o201mr534123qka.204.1612804022590;
        Mon, 08 Feb 2021 09:07:02 -0800 (PST)
Received: from ?IPv6:2601:5c0:c200:27c6:15d6:ef8f:290b:734a? ([2601:5c0:c200:27c6:15d6:ef8f:290b:734a])
        by smtp.gmail.com with ESMTPSA id l128sm16649708qkf.68.2021.02.08.09.07.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 09:07:02 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] drm/qxl: properly handle device init failures
From:   Tong Zhang <ztong0001@gmail.com>
In-Reply-To: <20210208104149.423758-1-kraxel@redhat.com>
Date:   Mon, 8 Feb 2021 12:07:01 -0500
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E07153A4-9B42-4050-903E-8BBB99D8ED8E@gmail.com>
References: <20210208104149.423758-1-kraxel@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does this patch fix an issue raised previously? Or should they be used =
together?
=
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2466541.html=20=


IMHO using this patch alone won=E2=80=99t fix the issue --

Best,
- Tong

> On Feb 8, 2021, at 5:41 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> Specifically do not try release resources which where
> not allocated in the first place.
>=20
> Cc: Tong Zhang <ztong0001@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> drivers/gpu/drm/qxl/qxl_display.c | 3 +++
> drivers/gpu/drm/qxl/qxl_kms.c     | 4 ++++
> 2 files changed, 7 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c =
b/drivers/gpu/drm/qxl/qxl_display.c
> index c326412136c5..ec50d2cfd4e1 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1183,6 +1183,9 @@ int qxl_destroy_monitors_object(struct =
qxl_device *qdev)
> {
> 	int ret;
>=20
> +	if (!qdev->monitors_config_bo)
> +		return 0;
> +
> 	qdev->monitors_config =3D NULL;
> 	qdev->ram_header->monitors_config =3D 0;
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_kms.c =
b/drivers/gpu/drm/qxl/qxl_kms.c
> index 66d74aaaee06..4dc5ad13f12c 100644
> --- a/drivers/gpu/drm/qxl/qxl_kms.c
> +++ b/drivers/gpu/drm/qxl/qxl_kms.c
> @@ -288,6 +288,10 @@ void qxl_device_fini(struct qxl_device *qdev)
> {
> 	int cur_idx;
>=20
> +	/* check if qxl_device_init() was successful (gc_work is =
initialized last) */
> +	if (!qdev->gc_work.func)
> +		return;
> +
> 	for (cur_idx =3D 0; cur_idx < 3; cur_idx++) {
> 		if (!qdev->current_release_bo[cur_idx])
> 			continue;
> --=20
> 2.29.2
>=20

