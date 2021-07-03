Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102FD3BA8F7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 16:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhGCOee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 10:34:34 -0400
Received: from m32-153.88.com ([43.250.32.153]:40466 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229598AbhGCOeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 10:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=b6j7QIjA07hPn5Qw816M1evhGPvtYI/KSbJDm
        aNuhSk=; b=AAVAbsYPbdfvxgE5UE+AltK60lwH85YOCL8FY+j5zeTCPT/hc8KDt
        NsA+3vY8EcWQORCs1hWEsTndxRoACQFKXmmp7JCbRcCijj4/d/o8DGUMyQfzx55m
        L05cKJUYgnPsSdQzzcW94MgobPHrFyGzm1FgP6W7H+hunpxCRcDqz0=
Received: from localhost.localdomain (unknown [113.251.11.229])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgDHnv3CdOBgiXM8AA--.16451S4;
        Sat, 03 Jul 2021 22:31:40 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] docs/zh_TW: fix an issue while building
Date:   Sat,  3 Jul 2021 22:31:29 +0800
Message-Id: <20210703143130.18349-3-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210703143130.18349-1-src.res@email.cn>
References: <20210703143130.18349-1-src.res@email.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GiKnCgDHnv3CdOBgiXM8AA--.16451S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW3XF4xtry8WF4rGrW3ZFb_yoW8XF4DpF
        9rKrZ7t3W7KF15Gr1kGr12qw4jvFyxuF4rGFWUtwn3urn3Cr4ktFs0grZFqF9aqrWrtF95
        Zrn0vryDXr12yw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUqvb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1U
        Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMx
        AIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jHBTOU
        UUUU=
X-Originating-IP: [113.251.11.229]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the documentation, the following issue was reported:

    /home/src-resources/Coding/Projects/Other-Projects/Linux/Documentation/
    translations/zh_TW/admin-guide/reporting-issues.rst:712: WARNING:
    duplicate label translations/zh_tw/admin-guide/reporting-issues:
    檢查「汙染」標誌, other instance in /home/src-resources/Coding/Projects/
    Other-Projects/Linux/Documentation/translations/zh_TW/admin-guide/
    reporting-issues.rst

Consequently, replace "檢查「汙染」標誌" with "檢測「汙染」標誌" to
solve it.

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 .../translations/zh_TW/admin-guide/reporting-issues.rst         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
index 390a1f40ba2f..27638e199f13 100644
--- a/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
+++ b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
@@ -371,7 +371,7 @@ Linux內核破壞了它處理的數據或損壞了它運行的硬體。當內核
 內核模塊。
 
 
-檢查「汙染」標誌
+檢測「汙染」標誌
 ----------------
 
     *當問題發生時，檢查您的內核是否被「汙染」，因爲使內核設置這個標誌的事件可
-- 
2.25.1

