Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634EE329D17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 12:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442971AbhCBCRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 21:17:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:55192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242312AbhCATo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:44:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E66265129;
        Mon,  1 Mar 2021 17:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614618198;
        bh=aWTIFM4NeP3t/+9+xymvdY5JiY10QtUC0TL3TErd+j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cl3EIHSPh75v5sPYED/50XvRYgqF75fKuZkDlci50N0CCznnCK//ZGgxWwxm8RkKB
         UtF2VwHQLdiTEjVk8bbxYsPngbw7c0uQdO3pYHCvuTCek14Qji5aAfOObF59aCUoEJ
         ebl1e207SUYAM91eE+dE5QjKZXd11fbS1c0w7LxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikos Tsironis <ntsironis@arrikto.com>,
        Ming-Hung Tsai <mtsai@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.4 326/340] dm era: Fix bitset memory leaks
Date:   Mon,  1 Mar 2021 17:14:30 +0100
Message-Id: <20210301161104.344274644@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161048.294656001@linuxfoundation.org>
References: <20210301161048.294656001@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikos Tsironis <ntsironis@arrikto.com>

commit 904e6b266619c2da5c58b5dce14ae30629e39645 upstream.

Deallocate the memory allocated for the in-core bitsets when destroying
the target and in error paths.

Fixes: eec40579d84873 ("dm: add era target")
Cc: stable@vger.kernel.org # v3.15+
Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
Reviewed-by: Ming-Hung Tsai <mtsai@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-era-target.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -47,6 +47,7 @@ struct writeset {
 static void writeset_free(struct writeset *ws)
 {
 	vfree(ws->bits);
+	ws->bits = NULL;
 }
 
 static int setup_on_disk_bitset(struct dm_disk_bitset *info,
@@ -811,6 +812,8 @@ static struct era_metadata *metadata_ope
 
 static void metadata_close(struct era_metadata *md)
 {
+	writeset_free(&md->writesets[0]);
+	writeset_free(&md->writesets[1]);
 	destroy_persistent_data_objects(md);
 	kfree(md);
 }
@@ -848,6 +851,7 @@ static int metadata_resize(struct era_me
 	r = writeset_alloc(&md->writesets[1], *new_size);
 	if (r) {
 		DMERR("%s: writeset_alloc failed for writeset 1", __func__);
+		writeset_free(&md->writesets[0]);
 		return r;
 	}
 
@@ -858,6 +862,8 @@ static int metadata_resize(struct era_me
 			    &value, &md->era_array_root);
 	if (r) {
 		DMERR("%s: dm_array_resize failed", __func__);
+		writeset_free(&md->writesets[0]);
+		writeset_free(&md->writesets[1]);
 		return r;
 	}
 


