Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0691354AA4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243229AbhDFBy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 21:54:57 -0400
Received: from mo-csw-fb1114.securemx.jp ([210.130.202.173]:59820 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbhDFBy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:54:56 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Apr 2021 21:54:55 EDT
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1114) id 1361lTZ5020195; Tue, 6 Apr 2021 10:47:29 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 1361ktBu006321; Tue, 6 Apr 2021 10:46:55 +0900
X-Iguazu-Qid: 2wGrPpF1uEzCrsK0MH
X-Iguazu-QSIG: v=2; s=0; t=1617673615; q=2wGrPpF1uEzCrsK0MH; m=j1mtSmg+I/E2iQsiK90JGCh/zBNv4ekOEacMF0peMck=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1110) id 1361krHY022634
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 6 Apr 2021 10:46:54 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 017411000A5;
        Tue,  6 Apr 2021 10:46:53 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 1361kqF7012658;
        Tue, 6 Apr 2021 10:46:52 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix corner case in bad block table handling.
Date:   Tue,  6 Apr 2021 10:46:50 +0900
X-TSB-HOP: ON
Message-Id: <cover.1616635406.git.ytc-mb-yfuruyama7@kioxia.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doyle, Patrick (1):
  Fix corner case in bad block table handling.

Yoshio Furuyama (1):
  Fix the issue for clearing status process

 drivers/mtd/nand/bbt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.1

