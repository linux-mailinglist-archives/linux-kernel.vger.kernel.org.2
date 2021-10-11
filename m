Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B74428F99
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbhJKN7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231538AbhJKN5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:57:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B364E61076;
        Mon, 11 Oct 2021 13:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633960432;
        bh=7uHLBaU7MVfBona6fKXUSESifdH1LisxkGZrXLyXGUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yf2aBSV/H9ueMlXBEw4HnQ+Kw6YfDCsLskn+JewsMwiy5SVgVF7VJxdXVG1Dnhqzt
         2YxcyarNzlSVt1eVhNmch6U5gnzDaa0pHkoYlbG/V3ZMRGADbLFxp3iulczKH4zOcd
         Ouxsyz4JEFdDFyMW/2CTlDs4OROQn1Sw9fRjXoOc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Karol Herbst <kherbst@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 58/83] drm/nouveau/debugfs: fix file release memory leak
Date:   Mon, 11 Oct 2021 15:46:18 +0200
Message-Id: <20211011134510.391146023@linuxfoundation.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011134508.362906295@linuxfoundation.org>
References: <20211011134508.362906295@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit f5a8703a9c418c6fc54eb772712dfe7641e3991c ]

When using single_open() for opening, single_release() should be
called, otherwise the 'op' allocated in single_open() will be leaked.

Fixes: 6e9fc177399f ("drm/nouveau/debugfs: add copy of sysfs pstate interface ported to debugfs")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Karol Herbst <kherbst@redhat.com>
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210911075023.3969054-2-yangyingliang@huawei.com
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index c2bc05eb2e54..1cbe01048b93 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -207,6 +207,7 @@ static const struct file_operations nouveau_pstate_fops = {
 	.open = nouveau_debugfs_pstate_open,
 	.read = seq_read,
 	.write = nouveau_debugfs_pstate_set,
+	.release = single_release,
 };
 
 static struct drm_info_list nouveau_debugfs_list[] = {
-- 
2.33.0



