Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410E3421B0B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhJEAVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhJEAVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:21:06 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC54C061749;
        Mon,  4 Oct 2021 17:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tBp2Xr2Aab9JmS/WKFkErf1SL00e2Cm2xg2oHgtaM9Y=; b=O+GylvMBR90V++DWbSrMt0eLBZ
        YCW8bJ6E5qrd4vuUI7UHebol10X6RGTPeXl3As76iVOuJaTVyZL8vBoT5Z+Xdav+HrIhphSewvFva
        YvQn1gOMdujRBvxZC+ZB/1W0OXweAblmowGOdhGfiTshL7g9djUH62ZW/zH6o2SLArzgP8GmjRocb
        i0hjM3oVngugdThoPDpNQ/5np0HZ5d75J6onDUY595ZV47n5SpZPpAptHY6bdmK66ikpM4t0UIKv3
        SHqJhuFjMrgh2ShsTf7RgQAA3RFrGemwjAOkDRThzkuhnzCPkroE/RocHOrqhCkxZuPeJvCFJLRir
        UCF9+rkQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXYAu-008SGi-1t; Tue, 05 Oct 2021 00:19:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/5 v3] sh: add git tree to MAINTAINERS
Date:   Mon,  4 Oct 2021 17:19:11 -0700
Message-Id: <20211005001914.28574-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211005001914.28574-1-rdunlap@infradead.org>
References: <20211005001914.28574-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the git tree location for linux-sh.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3: new patch in this series

 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20211001.orig/MAINTAINERS
+++ linux-next-20211001/MAINTAINERS
@@ -18047,6 +18047,7 @@ M:	Yoshinori Sato <ysato@users.sourcefor
 M:	Rich Felker <dalias@libc.org>
 L:	linux-sh@vger.kernel.org
 S:	Maintained
+T:	git git://git.libc.org/linux-sh
 Q:	http://patchwork.kernel.org/project/linux-sh/list/
 F:	Documentation/sh/
 F:	arch/sh/
