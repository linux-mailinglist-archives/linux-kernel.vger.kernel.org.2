Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36F93AC389
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhFRGTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:19:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59712 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbhFRGRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9C9B321B59;
        Fri, 18 Jun 2021 06:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/SpERyA+zkcmagUm1oEhXZEouTm6Uehd8gHw+VSJQNA=;
        b=zc5XQMFey/7ylS0roJbl4AxnY7tMUO6Tm7mOdCFx7ztYU4l10Ncs8pvChJJbQX86BFMv5M
        xElYoW86eRKbjAqJupJX6X71GvyZEaBZV8FGkwoH6p9HwMiF3YqOUTu9WSTCdC9eRky5Tw
        ZWmgNfqCaqBbadJzG3+ieHouIFi2SxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996921;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/SpERyA+zkcmagUm1oEhXZEouTm6Uehd8gHw+VSJQNA=;
        b=7oGAfchxAeN1Ne+nVx2rIIOpiSDngiNtisrn1Hp8siQIRcVD/pOwmkiXUrZs7Ezd8+mPJi
        DmBUgChE3Pxy3iAQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 75B64A3BCF;
        Fri, 18 Jun 2021 06:15:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 21/70] mxser: drop unused MOXA_DIAGNOSE macro
Date:   Fri, 18 Jun 2021 08:14:27 +0200
Message-Id: <20210618061516.662-22-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unused.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 79d7cecb7765..a830a4359ea1 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -51,7 +51,6 @@
 
 #define MOXA			0x400
 #define MOXA_GETDATACOUNT	(MOXA + 23)
-#define MOXA_DIAGNOSE		(MOXA + 50)
 #define MOXA_CHKPORTENABLE	(MOXA + 60)
 #define MOXA_HighSpeedOn	(MOXA + 61)
 #define MOXA_GET_MAJOR		(MOXA + 63)
-- 
2.32.0

