Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54940CDB2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhIOUGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbhIOUGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:06:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1274CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:05:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i6so7971796edu.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hW/OeF+2xThCoBB4pO2KSop//D4gyfmqL/cgUEWN854=;
        b=ZeZC9y8WTuQ5xOUUN140j8hngeIb/TNzOMqzz0d7m3aBDsc50IGyYclfdfQx4gY8bE
         wsAMqtQSlQg8T6q52pvOflBelYePPKb852XpyB2EPiKnWwU1C38V9bESgIZqnrWJkE7L
         5iEEFpX7edlN+JQ/YWHU19QaTX3dQPB7SQ4iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hW/OeF+2xThCoBB4pO2KSop//D4gyfmqL/cgUEWN854=;
        b=VIHFdxyQP02Kb6xE1ziZTd7zVrq3+Kw439kyYdmrgT16zGaurFrRkifXH0kl6OcG1F
         Imdqx5wqWL1/gnK6YIrI7r4RU9kpJTcPN7RibasAiIqWCHqYnlaIn9kNuYSKvuqM9XYt
         ziaU571xJVkk+dsVGgegAsx94P/hMh65WqPLEMk5YYNAMpa0BR8z5bEkSJhYBtz07548
         ZpG8MdtLaVguUxMQzlV58/3qWGxr4SVMG2y3c1R+lOMrFSJitsug+apPLpTl8ibV1gCX
         qKNJ9Z7q6fo3C5mjV7V4CXc0GuU0g6TVFYoQZZwStDikxeNVPhnG2AU/BrbM1RFTHveP
         L/Eg==
X-Gm-Message-State: AOAM531NOBaZ1nKHaCLxxSd9owqVdYyljHhtmjutvV2BQ3spRB/giAOl
        CamH1TlZZjteeMaqhmYXdQdAD3c1lX5u7g==
X-Google-Smtp-Source: ABdhPJxg5GiL5c5raQanus97SGqZg90ifRcLnTaTejtUIOiCzHzeeh56TA2aKN6i3hVAyNBXEX2F7A==
X-Received: by 2002:a17:906:1f81:: with SMTP id t1mr1948581ejr.510.1631736328496;
        Wed, 15 Sep 2021 13:05:28 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id m17sm393336ejn.108.2021.09.15.13.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:05:28 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hn.chen@sunplusit.com
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 1/3] media: uvc: Extend documentation of uvc_video_clock_decode()
Date:   Wed, 15 Sep 2021 22:05:23 +0200
Message-Id: <20210915200525.448941-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
In-Reply-To: <20210915200525.448941-1-ribalda@chromium.org>
References: <20210915200525.448941-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a explicit reference to uvc 1.5, explaining how the algorithm
supports the different behaviour of uvc 1.1 and 1.5.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index e16464606b14..77f4090f27d2 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -505,6 +505,9 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 
 	/* To limit the amount of data, drop SCRs with an SOF identical to the
 	 * previous one.
+	 * This filtering is also needed for supporting UVC 1.5. Where all the
+	 * data packages of the same frame contains the same sof. In that case
+	 * only the first one will match the host_sof.
 	 */
 	dev_sof = get_unaligned_le16(&data[header_size - 2]);
 	if (dev_sof == stream->clock.last_sof)
-- 
2.33.0.309.g3052b89438-goog

