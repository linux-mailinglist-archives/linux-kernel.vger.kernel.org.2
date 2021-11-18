Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B04B456563
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhKRWMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhKRWMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:12:18 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0599AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:09:18 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u18so14360155wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8F5qdm3ybEdW5Uy32cxwiH+8yxtt0dvI8EoeBZUz2hM=;
        b=U3a4+FUrrk0N3+aDnRQJtc9Yo9LbnSpoqLFTW8qK/sY94i8woy0tbmLZI5//4uaZxz
         /3gNkaYOloKAEcrXDv9f45HQvgDIbeBC4KFUnYNNPoiQTXwPcQFOGQSj/8/gK5ii/S9V
         yezQZvLvMhS87qpMAcezojFu0O7bJ4Mj4e1uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8F5qdm3ybEdW5Uy32cxwiH+8yxtt0dvI8EoeBZUz2hM=;
        b=JOXc4m6UmHlO1gfuV6dlfOo7vVbC3mAWtXijwR182en43X0cvMKk5W+CaeW0fXPNfw
         7n1AGeG8jqV2TgCMs4LgmUWAKNOOeaxWykbU8RsgtvTDHVsFd8QEZ30n9aaYvcwPvnm6
         cREJkgaiJupF9WiH6RI0th49TQ928MhcoPr/RGZpfGfqn6AqcE2CuFIYcrmxc9TXQ+kS
         3wfd9Pbux1fdJAM5TVX069Jc0Bz0r6g/r6LzKdB9Rdpb4bKh0k6LZggPR/Dr6R9VpeCp
         RPcA2s8A5UvfakuGCCrvjeLdZbKw9UCzw47kuMpSu65sxnz8HwQaSTzDjNsqitGnF1b8
         5PyQ==
X-Gm-Message-State: AOAM530ZLxQk7ZLQvEeXezea9CAG2EpydWK+DqdmxF6JaKzKcr4zsrHd
        pj3wtFRxQHcnmAqJvp0G7IPUjg==
X-Google-Smtp-Source: ABdhPJwzPu9lxfYVngVKF84nS3de+w1uAgNhi+8suRRgDBhSY06IXWjBkLJIcJjxofCpXHcnFezr/w==
X-Received: by 2002:adf:f08d:: with SMTP id n13mr1045300wro.395.1637273356534;
        Thu, 18 Nov 2021 14:09:16 -0800 (PST)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id f7sm13305180wmg.6.2021.11.18.14.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 14:09:16 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "hn . chen" <hn.chen@sunplusit.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/8] uvcvideo: Fixes for hw timestamping
Date:   Thu, 18 Nov 2021 22:09:05 +0000
Message-Id: <20211118220913.299978-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some fixes for fixing hw timestamp on some Logitech and Sunplus
cameras. The issues have been previously reported to the manufacturers.

Also include a patch to fix the current hw timestamping logic for ANY
uvc 1.5 model running at under 16 fps.

Ricardo Ribalda (8):
  media: uvc: Extend documentation of uvc_video_clock_decode()
  media: uvc: Allow quirking by entity guid
  media: uvc: Create UVC_QUIRK_IGNORE_EMPTY_TS quirk
  media: uvcvideo: Quirk for invalid dev_sof in Logi C922
  media: uvcvideo: Quirk for autosuspend in Logi C910
  media: uvcvideo: Allow hw clock updates with buffers not full
  media: uvcvideo: Refactor clock circular buffer
  media: uvcvideo: Fix hw timestampt handling for slow FPS

 drivers/media/usb/uvc/uvc_driver.c |  63 +++++++++++++++
 drivers/media/usb/uvc/uvc_video.c  | 119 ++++++++++++++++++-----------
 drivers/media/usb/uvc/uvcvideo.h   |   4 +
 3 files changed, 142 insertions(+), 44 deletions(-)

-- 
2.34.0.rc2.393.gf8c9666880-goog

