Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5E03ACAD1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhFRMbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhFRMbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:31:38 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCAFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id nb6so15542405ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nd8tKnHteHs+MG91mqWKWWwtIWkod9iePqwAeVKu1cc=;
        b=KN0sDJ7OW7z8kcju8lAYkvE7P4dzWTJHGsZvdtL4mRkHCDn9vo7OB4dyZPlEhF9ttB
         cZ7neAfly6lzhGCp/ryL7SvlzgLwZzOoqrLlDMga9HyGCD3qZx2q9FZ0X5ffciH7tEMa
         IMw8SqRSkwLNiTRxvjWcv7p9eh4zXPvSG8Ke0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nd8tKnHteHs+MG91mqWKWWwtIWkod9iePqwAeVKu1cc=;
        b=uAGgdP6YKclrmlepALk0Vn90g5C+xmhQvQLVVlicNmrzboR5zcQjaUvhWFapeJ4hg5
         MjU7edwt2/XPZmsx4El5Fw+ybt3MOD0rDMqNrJsu806BDy4ZFq1891HBpegVHhjG43Wx
         Eq3QCbFnMumSARVBuBVhMaqQRYa2vJY1aKWafKS9yeomEn7eR0xLnJzAVTBqwb/T0xvl
         foEhO0v0m902+/XctNq5Gv9u8kEh7CcME7nQ3yjR1wFjPAxMgu6CJctAeINV8LWxMg5c
         YarYQB0fORn2Y12EJrJRf1IFKp992kyOkLPcGyf+Egv0V/OTtweM1C5XyHGs8YZ6TRFZ
         zMhQ==
X-Gm-Message-State: AOAM532fA1eb6Vp3+GShU37S2al9zHskIhR/GCrD7Zv/gZxOpxEiCjWe
        kuqFEFA2KU7dZPRdRTk5RUlvhA==
X-Google-Smtp-Source: ABdhPJw7oe3eAD0Y+rrc4wHVXf8so/TYT0pp8TnrvSMwyTcZyU15/zLtuSiJjavJOqFJbnwxbOHi1g==
X-Received: by 2002:a17:906:498b:: with SMTP id p11mr11067164eju.295.1624019366371;
        Fri, 18 Jun 2021 05:29:26 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id o26sm4336403edt.62.2021.06.18.05.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 05:29:25 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v10 00/21] Fix v4l2-compliance errors
Date:   Fri, 18 Jun 2021 14:29:02 +0200
Message-Id: <20210618122923.385938-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*v4l2-compliance -m /dev/media0 -a -f
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

https://patchwork.linuxtv.org/project/linux-media/patch/20210317143453.483470-1-ribalda@chromium.org/

With Hans patch we can also pass v4l2-compliance -s.


Changelog from v9 (Thanks to Hans and Laurent)

- Convert struct uvc_control_class into u32
- Rename uvc_control_class into uvc_control_classes
- Order of variables
- Do not duplicate error messages
- Move "Return -EACCES to inactive control" to the end

Hans Verkuil (4):
  uvcvideo: uvc_ctrl_is_accessible: check for INACTIVE
  uvcvideo: improve error handling in uvc_query_ctrl()
  uvcvideo: don't spam the log in uvc_ctrl_restore_values()
  uvc: use vb2 ioctl and fop helpers

Ricardo Ribalda (17):
  media: v4l2-ioctl: Fix check_ext_ctrls
  media: pvrusb2: Do not check for V4L2_CTRL_WHICH_DEF_VAL
  media: uvcvideo: Do not check for V4L2_CTRL_WHICH_DEF_VAL
  media: v4l2-ioctl: S_CTRL output the right value
  media: uvcvideo: Remove s_ctrl and g_ctrl
  media: uvcvideo: Set capability in s_param
  media: uvcvideo: Return -EIO for control errors
  media: uvcvideo: refactor __uvc_ctrl_add_mapping
  media: uvcvideo: Add support for V4L2_CTRL_TYPE_CTRL_CLASS
  media: uvcvideo: Use dev->name for querycap()
  media: uvcvideo: Set unique vdev name based in type
  media: uvcvideo: Increase the size of UVC_METADATA_BUF_SIZE
  media: uvcvideo: Use control names from framework
  media: uvcvideo: Check controls flags before accessing them
  media: uvcvideo: Set error_idx during ctrl_commit errors
  media: docs: Document the behaviour of uvcvideo driver
  media: uvcvideo: Return -EACCES to inactive controls

 .../userspace-api/media/v4l/vidioc-g-ctrl.rst |   3 +
 .../media/v4l/vidioc-g-ext-ctrls.rst          |   3 +
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c      |   4 -
 drivers/media/usb/uvc/uvc_ctrl.c              | 339 +++++++++++----
 drivers/media/usb/uvc/uvc_driver.c            |  22 +-
 drivers/media/usb/uvc/uvc_metadata.c          |  10 +-
 drivers/media/usb/uvc/uvc_queue.c             | 143 -------
 drivers/media/usb/uvc/uvc_v4l2.c              | 389 +++---------------
 drivers/media/usb/uvc/uvc_video.c             |  43 +-
 drivers/media/usb/uvc/uvcvideo.h              |  50 +--
 drivers/media/v4l2-core/v4l2-ioctl.c          |  67 +--
 11 files changed, 428 insertions(+), 645 deletions(-)

-- 
2.32.0.288.g62a8d224e6-goog

