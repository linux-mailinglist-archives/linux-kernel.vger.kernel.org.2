Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CBA421E06
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 07:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhJEFjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 01:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhJEFjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 01:39:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81722C061745;
        Mon,  4 Oct 2021 22:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fBUNICS3Pwixz65i7Q16asMz+5dJwJkx8E+lnKdL6pM=; b=NOGKtj/TuRDL8tYrGmh5tKGLad
        0vcYwUc4cBC0yi8/RJmof0ZhcYYxvGr5GBgZvKonrwPnMCQzQelqr+gOlf7SGA8gW3dw0I/lhqUON
        8wEw1pMABWdvE09WdVSXtHtz9ISinJBow4dxvnO6/3zzPlHdIIzSZ4iBf13+l34dUyaLI5TKpAv2M
        XHIdwZA1V9SdTXbDGzCnnp50QPL4vuI5XCwtXHtOLEF7hteu7Z/vMTYWkCB83KqFiHva7oWg25/Fx
        0kaezQ8liuZQStVfWhYzDdycuwXzxdqCB8XV77XGFwgx+AEH7fo6KIZILNzG02X5C5cnU3Ylc7STI
        skhpPPzw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXd8p-008zfR-BN; Tue, 05 Oct 2021 05:37:27 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2] host1x: bus.c: drop excess kernel-doc entry @key
Date:   Mon,  4 Oct 2021 22:37:26 -0700
Message-Id: <20211005053726.14738-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warning in host1x:

../drivers/gpu/host1x/bus.c:774: warning: Excess function parameter 'key' description in '__host1x_client_register'

Fixes: 0cfe5a6e758f ("gpu: host1x: Split up client initalization and registration")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-tegra@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
v2: rebase and resend

 drivers/gpu/host1x/bus.c |    1 -
 1 file changed, 1 deletion(-)

--- lnx-515-rc4.orig/drivers/gpu/host1x/bus.c
+++ lnx-515-rc4/drivers/gpu/host1x/bus.c
@@ -761,7 +761,6 @@ EXPORT_SYMBOL(host1x_client_exit);
 /**
  * __host1x_client_register() - register a host1x client
  * @client: host1x client
- * @key: lock class key for the client-specific mutex
  *
  * Registers a host1x client with each host1x controller instance. Note that
  * each client will only match their parent host1x controller and will only be
