Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E953A85FC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhFOQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhFOQFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:05:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F79C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:03:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k7so23437687ejv.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ew5xh4uz2lX7oFQBGyZwGXMf76fOoNS1HWa77+Ik0jQ=;
        b=JAg0svTKS/k2pMwdpJQ6CnWuEJ1/z+Q772wf851vJvqq7AEkyt//HS1pkGjqDAJQtb
         sw4rn30w8CDLPXQ71bMHGS2etv7rzBS4cf3WSacNPbofX3c3NIZBAGFzLtoBrTQiXyck
         Up5Ztj48uYIQma+7UigO7SPpvKAigqLJ1V7Fj0qbGl+LlbCIC3IrnU3mb3LZendoI53W
         1ScxbEZPuNSrpmRsYhcXBmr6PU7fyNc8gaWTf5p+KUOFJrN/+wLnTKvvkWrP8iSQO5ze
         lq1exTMy6vSWBZRyFqjbaT0a1lDWNZ3V39/IXVBJdqg1OEePZsl9WZrq8GoQPtZqJZca
         hHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ew5xh4uz2lX7oFQBGyZwGXMf76fOoNS1HWa77+Ik0jQ=;
        b=H5fgasC/+zQ/ID+EFleds/b0/eJK6INfvb7vPyR6o24a44sigv+KNNJtiTQ2venEkW
         kNueuUgyH+LsqmUdKf03/IQHUVNd/3MQHss7gd1R6r/FWWjqAbYKpaTZo1/USrIVOLfy
         K3qBvPTnfO3wORnuhIwboUexcWqNKEij/iPkyYAcXpNv/F2nryZ6jwS4TMGEHE4ScCRZ
         YOclb+rm00lTJFVSFvhxX4AMcBxo+JzyG4auMCA7vqiPtpHuHdwuFHQ1Bkx1yveadFlQ
         bYHh2Dox2y69mj/B9QXSGzVMPNkjnR8iptGDpnH1Z9Jao7o3jJrj9MVn7CPV3JfM7dV+
         vSNw==
X-Gm-Message-State: AOAM533Nj1P03wZ49jdn8O0srrBdjTAdT7ESMmYU1Fsh3jqu/WuArqca
        4EM+25TAeRxEH6hjdGfs8/U=
X-Google-Smtp-Source: ABdhPJzsTHUlmYGDCzqCspYyhSjXj0RCCJBIszsqLU2I9VDw1dZgM4pi5XNKK7MOgK0Bpj3SQ1y+0A==
X-Received: by 2002:a17:906:6d97:: with SMTP id h23mr213320ejt.467.1623773021438;
        Tue, 15 Jun 2021 09:03:41 -0700 (PDT)
Received: from yoga-910.localhost ([188.26.224.68])
        by smtp.gmail.com with ESMTPSA id b1sm1640061ejz.54.2021.06.15.09.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:03:41 -0700 (PDT)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/3] arm64: dts: add PHY IRQs for the DPAA2 based RDB boards
Date:   Tue, 15 Jun 2021 19:03:34 +0300
Message-Id: <20210615160337.1320644-1-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Update the DTS PHY nodes to specify the IRQ lines for the PHYs found on
the DPAA2 based RDB boards.

Ioana Ciornei (3):
  arm64: dts: lx2160ardb: update PHY nodes with IRQ information
  arm64: dts: ls2088ardb: update PHY nodes with IRQ information
  arm64: dts: ls1088ardb: update PHY nodes with IRQ information

 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts | 9 +++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
 3 files changed, 17 insertions(+)

-- 
2.31.1

