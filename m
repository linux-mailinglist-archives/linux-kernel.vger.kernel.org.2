Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECAE33EC3E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhCQJLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhCQJKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:10:45 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A537C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:10:44 -0700 (PDT)
Received: from cap.home.8bytes.org (p549adcf6.dip0.t-ipconnect.de [84.154.220.246])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id D30172DA;
        Wed, 17 Mar 2021 10:10:41 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiaojian Du <xiaojian.du@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 0/3] iommu/amd: Fix booting with amd_iommu=off
Date:   Wed, 17 Mar 2021 10:10:34 +0100
Message-Id: <20210317091037.31374-1-joro@8bytes.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Hi,

it turned out that booting a kernel with amd_iommu=off on a machine
that has an AMD IOMMU causes an early kernel crash. There are two
reasons for this, and fixing one of them is already sufficient, but
both reasons deserve fixing, which is done in this patch-set.

Regards,

	Joerg

Joerg Roedel (3):
  iommu/amd: Move Stoney Ridge check to detect_ivrs()
  iommu/amd: Don't call early_amd_iommu_init() when AMD IOMMU is
    disabled
  iommu/amd: Keep track of amd_iommu_irq_remap state

 drivers/iommu/amd/init.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

-- 
2.30.2

