Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9BC34AA54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCZOmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhCZOlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:41:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63B3861A05;
        Fri, 26 Mar 2021 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616769715;
        bh=Ub6j1ADUPloP6U9Fcg9w8Y53uDIZ1oVcMBI4XxirdVg=;
        h=From:To:Cc:Subject:Date:From;
        b=bWtJboigcqM+Lq+lBvRhBiIJ61S9hI5EHboXwrW5tQTiIUBzuYH299yz/i3tn0VhQ
         H8D5TceAmlJz159qz+f6YnDq9JZUQ7pQSMLIsZUY2e1Hr0W9Q+wPF6hxYzo/Imm3yT
         wdWHlOB+k/ZXOuvQJ4fAlO0CBCzBkQ/XwtCkwDUMN2GjQ7+pTlrsTvQQmhoeOxTQGd
         MzMbhcT5Mt6yBblE4/qfpL+FLlp5pohwQLgJA7dmJjUCAXp4C93PGrw704nBCubtSf
         fBc5aGwY6PmFaGF8pSG/MHLVX0gAZJi9eerkIRGxi7BR774xnxq1sfhADbPHF4/TGe
         H7sqvWDaKAQTw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: delete empty compress.h
Date:   Fri, 26 Mar 2021 22:41:43 +0800
Message-Id: <20210326144143.2313-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Commit 75e91c888989 ("f2fs: compress: fix compression chksum")
wrongly introduced empty compress.h, delete it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 fs/f2fs/compress.h

diff --git a/fs/f2fs/compress.h b/fs/f2fs/compress.h
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.22.1

