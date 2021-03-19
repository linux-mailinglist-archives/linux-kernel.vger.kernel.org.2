Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4016C34151D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhCSFyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbhCSFxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:53:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ED5C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:53:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so3910386pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DzC04AgKpS+/8wk1fqCI0DBCCPddOjDutyiB6l+CoiE=;
        b=GG1r+PUpSUiCsiWA/rhCnrpIqujWnH8XG5CuSMVNSsPbXIOhHzOZ9ztfkb7+fxHrZW
         uBrUs9UdI+6tcYmrMdOY3ZOqDwii5pO9R78eSf2SkOFhh5hTqe0PdJd5x+6ob9+XvB2e
         7blnZbg+F3+0FHdDJiWvGxqPl2mX5MzRXVHbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DzC04AgKpS+/8wk1fqCI0DBCCPddOjDutyiB6l+CoiE=;
        b=IAE8Ff0gFs0pVmVxBygW0PhKhcorNm2CQkDez++mx7rehLDGkhHtn5/iYQ4/rH6GvE
         nI7NmYIPY7zTaJbLMu9QZ1/KlUUT+1Hhw//gLjrimBPSm6Sn0PDiCZXSBH31J02OvQc5
         q7VctbiO36v9LBrZI8OmAwYeKLPEPzG9g+X3mWgrQWaTzBoGsBT6rDQZ+kSdnpEb2h9a
         KumqUsApOOvGHR5zAnfnwqDIp3yfi1W3wuQ1RGfccRVIeYashpEw8rEFMNQl3O7QqsuG
         8/imALwf0MNiFMhGGXNUWJvIOBLnP9kFe9PN13G2ypBzf8Aq3z1w0JZQ1tk/ESPvygqA
         uXSQ==
X-Gm-Message-State: AOAM533bcNNsdxleAseeetABOfn1hZiw+J+OvZITKf84EdOjiKmGrMSs
        gKiwb5uWQxfGWt2OhkPtaU3/9Q==
X-Google-Smtp-Source: ABdhPJxD8/Kt3DGZx+0I4wu1sOGDa3KUEYnOOk0Pv/0VTPvK6ObfOyt93+p0/VHmKlBbwIqYn2urKw==
X-Received: by 2002:a17:90b:d85:: with SMTP id bg5mr8072905pjb.230.1616133227483;
        Thu, 18 Mar 2021 22:53:47 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:6577:f83d:5865:dfac])
        by smtp.gmail.com with ESMTPSA id o13sm4043704pgv.40.2021.03.18.22.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 22:53:47 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 0/6] media: uvcvideo: implement UVC 1.5 ROI
Date:   Fri, 19 Mar 2021 14:53:36 +0900
Message-Id: <20210319055342.127308-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch set implements UVC 1.5 ROI using v4l2_selection API.

V3:
- reimplemented ROI. We dont' use split controls anymore.
- Ricardo's feedback

Sergey Senozhatsky (6):
  media: v4l UAPI: add ROI selection targets
  media: v4l UAPI: document ROI selection targets
  media: v4l UAPI: add ROI auto-controls flags
  media: v4l UAPI: document ROI auto-controls flags
  media: uvcvideo: add UVC 1.5 ROI control
  MAINTAINERS: update Senozhatsky email address

 .../media/v4l/selection-api-configuration.rst |  22 +++
 .../media/v4l/selection-api-examples.rst      |  28 ++++
 .../media/v4l/v4l2-selection-flags.rst        |  40 +++++
 .../media/v4l/v4l2-selection-targets.rst      |  24 +++
 MAINTAINERS                                   |   8 +-
 drivers/media/usb/uvc/uvc_v4l2.c              | 147 +++++++++++++++++-
 include/uapi/linux/usb/video.h                |   1 +
 include/uapi/linux/v4l2-common.h              |  18 +++
 8 files changed, 281 insertions(+), 7 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

