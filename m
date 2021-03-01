Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04064329E95
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 13:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445681AbhCBDBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbhCAUNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:13:54 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52BAC061788;
        Mon,  1 Mar 2021 12:13:13 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id x124so17993930qkc.1;
        Mon, 01 Mar 2021 12:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJhSBkNGLpPmy0tBm0T3KDugBljtIoUbUA5gLaMg7Vg=;
        b=WcOrAQvSWUzKZ6975q/7s6BMsd5fgD5/37IgVVRnFQcP5IIE++nBO/XqCdRkpjnqv0
         0d/1yjvhsAJ9dfjGMZGoQc5Oa9KZP8BuWK3KAagXDuVBQrqiTi6iZStr7GU/BWijYi8N
         O7CFq8bizbQqcrTOlwzNdyxgIugPhfalOhkHiDZvJLl8PJC7R/+cGN5c2gYVm7Ouawfc
         Shw5FglgXl5j0jEtyThpFb0xQj41zj2XgIAqKfuYLQQQAr6zdIJC8AT/X63xISAjehyZ
         dCzO42Irsk/RqCDtmmPneVOo8hlxg5y2RnXrO7VluJ3eilAifGVcVCJ37sbXgmVvM/Y9
         bf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJhSBkNGLpPmy0tBm0T3KDugBljtIoUbUA5gLaMg7Vg=;
        b=BrcvBOBPgdZFVVU/HhoxlNWNIVtTOlOTLgrRlRkz2cXbtxHtR/TWESJY/mgS/+LzBB
         UMN1lNsF9DYENw0V/iGR/3Us2apQL3yEqHtVW1q6dmbLPVubHy0e72tpHfockaIsnzbY
         Do4LFgl5UBznbpCXAvoC66zWijG9/41/sj46VFcuJ+XN+LifG22Np5Hp5D6FTG1mGgjw
         EVOhCkIOtVbJ2HHLJ+NaifZVoXzPpB/vayQp1jzSyeyElIhNMo9jIh0zZNne8HKRm3H7
         OG1zckNMN3b3eD14ZCxqz6UwKcwLlwVEDocqhfhG6NxOkdLy12mPyzDucGqJ06i0WLoR
         g+TQ==
X-Gm-Message-State: AOAM532dZQPs6ENKlUo4KfrUXj1mEUUcb9rxHJWi3Isv2HRq9RNjoqBz
        gLxLTlcUhOL6Rl2+jIrGXKXtD2ncx129PNut
X-Google-Smtp-Source: ABdhPJyl68RnIwLiwSWsh2W4iymT1NM+tXcvSjPE3o6QofCgtYavelrGzoRkHo9RUSfUkcCCW++L5Q==
X-Received: by 2002:a05:620a:15bb:: with SMTP id f27mr15827723qkk.425.1614629593081;
        Mon, 01 Mar 2021 12:13:13 -0800 (PST)
Received: from localhost.localdomain ([156.146.37.135])
        by smtp.gmail.com with ESMTPSA id r67sm13297487qkd.93.2021.03.01.12.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 12:13:12 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] docs: sphinx: Fix couple of spellings in the file rstFlatTable.py
Date:   Tue,  2 Mar 2021 01:40:52 +0530
Message-Id: <20210301201052.11067-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/automaticly/automatically/
s/buidler/builder/

..and a sentence construction fix.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
 Incorporating Randy's observations ...i.e sentence construction

 Documentation/sphinx/rstFlatTable.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/sphinx/rstFlatTable.py b/Documentation/sphinx/rstFlatTable.py
index a3eea0bbe6ba..16bea0632555 100755
--- a/Documentation/sphinx/rstFlatTable.py
+++ b/Documentation/sphinx/rstFlatTable.py
@@ -22,7 +22,7 @@ u"""

     * *auto span* rightmost cell of a table row over the missing cells on the
       right side of that table-row.  With Option ``:fill-cells:`` this behavior
-      can changed from *auto span* to *auto fill*, which automaticly inserts
+      can be changed from *auto span* to *auto fill*, which automatically inserts
       (empty) cells instead of spanning the last cell.

     Options:
@@ -161,7 +161,7 @@ class ListTableBuilder(object):
         for colwidth in colwidths:
             colspec = nodes.colspec(colwidth=colwidth)
             # FIXME: It seems, that the stub method only works well in the
-            # absence of rowspan (observed by the html buidler, the docutils-xml
+            # absence of rowspan (observed by the html builder, the docutils-xml
             # build seems OK).  This is not extraordinary, because there exists
             # no table directive (except *this* flat-table) which allows to
             # define coexistent of rowspan and stubs (there was no use-case
--
2.26.2

