Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF093F7A10
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbhHYQS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:18:29 -0400
Received: from foss.arm.com ([217.140.110.172]:54702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240722AbhHYQSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EACF1063;
        Wed, 25 Aug 2021 09:17:26 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5044F3F66F;
        Wed, 25 Aug 2021 09:17:25 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 09/39] KVM: Add kvm_warn{,_ratelimited} macros
Date:   Wed, 25 Aug 2021 17:17:45 +0100
Message-Id: <20210825161815.266051-10-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the kvm_warn() and kvm_warn_ratelimited() macros to print a kernel
warning.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 include/linux/kvm_host.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ae7735b490b4..ada5019ad93d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -605,6 +605,10 @@ struct kvm {
 
 #define kvm_err(fmt, ...) \
 	pr_err("kvm [%i]: " fmt, task_pid_nr(current), ## __VA_ARGS__)
+#define kvm_warn(fmt, ...) \
+	pr_warn("kvm [%i]: " fmt, task_pid_nr(current), ## __VA_ARGS__)
+#define kvm_warn_ratelimited(fmt, ...) \
+	pr_warn_ratelimited("kvm [%i]: " fmt, task_pid_nr(current), ## __VA_ARGS__)
 #define kvm_info(fmt, ...) \
 	pr_info("kvm [%i]: " fmt, task_pid_nr(current), ## __VA_ARGS__)
 #define kvm_debug(fmt, ...) \
-- 
2.33.0

