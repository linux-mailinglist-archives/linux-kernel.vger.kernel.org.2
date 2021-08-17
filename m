Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A513EF5D0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 00:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhHQWnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 18:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbhHQWnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 18:43:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B32FC061764;
        Tue, 17 Aug 2021 15:42:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k8so412888wrn.3;
        Tue, 17 Aug 2021 15:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/EErO/rjGi3HIjQAdiJOIKEB5/1rFj/WqOlP8ebZfcw=;
        b=ib1cQiuPCTk6sV1rXF8jg8Vg5et7bHqdteOM7eKHsxyc/YcdncwL+ykSBiBRMKjnfL
         20soB1MdQJOzUVhOn/wux3w8BxiMTW/Qn/0HSC6bPq9SnsSZ+A9oc3rnaQ8QYVw7ftDk
         0QdrWI65scukIlCTdAp4fnN+hazvhFWLZmj++PKeLbnCE/FzMIJF2tzDXM8L3eLCV4ob
         pDG7WqZXxxmWDRlLFOOuHAGHKSbwyQ2R12oJhd7ZtNKJxY3HJKYvG470yjqKIqduxVoY
         s8FvKUDrb+uIkp+vgZISabe2gclM/AkdTcLizDsb2SDgY/JISP60vVMkM3q8QK5PjpTR
         ub3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/EErO/rjGi3HIjQAdiJOIKEB5/1rFj/WqOlP8ebZfcw=;
        b=WSunYMOjL6nfR8143qmJ+GfdnK1djAni8LtoxMIDWDAJ4MrTcVMxpSvVT1COVEASgA
         ck+N2EwTn95RkAWir7ACLRMJroigC8kkt0C0W4xAYNWmE11uX5AwJ9iQNZIVP9Mco6GL
         KjekHNFUgqTueB8eldTCvcs+sEf9CAm8i77vCT3OgAx3ccvmO3DFdzBTvClDVV1psMwi
         0+ykWugJr/TJZxCIefbzouTdLsO1qNHLn5kXnMjbOofRpiMf2guzGWJJQzQ6yAEjifnN
         JgHADtcHQabLIM33TUf/1Y78CmXoGLdEk7SETCv8syJVz7AhmWU5lffIH89jLH2ASG4p
         o/Kw==
X-Gm-Message-State: AOAM533AurES3NETbSZ1L8bDa6uR3mgZAEK9s8KVpTKtxQNKj4c08e7H
        cAssQBo4b5mJA+tyg/lOd6r/D3a4Xi4=
X-Google-Smtp-Source: ABdhPJyLrlq/ggq3ytvZzhy0Forr6tw4cYT7RQx3CfW0bYWKliyh0FL98OA+VaPtaSCcKt0MZxLAHw==
X-Received: by 2002:adf:ed87:: with SMTP id c7mr6774791wro.399.1629240152709;
        Tue, 17 Aug 2021 15:42:32 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec31.dynamic.kabel-deutschland.de. [95.91.236.49])
        by smtp.gmail.com with ESMTPSA id a3sm3976850wrx.38.2021.08.17.15.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 15:42:32 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v1 0/2] two minor changes of eMMC BKOPS
Date:   Wed, 18 Aug 2021 00:42:06 +0200
Message-Id: <20210817224208.153652-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>


Bean Huo (2):
  mmc: core: Issue HPI in case the BKOPS timed out
  mmc: core: Let BKOPS timeout readable/writable via sysfs

 drivers/mmc/core/mmc.c     | 32 ++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc_ops.c | 14 ++++++++++----
 include/linux/mmc/card.h   |  1 +
 3 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.25.1

