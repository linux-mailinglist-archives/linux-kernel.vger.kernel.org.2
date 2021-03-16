Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B236A33D1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbhCPKXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:23:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:32800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236531AbhCPKXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:23:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A664164FC7;
        Tue, 16 Mar 2021 10:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615890197;
        bh=IF6ZsxNjOeA4IVr6pl9txoM9es/COe6h/Oky2trJsvw=;
        h=From:To:Cc:Subject:Date:From;
        b=YZLbvx5l+uVu8q5dk+8cXDGLwkBH639Ok1h1XUWQJcoU7VdbKe56jjnYT53uki5kU
         f+JvzWEXh79e5IjOEvlNM4uLhCvvF2fjMlXtPAvNr4pI68sd/UIroMBFSygicLMfsl
         Q5QAsjKKrVVwvRMTx6zlcm4NRRZNy7/vy5kLLrrU=
From:   gregkh@linuxfoundation.org
To:     linux-staging@lists.linux.dev, devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] MAINTAINERS: move the staging subsystem to lists.linux.dev
Date:   Tue, 16 Mar 2021 11:23:11 +0100
Message-Id: <20210316102311.182375-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The drivers/staging/ tree has a new mailing list,
linux-staging@lists.linux.dev, so move the MAINTAINER entry to point to
it so that we get patches sent to the proper place.

There was no need to specify a list for the hikey9xx driver, the tools
pick up the "base" list for drivers/staging/* so remove that line to
make the file simpler.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7c25c0fc08a..9e876927c60d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8116,7 +8116,6 @@ F:	drivers/crypto/hisilicon/sec2/sec_main.c
 
 HISILICON STAGING DRIVERS FOR HIKEY 960/970
 M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
-L:	devel@driverdev.osuosl.org
 S:	Maintained
 F:	drivers/staging/hikey9xx/
 
@@ -17040,7 +17039,7 @@ F:	drivers/staging/vt665?/
 
 STAGING SUBSYSTEM
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-L:	devel@driverdev.osuosl.org
+L:	linux-staging@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 F:	drivers/staging/
-- 
2.30.2

