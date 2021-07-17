Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514E93CC45A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 18:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhGQQIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 12:08:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:50779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhGQQIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 12:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626537934;
        bh=Ghd1MT9V+KwVdIuSzG7J4EaSOKi8X4pveUIBghprPd8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=WncT9rg7u2ldGIfX0LXPAE51RVQAGzC6ZnRb+/bInJr/n2zuV28V+KpyRboDE6SAg
         D5ZQEFfVEAGeMdAIVz0FEBvqAtXuV6LuX4Y4TR0EaFGq7Cy58aoJvPM5iiufzM42Yb
         L1Phhcz99FEULJtZ3otk1Jt4g/C7g5b9JswqL/w4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MLzFr-1lnOOK3Nvl-00HwgC; Sat, 17 Jul 2021 18:05:33 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/most: Remove all strcpy() uses in favor of strscpy()
Date:   Sat, 17 Jul 2021 18:05:12 +0200
Message-Id: <20210717160512.16176-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JiIDoT8iq7qCoDuc3OufKWmgn5NfwOimhPLxZdvokGdKQ4k9jhr
 JV8UwliakEeM4R3K3WrrolsL/05EX4Oe+YAQAlHsPKgdczmk2P+ILPuj3rETkEmAprkHgbD
 plQlYSGIi9y6dPa72D7f1FiU6ZCrztL09FdgEJqox2K/Kh1RiZ6gsWIdaADHiC1LtGe64W/
 k6fyNm59K9Cn7RZVh/b0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4OFPtviAT50=:NO2zq/7nEX57HNYw4jBaZz
 jcF3RPLXNwOfpIxe0BuLbFSmXEaiXkuZM1KtgiMQBQDaJcMP9rU13CMig/Lb8Mxg+Ap8uqMUi
 5ucRUG7l61MIBAl2HOzSDsILNJdneFjq0i24uxrQihr7O6N2XZQh7QTRPRKBCF8NBKuuI1TNh
 hhx2H440FUQQQiFeMtgaPFWRYX29PKFD9CPKmZdXunT1uAJWOpmvpvojTY5GucNpXVUovj1xQ
 N/a0xyaWP5+bsRS0Bg2GT3G4u/IFFsa5DnpaAG5npXQEPW8d3c0/FNa4g8SAPMvvRe358GR03
 5/AZ5oBEiOWpUmUYrZnDBBNPuz52RQe/YkWuUE5eKseRJsO7XGKJPStIhRYiEDlUmKiwvL8SW
 +PWmiwW+A0UICn3UV0kApmjapdzEYZsharufG+gFYNAwXgmxBZQ//mqiJ4+lZwFRXwBeA2Az7
 XodCHq1hQFF8L4rFyWsjeTs+V+UqaTrGxm0yF4FNzkHyr595TG8IEcNnNBMnJ4LPozYiUZyxY
 txXU6jZl+rVuzBeDzj4LuwD5bzQ5lqVZAQZY+lln+U7e3tmJRIqFmR0XU3q4jiaakh3aqyhBS
 VJ7O6ZXbjShS7oSJAHoWDsMpRcg+8zVbxl8F9rRiLOUp8udJXh7BdcqofqhityxbiybmeoZhE
 1UDo2QiK+zoVYZAJDdP5cbktb2xqi09iuD3/xgAAtP4pApHrx1C9nMyPFFqcbt7EwzJB9QhtR
 63BhELlAaD3ct5dRaJtnNCppfwu+o6NYDv5+Z30UxhKoHHB36DAe/7i3A7eQD5A8Y9/+bdqbp
 efQas28vXRXqcHCeaWxxoIoaQ2TYZJRfpMhNjco2vp5f4OGKzmggXTKY0U6nU4Qoa1VZM9ZGm
 tFqVR6dyd6ivZWmIMOj66A0Cfk4shIc68GqYCQlEGfZ2kty0TT693K2DfFqEdAxXad6z9cZkd
 uMbkReTFyHhEdobnR0ZVUSsHU46KztGdK/UmB4Ns1xivBUS1oNv21hVKX44s0H7Pl5TUlDsqJ
 JShTr7/RjTQajIxvJLzpp3vL57EqGT+cqfGb7ltHRl2amYWKbJ7k9kWGwH+sFBCya+87rKDBO
 oXKOK0veWGUF9GO51lxkZMenq2IqtJZfwNR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy().

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/staging/most/video/video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/vid=
eo/video.c
index 90933d78c332..b7858e47145f 100644
=2D-- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -258,7 +258,7 @@ static int vidioc_enum_fmt_vid_cap(struct file *file, =
void *priv,
 	if (f->index)
 		return -EINVAL;

-	strcpy(f->description, "MPEG");
+	strscpy(f->description, "MPEG", sizeof(f->description));
 	f->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	f->flags =3D V4L2_FMT_FLAG_COMPRESSED;
 	f->pixelformat =3D V4L2_PIX_FMT_MPEG;
@@ -306,7 +306,7 @@ static int vidioc_enum_input(struct file *file, void *=
priv,
 	if (input->index >=3D V4L2_CMP_MAX_INPUT)
 		return -EINVAL;

-	strcpy(input->name, "MOST Video");
+	strscpy(input->name, "MOST Video", sizeof(input->name));
 	input->type |=3D V4L2_INPUT_TYPE_CAMERA;
 	input->audioset =3D 0;

=2D-
2.25.1

