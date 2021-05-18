Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CCB387CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350375AbhERPr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350311AbhERPqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:46:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3802C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 08:45:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id z12so13873252ejw.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uzhu44uRZv1s3nfAlcOB8ei5a/9G/5m4eMNR5sBJlT4=;
        b=Gv4f8B/Gxitv8+cOCEpXL5j7KUaKWbrZswuaSXIHed5VMYd8XhHu7K7zKuml6EFOpb
         dZknsuFeZNYojlHQng9VgaM/QrqcH74VJrmdrfwPgeo5XDwWGNZTKVpp9EO7PqyJKMyJ
         7JSkTosNgiQaEdWvV6OYiumeVB7+oEZA1yUmApJOgWWGzVe5fWGW/UlF3Pbx3wmExdF4
         P3exJcgdKVUN9X6M0d8VZWT23DeQSGq4sFDbUMAXs38QsTYIQobDQ6Ed2dVLU+exv+35
         NndqJuQLUQFI/XMBCdBGwvDRkfaxHVHME9h/X7O19sAqwn64FE9HG+Z8aG78GSXOc0gj
         D+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uzhu44uRZv1s3nfAlcOB8ei5a/9G/5m4eMNR5sBJlT4=;
        b=rBVGbal1REtae9Ej7de2CJcsVak26y8Fz8KPkabWMfcPkZ/0GgrjoE10iiFm8PE2bT
         HSGRNKg5uJOYDgpBvXPN2M4KEK1lUIhkHijB3wY9gaVLo7vAos93mrS6VGhUlQIJuo4q
         NlfzYtiXKBSjlQDLy7b921JxtA9U5/qOPFNSSVphO5bV9EDsMeP0FF/BjotHNo5L7M51
         8Oa0ZLgv9zjp6MAaEqb9GYwxK2ziy2TMaokSuxExpQ8Tcr/DWmMQHVxyyXpKVrrVaQS/
         1CVq/7v9wjS6El/oTXraBnabSV+zrEEVfHVUvxmtrYsLhFu5YJGb505Stka4/GT99Kg7
         WFag==
X-Gm-Message-State: AOAM531eXzUczrc4RcjBULqhBtbiWEp7tL6KyFtZ/iX67P4PbWDYOoj8
        ZZ7DaeG6Q2hkHpRejN5Pe9VHiQ==
X-Google-Smtp-Source: ABdhPJyWv38guj9NKPQJrcpRLso+xBI2P2svq44TuYFknZlEJ1aJN2cs8hJT8lW6Jvur3bQEyDT4vg==
X-Received: by 2002:a17:906:1e15:: with SMTP id g21mr6660662ejj.241.1621352723392;
        Tue, 18 May 2021 08:45:23 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id n17sm13016434eds.72.2021.05.18.08.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 08:45:23 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 0/5] Venus fatal error handling
Date:   Tue, 18 May 2021 18:45:04 +0300
Message-Id: <20210518154509.602137-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the stateful decoder spec fatal errors could be
recovered either by close and open it again the file descriptor
or by stop the streaming and starting it again. This patch series
is attempting to solve the second fatal recovery case.

regards,
Stan

Stanimir Varbanov (5):
  venus: venc: Use pmruntime autosuspend
  venus: Make sys_error flag an atomic bitops
  venus: hfi: Check for sys error on session hfi functions
  venus: helpers: Add helper to mark fatal vb2 error
  venus: Handle fatal errors during encoding and decoding

 drivers/media/platform/qcom/venus/core.c    |  13 ++-
 drivers/media/platform/qcom/venus/core.h    |   6 +-
 drivers/media/platform/qcom/venus/helpers.c |  16 ++-
 drivers/media/platform/qcom/venus/helpers.h |   1 +
 drivers/media/platform/qcom/venus/hfi.c     |  48 +++++++-
 drivers/media/platform/qcom/venus/vdec.c    |  18 ++-
 drivers/media/platform/qcom/venus/venc.c    | 117 ++++++++++++++++++--
 7 files changed, 202 insertions(+), 17 deletions(-)

-- 
2.25.1

