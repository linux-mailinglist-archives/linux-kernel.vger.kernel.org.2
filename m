Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8409D33DBF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbhCPSB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239540AbhCPSAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:00:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D47EC061763
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:00:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r17so73663238ejy.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ckk2erlqddqu+PG/7Bp2HBZ/AtQ6BgEsYvEVjbfanBw=;
        b=F4cmoL2cuQ7J+/UksOxy2Cyk73iLpsXM2Lw2bkdu0FlxwBhibMbM7bdd/OrqU5UAHp
         8+edCkQYZfQZzdpEZOSQ3rm2+upKBaeugDnkfNbmJ4xxRNwfCqM7uL1vjQW7RAa7fAFt
         +w33wVdBJnI6h+VhoT3mowWvdS/9K2eF9RSCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ckk2erlqddqu+PG/7Bp2HBZ/AtQ6BgEsYvEVjbfanBw=;
        b=Yby2nBFbz1YT0JuYoCI2tpsopx/w6UQZWqKXL6mFi4U1wSPx5bmT/PBc87qkVOW3bm
         8i2SOICr8y4Aa8ZzOdUlC5vOcmEIlUlyfbfm1gEVzacYAuvFUXoa8rdbu656I8QyPJSe
         qmDWbRaMYfAMpz4g11X33qhgI7z3eduxaGi2AgOEZS7Tf/g90DEeIyvdbzhInSbb42E3
         SYZ+/fi2tvzA4iCpbjhIweoGQ3FiApvNYwXd0DfST0AeSk4t4FJvSUf2PE610rLNdFpl
         C2jxY5+XIvR3xxKo6FMP7Sn201aG0uN9lvxBDrBD73MaRQS5xrb7U4GbB+17mMxpohGT
         Sgwg==
X-Gm-Message-State: AOAM530uhtdoXlSU38ZHLRnqS4G2IixiSM1eFdUUtQ9WyBcbuyNqen9R
        B5I/q7rgW6bPnWLtBBOFJIfqzw==
X-Google-Smtp-Source: ABdhPJwc4piGP+4s8AlfA/HkFlkdi4TkpIECrDLX5CnIQAa932qG9uExuxIDNqGFTJNsXfcvxsx+aw==
X-Received: by 2002:a17:906:2db2:: with SMTP id g18mr31466097eji.73.1615917607893;
        Tue, 16 Mar 2021 11:00:07 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id c19sm10953182edu.20.2021.03.16.11.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:00:07 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 00/13] uvcvideo: Fix v4l2-compliance errors
Date:   Tue, 16 Mar 2021 18:59:50 +0100
Message-Id: <20210316180004.1605727-1-ribalda@chromium.org>
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

Changelog  from v4 (Thanks to Hans and Laurent)
- Use framework names for controls
- Check the control flags before accessing them
- Drop meta headers instead of returning error
- Fix error_idx handling in v4l2-ioctl

Hans Verkuil (1):
  uvc: use vb2 ioctl and fop helpers

Ricardo Ribalda (12):
  media: v4l2-ioctl: Fix check_ext_ctrls
  media: uvcvideo: Set capability in s_param
  media: uvcvideo: Return -EIO for control errors
  media: uvcvideo: Check controls flags before accessing them
  media: uvcvideo: refactor __uvc_ctrl_add_mapping
  media: uvcvideo: Add support for V4L2_CTRL_TYPE_CTRL_CLASS
  media: uvcvideo: Use dev->name for querycap()
  media: uvcvideo: Set unique vdev name based in type
  media: uvcvideo: Increase the size of UVC_METADATA_BUF_SIZE
  media: uvcvideo: Return -EACCES to inactive controls
  media: uvcvideo: Use control names from framework
  media: v4l2-ioctl: Set error_idx to the right value

 drivers/media/usb/uvc/uvc_ctrl.c     | 209 +++++++++++----
 drivers/media/usb/uvc/uvc_driver.c   |  22 +-
 drivers/media/usb/uvc/uvc_metadata.c |   8 +-
 drivers/media/usb/uvc/uvc_queue.c    | 143 ----------
 drivers/media/usb/uvc/uvc_v4l2.c     | 373 ++++++---------------------
 drivers/media/usb/uvc/uvc_video.c    |  13 +-
 drivers/media/usb/uvc/uvcvideo.h     |  41 +--
 drivers/media/v4l2-core/v4l2-ioctl.c |  40 ++-
 8 files changed, 303 insertions(+), 546 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

