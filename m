Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C383DF5F1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 21:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240326AbhHCTqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 15:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240287AbhHCTq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:46:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5466C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 12:46:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so5435955pjr.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZbrdU/UKTkICYXn4Y/qNSu6Ip6OLOZ53UNNbGHdwbHU=;
        b=D2T4s519RH3o9DayGWyvABZ9W7BIdA95AhOD58ZBgWpCWfnrRGsupR2lelPe0MOAMS
         GGkv5nwXbFA9GUTbRea9BKoAC/caLzEurBN+4hyeLdZrjZt24GGUJfgw1slT1428DKOe
         3cVeZWb4UoLMsWiz+9cGUkSrXObot0nsc+NSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZbrdU/UKTkICYXn4Y/qNSu6Ip6OLOZ53UNNbGHdwbHU=;
        b=sWjPxr4qJHxXSJRiNikJl9tfwtwwjBdXHyJ5WIo6/eiwC/Q2HUK1hP32NpV5+iBNrL
         NxIFs7gHIbqMjgG0XYuY/Y4lSL4Fmwxk/NmnzC6D7lAAValmWk8d3Ap4kDIKZq+GHMxP
         v6Ala6b79B+zqioTCZotQ0W+W+E2/eH3ANGBF8FSWclH5/6dFOpR5Eu08kbWNXSLfj3p
         k38ov3/e3xebWZeDHGTP03BJU3a3XyILeXZrnI7+yfK8zILMBPDlyzkOZ37+q+p5PQoj
         Ac81fXb50cYkMEFB41oo11OCK5u6nyluIBz3fw+Ivs8TIrDO54EH0qNTBNxZpCqssxlL
         2lZA==
X-Gm-Message-State: AOAM533CoaojCHxfPsrJLF5n+cYUoVmJme5K7Ic0mSeXYClcOMePXVkZ
        DJ0xbg89IThnmtr0yGUs99y2Fw==
X-Google-Smtp-Source: ABdhPJyYZ9B3BySnH9oqZjhdZO0wroXHMvbLrQY9HN7ZWMHW3Jp2a0+s/gAl92r8CGhxar10BbsyDg==
X-Received: by 2002:aa7:921a:0:b029:2cf:b55b:9d52 with SMTP id 26-20020aa7921a0000b02902cfb55b9d52mr23271704pfo.35.1628019975270;
        Tue, 03 Aug 2021 12:46:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d2sm3696139pjd.24.2021.08.03.12.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:46:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 3/3] media: tm6000: Avoid card name truncation
Date:   Tue,  3 Aug 2021 12:46:10 -0700
Message-Id: <20210803194610.326030-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210803194610.326030-1-keescook@chromium.org>
References: <20210803194610.326030-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; h=from:subject; bh=1oDzfdaSSwG4d9ZmaRw6FpYznHEboP9KMhXO0fjsR1w=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhCZ0CjUb+8eRC03abQg/vPUYewXl0dlfpCowJI9Qa wahO6baJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQmdAgAKCRCJcvTf3G3AJktXD/ 9r41B3rfRsB7I5sxiQh3GMYhUOSHYqYQqpXYTxVhhoxwCrZ/HeG8v/8KlQ7SIa0dOWK3VgRwzbkTUz sAZjRSI8PWRyKSggA2gALGOHOn9EjLnCU6ILhxnVt6PgQywGBxIvZU9LyaST7NIO52WPsDLLgLcEvO axsZzRr1TY+bDDpsREJzgvyMp6TeLZiUUdvo0iS2HKsydRnlj04KuPppyHtHxw9bsYYtTD+345vnRz +tKheOLSDPwCOL1jIxDziaPt7wWE/t1FAw8SjM96uRcgAwlzF8hGzUZQAxhwJcXMMFIOsmVwJHfP0k 1wUaaub+05dCPC5sZf2ycvapqZurCdCQpl5RyXO86JqiPqnL2SW+tlfxXoYo3d64Ggh8SLXv3rpDmo uYtUF/4Pye84w0Pq2UsdLNFAtRdm3bI0Tc1azgstp6E3ngSR27D9FeEiA1LubprBI0ZoUTAsjt1VV/ 1TmHS76Bp8C5ZMziqMBe+H5ykGvGGTniLAWjZRZ/Sw/2K8xCYJlogUUk7PqqgWRMqfBr5YxYywCeTP yTFJG4mtURnyJbplwg03ar3BXdlRYbepLObdPFbVWppCV/0d+/HFJIEARTmCDDcg+1WR7nwqtaCgmp Fp+xow7hdez1mmcEYnPDUAGK8K0D11TWU6I0aXkrT0+HCB/OkkifMxsqI/GQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "card" string only holds 31 characters (and the terminating NUL).
In order to avoid truncation, use a shorter card description instead of
the current result, "Trident TVMaster TM5600/6000/60".

Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
Fixes: e28f49b0b2a8 ("V4L/DVB: tm6000: fix some info messages")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/media/usb/tm6000/tm6000-video.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/usb/tm6000/tm6000-video.c b/drivers/media/usb/tm6000/tm6000-video.c
index 3f650ede0c3d..e293f6f3d1bc 100644
--- a/drivers/media/usb/tm6000/tm6000-video.c
+++ b/drivers/media/usb/tm6000/tm6000-video.c
@@ -852,8 +852,7 @@ static int vidioc_querycap(struct file *file, void  *priv,
 	struct tm6000_core *dev = ((struct tm6000_fh *)priv)->dev;
 
 	strscpy(cap->driver, "tm6000", sizeof(cap->driver));
-	strscpy(cap->card, "Trident TVMaster TM5600/6000/6010",
-		sizeof(cap->card));
+	strscpy(cap->card, "Trident TM5600/6000/6010", sizeof(cap->card));
 	usb_make_path(dev->udev, cap->bus_info, sizeof(cap->bus_info));
 	cap->capabilities = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_READWRITE |
 			    V4L2_CAP_DEVICE_CAPS;
-- 
2.30.2

