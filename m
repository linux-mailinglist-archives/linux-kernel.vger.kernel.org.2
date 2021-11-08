Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B98B449AB6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbhKHR0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbhKHR0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:26:46 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6183DC061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 09:24:02 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id l7-20020a0568302b0700b0055ae988dcc8so23446615otv.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 09:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6WxNy+sbprXqh5vUpIWWndzj2Xknzdzzhl1WXIKKdHQ=;
        b=jGRpem+QkB3LWgMkD1Rnnfu6Yf5Z+jVo0M55XBh3r847EYt0OfjzNGjaPk5xuBakSy
         RlwUxyz48wK1ogpcuTDgcHs4uTnGnHpr51twgj2PHLneYxMhWyTDHMUp4nJ2+bLwAU+R
         7l0esbWNGbAXZ5MspFa6gVYyTrM7mXevu3/yolaB73rYX9qtk6CxQiGISZQ04MyjHM3l
         DE3I91clpu4dXZh2Dx/Eb4Rjau+PkSBwew9QINYrHTuqvKhZUmXliIuIMjI67m4IivvN
         NniEYiZgXrZySmIBeNtjas/D6raW1GjvarZpHFkwl0LZCiF9S45azGPe1edyN16ra4YY
         Opfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6WxNy+sbprXqh5vUpIWWndzj2Xknzdzzhl1WXIKKdHQ=;
        b=tOj/oPk9Ys2oNnrrhKQ6NlBKjkACsGr6BrLbR/mRtGhnh00aLXGKHC1/bwqvuOG032
         Y27B9USMF2lkPTkQuruTkKgcIOGDC7JBd3fyCET6pe++w0E47E1PqwKWKZIA42rcKLLb
         0giN5DEPT4IZ6j2zyCjJSXeGKViB7WIngELF7MKRH7V/U6nssjNJ+SuXyU6PZd8gG+BQ
         pLgXv3ZoxlWT2Kh/w1oOE0OKsHr4/HJ+BBt0qshkGow9jHLDKK9nZSSBB5r2VNpJRunm
         tgVDWYMfrcviLgj9KGjdDLb0kqXr+ioaQnfouDFKt56aFm4Gy1+bxSZ+ujVUxUclcM62
         IurQ==
X-Gm-Message-State: AOAM5314LB+2xa5Yi4CmMOV/jPLYZcItn4ejqygEP2hvXrrBBUNoqi3f
        GBtetF+FCeABXi09T3Iq6wBY8A==
X-Google-Smtp-Source: ABdhPJwnI/0a8eSi6T5sh6kjSDOylJYlYzjZs/9j5wYlWMNfnHQj5nFJ1qQvJFLzV0DvMv8An3yI3A==
X-Received: by 2002:a05:6830:91a:: with SMTP id v26mr462006ott.313.1636392241682;
        Mon, 08 Nov 2021 09:24:01 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y1sm1595919otu.58.2021.11.08.09.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 09:24:01 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Chris Lew <clew@codeaurora.org>,
        Kees Cook <keescook@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [GIT PULL] rpmsg updates for v5.16
Date:   Mon,  8 Nov 2021 11:23:57 -0600
Message-Id: <20211108172357.2477129-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.16

for you to fetch changes up to b16a37e1846c9573a847a56fa2f31ba833dae45a:

  rpmsg: glink: Send READ_NOTIFY command in FIFO full case (2021-10-15 11:02:11 -0500)

----------------------------------------------------------------
rpmsg updates for v5.16

For the GLINK implementation this adds support for splitting outgoing
messages that are too large to fit in the fifo, it introduces the use of
"read notifications", to avoid polling in the case where the outgoing
fifo is full and a few bugs are squashed.

The return value of rpmsg_create_ept() for when RPMSG is disabled is
corrected to return a valid error, the Mediatek rpmsg driver is updated
to match the DT binding and a couple of cleanups are done in the virtio
rpmsg driver.

----------------------------------------------------------------
Alexandru Ardelean (1):
      rpmsg: virtio_rpmsg_bus: use dev_warn_ratelimited for msg with no recipient

Arnaud Pouliquen (1):
      rpmsg: Fix rpmsg_create_ept return when RPMSG config is not defined

Arun Kumar Neelakantam (3):
      rpmsg: glink: Add TX_DATA_CONT command while sending
      rpmsg: glink: Remove the rpmsg dev in close_ack
      rpmsg: glink: Send READ_NOTIFY command in FIFO full case

Cai Huoqing (1):
      rpmsg: virtio: Remove unused including <linux/of_device.h>

Chris Lew (1):
      rpmsg: glink: Remove channel decouple from rpdev release

Kees Cook (1):
      rpmsg: glink: Replace strncpy() with strscpy_pad()

Tinghan Shen (1):
      rpmsg: Change naming of mediatek rpmsg property

 drivers/rpmsg/mtk_rpmsg.c         |  2 +-
 drivers/rpmsg/qcom_glink_native.c | 90 +++++++++++++++++++++++++++++++++++----
 drivers/rpmsg/virtio_rpmsg_bus.c  |  3 +-
 include/linux/rpmsg.h             |  2 +-
 4 files changed, 85 insertions(+), 12 deletions(-)
