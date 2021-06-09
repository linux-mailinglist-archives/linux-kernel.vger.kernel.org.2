Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C323A1CFB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 20:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFISqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 14:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFISqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:46:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02D3C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 11:44:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m18so26605051wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/OeoAGy1A3IEy3Gj7xVoOV+pgm3ejfFP6M33G2/qTsw=;
        b=pkyiwUcWdl2NTbfay2RmnndJmbGNmeF/TpRKXQlrM09uMItjvBrIuMW/yqfZXL6Zfj
         mWuImxuPnqlTYVHPBD5Zy6AAT/yXeXsJ3b/roRx448bStXeICJnt6cywkf/QblOyUwls
         tuLyNqScuMyfa+jJOHqL49vjyZ8UMTLs8a2nZu2G42tA5sQOsIr018nRTrTIJ88oyjRt
         wmLwn1OFIyLeJJKsiM/NGTkIjA7fmuh3e7ZleCZLQwtYF6JxYXOTWZiMR08kRvbja9UZ
         uCSQT1W16VwadtXZuZtPckPedy3bX3MgHMxglkSuHtDIlGl9Gn4blMIpe4I5fOGm9XAq
         RRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/OeoAGy1A3IEy3Gj7xVoOV+pgm3ejfFP6M33G2/qTsw=;
        b=cBEpIXzX1DkoaCMi67FmC4x38lkr1LZJahv5RD8yxv5ermutxzjCuvY7FRNNl/fJSF
         NsJEciR+TyrIoGb4l2eaTXLOGH2CurXWG5bVFydSEvDLTEJx+FYoe24UfYsGhWtIBzPp
         eCLbSEdK0vyeDPgvXi+B/RRi7Pax3w0993MFzkZTjvpQHwinULz8tjnOPdAWmXw8vUXV
         Ap2Xb0MTw+AOKIyCMqV/y93LbDs3pKbHe1a22GVctzYUQTz0TTPJC6saXznflEAYbcFL
         7t8I9ZmFmq+rbHpPkoprXooxX2sum2ZyZ238FGO/g0PZ93CWelgJ1fnPM6f9/a0mDQyw
         Fhjw==
X-Gm-Message-State: AOAM532B03ThCNmXbOIasC0mxHndIPX62rdJjf5zNVKWD4AokOR5TZGA
        5L/Uy0OwNFiBNozKbnND3/4vPkCjm0c=
X-Google-Smtp-Source: ABdhPJyqUYDNMxAjgCCKsq5G3Vq3A3JYH+56SAGroHWV29UQhmfk99mYGfD+gkI2OWijT1G7x88U/Q==
X-Received: by 2002:adf:9b9d:: with SMTP id d29mr1224843wrc.226.1623264244284;
        Wed, 09 Jun 2021 11:44:04 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f29:3800:a9b1:fb24:eb4f:c8ac? (p200300ea8f293800a9b1fb24eb4fc8ac.dip0.t-ipconnect.de. [2003:ea:8f29:3800:a9b1:fb24:eb4f:c8ac])
        by smtp.googlemail.com with ESMTPSA id x18sm794930wrw.19.2021.06.09.11.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 11:44:03 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: NVME using PCI legacy interrupts only
Message-ID: <52371274-20bc-a150-a3ed-ba3e1305ad3e@gmail.com>
Date:   Wed, 9 Jun 2021 20:43:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that on linux-next from June 8th my nvme disk is using legacy
interrupts only. Some debugging lead me to irq_find_mapping() in
msi_domain_alloc() returning -EEXIST.

The nvme core first allocates a MSI-X interrupt for setup purposes
and later frees it and allocates the final number of MSI-X interrupts.

The following experimental change brought back the MSI-X interrupts.
This makes me think that somehow freeing a MSI-X interrupt doesn't
free it completely. I didn't see this behavior a few days ago,
therefore I think it's related to the recent changes to
irqdomain/genirq.

Didn't do a bisect yet, maybe you have an idea already.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b17070..8cc600819 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2381,7 +2381,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
         * interrupts. Pre-enable a single MSIX or MSI vec for setup. We'll
         * adjust this later.
         */
-       result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+       result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
        if (result < 0)
                return result;


