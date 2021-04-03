Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956ED353192
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 01:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhDBXhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 19:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbhDBXhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 19:37:24 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D986BC061793
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 16:37:21 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id s16so6011205qvw.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 16:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=hxOdTPpVs0OLaNI1MhoMJVqB/0q7UI+sL38GyJFv0ok=;
        b=pHQ58jffyF3hIAyeczKLaF7omuWYSpTZs1LHlw85Qdq0LemzjlOhyjyMOPMCPUpD6q
         SYVTfPukcTmM5ou+2h/oAlvRp8NI0vHkUNIeStEIyfith0KOoTL1TRAl6pfbIVD4ObAs
         1pKE+4Fg9SbRcuyEVnIQ8NOkuH40UxTIzGj34Tj15fSg8HB+OQbWS9qjYaciEnwwQSsQ
         bbyt5KIBab6kbWinTTSOldO+Kekxl+6so2i5QbvfMRMba/kIqBT1cELTtScSWETg8+Vw
         tI1v1q4YIWaPuQJIj/W3wDGF0xAnFcqPedSC0B7ioCfQsdc49eC1yDHaTw138ta1pzwg
         SQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=hxOdTPpVs0OLaNI1MhoMJVqB/0q7UI+sL38GyJFv0ok=;
        b=TzSG1TJrlC6MUuOlBtRcyFvRWc3wIYO+qMwasb96rGOALTM70iUTSaCULLBWUfqrQN
         W3r2sGGsb7wVbo2iBXLADi/58dcBAZ0FyEFpaWeI4/TiIDpty0WniheOhJEV//FgKEMJ
         WcPO+TCdVp+RKdKtNTIx7WNItxJ9Pdvunxp0Ep2/CPqGyp0/yWl0cpzdbaKgcWWwSMLo
         NCyYSTqMtcPdNoJTOy6nIkaqoVPda+cVNAZ5VkPkEM6wij8cznSOEuDHPoP8o7BWAYFv
         4r6F+MjIrDF8j2uk6bX57YBVUo94WYJLP+IHmlu1nylLdFvjabV0KG6+OrcIyw2Q6RVX
         clcQ==
X-Gm-Message-State: AOAM532ZXFnBjjq468FMF6jeCFzLlJ5hKHCvwB2FtGVnWDdOtS1NGORB
        VbbI7vFqpwtYD1UN4UtfB1WhpGblk4E=
X-Google-Smtp-Source: ABdhPJwMLRcHaoMz5B/7lzVd82CqdHKCj814w9v+/71/foV2I1o7LbmN/QxgbM0MoMhA5CnQHM1r4+6eyVE=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:24a7:3342:da61:f6aa])
 (user=seanjc job=sendgmr) by 2002:a0c:f6cf:: with SMTP id d15mr14864420qvo.62.1617406641042;
 Fri, 02 Apr 2021 16:37:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  2 Apr 2021 16:37:00 -0700
In-Reply-To: <20210402233702.3291792-1-seanjc@google.com>
Message-Id: <20210402233702.3291792-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210402233702.3291792-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH 3/5] crypto: ccp: Play nice with vmalloc'd memory for SEV
 command structs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy vmalloc'd data to an internal buffer instead of rejecting outright
so that callers can put SEV command buffers on the stack without running
afoul of CONFIG_VMAP_STACK=y.  Currently, the largest supported command
takes a 68 byte buffer, i.e. pretty much every command can be put on the
stack.  Because sev_cmd_mutex is held for the entirety of a transaction,
only a single bounce buffer is required.

Use a flexible array for the buffer, sized to hold the largest known
command.   Alternatively, the buffer could be a union of all known
command structs, but that would incur a higher maintenance cost due to
the need to update the union for every command in addition to updating
the existing sev_cmd_buffer_len().

Align the buffer to an 8-byte boundary, mimicking the alignment that
would be provided by the compiler if any of the structs were embedded
directly.  Note, sizeof() correctly incorporates this alignment.

Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/crypto/ccp/sev-dev.c | 33 +++++++++++++++++++++++++++------
 drivers/crypto/ccp/sev-dev.h |  7 +++++++
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 4c513318f16a..6d5882290cfc 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -135,13 +135,14 @@ static int sev_cmd_buffer_len(int cmd)
 	return 0;
 }
 
-static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
+static int __sev_do_cmd_locked(int cmd, void *__data, int *psp_ret)
 {
 	struct psp_device *psp = psp_master;
 	struct sev_device *sev;
 	unsigned int phys_lsb, phys_msb;
 	unsigned int reg, ret = 0;
 	int buf_len;
+	void *data;
 
 	if (!psp || !psp->sev_data)
 		return -ENODEV;
@@ -152,11 +153,21 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 	sev = psp->sev_data;
 
 	buf_len = sev_cmd_buffer_len(cmd);
-	if (WARN_ON_ONCE(!!data != !!buf_len))
+	if (WARN_ON_ONCE(!!__data != !!buf_len))
 		return -EINVAL;
 
-	if (WARN_ON_ONCE(data && is_vmalloc_addr(data)))
-		return -EINVAL;
+	if (__data && is_vmalloc_addr(__data)) {
+		/*
+		 * If the incoming buffer is virtually allocated, copy it to
+		 * the driver's scratch buffer as __pa() will not work for such
+		 * addresses, vmalloc_to_page() is not guaranteed to succeed,
+		 * and vmalloc'd data may not be physically contiguous.
+		 */
+		data = sev->cmd_buf;
+		memcpy(data, __data, buf_len);
+	} else {
+		data = __data;
+	}
 
 	/* Get the physical address of the command buffer */
 	phys_lsb = data ? lower_32_bits(__psp_pa(data)) : 0;
@@ -204,6 +215,13 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 	print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
 			     buf_len, false);
 
+	/*
+	 * Copy potential output from the PSP back to __data.  Do this even on
+	 * failure in case the caller wants to glean something from the error.
+	 */
+	if (__data && data != __data)
+		memcpy(__data, data, buf_len);
+
 	return ret;
 }
 
@@ -978,9 +996,12 @@ int sev_dev_init(struct psp_device *psp)
 {
 	struct device *dev = psp->dev;
 	struct sev_device *sev;
-	int ret = -ENOMEM;
+	int ret = -ENOMEM, cmd_buf_size = 0, i;
 
-	sev = devm_kzalloc(dev, sizeof(*sev), GFP_KERNEL);
+	for (i = 0; i < SEV_CMD_MAX; i++)
+		cmd_buf_size = max(cmd_buf_size, sev_cmd_buffer_len(i));
+
+	sev = devm_kzalloc(dev, sizeof(*sev) + cmd_buf_size, GFP_KERNEL);
 	if (!sev)
 		goto e_err;
 
diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index dd5c4fe82914..b43283ce2d73 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -52,6 +52,13 @@ struct sev_device {
 	u8 api_major;
 	u8 api_minor;
 	u8 build;
+
+	/*
+	 * Buffer used for incoming commands whose physical address cannot be
+	 * resolved via __pa(), e.g. stack pointers when CONFIG_VMAP_STACK=y.
+	 * Note, alignment isn't strictly required.
+	 */
+	u8 cmd_buf[] __aligned(8);
 };
 
 int sev_dev_init(struct psp_device *psp);
-- 
2.31.0.208.g409f899ff0-goog

