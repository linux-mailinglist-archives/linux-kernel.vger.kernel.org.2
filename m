Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5647F459A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhKWCbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:31:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhKWCbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:31:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BC9560FD7;
        Tue, 23 Nov 2021 02:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637634483;
        bh=tyfrpeux84ftug2ONg9ZfP/BwMlpGSVGl+i7DUhZPDY=;
        h=From:To:Cc:Subject:Date:From;
        b=LGNH61duIdHVHoGEPhi1amdYNfTiDEZRyI0RPdAVTt3G4tfnRtL9HAj0U/rFfmWwK
         J8MjSsym4aSO1Ha4PvyCMHedm/suRmTTP1H0ocKNSRrmDbhiaHIre8WER2BPYs+52Z
         asJloFmSmqcScYctnbjKoAKZS7hPo0E1AFx8iF7mlEZnzh+QiOCnSr+E8DEEhmz2Pr
         68Ceu8x4kJXq+up1H0xSmS7qfqg9kl2PYJtMheuldLnDTrVe5z8c1qfunZMLZRI+zH
         TMq6KPQnLFbQypvwGMZLAubC+9ZiluWKAmqM8jt0q0UWiQjRjDMUbRzfa3pbPlLus5
         sga5A6ymc+02Q==
From:   guoren@kernel.org
To:     guoren@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] mailmap: Update email address for Guo Ren
Date:   Tue, 23 Nov 2021 10:27:41 +0800
Message-Id: <20211123022741.545541-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The ren_guo@c-sky.com would be deprecated and use guoren@kernel.org
as the main email address.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 14314e3c5d5e..c709878864ad 100644
--- a/.mailmap
+++ b/.mailmap
@@ -123,6 +123,8 @@ Greg Kroah-Hartman <gregkh@suse.de>
 Greg Kroah-Hartman <greg@kroah.com>
 Greg Kurz <groug@kaod.org> <gkurz@linux.vnet.ibm.com>
 Gregory CLEMENT <gregory.clement@bootlin.com> <gregory.clement@free-electrons.com>
+Guo Ren <guoren@kernel.org> <guoren@linux.alibaba.com>
+Guo Ren <guoren@kernel.org> <ren_guo@c-sky.com>
 Gustavo Padovan <gustavo@las.ic.unicamp.br>
 Gustavo Padovan <padovan@profusion.mobi>
 Hanjun Guo <guohanjun@huawei.com> <hanjun.guo@linaro.org>
-- 
2.25.1

