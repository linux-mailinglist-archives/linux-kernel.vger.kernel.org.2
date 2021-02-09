Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF944314E23
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhBILVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhBILS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:18:57 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B46C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 03:18:13 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x136so5124573pfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 03:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RC5hON+NnajawpzB/GNIRHvEjGmIio6mT3cCoEgSwQ=;
        b=a7Rcag+6J3kBmp8/yzL63VUK4wCGQuav9FO850Wd4S/dKvV5Ym603gZIhiVSARPgjR
         bvtjW+KRW98X9VemNCulQ0IyBM3T6kOQ8fEISPwgBkiffOGp9+jEaE090fwZ04pfgFUF
         d8inATP9YUg4APdGRSUh6IyVn46SOqX+TyDgEHgECnF2gI/h5FEQeJ5wPgLaD3JN1ZfW
         w5FPhlceRAV/CALYaAimF3YVjNJP61Q+vyIGpQilsL69gjYGc+vLSvCr3RlPCz1uK0XH
         /3RPSz9Ykaq6uufyrnzmXBprgPn2EXGeHDSCQzntAXokQQKZkfZrvB28gykXztRMbSxm
         3b+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RC5hON+NnajawpzB/GNIRHvEjGmIio6mT3cCoEgSwQ=;
        b=Ip/jF8aCL8VjuMFi+8M42eMGyzmXpPNshaRPeForuyMr18fGatnPjUh3E+R5KNMa7F
         xYfwp648k9v9u3aZ5KzC3Ksv/XogJ8Q3AUwxPt4ug7zNg9IYz6fVaDqSxg+y3DmalJ1S
         QeCo+X7A1OVcA4Jmc0m01w9Xn58deYlbQwaWYdBi+/eJgcbRRF10x+IgygeQsnOtTGzn
         f/tyQbkt9C1zJ4b2DIqK6Y7IpDz1Skxkd/ziZY3q+QAMUiH0t3p1jvFXAoKhgy9j8f7j
         6EkVx8UOEeUe9Ks6adUihBPUuvQaqGCK4/B+hwPJeHmLVMqvF/Fg/biiGgg9nJvYqRlg
         DekA==
X-Gm-Message-State: AOAM532uzTz3HJILYsJ7Y3jzUffzmkgCuuNumoM97iZCzz7OR93R+d0u
        8pKo1aMtUCWK3L6vG5JmTwzpog==
X-Google-Smtp-Source: ABdhPJy4arvbQcjsyMyytXfd7r95VoGqqjgjvXBA56g7CAJAUcbXmm/s/sQXmFDLG5BYt/6lgnc3+w==
X-Received: by 2002:a65:520d:: with SMTP id o13mr21458658pgp.57.1612869493260;
        Tue, 09 Feb 2021 03:18:13 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id x9sm7744461pfc.114.2021.02.09.03.18.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 03:18:12 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH Resend] mailbox: arm_mhuv2: Fix sparse warnings
Date:   Tue,  9 Feb 2021 16:48:08 +0530
Message-Id: <db5dd593cfd8b428ce44c1cce7484d887fa5e67c.1612869229.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bunch of sparse warnings in the newly added arm_mhuv2
driver.

drivers/mailbox/arm_mhuv2.c:506:24: warning: incorrect type in argument 1 (different address spaces)
drivers/mailbox/arm_mhuv2.c:506:24:    expected void const volatile [noderef] __iomem *addr
drivers/mailbox/arm_mhuv2.c:506:24:    got unsigned int [usertype] *
drivers/mailbox/arm_mhuv2.c:547:42: warning: incorrect type in argument 2 (different address spaces)
drivers/mailbox/arm_mhuv2.c:547:42:    expected unsigned int [usertype] *reg
drivers/mailbox/arm_mhuv2.c:547:42:    got unsigned int [noderef] __iomem *
drivers/mailbox/arm_mhuv2.c:625:42: warning: incorrect type in argument 2 (different address spaces)
drivers/mailbox/arm_mhuv2.c:625:42:    expected unsigned int [usertype] *reg
drivers/mailbox/arm_mhuv2.c:625:42:    got unsigned int [noderef] __iomem *
drivers/mailbox/arm_mhuv2.c:972:24: warning: dereference of noderef expression
drivers/mailbox/arm_mhuv2.c:973:22: warning: dereference of noderef expression
drivers/mailbox/arm_mhuv2.c:993:25: warning: dereference of noderef expression
drivers/mailbox/arm_mhuv2.c:1026:24: warning: dereference of noderef expression
drivers/mailbox/arm_mhuv2.c:1027:22: warning: dereference of noderef expression
drivers/mailbox/arm_mhuv2.c:1048:17: warning: dereference of noderef expression

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi,

This should have been merged to 5.11-rc since the driver got introduced
in 5.11-rc1 itself. I don't see it queued for linux-next as well. It was
posted over 6 weeks back and no response is received yet:

https://lore.kernel.org/lkml/db5dd593cfd8b428ce44c1cce7484d887fa5e67c.1609303304.git.viresh.kumar@linaro.org/

Would be good if this can still go in 5.11.

 drivers/mailbox/arm_mhuv2.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
index 67fb10885bb4..8223c1005254 100644
--- a/drivers/mailbox/arm_mhuv2.c
+++ b/drivers/mailbox/arm_mhuv2.c
@@ -238,19 +238,19 @@ struct mhuv2_mbox_chan_priv {
 };
 
 /* Macro for reading a bitfield within a physically mapped packed struct */
-#define readl_relaxed_bitfield(_regptr, _field)				\
+#define readl_relaxed_bitfield(_regptr, _type, _field)			\
 	({								\
 		u32 _regval;						\
 		_regval = readl_relaxed((_regptr));			\
-		(*(typeof((_regptr)))(&_regval))._field;		\
+		(*(_type *)(&_regval))._field;				\
 	})
 
 /* Macro for writing a bitfield within a physically mapped packed struct */
-#define writel_relaxed_bitfield(_value, _regptr, _field)		\
+#define writel_relaxed_bitfield(_value, _regptr, _type, _field)		\
 	({								\
 		u32 _regval;						\
 		_regval = readl_relaxed(_regptr);			\
-		(*(typeof(_regptr))(&_regval))._field = _value;		\
+		(*(_type *)(&_regval))._field = _value;			\
 		writel_relaxed(_regval, _regptr);			\
 	})
 
@@ -496,7 +496,7 @@ static const struct mhuv2_protocol_ops mhuv2_data_transfer_ops = {
 
 /* Interrupt handlers */
 
-static struct mbox_chan *get_irq_chan_comb(struct mhuv2 *mhu, u32 *reg)
+static struct mbox_chan *get_irq_chan_comb(struct mhuv2 *mhu, u32 __iomem *reg)
 {
 	struct mbox_chan *chans = mhu->mbox.chans;
 	int channel = 0, i, offset = 0, windows, protocol, ch_wn;
@@ -969,8 +969,8 @@ static int mhuv2_tx_init(struct amba_device *adev, struct mhuv2 *mhu,
 	mhu->mbox.ops = &mhuv2_sender_ops;
 	mhu->send = reg;
 
-	mhu->windows = readl_relaxed_bitfield(&mhu->send->mhu_cfg, num_ch);
-	mhu->minor = readl_relaxed_bitfield(&mhu->send->aidr, arch_minor_rev);
+	mhu->windows = readl_relaxed_bitfield(&mhu->send->mhu_cfg, struct mhu_cfg_t, num_ch);
+	mhu->minor = readl_relaxed_bitfield(&mhu->send->aidr, struct aidr_t, arch_minor_rev);
 
 	spin_lock_init(&mhu->doorbell_pending_lock);
 
@@ -990,7 +990,7 @@ static int mhuv2_tx_init(struct amba_device *adev, struct mhuv2 *mhu,
 			mhu->mbox.txdone_poll = false;
 			mhu->irq = adev->irq[0];
 
-			writel_relaxed_bitfield(1, &mhu->send->int_en, chcomb);
+			writel_relaxed_bitfield(1, &mhu->send->int_en, struct int_en_t, chcomb);
 
 			/* Disable all channel interrupts */
 			for (i = 0; i < mhu->windows; i++)
@@ -1023,8 +1023,8 @@ static int mhuv2_rx_init(struct amba_device *adev, struct mhuv2 *mhu,
 	mhu->mbox.ops = &mhuv2_receiver_ops;
 	mhu->recv = reg;
 
-	mhu->windows = readl_relaxed_bitfield(&mhu->recv->mhu_cfg, num_ch);
-	mhu->minor = readl_relaxed_bitfield(&mhu->recv->aidr, arch_minor_rev);
+	mhu->windows = readl_relaxed_bitfield(&mhu->recv->mhu_cfg, struct mhu_cfg_t, num_ch);
+	mhu->minor = readl_relaxed_bitfield(&mhu->recv->aidr, struct aidr_t, arch_minor_rev);
 
 	mhu->irq = adev->irq[0];
 	if (!mhu->irq) {
@@ -1045,7 +1045,7 @@ static int mhuv2_rx_init(struct amba_device *adev, struct mhuv2 *mhu,
 		writel_relaxed(0xFFFFFFFF, &mhu->recv->ch_wn[i].mask_set);
 
 	if (mhu->minor)
-		writel_relaxed_bitfield(1, &mhu->recv->int_en, chcomb);
+		writel_relaxed_bitfield(1, &mhu->recv->int_en, struct int_en_t, chcomb);
 
 	return 0;
 }
-- 
2.25.0.rc1.19.g042ed3e048af

