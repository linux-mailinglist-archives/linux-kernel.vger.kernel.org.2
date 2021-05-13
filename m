Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBFF37F382
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhEMHYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:24:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2471 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhEMHYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:24:45 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FgjkF49MXzBtyS;
        Thu, 13 May 2021 15:20:53 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Thu, 13 May 2021
 15:23:34 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH -next 0/4] drm/radeon: fix some doc-warnings
Date:   Thu, 13 May 2021 15:25:55 +0800
Message-ID: <20210513072559.1731410-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yang Yingliang (4):
  drm/radeon/cik: correct function name cik_irq_suspend()
  drm/radeon: correct function name radeon_cs_parser_fini()
  drm/radeon/r100: correct function name r100_cs_packet_parse_vline()
  drm/radeon/radeon_vm: correct function names in radeon_vm.c

 drivers/gpu/drm/radeon/cik.c       | 2 +-
 drivers/gpu/drm/radeon/r100.c      | 2 +-
 drivers/gpu/drm/radeon/radeon_cs.c | 2 +-
 drivers/gpu/drm/radeon/radeon_vm.c | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.1

