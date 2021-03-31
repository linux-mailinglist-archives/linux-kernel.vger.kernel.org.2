Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC75A350126
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhCaNVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:21:35 -0400
Received: from mail-m121143.qiye.163.com ([115.236.121.143]:34654 "EHLO
        mail-m121143.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbhCaNVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:21:10 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.181])
        by mail-m121143.qiye.163.com (Hmail) with ESMTPA id CA0365404C0;
        Wed, 31 Mar 2021 21:12:42 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/nouveau: cleanup-coding-style-a-bit
Date:   Wed, 31 Mar 2021 06:12:35 -0700
Message-Id: <20210331131237.60826-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkgeHRkdTEgfSUkdVkpNSkxKQk1ITUhLQk1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MVE6FQw5CD8TMDUBTi8KNEgp
        ETwwFAhVSlVKTUpMSkJNSE1ISE9MVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
        TklVSk9OVUpDSllXWQgBWUFOSkhLNwY+
X-HM-Tid: 0a78886a2cfeb038kuuuca0365404c0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is to make the code a bit readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c | 44 ++++++++++-----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c b/drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c
index 57df997c5ff3..053e86845d63 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c
@@ -41,9 +41,9 @@ static int
 wndwc37e_csc_set(struct nv50_wndw *wndw, struct nv50_wndw_atom *asyw)
 {
 	struct nvif_push *push = wndw->wndw.push;
-	int ret;
+	int ret = PUSH_WAIT(push, 13);
 
-	if ((ret = PUSH_WAIT(push, 13)))
+	if (ret)
 		return ret;
 
 	PUSH_MTHD(push, NVC37E, SET_CSC_RED2RED, asyw->csc.matrix, 12);
@@ -54,9 +54,9 @@ static int
 wndwc37e_ilut_clr(struct nv50_wndw *wndw)
 {
 	struct nvif_push *push = wndw->wndw.push;
-	int ret;
+	int ret = PUSH_WAIT(push, 2);
 
-	if ((ret = PUSH_WAIT(push, 2)))
+	if (ret)
 		return ret;
 
 	PUSH_MTHD(push, NVC37E, SET_CONTEXT_DMA_INPUT_LUT, 0x00000000);
@@ -67,9 +67,9 @@ static int
 wndwc37e_ilut_set(struct nv50_wndw *wndw, struct nv50_wndw_atom *asyw)
 {
 	struct nvif_push *push = wndw->wndw.push;
-	int ret;
+	int ret = PUSH_WAIT(push, 4);
 
-	if ((ret = PUSH_WAIT(push, 4)))
+	if (ret)
 		return ret;
 
 	PUSH_MTHD(push, NVC37E, SET_CONTROL_INPUT_LUT,
@@ -100,9 +100,9 @@ int
 wndwc37e_blend_set(struct nv50_wndw *wndw, struct nv50_wndw_atom *asyw)
 {
 	struct nvif_push *push = wndw->wndw.push;
-	int ret;
+	int ret = PUSH_WAIT(push, 8);
 
-	if ((ret = PUSH_WAIT(push, 8)))
+	if (ret)
 		return ret;
 
 	PUSH_MTHD(push, NVC37E, SET_COMPOSITION_CONTROL,
@@ -145,9 +145,9 @@ int
 wndwc37e_image_clr(struct nv50_wndw *wndw)
 {
 	struct nvif_push *push = wndw->wndw.push;
-	int ret;
+	int ret = PUSH_WAIT(push, 4);
 
-	if ((ret = PUSH_WAIT(push, 4)))
+	if (ret)
 		return ret;
 
 	PUSH_MTHD(push, NVC37E, SET_PRESENT_CONTROL,
@@ -162,9 +162,9 @@ static int
 wndwc37e_image_set(struct nv50_wndw *wndw, struct nv50_wndw_atom *asyw)
 {
 	struct nvif_push *push = wndw->wndw.push;
-	int ret;
+	int ret = PUSH_WAIT(push, 17);
 
-	if ((ret = PUSH_WAIT(push, 17)))
+	if (ret)
 		return ret;
 
 	PUSH_MTHD(push, NVC37E, SET_PRESENT_CONTROL,
@@ -215,9 +215,9 @@ int
 wndwc37e_ntfy_clr(struct nv50_wndw *wndw)
 {
 	struct nvif_push *push = wndw->wndw.push;
-	int ret;
+	int ret = PUSH_WAIT(push, 2);
 
-	if ((ret = PUSH_WAIT(push, 2)))
+	if (ret)
 		return ret;
 
 	PUSH_MTHD(push, NVC37E, SET_CONTEXT_DMA_NOTIFIER, 0x00000000);
@@ -228,9 +228,9 @@ int
 wndwc37e_ntfy_set(struct nv50_wndw *wndw, struct nv50_wndw_atom *asyw)
 {
 	struct nvif_push *push = wndw->wndw.push;
-	int ret;
+	int ret = PUSH_WAIT(push, 3);
 
-	if ((ret = PUSH_WAIT(push, 3)))
+	if (ret)
 		return ret;
 
 	PUSH_MTHD(push, NVC37E, SET_CONTEXT_DMA_NOTIFIER, asyw->ntfy.handle,
@@ -245,9 +245,9 @@ int
 wndwc37e_sema_clr(struct nv50_wndw *wndw)
 {
 	struct nvif_push *push = wndw->wndw.push;
-	int ret;
+	int ret = PUSH_WAIT(push, 2);
 
-	if ((ret = PUSH_WAIT(push, 2)))
+	if (ret)
 		return ret;
 
 	PUSH_MTHD(push, NVC37E, SET_CONTEXT_DMA_SEMAPHORE, 0x00000000);
@@ -258,9 +258,9 @@ int
 wndwc37e_sema_set(struct nv50_wndw *wndw, struct nv50_wndw_atom *asyw)
 {
 	struct nvif_push *push = wndw->wndw.push;
-	int ret;
+	int ret = PUSH_WAIT(push, 5);
 
-	if ((ret = PUSH_WAIT(push, 5)))
+	if (ret)
 		return ret;
 
 	PUSH_MTHD(push, NVC37E, SET_SEMAPHORE_CONTROL, asyw->sema.offset,
@@ -274,9 +274,9 @@ int
 wndwc37e_update(struct nv50_wndw *wndw, u32 *interlock)
 {
 	struct nvif_push *push = wndw->wndw.push;
-	int ret;
+	int ret = PUSH_WAIT(push, 5);
 
-	if ((ret = PUSH_WAIT(push, 5)))
+	if (ret)
 		return ret;
 
 	PUSH_MTHD(push, NVC37E, SET_INTERLOCK_FLAGS, interlock[NV50_DISP_INTERLOCK_CURS] << 1 |
-- 
2.31.0

