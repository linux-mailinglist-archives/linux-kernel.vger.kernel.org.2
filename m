Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D95940F55B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbhIQJ4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:56:31 -0400
Received: from egress-ip33b.ess.de.barracuda.com ([18.185.115.237]:33928 "EHLO
        egress-ip33b.ess.de.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232046AbhIQJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:56:30 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200]) by mx-outbound47-143.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 17 Sep 2021 09:55:04 +0000
Received: by mail-pg1-f200.google.com with SMTP id d5-20020a63ed05000000b002688d3aff8aso7535442pgi.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 02:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dW2y3JpGEeNTiuBduWiPLB/E/rjHnmG0LPnJjV7yO2Y=;
        b=RKRs78g03q8Sc/JD4MyksBzoFOdBw8ALwTlWHj0Fl//5yxfXzq9jA6EPmU7/oEeqrR
         zWP4uNWt4+pBGSxXOWqapIgg+a1z1w27Ilfw/UYn0Bp1NEcoETrFyh+Ls5AiI/BeQavs
         hYHuSGeXXo1A+XIRjZdOonO4mgJ6lGDDqZuLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dW2y3JpGEeNTiuBduWiPLB/E/rjHnmG0LPnJjV7yO2Y=;
        b=g5iMLZb6sqvbcD2rorAXS9xUiS7lPu81dhpXdrQQDlzk/0SNxu69l6VQ8V0m0FLVkx
         BOPn7MPvRqJVK2/z8ysUZuY6giBlN1dGutu27kLN9mIIN6TDgYKBa+nlcJd+LOKPMu1I
         psMuQc7ILY+rxFrrD8/yXxOTeWzNTpAc70b34FbAmvMvxWN4wda93pfSbcycHz3sG8cy
         5vCutSkiZGgn20OXM8AXXKROY4jP/pJNiJGTWYGDF0MnCeaElnNDu2EhCe7nxgbYqtdc
         W2ehs0HXUjp66D4hT1PR0SlQ683t8kQ9ZzmZhNR+BjZmdPTki8r5QTwQWJLrQrSt4z9D
         rQHA==
X-Gm-Message-State: AOAM530akw/rD+mgO26ddiIjDJTFBXtKtXSOuu3WK7aM+fmZ1XOMQvoi
        gnOSCUsRYP09KnjFmTNAzR/YvUrfMUqoE8zqTMzg1gd6R7iHi6qiOvBb71Eb43CM7gYs8c3tMpU
        ulIzNNyokNl1mWG4k9GUAYKIVm/WBT5egeVo/n/MG596sQE144dbWmGVwRz36
X-Received: by 2002:a63:6f42:: with SMTP id k63mr9022321pgc.358.1631872503381;
        Fri, 17 Sep 2021 02:55:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGYGkflcekoTfeEFHcJJ244092qVcUgtpuYJ5QZz7acdzg3s1jnSqxXRASV7/bL8hfMIoOKA==
X-Received: by 2002:a63:6f42:: with SMTP id k63mr9022298pgc.358.1631872503089;
        Fri, 17 Sep 2021 02:55:03 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id p2sm6077333pgd.84.2021.09.17.02.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:55:02 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Suman Anna <s-anna@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3 0/2] dt-bindings: remoteproc: k3-r5f|dsp: Remove
Date:   Fri, 17 Sep 2021 15:24:24 +0530
Message-Id: <20210917095426.19277-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1631872503-312175-5439-1350-1
X-BESS-VER: 2019.1_20210916.2102
X-BESS-Apparent-Source-IP: 209.85.215.200
X-BESS-Outbound-Spam-Score: 0.20
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.234538 [from 
        cloudscan23-185.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.20 PR0N_SUBJECT           META: Subject has letters around special characters (pr0n) 
X-BESS-Outbound-Spam-Status: SCORE=0.20 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND, PR0N_SUBJECT
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Bjorn,

The series of patches are meant to help make the rproc bindings for K3
r5f and dsp support independent of board/platform involved. The current
examples get in the way of the device tree cleanups and new platform
introductions [1].

When applying this series, it would greatly help us if you could provide
us with a immutable tag for Nishanth to merge in and help introduce the
newer platforms that are blocked by this cleanup. See [2] for further
context of why we are requesting for immutable tag.

Changes in V3:
- Added r5f cleanup as well
- Commit message, $subject and simplification of the fixup.

V2: https://lore.kernel.org/all/20210818074030.1877-1-sinthu.raja@ti.com/
V1: https://lore.kernel.org/all/20210817152005.21575-1-sinthu.raja@ti.com/


Sinthu Raja (2):
  dt-bindings: remoteproc: k3-r5f: Remove board-specific compatible from
    DT example
  dt-bindings: remoteproc: k3-dsp: Remove board-specific compatible from
    DT example

 .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml       | 4 +---
 .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml       | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

[1] https://lore.kernel.org/all/1631794913.472895.1119414.nullmailer@robh.at.kernel.org/ 
[2] https://lore.kernel.org/linux-arm-kernel/20210125141642.4yybjnklk3qsqjdy@steersman/
-- 
2.32.0

