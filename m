Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8193FABDC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 15:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhH2NOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 09:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbhH2NOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 09:14:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8F6C0613D9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 06:13:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g13so25234333lfj.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 06:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VaIELk3aejG928b4attVmLHeHooVAXSsVOw7u++6ic8=;
        b=NBuVmcUEZj+2izFzWo7km7GIur/VKIWIdCygLu4Gtd5j+RVmNsWMrgh04N2TZuSMfU
         qOCfcwDEjE8ZtdKrslnPtXszndze+62w2XWwb6xGVsH1q3jBWtuTLCb9KuSLNbPPRhlK
         IbpDOICgqNbLc24No+PMG8DhLUM2mN/elJS0GRGV4rFr6iSEdeGZxaI/ykar8IBYY9uy
         Mctoi0prxcBGI+UT9DvbqIAUUP2Iz4yWSGuhWEeXcrakwQ1fy45teTG3uj0aqnye2YP6
         lXtLTZX24wvaqQuWHyNbc/msMLpxxBuORKzKEUoSATLWOgQ2fAAvsiPWesmAzPXBNpqI
         WsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VaIELk3aejG928b4attVmLHeHooVAXSsVOw7u++6ic8=;
        b=Gympkj5zPoC7cgAuRshnArPxuYwZ9NIdhOeLYn8yhmqLMZdrVy2rmOYq90vbMxQt4z
         cIcwoXQb1jylSVUUZkYnxiuGRDLtxVP/v+KxXPDubIQ/vwUyBN9smcRiDHj2d7qdBMHP
         p9JhneEQ7rizE9+ztWz82vmaxelVXE+5BjREdWwyndylWEvY9MW3VlLgf/9XiJ0YcG3i
         1oElDExy9QtbuaKjGxGALQDp5/kczQfIgLPc2rnr9lfD44oexxbgsf6of4l/PFC5MEym
         rMGS1YQFReTmoKla0jIi6FuFXvBQUS0DnplQFovW0zmJuO+GCFst3ZHr4BTSIhe1A4lX
         Wp2g==
X-Gm-Message-State: AOAM531AxoBA0vJgcyWApO+tKCaCxldE42KzJtR+s5U5qdMN1jMMdYW0
        oqdEUGoXMI71c/7xXkH59Rdytg==
X-Google-Smtp-Source: ABdhPJxoTTCTULxN0AI0ux6Ox/vGsWyAWulCZNHRsyc3AM9WfbWCnshA9YjeDZK67Cxvk0WaVZLaHA==
X-Received: by 2002:a05:6512:6cd:: with SMTP id u13mr13935373lff.184.1630242789821;
        Sun, 29 Aug 2021 06:13:09 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x13sm712503lfq.262.2021.08.29.06.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 06:13:09 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [RFC v2 00/13] create power sequencing subsystem
Date:   Sun, 29 Aug 2021 16:12:52 +0300
Message-Id: <20210829131305.534417-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second RFC on the proposed power sequencer subsystem. This
is a generification of the MMC pwrseq code. The subsystem tries to
abstract the idea of complex power-up/power-down/reset of the devices.

To ease migration to pwrseq and to provide compatibility with older
device trees, while keeping drivers simple, this iteration of RFC
introduces pwrseq fallback support: pwrseq driver can register fallback
providers. If another device driver requests pwrseq instance and none
was declared, the pwrseq fallback code would go through the list of
fallback providers and if the match is found, driver would return a
crafted pwrseq instance. For now this mechanism is limited to the OF
device matching, but it can be extended further to use any combination
of device IDs.

The primary set of devices that promted me to create this patchset is
the Qualcomm BT+WiFi family of chips. They reside on serial+platform or
serial + SDIO interfaces (older generations) or on serial+PCIe (newer
generations).  They require a set of external voltage regulators to be
powered on and (some of them) have separate WiFi and Bluetooth enable
GPIOs.

This patchset being an RFC tries to demonstrate the approach, design and
usage of the pwrseq subsystem. Following issues are present in the RFC
at this moment but will be fixed later if the overall approach would be
viewed as acceptable:

 - No documentation
   While the code tries to be self-documenting proper documentation
   would be required.

 - Minimal device tree bindings changes
   There are no proper updates for the DT bindings (thus neither Rob
   Herring nor devicetree are included in the To/Cc lists). The dt
   schema changes would be a part of v1.

 - Lack of proper PCIe integration
   At this moment support for PCIe is hacked up to be able to test the
   PCIe part of qca6390. Proper PCIe support would require automatically
   powering up the devices before the bus scan depending on the proper
   device structure in the device tree.

Changes since RFC v1:
 - Provider pwrseq fallback support
 - Implement fallback support in pwrseq_qca.
 - Mmove susclk handling to pwrseq_qca.
 - Significantly simplify hci_qca.c changes, by dropping all legacy
   code. Now hci_qca uses only pwrseq calls to power up/down bluetooth
   parts of the chip.


