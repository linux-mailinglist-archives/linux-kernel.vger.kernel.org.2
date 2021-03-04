Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3770E32CD9D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 08:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhCDHai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 02:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhCDHaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 02:30:14 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573DFC061574
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 23:29:34 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 18so3448897pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 23:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VdsqpWwdEeY8aJX19dV6yy4QxSmnpc0PvPEJST03Ftw=;
        b=SBllmr7z0guUOiLqKiI/ztyELVCFIzx0GeOzVAxDWimvy5kFp1YEUArlJDnGUIvfcL
         vn1EPExQyvaivS2ubCkjN8MBIwi0x+1c8y+ymN5nyK5ihK6kUJTr88EF6Euc1drKY47u
         tkiBRC8rDsxUrQIpJxCP1H1icjMZiDsZog1r/9tOtS21iIKJoXgirlNeAqY6VLXlnwgt
         PSkwxcd5NB+cHTQFSx7vWNkc8YnlOTXHSXXTQHKNSbRt1k++O450gn63c+0isrkC/i5x
         qQ7ks+3z3AcRSm1v5SkI/Z6TjJP60HX7cfyjPebcX4E+an+b6NeqN98ogxwMzLvOkHd5
         Z0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VdsqpWwdEeY8aJX19dV6yy4QxSmnpc0PvPEJST03Ftw=;
        b=EupZcItJlNGWX65QuW6Ud1GTHvtpXs+WCNWz/Kl+Yjlt+LHYfWIZ1xuzA4lLNhcES7
         696Ome/wlg9RIagPy3H8IwC9XhC23KJIQt/QoafNx0NFvEPNyDlONWCrryFy6yWoPCxH
         moC3h+tuvxftnwJF1AByt5XxOlicoOkM7VATeD6wQ/iOEwnQ/ffmlWFBwV70N66dslUk
         3eoH6SVIEnlUyrT9k3Fz0459KHjToescUISWHeZl3a/joOO0YstICVuichiWMPLow/GM
         rcYRNgNXrZMYIPRgozpN02l7Ow7CVE1b2KYFBzTpF6BAb56xzTeup92XHpWwjpgBr0rr
         KLWA==
X-Gm-Message-State: AOAM533qZbrTsDVS0RV+6DVe7FMBip4EF2vhhEwFbG/XUa1hhIV76ATN
        TBy7c8R3XpfajTNdP/zSW163sTOkg/mQjq8S
X-Google-Smtp-Source: ABdhPJyfMZG1CtknVJRfzGR12b3WSU2BAr4Rux0Iqvsh2TIsPjSTBYnUZJZyALZGRd6fDwpolGDJAw==
X-Received: by 2002:a63:1503:: with SMTP id v3mr2565575pgl.240.1614842973739;
        Wed, 03 Mar 2021 23:29:33 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c0:4701:ae70:a76a:a553:bfca:caa6])
        by smtp.gmail.com with ESMTPSA id t36sm1451005pfg.111.2021.03.03.23.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 23:29:33 -0800 (PST)
From:   Drew Fustini <drew@beagleboard.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        WenZhang <zhangwen@yulong.com>, zuoqilin <zuoqilin@yulong.com>,
        Joe Perches <joe@perches.com>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>,
        Wang Qing <wangqing@vivo.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        dingsenjie <dingsenjie@yulong.com>,
        SeongJae Park <sjpark@amazon.de>,
        Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Drew Fustini <drew@beagleboard.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] scripts/spelling.txt: add "overlfow"
Date:   Wed,  3 Mar 2021 23:26:58 -0800
Message-Id: <20210304072657.64577-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add typo "overlfow" for "overflow". This typo was found and fixed in
net/sctp/tsnmap.c.

Link: https://lore.kernel.org/netdev/20210304055548.56829-1-drew@beagleboard.org/
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 2e3ba91a5072..f57e3e9538b0 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1013,6 +1013,7 @@ oustanding||outstanding
 overaall||overall
 overhread||overhead
 overlaping||overlapping
+overlfow||overflow
 overide||override
 overrided||overridden
 overriden||overridden
-- 
2.27.0

