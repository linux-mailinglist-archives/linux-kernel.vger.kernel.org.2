Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8053422E2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhCSRJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSRJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:09:10 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECBCC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j3so11602601edp.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yxeFHmptn0JVYjjqlep/ixg1qpU4RxiT/QKSI0OyjHc=;
        b=OUSENcb1+KLAurvQEX9kaSQEr3/k1o6OqWgGLaRaBvgDxIzi7ceEdb3NOFr8E9GZfE
         9cy5HkgU3fR+x7XCH+TcCZ3mQN29B/FSFb8d/KwF7ghRMyGUeiBqIYftJoKjKpN93qYz
         TPIIOhSgXvIp0ClAz+re1DN2slm6JcO4EuGu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yxeFHmptn0JVYjjqlep/ixg1qpU4RxiT/QKSI0OyjHc=;
        b=VIux8v9sDKEpwWHRAlHQ061raHN6jcMyl/QA1yxgNzwdlCB8dtjtUctn4y9BUY+j3L
         4znPGH+fhn4C0qejUbxFPZrcCxWd7yfyR/TpdfZ2cVINo804i+cU2P4/vXZCuJm3CpGy
         8uQTcp4sYd9AiZOpNYfiwvg9wDfu35mcDna0QdyQgXEImtC0JCf4lDvqhzu6pVH4pewj
         bLOXKcLpdH8ZANO9nqMwDGN6mv0iGW4+0UmzhjPYEe39eqCXxCz70iXv4Kqt8VCsWFnj
         pVnksW5LlTuevQuYNB4IoLgm1YnlfoYN6xNFo45J1YadIyaw+xT1nQ3jWXjH543rQtz8
         4hwg==
X-Gm-Message-State: AOAM530k9jkOd0pRWfe3KQrQ/RfBmmR02Lef8oosrDz/G4uxzPZv/v+J
        hOJzIU9H3oEpe9vxwzavQC6Ybg==
X-Google-Smtp-Source: ABdhPJw8h2DAmHs6sC4U1duVV+7Dv/e4EBZwqc/1X+yZx3H0K7qDvJ1oXNxg68CRUedHrhAtoDLP+Q==
X-Received: by 2002:a05:6402:447:: with SMTP id p7mr10841424edw.89.1616173749101;
        Fri, 19 Mar 2021 10:09:09 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id be27sm4506050edb.47.2021.03.19.10.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:09:08 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 00/19] uvcvideo: Fix v4l2-compliance errors
Date:   Fri, 19 Mar 2021 18:08:47 +0100
Message-Id: <20210319170906.278238-1-ribalda@chromium.org>
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

https://patchwork.linuxtv.org/project/linux-media/patch/20210317143453.483470-1-ribalda@chromium.org/

With Hans patch we can also pass v4l2-compliance -s.

Changelog from v7 (Thanks to Hans)
- Fix error in v4l2-ioct regarding S_CTRL
- Remove s_ctrl and g_ctrl from the driver
- Re-implement the error_idx handling
- Downgrade some error messages to debug messages
- Fix typo S_CROP isntead of S_CTRL

Hans Verkuil (1):
  uvc: use vb2 ioctl and fop helpers

Ricardo Ribalda (18):
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
  media: uvcvideo: Return -EACCES to inactive controls
  media: docs: Document the behaviour of uvcdriver
  media: uvcvideo: Downgrade control error messages

 .../userspace-api/media/v4l/vidioc-g-ctrl.rst |   5 +
 .../media/v4l/vidioc-g-ext-ctrls.rst          |   5 +
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c      |   4 -
 drivers/media/usb/uvc/uvc_ctrl.c              | 309 ++++++++++----
 drivers/media/usb/uvc/uvc_driver.c            |  22 +-
 drivers/media/usb/uvc/uvc_metadata.c          |  10 +-
 drivers/media/usb/uvc/uvc_queue.c             | 143 -------
 drivers/media/usb/uvc/uvc_v4l2.c              | 389 +++---------------
 drivers/media/usb/uvc/uvc_video.c             |  15 +-
 drivers/media/usb/uvc/uvcvideo.h              |  53 +--
 drivers/media/v4l2-core/v4l2-ioctl.c          |  66 +--
 11 files changed, 392 insertions(+), 629 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

