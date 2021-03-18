Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82D8340F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhCRU3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhCRU3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:29:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5991FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:29:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k10so6029919ejg.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3hi9oL99n8axRv4F2xKskdWpq2vH4h46Ymny3ztdTvk=;
        b=PVzxiSkyxe87SQaAcBYjQURstMVlXnK+tLPtxtdE6tpqXE1mRe3ciREBRxvQg/fAku
         ZCsIbVejywf27xZVexGr3GzBkpl8BYGxFaNZ4z/96cCKAJxYmy/giwj1t+ko8lmDZDfV
         MpJzHvA5uH3H/Bn2pRzDN167EaRkXVkkCwRtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3hi9oL99n8axRv4F2xKskdWpq2vH4h46Ymny3ztdTvk=;
        b=C7x1jAO8g24oe5xJMJ8dL6jOGC035SfK5HVxF/Hr6fqSAJdAoC27aHTVMb+3/CS6yb
         sY74/MGrRzlK7X26n8dYdnxWra3UOzw/tntoTsLZMbTxmYgNOVmqXfxRKssD/1bEXcqr
         RPcxQbpnM/+dzcPCRi7Rrw3uR/wS0lKqQ6Z91exJ+oNnB3av+UvXWDxIMZz3nhUns49t
         kvW6tJ3aggPGLH2CDDro86LRvq98ew4lFEQABKMp82w8rJWjaEtKXuFuDMAmz9j/BCQg
         AyRr89nm9hczpUcmKXGB92lhNHjjiixlgAWlNfM/p7iK6mQB8QYDFj9VTh9UaTa+yd0Y
         OkVg==
X-Gm-Message-State: AOAM532dOy+PN4Z5Oh7JFnjcqu2Smh78OHQ20T34NkkA5hYiQ/gekxXy
        lQDnJ+GjhBKXltx8XboaUo3pgw==
X-Google-Smtp-Source: ABdhPJzLP+uwu5YSXQao8b4J2rrtU919i1z94pi9b727GF+e7lQT+RoFDA3ZzII362HIXcnA2WVTYQ==
X-Received: by 2002:a17:906:a0d4:: with SMTP id bh20mr418725ejb.348.1616099370152;
        Thu, 18 Mar 2021 13:29:30 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id a22sm2533767ejr.89.2021.03.18.13.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:29:29 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v7 00/17] uvcvideo: Fix v4l2-compliance errors
Date:   Thu, 18 Mar 2021 21:29:11 +0100
Message-Id: <20210318202928.166955-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4l2-compliance -m /dev/media0 -a -f
Total for uvcvideo device /dev/media0: 8, Succeeded: 6, Failed: 2, Warnings: 0
Total for uvcvideo device /dev/video0: 54, Succeeded: 50, Failed: 4, Warnings: 2
Total for uvcvideo device /dev/video1: 46, Succeeded: 46, Failed: 0, Warnings: 0
Grand Total for uvcvideo device /dev/media0: 108, Succeeded: 102,
Failed: 6, Warnings: 2

After fixing all of them we go down to:

Total for uvcvideo device /dev/media0: 8, Succeeded: 8, Failed: 0, Warnings: 0
Total for uvcvideo device /dev/video0: 54, Succeeded: 54, Failed: 0, Warnings: 0
Total for uvcvideo device /dev/video1: 46, Succeeded: 46, Failed: 0, Warnings: 0
Grand Total for uvcvideo device /dev/media0: 108, Succeeded: 108,
Failed: 0, Warnings: 0

YES, NO MORE WARNINGS :)

Note that we depend on:
https://patchwork.linuxtv.org/project/linux-media/patch/20210315172531.101694-1-ribalda@chromium.org/

With Hans patch we can also pass v4l2-compliance -s.

Changelog  from v6 (Thanks to Hans)
- Squash all check_ext_ctrls patches
- Add documentation patch
- Return the correct ctrl_idx if the hw fails
- Fix accessible typo
- Set the proper name also for the metadata node

Hans Verkuil (1):
  uvc: use vb2 ioctl and fop helpers

Ricardo Ribalda (16):
  media: v4l2-ioctl: Fix check_ext_ctrls
  media: pvrusb2: Do not check for V4L2_CTRL_WHICH_DEF_VAL
  media: uvcvideo: Do not check for V4L2_CTRL_WHICH_DEF_VAL
  media: uvcvideo: Set capability in s_param
  media: uvcvideo: Return -EIO for control errors
  media: uvcvideo: refactor __uvc_ctrl_add_mapping
  media: uvcvideo: Add support for V4L2_CTRL_TYPE_CTRL_CLASS
  media: uvcvideo: Use dev->name for querycap()
  media: uvcvideo: Set unique vdev name based in type
  media: uvcvideo: Increase the size of UVC_METADATA_BUF_SIZE
  media: uvcvideo: Use control names from framework
  media: uvcvideo: Check controls flags before accessing them
  media: uvcvideo: Return -EACCES to inactive controls
  media: docs: Document the behaviour of uvcdriver
  media: uvcvideo: Refactor __uvc_ctrl_commit
  media: uvcvideo: Set error_idx during ctrl_commit errors

 .../userspace-api/media/v4l/vidioc-g-ctrl.rst |   5 +
 .../media/v4l/vidioc-g-ext-ctrls.rst          |   5 +
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c      |   4 -
 drivers/media/usb/uvc/uvc_ctrl.c              | 312 +++++++++++----
 drivers/media/usb/uvc/uvc_driver.c            |  22 +-
 drivers/media/usb/uvc/uvc_metadata.c          |  10 +-
 drivers/media/usb/uvc/uvc_queue.c             | 143 -------
 drivers/media/usb/uvc/uvc_v4l2.c              | 360 ++++--------------
 drivers/media/usb/uvc/uvc_video.c             |  13 +-
 drivers/media/usb/uvc/uvcvideo.h              |  53 +--
 drivers/media/v4l2-core/v4l2-ioctl.c          |  59 ++-
 11 files changed, 408 insertions(+), 578 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

