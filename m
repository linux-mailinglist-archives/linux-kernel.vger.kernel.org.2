Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA26366FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242464AbhDUQSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbhDUQSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:18:42 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03530C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:18:07 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r186so15146256oif.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5IyC7Gpwn5ArZ5GanVhyjl5d8zPk1aPolAUQ4cg0yI=;
        b=W8RcbjmW8ZSOG+xTgCM551bMZ/waizOAlhWCuQ1MflmMQRD/OJYhLJo79NtPBqURlg
         GtT2q0WhnNlwyttY/HrjDINdCBlRjQZLnJEXpTy1j3xjE5nxC8Jy120x4p45BKLy2M6T
         QfZxs4A/62x0ltpISQi7q2yaooQyKtibGxgf6A5bmqk0T050WaoTvPCEt8H81mhlMGy3
         rQTQk3lOS7OxdyejpNV+MvnnoiFbNeCRR+qGfLYdgmTlpzCKN+CvYcwj2NLiWDO+I0ji
         FJmGP8qyiLtq5Fwn3QAq5mZ0afE6blYLEmlsYPV48HDvZbndHZBh+XOzFr8EcRD+dcZP
         XdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=d5IyC7Gpwn5ArZ5GanVhyjl5d8zPk1aPolAUQ4cg0yI=;
        b=FfqqAzBE71MG/yUoMjTWpMa9M85cVMKVBLKpgwVcZCF+CxaZV64nXbC63m4/Abg24F
         1GXHF6vfGVfvMpnphvZmDXC1ViA8h4aARLX89ERzLquK/mfwhf4EUTmFFrX8EEb8IGxz
         V3RjAEF43bHGNdcP0N2iuumAM97CWzwekSLSe2n+wx7nitDTx3KubziNvQtcNVxTx14/
         ewn7njA1sIcBtzDl7xv+iSV8TaxFCd64bWvHpT5Y7J+D9bClUnMdI/QCJxmOnrC+3O6Z
         8HjuJhLDxeqRBvlLH0KHdz1BYdfIXx2Qz5eDsHOf01GppNWtzdlthHlDtO431q0EPWWP
         yQzg==
X-Gm-Message-State: AOAM532xLgbdTCo9+5qdqBHyLKw5sEpJe4OVXGCz9cAshcmr87gFwqlj
        HkIDV0bU27XzAmLeTQhPKPCtobaLMkk=
X-Google-Smtp-Source: ABdhPJxLD2J7kjsRr4bQeHQNlhiyYOmBZqzEdKSHxoRd6pcHgTe1Elkjy8gyHtZydpUgPCR74pFYWw==
X-Received: by 2002:aca:ad81:: with SMTP id w123mr5895267oie.113.1619021886481;
        Wed, 21 Apr 2021 09:18:06 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m3sm627253otk.18.2021.04.21.09.18.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Apr 2021 09:18:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] drm/amd/display: Fix build warnings
Date:   Wed, 21 Apr 2021 09:18:02 -0700
Message-Id: <20210421161802.175639-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following build warnings.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:
	In function ‘dm_update_mst_vcpi_slots_for_dsc’:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6242:46:
	warning: variable ‘old_con_state’ set but not used

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:
	In function ‘amdgpu_dm_commit_cursors’:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7709:44:
	warning: variable ‘new_plane_state’ set but not used

The variables were introduced to be used in iterators, but not used.
Use other iterators which don't require the unused variables.

Fixes: 8ad278062de4e ("drm/amd/display: Disable cursors before disabling planes")
Fixes: 29b9ba74f6384 ("drm/amd/display: Recalculate VCPI slots for new DSC connectors")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 573cf17262da..f9b87f1f424b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6239,13 +6239,13 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 {
 	struct dc_stream_state *stream = NULL;
 	struct drm_connector *connector;
-	struct drm_connector_state *new_con_state, *old_con_state;
+	struct drm_connector_state *new_con_state;
 	struct amdgpu_dm_connector *aconnector;
 	struct dm_connector_state *dm_conn_state;
 	int i, j, clock, bpp;
 	int vcpi, pbn_div, pbn = 0;
 
-	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
+	for_each_new_connector_in_state(state, connector, new_con_state, i) {
 
 		aconnector = to_amdgpu_dm_connector(connector);
 
@@ -7706,15 +7706,14 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
 static void amdgpu_dm_commit_cursors(struct drm_atomic_state *state)
 {
 	struct drm_plane *plane;
-	struct drm_plane_state *old_plane_state, *new_plane_state;
+	struct drm_plane_state *old_plane_state;
 	int i;
 
 	/*
 	 * TODO: Make this per-stream so we don't issue redundant updates for
 	 * commits with multiple streams.
 	 */
-	for_each_oldnew_plane_in_state(state, plane, old_plane_state,
-				       new_plane_state, i)
+	for_each_old_plane_in_state(state, plane, old_plane_state, i)
 		if (plane->type == DRM_PLANE_TYPE_CURSOR)
 			handle_cursor_update(plane, old_plane_state);
 }
-- 
2.17.1

