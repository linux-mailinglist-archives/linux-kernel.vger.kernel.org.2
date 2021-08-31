Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F613FC036
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 02:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbhHaAyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 20:54:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231989AbhHaAyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 20:54:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E499A60FF2;
        Tue, 31 Aug 2021 00:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630371229;
        bh=wBfoW5VjwX94tcmf1r6pB9v16U5JrskEzJHYSKjraeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbsDjgF4iL4PUIHG0HoCvJiey/CrxhSgz64wChmx8LYG+bVhTon7os6IsuNZirvRz
         YandMPLGIx9SEZvQL8C3AzBJVVCiU/L8U6TSzGZ0LDiiVzWtfcg33ExaBw3MqTRmtn
         NJP2a8hktUNxs72et2K904CfeaJHLfmcUWrPbg61rMZoG5P0AwK1aU1HN2ALtL5bWp
         3fVG20HP+dmaezpLzyvEPZOLDLGmFqXr+4R7uWpidqfDfbOMb3nTGy1lGl8zLt28/9
         HX6FPUpdG9SfMCYPznYdh6K8UoebkRyxldHQRHphVsepPRNcYHlPeDcU1KFc4ZYm7v
         2MbMVD4/RTmrA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: should put a page beyond EOF when preparing a write
Date:   Mon, 30 Aug 2021 17:53:46 -0700
Message-Id: <20210831005346.118701-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
In-Reply-To: <20210831005346.118701-1-jaegeuk@kernel.org>
References: <20210831005346.118701-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prepare_compress_overwrite() gets/locks a page to prepare a read, and calls
f2fs_read_multi_pages() which checks EOF first. If there's any page beyond EOF,
we unlock the page and set cc->rpages[i] = NULL, which we can't put the page
anymore. This makes page leak, so let's fix by putting that page.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8e8824605f83..41d29382eced 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2183,6 +2183,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 			continue;
 		}
 		unlock_page(page);
+		if (for_write)
+			put_page(page);
 		cc->rpages[i] = NULL;
 		cc->nr_rpages--;
 	}
-- 
2.33.0.259.gc128427fd7-goog

