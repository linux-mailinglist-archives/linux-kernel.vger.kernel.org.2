Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C3C44382D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhKBWFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhKBWEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:04:55 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB539C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 15:02:19 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 996B45ECB;
        Tue,  2 Nov 2021 22:02:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 996B45ECB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635890539; bh=mVXu/9FhJQoBbaQSUmq4umo87osMVAiYjT95366o2ME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gtsnZE49Cx8pooJDO/n2hBgLm9j+7vM8Y9uLqFTHWArgCycyJO/vdjeAnxD6y3Wkj
         iUD+J+nBE91J0DhWL4EQ8RjLtC9TCGs+hr7UeNsNRXebgauXOKpO1Q6RkzpNYid5aG
         JGRqu1ouhIPLWt1v3YxA5whhzwPg1Zes1ASXXb5fYAzGwUSS5TbGPaL2ZCePD58+jk
         +Ev/NDA6weDl72A2SXDaIC6wgx4mTdVIvejAmBn1tnZHxXGu+KY44G2Nn6a8x/YdM1
         a3hZfJRIFTcWAfeQouCS2utFgOOqs7vpZuTayDLA0BqaZxZvrAjcoXDmJfyCZiHgOS
         qciCmdHu10GEA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/9] Input: remove unused header <linux/input/cy8ctmg110_pdata.h>
Date:   Tue,  2 Nov 2021 16:01:59 -0600
Message-Id: <20211102220203.940290-6-corbet@lwn.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211102220203.940290-1-corbet@lwn.net>
References: <20211102220203.940290-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 83b41248ed04 ("Input: cy8ctmg110_ts - switch to using gpiod API")
remove the last use of <linux/input/cy8ctmg110_pdata.h> but left the header
file behind.  Nothing uses it now, delete it.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/linux/input/cy8ctmg110_pdata.h | 10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 include/linux/input/cy8ctmg110_pdata.h

diff --git a/include/linux/input/cy8ctmg110_pdata.h b/include/linux/input/cy8ctmg110_pdata.h
deleted file mode 100644
index ee1d44545f30..000000000000
--- a/include/linux/input/cy8ctmg110_pdata.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_CY8CTMG110_PDATA_H
-#define _LINUX_CY8CTMG110_PDATA_H
-
-struct cy8ctmg110_pdata
-{
-	int reset_pin;		/* Reset pin is wired to this GPIO (optional) */
-};
-
-#endif
-- 
2.31.1

