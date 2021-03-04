Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77D732CDF4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 08:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhCDHyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 02:54:38 -0500
Received: from m12-14.163.com ([220.181.12.14]:51034 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235088AbhCDHyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 02:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aMKLs
        KYw4wm9UoYq9YlcxxIFzq3shc7JJEz+BHGZnEw=; b=UCu8XNURtlcW8fLP7Dtly
        +GSVecSIANisSnti6FwMFC1Une4ebVu/ZWx/ZueR6xCFpuunFdVuYda9QUlq9ROJ
        f7qBk1gc0iBaPoLM+cR2RnfB5aiJjrhj4D9fjHBdIxw2VMZqwaWC2nNZp41Vjajs
        dmMiA8CHMpE9wsYyhKhURE=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowAC3hNm0hUBg0PeEng--.10756S2;
        Thu, 04 Mar 2021 15:01:14 +0800 (CST)
From:   zuoqilin1@163.com
To:     akpm@linux-foundation.org, ebiggers@google.com,
        j.neuschaefer@gmx.net, joe@perches.com, sjpark@amazon.de,
        colin.king@canonical.com
Cc:     linux-kernel@vger.kernel.org, zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] scripts/spelling.txt: Add "diabled" typo
Date:   Thu,  4 Mar 2021 15:01:06 +0800
Message-Id: <20210304070106.2313-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAC3hNm0hUBg0PeEng--.10756S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUkg_-DUUUU
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiHhpLiVSItDlmTgAAs-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Increase "diabled" spelling error check.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 2e3ba91..e5f3b7e 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -470,6 +470,7 @@ devided||divided
 deviece||device
 devision||division
 diable||disable
+diabled||disabled
 dicline||decline
 dictionnary||dictionary
 didnt||didn't
-- 
1.9.1


