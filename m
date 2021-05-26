Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903AB392085
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 21:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbhEZTH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 15:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233869AbhEZTHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 15:07:17 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB662610A5;
        Wed, 26 May 2021 19:05:45 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1llyqe-003o26-6E; Wed, 26 May 2021 20:05:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Bhupesh SHARMA <bhupesh.sharma@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, kernel-team@android.com
Subject: [PATCH 2/4] kernel/resource: Populate child pointer in find_next_iomem_res()
Date:   Wed, 26 May 2021 20:05:29 +0100
Message-Id: <20210526190531.62751-3-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210526190531.62751-1-maz@kernel.org>
References: <20210526190531.62751-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org, mark.rutland@arm.com, james.morse@arm.com, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, ebiederm@xmission.com, bhupesh.sharma@linaro.org, takahiro.akashi@linaro.org, dyoung@redhat.com, mdf@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When find_next_iomem_res() returns a resource, it doesn't
populate the child pointer (but does so with the parent).

As we are about to need to arse child resources, populate
this pointer as well.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/resource.c b/kernel/resource.c
index ca9f5198a01f..311b8d2c9957 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -377,6 +377,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 			.flags = p->flags,
 			.desc = p->desc,
 			.parent = p->parent,
+			.child = p->child,
 		};
 	}
 
-- 
2.30.2

