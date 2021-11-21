Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0329458582
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 18:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbhKURot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 12:44:49 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:60882 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbhKURos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 12:44:48 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id oqqUmhaPXdmYboqqUmGBjl; Sun, 21 Nov 2021 18:41:43 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 21 Nov 2021 18:41:43 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] drm/amdkfd: Slighly optimize 'init_doorbell_bitmap()'
Date:   Sun, 21 Nov 2021 18:41:40 +0100
Message-Id: <3e54737649cf94daabaa5b51db9f4c21d43124fe.1637516393.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2343a4e6547a8436419308744ba8c433088922a5.1637516393.git.christophe.jaillet@wanadoo.fr>
References: <2343a4e6547a8436419308744ba8c433088922a5.1637516393.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'doorbell_bitmap' bitmap has just been allocated. So we can use the
non-atomic '__set_bit()' function to save a few cycles as no concurrent
access can happen.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
bitmap_set() could certainly also be use, but range checking would be
tricky.
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 172ee8763523..2e9d341062c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1447,9 +1447,9 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
 
 	for (i = 0; i < KFD_MAX_NUM_OF_QUEUES_PER_PROCESS / 2; i++) {
 		if (i >= range_start && i <= range_end) {
-			set_bit(i, qpd->doorbell_bitmap);
-			set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
-				qpd->doorbell_bitmap);
+			__set_bit(i, qpd->doorbell_bitmap);
+			__set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
+				  qpd->doorbell_bitmap);
 		}
 	}
 
-- 
2.30.2

