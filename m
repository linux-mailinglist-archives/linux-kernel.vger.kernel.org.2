Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE8145A0B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbhKWK6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:58:45 -0500
Received: from 8bytes.org ([81.169.241.247]:58504 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235733AbhKWK6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:58:44 -0500
Received: from cap.home.8bytes.org (p549adbee.dip0.t-ipconnect.de [84.154.219.238])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 99C54BBE;
        Tue, 23 Nov 2021 11:55:33 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 0/2] iommu: Two minor cleanups for v5.16
Date:   Tue, 23 Nov 2021 11:55:05 +0100
Message-Id: <20211123105507.7654-1-joro@8bytes.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Hi,

here are two minor cleanups in the IOMMU code for v5.16. If there are
no objections I will sent them upstream this week.

Regards,

	Joerg

Joerg Roedel (2):
  iommu/vt-d: Remove unused PASID_DISABLED
  iommu/amd: Clarify AMD IOMMUv2 initialization messages

 arch/x86/include/asm/fpu/api.h | 6 ------
 drivers/iommu/amd/iommu_v2.c   | 6 +++---
 2 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.33.1

