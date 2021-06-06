Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CA839CFD1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 17:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFFPk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 11:40:56 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:38636 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFFPkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 11:40:52 -0400
Received: by mail-pj1-f52.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so10345611pjz.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MZa4LkuOXQf2g9VK8g5aJEMIcyTZgxMLy0Y/ZXyQsrw=;
        b=BCtwd+NKmPSakGtVrG8XhyXhQCQd0GD3iS4JA2VmO1RPq8GNvdTsDVPMOwNNRERKbJ
         BJgaQxeXW0sQwHmNSgoxUn7cQL6LFhVOMVxqkSNIZ/gKB8a3Nef3WQWBIOu+BxkOf40U
         YP8HpCCAroelq9C0q11auS/QYeDlwD4JyTSveHjSNuYHFO4FrV9JXdkSgErnixtxSznq
         FR+HHl+SAW6zfhSbPMOgTvP1HUim5YsHAekKjm+K3qri8D4Ubr9QmO0Bnh9FtllR43Np
         IoPKxjs1zr+i/S5o50fH0gRMwC6+c7O/PF1GVhS/I957w+WFN5KckmqctEsZqQQpOs3q
         In3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MZa4LkuOXQf2g9VK8g5aJEMIcyTZgxMLy0Y/ZXyQsrw=;
        b=c0iKYm8U7IqrgitS8o9MbyV5GO4629lPqx6Ff69twhNgOjeAC8Z/KsqX9fdIaSDMxw
         cRvsAJLOFxR6iY174sYY4AKagBsWlpzGihVQltu0omKpJu0+ozqFrhoH/d09D+xyDEeU
         QmmT4eZGvkItu4Y4wrArYEO/nQK3xqoFvdS5C7wKNJ0PoWNrpOtTkozDsioWED+llHin
         cLewxAabIa9xrPwE8ACP/oZ1nQWUgSZBpmKlDX+JMhcc8LvWunslxp64ct/JL3uXQ/yk
         irrN7jf2Wy3dy9cTJzz9G7YmMdszxWso5f4KB15sJ+N/+IyWtPavpiZio6oo5whp+bR6
         oEQw==
X-Gm-Message-State: AOAM53112K9Ll71CWBvOAbH2uA+eITZQoXHMO8mANOmp6UoHklM9/D/4
        iOd4NDEwuI8W6oH7t0JWAaH7I9DGTv2A
X-Google-Smtp-Source: ABdhPJyzvGoKMSbpPS6n9eH76TNaXFLcBAlrxW6PN5SaizB0tsqUiuLp9fRWy9kqEuRHPkneXIIy9Q==
X-Received: by 2002:a17:902:6908:b029:f7:cbad:c07a with SMTP id j8-20020a1709026908b02900f7cbadc07amr13947394plk.2.1622993868707;
        Sun, 06 Jun 2021 08:37:48 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.59])
        by smtp.gmail.com with ESMTPSA id g29sm6497919pgm.11.2021.06.06.08.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 08:37:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarvis.w.jiang@gmail.com, loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] MHI fixes for v5.13
Date:   Sun,  6 Jun 2021 21:07:38 +0530
Message-Id: <20210606153741.20725-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This patchset contains below MHI fixes for v5.13. All of the issues are
fixed in the mhi_pci_generic controller driver:

1. Fixed channel names for channels 32 and 33 in T99W175 modem
2. Fixed the issue with hibernation reported in kernel bugzilla
3. Fixed possible use-after-free in mhi_pci_remove()

Please consider merging!

Thanks,
Mani

Jarvis Jiang (1):
  bus: mhi: pci_generic: T99W175: update channel name from AT to DUN

Loic Poulain (1):
  bus: mhi: pci-generic: Fix hibernation

Wei Yongjun (1):
  bus: mhi: pci_generic: Fix possible use-after-free in mhi_pci_remove()

 drivers/bus/mhi/pci_generic.c | 42 +++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

-- 
2.25.1

