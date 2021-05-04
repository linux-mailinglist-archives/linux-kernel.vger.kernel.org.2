Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA066372CAF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhEDPEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhEDPEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:04:36 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EB0C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 08:03:41 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id c36-20020a05683034a4b02902a5b84b1d12so8100017otu.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l8oxEK0+HwDjIWVBD1cWvA/dkEeyw6Fa4y4+NCRnCdk=;
        b=rptIgdPwijnJU9k8ZIhkIFHQKzmOWBMLdboLN4DiHSB6ajKrCDv/dUP3BxQlhhw3Fi
         kfFbRLMqTN08J8VcsaNVVoP22D0ecMO9+itmMPNnROXzJPWMdR6dj7bD0E5J6LwIjGSJ
         kf174jRXWuEjO31IOeXhTcvQmsqdHwMlqI1W+jWAnZwUUNa2u+4NRNkiVAwa7LoqZ1Ek
         otcAEcnBKmXZfYGQEqKptnfu78zK1R8M0jH0c/rvs4cQy6tavakW8MoVzLftyOMicsP4
         +3BOd6rLeyUi+oqqtqzthd+MsveW/nOyLSZHjPqd2akN6xLjiKvrkiEAtITSbD69Z5TG
         xNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l8oxEK0+HwDjIWVBD1cWvA/dkEeyw6Fa4y4+NCRnCdk=;
        b=Om+70gw1B6CnJQsrEK3/6s/1v7ZdhVAfroMIXEl1rk8rPStGzNft+WSV5YNB5ss409
         +wmV8YYKsMCKBufdYxuQ/3A8rZA7cUmnLtd+QO/3XEJysQ/I7vsL/2zcmsfb/m8LQL78
         PkUZkKs9hpDFDA0CMpQ9nD4gnh+sEAMLvc+Nh8DkzRA85Q425fZBh89ojHiTR9Y7tUR1
         BrMpe2Cc/FAlDK5SvccVkHRzpTkppjnHLspVKhfgZfV+X6EodC0REGoi7bkkzxmW0mE4
         yn2umZTl3ycZ4kkHyCNjf9QMeLvuwnYIE6pL+V8HRGOuAGoqfz2cmyt83FnUKncndZe+
         Uz6w==
X-Gm-Message-State: AOAM530ajlAXeAxJI9j2jZKaAJQ2ydunHG+s0BLLevttPA052iUO9ZC+
        cC8tQbyM4/iIMdAAxAhEaCppqA==
X-Google-Smtp-Source: ABdhPJw26S/9SPWC8/ajfC1G/sCNkJ7Mf+PS89amtiIxRCPcoQMPRpwZLMhDqBH2I5myNvfiBqew/g==
X-Received: by 2002:a9d:4787:: with SMTP id b7mr1211201otf.280.1620140620503;
        Tue, 04 May 2021 08:03:40 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i130sm747856oif.49.2021.05.04.08.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 08:03:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [GIT PULL] rpmsg updates for v5.13
Date:   Tue,  4 May 2021 10:03:39 -0500
Message-Id: <20210504150339.1468558-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rpmsg-v5.13

for you to fetch changes up to 26594c6bbb60c6bc87e3762a86ceece57d164c66:

  rpmsg: qcom_glink_native: fix error return code of qcom_glink_rx_data() (2021-04-09 11:08:42 -0500)

----------------------------------------------------------------
rpmsg updates for v5.13

In addition to some bug fixes and cleanups this adds support for
exposing the virtio based transport to user space using the rpmsg_char
driver.

----------------------------------------------------------------
Arnaud Pouliquen (6):
      rpmsg: char: Rename rpmsg_char_init to rpmsg_chrdev_init
      rpmsg: Move RPMSG_ADDR_ANY in user API
      rpmsg: Add short description of the IOCTL defined in UAPI.
      rpmsg: char: Use rpmsg_sendto to specify the message destination address
      rpmsg: virtio: Register the rpmsg_char device
      rpmsg: char: Return an error if device already open

Jia-Ju Bai (1):
      rpmsg: qcom_glink_native: fix error return code of qcom_glink_rx_data()

 drivers/rpmsg/qcom_glink_native.c | 17 +++++++++++
 drivers/rpmsg/qcom_smd.c          | 16 ++++++++++
 drivers/rpmsg/rpmsg_char.c        | 11 ++++---
 drivers/rpmsg/virtio_rpmsg_bus.c  | 62 +++++++++++++++++++++++++++++++++++----
 include/linux/rpmsg.h             |  3 +-
 include/uapi/linux/rpmsg.h        | 13 ++++++--
 6 files changed, 109 insertions(+), 13 deletions(-)
