Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC04937065A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 10:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhEAIU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 04:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhEAIU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 04:20:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC1FC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 01:20:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ge1so315220pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0QhAMVRyhNZYOJkS7fUdHkK76N85VkHR9KJl9UPz1Y=;
        b=BwppWs5HW/jbJNB2RxDjaX8ydUGFrmXSsSghqsA4s4C5yVNYRb2qgd/bFA/7Njine0
         1oXLMT7wJa1F2+bROSEwmXOrFKLgpX3KgehxvehGzt1lmoCvpXvNrG2qs4bQ9YwIunsD
         dcFYc9Fccj66Zg30m9OfByEkxPH+0zFVa1+xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0QhAMVRyhNZYOJkS7fUdHkK76N85VkHR9KJl9UPz1Y=;
        b=E3j126XcC0M52/z5wivFUYh5tT5v1f6CDbdRZm16fa3y9y6BPNLPdHVqv/1jbNquLe
         S9bb7Z7vK8X7T5PyJsRAVq63eMyDdI1TZjytCRtJC7ZUcQd8xCYIgQ78YS9sfDsHlztK
         YgZ5JKM7NdgPxuwCeAyY9gm1qbiTdKS7aPhRndARlDEzqi6Xol8++DTCAdHl0gHhLMN3
         q8i+0OBLtHSI4aN49T9QMeK59Z5M4dYnOOHDUYp/MBhKvF2j/TLBtUrZfLfBuqczkMG2
         xl7M+XS5RvIPPXgAfULBDJBoni/iqyLaHLyAsZ5CDD1FJD/MCdVgjEOI061UeaJVtDuP
         /unw==
X-Gm-Message-State: AOAM530YSmP0UMVGZF1UW5doLcYChLo50XvI76Wm6srblwuE5FBQhpUb
        tuaqoGp5Am2GS5Q3G1UI8AJVVA==
X-Google-Smtp-Source: ABdhPJwqf9Ub0IV90a1ZxmPebz2HBQYvKnice/9THmJFRh83gL37jdOs/v/FMtOTSdQL8rPMPBEhlg==
X-Received: by 2002:a17:90a:1d4b:: with SMTP id u11mr19137166pju.74.1619857207370;
        Sat, 01 May 2021 01:20:07 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:8be7:e987:d00a:1442])
        by smtp.gmail.com with ESMTPSA id b7sm3763003pjq.36.2021.05.01.01.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 01:20:06 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 0/5] media: uvcvideo: implement UVC 1.5 ROI
Date:   Sat,  1 May 2021 17:19:56 +0900
Message-Id: <20210501082001.100533-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch set implements UVC 1.5 ROI using v4l2_selection API.

v5:
-- fixed UAPI typo: STABILIXATION
-- moved V4L2_CID_REGION_OF_INTEREST_AUTO to V4L2_CID_CAMERA_CLASS_BASE+36
-- added more comments (Ricardo)
-- added V4L2_CID_REGION_OF_INTEREST_AUTO to v4l2_ctrl_get_name() (Ricardo)

Sergey Senozhatsky (5):
  media: v4l UAPI: add ROI selection targets
  media: v4l UAPI: document ROI selection targets
  media: uvcvideo: add ROI auto controls
  media: v4l UAPI: document ROI auto_controls
  media: uvcvideo: add UVC 1.5 ROI control

 .../media/v4l/ext-ctrls-camera.rst            |  23 +++
 .../media/v4l/selection-api-configuration.rst |  22 ++
 .../media/v4l/selection-api-examples.rst      |  27 +++
 .../media/v4l/v4l2-selection-targets.rst      |  24 +++
 drivers/media/usb/uvc/uvc_ctrl.c              |  19 ++
 drivers/media/usb/uvc/uvc_v4l2.c              | 189 +++++++++++++++++-
 drivers/media/v4l2-core/v4l2-ctrls.c          |   1 +
 include/uapi/linux/usb/video.h                |   1 +
 include/uapi/linux/v4l2-common.h              |   8 +
 include/uapi/linux/v4l2-controls.h            |  10 +
 10 files changed, 321 insertions(+), 3 deletions(-)

-- 
2.31.1.527.g47e6f16901-goog

