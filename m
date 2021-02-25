Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC95324E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 11:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhBYKiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 05:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbhBYKRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 05:17:15 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DF3C061794
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 02:16:35 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t9so3214262pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 02:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wMbLxKNkDpzuPU6JFjBqwFju2l5enVa2Q9qyY3MVMko=;
        b=iSbZeNvwHuJObcFu4RyPI7EPpnGmLo3djTp9h0fyP0WpliZTdI+8qO0KpBf1BV49C8
         6nlTnigI+sHrvnUwHm3aqwUml5zAqVRaCBJxyVddwht91uak0IrxFS85iN/LtbEWdRfW
         OcHHlrGLBBCffLj6xLn51ggUJp76hilQGtUpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMbLxKNkDpzuPU6JFjBqwFju2l5enVa2Q9qyY3MVMko=;
        b=jXs4i6MEybxMsjbtElWAdQ++IC5oI26f3NWqPECTVmi/EevYHOPvFJkuklxfp0C9jM
         L3rzsFW71/B/t/GgkpJv9uGKBzlbA3dOAizJcaqVWeuEWC9xaobKrfaInNZqGJ41Suyu
         poYcZCkj76vWelsgl70p+pFwbYKgU73iIEPYpIfs4ddEPnr30m/Ryqr/h5kBJdCTXWiF
         7Y7LyZI47kzc/ynobfTDWJME5j2/i0Ey3tSs1ijykFSKu0JZOhcTzG8J7WCmM9RSTyJH
         H+PK7oJEfTZtsxtPfeFt1s58jnwVGfF7wG52m8IbN23hLaAJF6RZNjAwsJcc7Txn6a9s
         aRJA==
X-Gm-Message-State: AOAM531J4bvUtmd5YDEMqpkELjXl4j5XaznVhAMDKEvkC2TgUG+e1Xw7
        4qHYR3jKGZ8ALdxSrFthPyn4vg==
X-Google-Smtp-Source: ABdhPJyhV7QwrwKdc7ep1kJ+J2ce9B6LF+AJR7Q5+X6FUg34c6aXUJnzIPh+Sm0uGhau+LCPyL5PcA==
X-Received: by 2002:a17:902:d2cb:b029:de:757c:1f0c with SMTP id n11-20020a170902d2cbb02900de757c1f0cmr2494422plc.40.1614248194556;
        Thu, 25 Feb 2021 02:16:34 -0800 (PST)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:2550:3154:2c53:b6e7])
        by smtp.gmail.com with ESMTPSA id z2sm5848193pfc.8.2021.02.25.02.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 02:16:34 -0800 (PST)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v2 3/8] media: add Mediatek's MM21 format
Date:   Thu, 25 Feb 2021 19:16:07 +0900
Message-Id: <20210225101612.2832444-4-acourbot@chromium.org>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
In-Reply-To: <20210225101612.2832444-1-acourbot@chromium.org>
References: <20210225101612.2832444-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Mediatek's non-compressed 8 bit block video mode. This format is
produced by the MT8183 codec and can be converted to a non-proprietary
format by the MDP3 component.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 Documentation/userspace-api/media/v4l/pixfmt-reserved.rst | 7 +++++++
 drivers/media/v4l2-core/v4l2-ioctl.c                      | 1 +
 include/uapi/linux/videodev2.h                            | 1 +
 3 files changed, 9 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index c9231e18859b..187ea89f7a25 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -242,6 +242,13 @@ please make a proposal on the linux-media mailing list.
 	It is an opaque intermediate format and the MDP hardware must be
 	used to convert ``V4L2_PIX_FMT_MT21C`` to ``V4L2_PIX_FMT_NV12M``,
 	``V4L2_PIX_FMT_YUV420M`` or ``V4L2_PIX_FMT_YVU420``.
+    * .. _V4L2-PIX-FMT-MM21:
+
+      - ``V4L2_PIX_FMT_MM21``
+      - 'MM21'
+      - Non-compressed, tiled two-planar format used by Mediatek MT8183.
+	This is an opaque intermediate format and the MDP3 hardware can be
+	used to convert it to other formats.
     * .. _V4L2-PIX-FMT-SUNXI-TILED-NV12:
 
       - ``V4L2_PIX_FMT_SUNXI_TILED_NV12``
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 31d1342e61e8..0b85b2bbc628 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1384,6 +1384,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_TM6000:	descr = "A/V + VBI Mux Packet"; break;
 	case V4L2_PIX_FMT_CIT_YYVYUY:	descr = "GSPCA CIT YYVYUY"; break;
 	case V4L2_PIX_FMT_KONICA420:	descr = "GSPCA KONICA420"; break;
+	case V4L2_PIX_FMT_MM21:		descr = "Mediatek 8-bit block format"; break;
 	case V4L2_PIX_FMT_HSV24:	descr = "24-bit HSV 8-8-8"; break;
 	case V4L2_PIX_FMT_HSV32:	descr = "32-bit XHSV 8-8-8-8"; break;
 	case V4L2_SDR_FMT_CU8:		descr = "Complex U8"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 79dbde3bcf8d..e6890dae76ec 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -731,6 +731,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_Y12I     v4l2_fourcc('Y', '1', '2', 'I') /* Greyscale 12-bit L/R interleaved */
 #define V4L2_PIX_FMT_Z16      v4l2_fourcc('Z', '1', '6', ' ') /* Depth data 16-bit */
 #define V4L2_PIX_FMT_MT21C    v4l2_fourcc('M', 'T', '2', '1') /* Mediatek compressed block mode  */
+#define V4L2_PIX_FMT_MM21     v4l2_fourcc('M', 'M', '2', '1') /* Mediatek 8-bit block mode, two non-contiguous planes */
 #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel Planar Greyscale 10-bit and Depth 16-bit */
 #define V4L2_PIX_FMT_SUNXI_TILED_NV12 v4l2_fourcc('S', 'T', '1', '2') /* Sunxi Tiled NV12 Format */
 #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4-bit packed depth confidence information */
-- 
2.30.0.617.g56c4b15f3c-goog

