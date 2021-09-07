Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A209D402A53
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhIGOBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhIGOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:01:32 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51744C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 07:00:26 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so2933740ooh.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SA1mhtpYtWRd9fvfdDUUAhfghCCNO8LibpejZwbq7KY=;
        b=Abu+rZI3qC8rCRA/sBxBT++VNhG0T4Y68e0Gk8fqRDSxmUvfe7dtCYfNWr3Wvdhr/U
         gfS5QmShGVNu68yIeA4aikN1wVlnxLd2qB1AuGE05J/jopYhXF6x/8NTqxZbvq14tzyM
         owRmBKO/LhoBPGI6h8c/IxbfSx3WFwezyyWUrP+2tFUwpZ32inTtl3m2j5WZUjCI0+em
         +bwqG3joXUpchLSOgLfk5eZnbUAlYgyjLvh8xuUPpLn922rGGB+muel4mo6xt6Z+Was5
         Q/f2oOx5IwndB2BwV6n6fzTbuvrQJk7CAhsutoM7GwCK9tMssFfFGXWPD5kTNAOAva3a
         ApxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SA1mhtpYtWRd9fvfdDUUAhfghCCNO8LibpejZwbq7KY=;
        b=jPVlirWlAykhlIdFXx8durpYQJCgHlessJRv90zT2V2tzhEZE/0igIGgu/aeW9hJzu
         9WoOoq8FuSdW+rDT7VI++nea3F7lZvr9KcLZC4hHz0JXwuUkUx9lXibCD4v7XOtPWwpY
         P9oVvYkN4wMdg6g1u9NiQptJielT8+R5Zb9nQPyXRsYnNOFGrnM0oniE6G0h1UCGWtGD
         c0E9qpAuSb8bYUbQ4LUbkxgYbhLFDsn2YyCNgILTIfh+UfWtpN9H0j2cVsHIbS4hKAwS
         E5TwOtVuq3pbpHDzIsojATl5wYy/IQEpfvAE5wDmDj4I0NvzJdElUo9LXtu0pUqooa9W
         DHmQ==
X-Gm-Message-State: AOAM533gKnBogwHwPPkjAwXCtFUqkJ3WzgL2W+yixWPdz497nJdS+r2C
        RGljhbVcU75Qw4wmQNlwDHZ1Vw==
X-Google-Smtp-Source: ABdhPJy4neyb9vQAxOCliffCIuMJP8B2gf3hkbimmCa7xRy3MCJaEkSNgZ0KG91VIEMKvyLwODi4FA==
X-Received: by 2002:a4a:6f4a:: with SMTP id i10mr18190534oof.64.1631023225076;
        Tue, 07 Sep 2021 07:00:25 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z7sm1924500ooh.38.2021.09.07.07.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 07:00:24 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alex Elder <elder@linaro.org>
Subject: [GIT PULL] remoteproc updates for v5.15
Date:   Tue,  7 Sep 2021 09:00:23 -0500
Message-Id: <20210907140023.2399178-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.15

for you to fetch changes up to a0a77028c85ad1f6f36c3ceea21b30dc43721665:

  remoteproc: q6v5_pas: Add sdm660 ADSP PIL compatible (2021-08-04 12:37:32 -0500)

----------------------------------------------------------------
remoteproc updates for v5.15

This moves the crash recovery worker to the freezable work queue to
avoid interaction with other drivers during suspend & resume. It fixes a
couple of typos in comments.

It adds support for handling the audio DSP on SDM660 and it fixes a race
between the Qualcomm wireless subsystem driver and the associated driver
for the RF chip.

----------------------------------------------------------------
Alex Elder (1):
      remoteproc: use freezable workqueue for crash notifications

Bjorn Andersson (1):
      remoteproc: qcom: wcnss: Fix race with iris probe

Dong Aisheng (2):
      remoteproc: fix an typo in fw_elf_get_class code comments
      remoteproc: fix kernel doc for struct rproc_ops

Konrad Dybcio (2):
      dt-bindings: remoteproc: qcom: adsp: Add SDM660 ADSP
      remoteproc: q6v5_pas: Add sdm660 ADSP PIL compatible

 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |   1 +
 drivers/remoteproc/qcom_q6v5_pas.c                 |   1 +
 drivers/remoteproc/qcom_wcnss.c                    |  49 +++------
 drivers/remoteproc/qcom_wcnss.h                    |   4 +-
 drivers/remoteproc/qcom_wcnss_iris.c               | 120 +++++++++++++--------
 drivers/remoteproc/remoteproc_core.c               |   4 +-
 drivers/remoteproc/remoteproc_elf_helpers.h        |   2 +-
 include/linux/remoteproc.h                         |   5 +-
 8 files changed, 96 insertions(+), 90 deletions(-)
