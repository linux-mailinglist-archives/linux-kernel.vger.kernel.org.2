Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0A4434AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJTMJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 08:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJTMJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:09:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D72C061746
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:07:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y1so15968478plk.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UPb23yf1YkyfOx+oag7Ck//sJg18vV7uspwA+E7VEtk=;
        b=DMq8CQb8145WnBh56YUXI87IitFSapenMfe4DDTV8hUsTUsiLYw4XRbUw3w5R9rBM9
         b+ZYOdlWv+oFKRKxtvAlpD+OpIhUDEbcJlnPUPTTmpudRw2ztYPv0wnaZXx8SnZDbL+S
         5M43mm30t2OLt2IjJLS1ajqbvPrcDTgo35H3WpyAVVU1HXl1UyGblE0ranub1VIZFV1B
         XmOUFgBX2DF9lf9yuIgV53spgv7ellxEcthCmpZOrQuzOkWAJyqnzGZsbzmbd7WokKZE
         sASek1uWUTfk+cAI4YQ3RNOPpKyjrCooiARK57Fa8J1BGzBiDt7hcHJfxwx6pDMPTedl
         fhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UPb23yf1YkyfOx+oag7Ck//sJg18vV7uspwA+E7VEtk=;
        b=A5D8Xb99yzaly0afiBoppEaesWTQdzWTXkMmItIEju4Ar90MllnaxJ+5NnoW17ISZ4
         UEcz6YpwKIvT0E1B5BAMWXPLCk3iDLpPVmyBYk0NAiRjg/RrGTa4sk+4pw8GFpSVDYcM
         BC6ciT13eUY+mwjCiwpXOYJ8QD0DomAYPAtNEDTCMkv+y76iCvBv9bYgkS0QwK8M9F+f
         vIVVA4jhYaawq/w12HWrOnUJHgMbSKwH56wc6BGBII1jWmgE5A9AuW5pq0y/6Ad/NTws
         D36/D77qI+IdfEeezs6a9bEddwwigtMp0PiCMEwNFaBUtnieSjJAruFgyqJ0gVc4vZTc
         +E+A==
X-Gm-Message-State: AOAM532UODArSFJ6vD6vLfGy81nBymjPsQRvImQlFzpeyHfbRbp21Gwc
        PjHNJkjTEndO21CqIPC1g21OPg==
X-Google-Smtp-Source: ABdhPJxXKuFjiVRLuWSpaoxDL57/NxBql+534hTakttbVJJ00w2S51CzmB+kaHBLm9jfrM18hOLnmw==
X-Received: by 2002:a17:90b:ecc:: with SMTP id gz12mr6952300pjb.241.1634731657391;
        Wed, 20 Oct 2021 05:07:37 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id o72sm2268237pjo.50.2021.10.20.05.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 05:07:36 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     pbonzini@redhat.com, corbet@lwn.net
Cc:     wanpengli@tencent.com, seanjc@google.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] x86/kvm: Introduce boot parameter no-kvm-pvipi
Date:   Wed, 20 Oct 2021 20:07:26 +0800
Message-Id: <20211020120726.4022086-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although host side exposes KVM PV SEND IPI feature to guest side,
guest should still have a chance to disable it.

A typicall case of this parameter:
If the host AMD server enables AVIC feature, the flat mode of APIC
get better performance in the guest.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/x86/kernel/kvm.c                           | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 43dc35fe5bc0..73b8712b94b0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3495,6 +3495,8 @@
 	no-kvmapf	[X86,KVM] Disable paravirtualized asynchronous page
 			fault handling.
 
+	no-kvm-pvipi	[X86,KVM] Disable paravirtualized KVM send IPI.
+
 	no-vmw-sched-clock
 			[X86,PV_OPS] Disable paravirtualized VMware scheduler
 			clock and use the default one.
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index b656456c3a94..911f1cd2bec5 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -62,6 +62,17 @@ static int __init parse_no_stealacc(char *arg)
 
 early_param("no-steal-acc", parse_no_stealacc);
 
+static int kvm_pvipi = 1;
+
+static int __init parse_no_kvm_pvipi(char *arg)
+{
+	kvm_pvipi = 0;
+
+	return 0;
+}
+
+early_param("no-kvm-pvipi", parse_no_kvm_pvipi);
+
 static DEFINE_PER_CPU_DECRYPTED(struct kvm_vcpu_pv_apf_data, apf_reason) __aligned(64);
 DEFINE_PER_CPU_DECRYPTED(struct kvm_steal_time, steal_time) __aligned(64) __visible;
 static int has_steal_clock = 0;
@@ -795,7 +806,7 @@ static uint32_t __init kvm_detect(void)
 static void __init kvm_apic_init(void)
 {
 #ifdef CONFIG_SMP
-	if (pv_ipi_supported())
+	if (pv_ipi_supported() && kvm_pvipi)
 		kvm_setup_pv_ipi();
 #endif
 }
-- 
2.25.1

