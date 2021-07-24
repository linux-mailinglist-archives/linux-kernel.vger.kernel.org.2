Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4991E3D4A5B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 23:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhGXVJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 17:09:42 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:58736
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230461AbhGXVJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 17:09:27 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id EFEB53F35A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 21:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627163397;
        bh=i+Q0llccIqMx5SsL7f2qLyVatbD4Rx39C8icqgEfdwA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ekS53k4Smw9XVnH+au6OsJ+Mkenc5/eTJ/Oxz07HCWukS7Il0jH4iJyrEw3aulfFc
         ALcyMHXOMPCP/9M8i2GXnsCRplk+AF1WErU25f5Ww9JCPHOuDEPo3BpkYGpTcbU6v+
         W7sP1bcjZmyQIpbyYTDtsT6lk5Ll3g/mRHF5B7ZhqCi4XVPlArISgmUEYclf7WCO7N
         4eqgHRm4TUoAsvsxQ14g3gGvhIKXPEBEsiZiRluq5/yLCG50w69/D0h5yzFidzQaHj
         9W+mo7ELle2tO2V4RORqnq4Qv+UKhH2eoTDwrOKkQGUnHH72yHuNKpXJzVhDco5ZsP
         YWni+HPDEfGRw==
Received: by mail-ed1-f71.google.com with SMTP id s8-20020a0564020148b02903948b71f25cso2801961edu.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+Q0llccIqMx5SsL7f2qLyVatbD4Rx39C8icqgEfdwA=;
        b=Q6h1naLBxKcDmVy8aYgvxFsuNUYkTQpr7cnK3e0ToEs53cUrUClb+PoSGgj0bPZKCA
         XaQrSJsFoD3QUVWEnC2neHZ/zlEejl7RNcxs7AVzO6DMVbb7Y1OsGUoQC1wtoo3OrJrD
         DfNZXt0GHvwZ7IkGgXr9rNgYEFS4o/wZN7qiC6gNLniKmKS+nyqz8E7lm+V1wkUUMBwq
         ygwCdwvXxka+s5bRdUPAH3+kj3DZ8N5rtmvrUMvOIUkepyAUlVNIRQq6RXVVqh74dOHk
         EU10ryVcmsIKo8hxZnLzpjl4dMm5XyRNMD6Qzs/vrsGOT1E4Y5pnLXYeef6tIteCRQIh
         Cu1g==
X-Gm-Message-State: AOAM530HfCM1QeWeiMw7Acr4qeODwYk5D/cgooF5lWvNpuaPRaGUZE3s
        pNQraIBUYZf+XKaLrdX0pNJmdWFNRcpBpCcdTKQzBowtM/Ub/drrFGxlFZ9+ZSNkCS8/8Qid3Lo
        uUpwtwjI70N3atfP9G+1FJ3iBsr/LLvJPaTaAXifdAw==
X-Received: by 2002:a05:6402:430e:: with SMTP id m14mr10296148edc.120.1627163397540;
        Sat, 24 Jul 2021 14:49:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymDQtRzFb9UEZAtt6Ovb/j39XIvk8E2P6p5LIuQnS1n8kjgb+MF7fTYK1hCJjwQajwuR/7Qw==
X-Received: by 2002:a05:6402:430e:: with SMTP id m14mr10296138edc.120.1627163397361;
        Sat, 24 Jul 2021 14:49:57 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id s10sm12821908ejc.39.2021.07.24.14.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 14:49:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 12/12] nfc: constify nfc_digital_ops
Date:   Sat, 24 Jul 2021 23:49:28 +0200
Message-Id: <20210724214928.122096-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
References: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither the core nor the drivers modify the passed pointer to struct
nfc_digital_ops, so make it a pointer to const for correctness and safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/nfcsim.c      | 2 +-
 drivers/nfc/port100.c     | 2 +-
 drivers/nfc/st95hf/core.c | 2 +-
 drivers/nfc/trf7970a.c    | 2 +-
 include/net/nfc/digital.h | 4 ++--
 net/nfc/digital_core.c    | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nfc/nfcsim.c b/drivers/nfc/nfcsim.c
index a9864fcdfba6..143dc49b815b 100644
--- a/drivers/nfc/nfcsim.c
+++ b/drivers/nfc/nfcsim.c
@@ -320,7 +320,7 @@ static int nfcsim_tg_listen(struct nfc_digital_dev *ddev, u16 timeout,
 	return nfcsim_send(ddev, NULL, timeout, cb, arg);
 }
 
-static struct nfc_digital_ops nfcsim_digital_ops = {
+static const struct nfc_digital_ops nfcsim_digital_ops = {
 	.in_configure_hw = nfcsim_in_configure_hw,
 	.in_send_cmd = nfcsim_in_send_cmd,
 
diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index 1d614f9d864a..ccb5c5fab905 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -1463,7 +1463,7 @@ static int port100_listen(struct nfc_digital_dev *ddev, u16 timeout,
 	return port100_tg_send_cmd(ddev, skb, timeout, cb, arg);
 }
 
-static struct nfc_digital_ops port100_digital_ops = {
+static const struct nfc_digital_ops port100_digital_ops = {
 	.in_configure_hw = port100_in_configure_hw,
 	.in_send_cmd = port100_in_send_cmd,
 
diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index 2dc788c363fd..993818742570 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -1037,7 +1037,7 @@ static void st95hf_abort_cmd(struct nfc_digital_dev *ddev)
 {
 }
 
-static struct nfc_digital_ops st95hf_nfc_digital_ops = {
+static const struct nfc_digital_ops st95hf_nfc_digital_ops = {
 	.in_configure_hw = st95hf_in_configure_hw,
 	.in_send_cmd = st95hf_in_send_cmd,
 
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 33978022ae47..1aed44629aaa 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -1861,7 +1861,7 @@ static void trf7970a_abort_cmd(struct nfc_digital_dev *ddev)
 	mutex_unlock(&trf->lock);
 }
 
-static struct nfc_digital_ops trf7970a_nfc_ops = {
+static const struct nfc_digital_ops trf7970a_nfc_ops = {
 	.in_configure_hw	= trf7970a_in_configure_hw,
 	.in_send_cmd		= trf7970a_send_cmd,
 	.tg_configure_hw	= trf7970a_tg_configure_hw,
diff --git a/include/net/nfc/digital.h b/include/net/nfc/digital.h
index 963db96bcbbb..bb3e8fdc0692 100644
--- a/include/net/nfc/digital.h
+++ b/include/net/nfc/digital.h
@@ -191,7 +191,7 @@ struct digital_poll_tech {
 
 struct nfc_digital_dev {
 	struct nfc_dev *nfc_dev;
-	struct nfc_digital_ops *ops;
+	const struct nfc_digital_ops *ops;
 
 	u32 protocols;
 
@@ -236,7 +236,7 @@ struct nfc_digital_dev {
 	void (*skb_add_crc)(struct sk_buff *skb);
 };
 
-struct nfc_digital_dev *nfc_digital_allocate_device(struct nfc_digital_ops *ops,
+struct nfc_digital_dev *nfc_digital_allocate_device(const struct nfc_digital_ops *ops,
 						    __u32 supported_protocols,
 						    __u32 driver_capabilities,
 						    int tx_headroom,
diff --git a/net/nfc/digital_core.c b/net/nfc/digital_core.c
index 8f2572decccd..fefc03674f4f 100644
--- a/net/nfc/digital_core.c
+++ b/net/nfc/digital_core.c
@@ -745,7 +745,7 @@ static const struct nfc_ops digital_nfc_ops = {
 	.im_transceive = digital_in_send,
 };
 
-struct nfc_digital_dev *nfc_digital_allocate_device(struct nfc_digital_ops *ops,
+struct nfc_digital_dev *nfc_digital_allocate_device(const struct nfc_digital_ops *ops,
 					    __u32 supported_protocols,
 					    __u32 driver_capabilities,
 					    int tx_headroom, int tx_tailroom)
-- 
2.27.0

