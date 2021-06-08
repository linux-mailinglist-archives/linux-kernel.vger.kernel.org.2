Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0005839F402
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhFHKud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:50:33 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50605 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231640AbhFHKub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:50:31 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id EB6575804DB;
        Tue,  8 Jun 2021 06:48:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 08 Jun 2021 06:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=/Ur7EbHSZJ9Sa
        bS075E1hphcD/QQ2mBKVUhEFdiJJUY=; b=foc3+mQJOxAhOyw3DxyDrqF4UDXd4
        FOPQoJaWk91aNci+0mRReMftFJDg2kUqbS74EIeRiTW4JDBZ27p1tmvLr2X5sP2A
        nWh7aDF36jDbk7/WE+WFcnpmAv/CdFfNKZn7fU6PvdNgqq5qtB32LYIYIgVXLVRh
        TIuTKQaD/hHTYoSJWtyF6QRlSRNsXz5vqYYlzVTE95Wio3oFrto6360Mh9XwD6MK
        3YcWCmrxTz5PigwixJL4qC+h1qTwq2GCx0neRTFvhzuMIvm2XcOY28fY1DgHPeAz
        wWvfg8ZnJlPgLu3JIfLOw6xoW66cFWZPjVl3T2jSVcfBtpD50ZFRMOGUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=/Ur7EbHSZJ9SabS075E1hphcD/QQ2mBKVUhEFdiJJUY=; b=GWfmcmD7
        tGuiedKe8GtYANO0YdnIyjwgqJZvf97Dqnv/3YbADa5AsMbWRdqLmvh1A+8PYlBF
        TTV2X6tQj5T6OI3cCnDGMpD4Hy5BOmasSJlaaTDfelbNGqPYBGa+d8xgeDHwuc2b
        rDXjxEHwcdNe/esje7owUQzLBoSgbiwqRcso6/PNMpATjONjbJ5CibFvlpzWVXnk
        ua5mVfjsS5f8q8iYkV7cWUbt5MT2JQwTG2yBSNd5C08CqnfQSBpYkxGxZFTwmSkp
        m7Sbc6YPj/VQumBOutYBeqfI10LJEvX6buJPG/bGSMGIw2AO5Cp0kQYU0n9wpsTI
        RjXkLiV1NsiPBQ==
X-ME-Sender: <xms:Bku_YJYG-CDtAkSwWXgQX2Q1YkjeqgQ3gyE64-nRzBVI_v_Zo5p6BA>
    <xme:Bku_YAauw00LA5ZSNnOYxlS_x-R0WiuP_YSSpS_znbB63sUrOiMPCAVjTtnwZCNrG
    wf81oLwtviLbh5vfQ>
X-ME-Received: <xmr:Bku_YL_UkoNLv2-NQWTm6IlZ8uKBhVPNY13BELbmPSqOLA7pDnK4h0wfvMFkPNzTW39N-5EQcVQgsYm6mxy-pvCnTa7PpnYZkds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:Bku_YHqbn_e2QiXgUiczbEtA7qK4sAQ9T8uwZ47vzFsDSNR4LMAIMA>
    <xmx:Bku_YEqTYDHM7BIMo-ecLjAS_POw4mXBU1HqZp_0C5P0Dfk0ODmfrg>
    <xmx:Bku_YNTOkT8v-8q2GpyajlFPpzAJjc36ACaBzyaOihN1O6QIAlzpcw>
    <xmx:Bku_YCaP3BoKfbkp1MAEimRN3lAkeclsYP-AofunUHKXKSHPIQ4dlQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jun 2021 06:48:32 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     openipmi-developer@lists.sourceforge.net, openbmc@lists.ozlabs.org,
        minyard@acm.org
Cc:     devicetree@vger.kernel.org, tmaimon77@gmail.com,
        linux-aspeed@lists.ozlabs.org, avifishman70@gmail.com,
        venture@google.com, linux-kernel@vger.kernel.org,
        tali.perry1@gmail.com, robh+dt@kernel.org,
        chiawei_wang@aspeedtech.com, linux-arm-kernel@lists.infradead.org,
        benjaminfair@google.com, arnd@arndb.de, zweiss@equinix.com,
        joel@jms.id.au, KWLIU@nuvoton.com
Subject: [PATCH v4 03/16] ipmi: kcs_bmc: Rename {read,write}_{status,data}() functions
Date:   Tue,  8 Jun 2021 20:17:44 +0930
Message-Id: <20210608104757.582199-4-andrew@aj.id.au>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608104757.582199-1-andrew@aj.id.au>
References: <20210608104757.582199-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the functions in preparation for separating the IPMI chardev out
from the KCS BMC core.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Zev Weiss <zweiss@equinix.com>
---
 drivers/char/ipmi/kcs_bmc.c | 52 ++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index 58fb1a7bd50d..c4336c1f2d6d 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -45,42 +45,42 @@ enum kcs_states {
 #define KCS_CMD_WRITE_END         0x62
 #define KCS_CMD_READ_BYTE         0x68
 
-static inline u8 read_data(struct kcs_bmc *kcs_bmc)
+static inline u8 kcs_bmc_read_data(struct kcs_bmc *kcs_bmc)
 {
 	return kcs_bmc->io_inputb(kcs_bmc, kcs_bmc->ioreg.idr);
 }
 
-static inline void write_data(struct kcs_bmc *kcs_bmc, u8 data)
+static inline void kcs_bmc_write_data(struct kcs_bmc *kcs_bmc, u8 data)
 {
 	kcs_bmc->io_outputb(kcs_bmc, kcs_bmc->ioreg.odr, data);
 }
 
-static inline u8 read_status(struct kcs_bmc *kcs_bmc)
+static inline u8 kcs_bmc_read_status(struct kcs_bmc *kcs_bmc)
 {
 	return kcs_bmc->io_inputb(kcs_bmc, kcs_bmc->ioreg.str);
 }
 
-static inline void write_status(struct kcs_bmc *kcs_bmc, u8 data)
+static inline void kcs_bmc_write_status(struct kcs_bmc *kcs_bmc, u8 data)
 {
 	kcs_bmc->io_outputb(kcs_bmc, kcs_bmc->ioreg.str, data);
 }
 
-static void update_status_bits(struct kcs_bmc *kcs_bmc, u8 mask, u8 val)
+static void kcs_bmc_update_status(struct kcs_bmc *kcs_bmc, u8 mask, u8 val)
 {
 	kcs_bmc->io_updateb(kcs_bmc, kcs_bmc->ioreg.str, mask, val);
 }
 
 static inline void set_state(struct kcs_bmc *kcs_bmc, u8 state)
 {
-	update_status_bits(kcs_bmc, KCS_STATUS_STATE_MASK,
+	kcs_bmc_update_status(kcs_bmc, KCS_STATUS_STATE_MASK,
 					KCS_STATUS_STATE(state));
 }
 
 static void kcs_force_abort(struct kcs_bmc *kcs_bmc)
 {
 	set_state(kcs_bmc, ERROR_STATE);
-	read_data(kcs_bmc);
-	write_data(kcs_bmc, KCS_ZERO_DATA);
+	kcs_bmc_read_data(kcs_bmc);
+	kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
 
 	kcs_bmc->phase = KCS_PHASE_ERROR;
 	kcs_bmc->data_in_avail = false;
@@ -99,9 +99,9 @@ static void kcs_bmc_handle_data(struct kcs_bmc *kcs_bmc)
 	case KCS_PHASE_WRITE_DATA:
 		if (kcs_bmc->data_in_idx < KCS_MSG_BUFSIZ) {
 			set_state(kcs_bmc, WRITE_STATE);
-			write_data(kcs_bmc, KCS_ZERO_DATA);
+			kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
 			kcs_bmc->data_in[kcs_bmc->data_in_idx++] =
-						read_data(kcs_bmc);
+						kcs_bmc_read_data(kcs_bmc);
 		} else {
 			kcs_force_abort(kcs_bmc);
 			kcs_bmc->error = KCS_LENGTH_ERROR;
@@ -112,7 +112,7 @@ static void kcs_bmc_handle_data(struct kcs_bmc *kcs_bmc)
 		if (kcs_bmc->data_in_idx < KCS_MSG_BUFSIZ) {
 			set_state(kcs_bmc, READ_STATE);
 			kcs_bmc->data_in[kcs_bmc->data_in_idx++] =
-						read_data(kcs_bmc);
+						kcs_bmc_read_data(kcs_bmc);
 			kcs_bmc->phase = KCS_PHASE_WRITE_DONE;
 			kcs_bmc->data_in_avail = true;
 			wake_up_interruptible(&kcs_bmc->queue);
@@ -126,34 +126,34 @@ static void kcs_bmc_handle_data(struct kcs_bmc *kcs_bmc)
 		if (kcs_bmc->data_out_idx == kcs_bmc->data_out_len)
 			set_state(kcs_bmc, IDLE_STATE);
 
-		data = read_data(kcs_bmc);
+		data = kcs_bmc_read_data(kcs_bmc);
 		if (data != KCS_CMD_READ_BYTE) {
 			set_state(kcs_bmc, ERROR_STATE);
-			write_data(kcs_bmc, KCS_ZERO_DATA);
+			kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
 			break;
 		}
 
 		if (kcs_bmc->data_out_idx == kcs_bmc->data_out_len) {
-			write_data(kcs_bmc, KCS_ZERO_DATA);
+			kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
 			kcs_bmc->phase = KCS_PHASE_IDLE;
 			break;
 		}
 
-		write_data(kcs_bmc,
+		kcs_bmc_write_data(kcs_bmc,
 			kcs_bmc->data_out[kcs_bmc->data_out_idx++]);
 		break;
 
 	case KCS_PHASE_ABORT_ERROR1:
 		set_state(kcs_bmc, READ_STATE);
-		read_data(kcs_bmc);
-		write_data(kcs_bmc, kcs_bmc->error);
+		kcs_bmc_read_data(kcs_bmc);
+		kcs_bmc_write_data(kcs_bmc, kcs_bmc->error);
 		kcs_bmc->phase = KCS_PHASE_ABORT_ERROR2;
 		break;
 
 	case KCS_PHASE_ABORT_ERROR2:
 		set_state(kcs_bmc, IDLE_STATE);
-		read_data(kcs_bmc);
-		write_data(kcs_bmc, KCS_ZERO_DATA);
+		kcs_bmc_read_data(kcs_bmc);
+		kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
 		kcs_bmc->phase = KCS_PHASE_IDLE;
 		break;
 
@@ -168,9 +168,9 @@ static void kcs_bmc_handle_cmd(struct kcs_bmc *kcs_bmc)
 	u8 cmd;
 
 	set_state(kcs_bmc, WRITE_STATE);
-	write_data(kcs_bmc, KCS_ZERO_DATA);
+	kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
 
-	cmd = read_data(kcs_bmc);
+	cmd = kcs_bmc_read_data(kcs_bmc);
 	switch (cmd) {
 	case KCS_CMD_WRITE_START:
 		kcs_bmc->phase = KCS_PHASE_WRITE_START;
@@ -212,7 +212,7 @@ int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc)
 
 	spin_lock_irqsave(&kcs_bmc->lock, flags);
 
-	status = read_status(kcs_bmc);
+	status = kcs_bmc_read_status(kcs_bmc);
 	if (status & KCS_STATUS_IBF) {
 		if (!kcs_bmc->running)
 			kcs_force_abort(kcs_bmc);
@@ -350,7 +350,7 @@ static ssize_t kcs_bmc_write(struct file *filp, const char __user *buf,
 		kcs_bmc->data_out_idx = 1;
 		kcs_bmc->data_out_len = count;
 		memcpy(kcs_bmc->data_out, kcs_bmc->kbuffer, count);
-		write_data(kcs_bmc, kcs_bmc->data_out[0]);
+		kcs_bmc_write_data(kcs_bmc, kcs_bmc->data_out[0]);
 		ret = count;
 	} else {
 		ret = -EINVAL;
@@ -373,13 +373,11 @@ static long kcs_bmc_ioctl(struct file *filp, unsigned int cmd,
 
 	switch (cmd) {
 	case IPMI_BMC_IOCTL_SET_SMS_ATN:
-		update_status_bits(kcs_bmc, KCS_STATUS_SMS_ATN,
-				   KCS_STATUS_SMS_ATN);
+		kcs_bmc_update_status(kcs_bmc, KCS_STATUS_SMS_ATN, KCS_STATUS_SMS_ATN);
 		break;
 
 	case IPMI_BMC_IOCTL_CLEAR_SMS_ATN:
-		update_status_bits(kcs_bmc, KCS_STATUS_SMS_ATN,
-				   0);
+		kcs_bmc_update_status(kcs_bmc, KCS_STATUS_SMS_ATN, 0);
 		break;
 
 	case IPMI_BMC_IOCTL_FORCE_ABORT:
-- 
2.30.2

