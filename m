Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA76B3E269E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244023AbhHFJAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243999AbhHFJAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:00:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC86C06179A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 01:59:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c9so10093186wri.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxK+zMmGDONmI7WIfXVr+8WBGLkcNBTLLe2aNcDSEh0=;
        b=ee+ZouvgPjCHKBIKONHKjNK+HhdwZ3dfG+T8JdGJHKzyRTx+OZNy6xiGo9jZpWD1HU
         dk7Sz+Tpe/QSvy9SS0rjN4JdO0XFqAB0N7U1ywRrDYDRs8XAyx8bdObs2cyGnlRMYbse
         7RGIygz4FQt6Nh/z5Msobvpb5yjG4w2g9TY38DN64CcoaXoFH3lE715+sQAPTJL4y88H
         rj07YQaMc9C427YWHdI6Kv66l36x9tvY2PI0gCFyHOCHTRnpKODqwF28v16yzp4OTYKW
         fOsYd1fjRdnZaTzCh3RRf8XqbTss9weN+Sja2IhOHkBbZOb9YRst3kHs1QogJDXzMo+X
         DlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxK+zMmGDONmI7WIfXVr+8WBGLkcNBTLLe2aNcDSEh0=;
        b=WXdmvOO99IdzyAC34t9hhZdtf86TVBgjdM5gcpF7qP3KfcP9MZIhpDp5Z2rRijJjrl
         qUKU7EweC3OGlw+kTMIrrIkmWY59asPVMbnKaz9s9pc76b6A8FdpOLfliIXFDV3tZXRG
         EKtoEGAVETi61LO2R9T9JHvn7lhG1eglJSgRm2sm4PSABYUVXFlYc/yekAoPAVyzxcD1
         zt+PeHNMcPYK+GUsBk9YbMCGu9X74wSTr/K70h1FXa8RWE+NI2aTfySZhI6V/uKrGS7F
         u/LxyCTAEt/UdUJZUAfI1z72ybEVrcdcp8GbVl3iQcBXjrE1+ayqSekMvu7iGrN4BoDw
         8jfQ==
X-Gm-Message-State: AOAM530yo5/1aVHZQYpZFXncs9DtOwutKRkUgSVmyiZKWV9LAd+VLN0t
        e0AW74G85uO/C6oza/Dahc4tFA==
X-Google-Smtp-Source: ABdhPJxQZefqzxkYiso8YGxQFPxwhTpRO+NEUTCQZ99TUphrLhJ63rt6yHq44uXS+aMzMSDFaqwiMg==
X-Received: by 2002:a5d:6b8f:: with SMTP id n15mr9416463wrx.103.1628240390316;
        Fri, 06 Aug 2021 01:59:50 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x18sm8506144wrw.19.2021.08.06.01.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 01:59:49 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] nvmem: patches (set 1) for 5.15
Date:   Fri,  6 Aug 2021 09:59:43 +0100
Message-Id: <20210806085947.22682-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 5.14 which includes
- these are mostly qfprom provider powerdomain support patches.
- fix in core for incorrect error handing in nvmem_register path

Can you please queue them up for 5.15.

thanks for you help,
srini

Rajendra Nayak (3):
  dt-bindings: nvmem: qfprom: Add optional power-domains property
  nvmem: qfprom: Fix up qfprom_disable_fuse_blowing() ordering
  nvmem: qfprom: sc7280: Handle the additional power-domains vote

Srinivas Kandagatla (1):
  nvmem: core: fix error handling while validating keepout regions

 .../bindings/nvmem/qcom,qfprom.yaml           |  3 ++
 drivers/nvmem/core.c                          |  7 +++--
 drivers/nvmem/qfprom.c                        | 31 +++++++++++++++++--
 3 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.21.0

