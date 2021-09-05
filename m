Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99756400E94
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 09:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhIEHdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 03:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhIEHdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 03:33:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5B9C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 00:32:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq28so7072545lfb.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 00:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6+3B9t1RtmIpk1Y5k8Qbj0wAkB7hCJyM5IWL4YBz3pM=;
        b=M7mWvfJu3PN2CkhJ6l99lKh2jT5UCjKLpD19cNQRicDq+l5fuoD2Y5pDYJXtt8cLsV
         VjjK3CufZBQPwKmAooIsXyiY2EFimnmSBGHeGiK91ujehIWVje1aCD9BEG+l9KfV11f6
         AwFUX8wgUyvaidD20pHde3s6YR8HzjJdlcBYPR/onWm0CQHP8YAGKaJJde9dt8JzKT3O
         Bi+rJqH8wS8soqdRpn+fFfCt0SXA0D1IhEy0tV0oPfoxS2Fyg/WZNmbMDMVzNu4wZfH4
         sZayMnCUsmDMES8fdgZJlPKE2+C1ARItRr2sCka7lIZ1sL8Ze2r9hSqQpWlNrVhtEE79
         i0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6+3B9t1RtmIpk1Y5k8Qbj0wAkB7hCJyM5IWL4YBz3pM=;
        b=c4pViImys8b0fbilK7EcwlTEfL29i4YXcEvXk5yu5q4HTGlO4mSvOKQXP28BraoerY
         YbdkZMckVoDqQaQOjIQbWyTwbhTUt8e8kjalHgiPxhSyaoLTvSCXZTY9U45m/K/iHQ2m
         Lpfz5AO3rme6PevYXyiY6Nl7xiKU0jEIwwKnCvPo8FT44X4bewt5ykdHWgHWHYjkznoB
         x6xxXH8xc8MBQJor/lpm8rFpgmj0wRlcwuzK8y2waI0E28LVOCGhpGrf2ECw61yzmf1m
         wROvxOl3Yde6zNS7LE2MCzrDNT1KGZtcxCgU5MEZEBHabmR1iSDbGldAaX4wGHL/b1Xr
         p6VQ==
X-Gm-Message-State: AOAM532YjOKHWsb5bWKv8BniyEuTWxZzlOTsycCA30us85uNWz6xcSIR
        uu++sBy2jqmWE1r6e4TWXSII7WUk28pZ6YA=
X-Google-Smtp-Source: ABdhPJwwsYfjs5dsX2S9wiB3t4MmCvPa7Iqez1JOroMoVlo9atEIQAJk5nCDNTQCp+S74NlHCaEarA==
X-Received: by 2002:a05:6512:686:: with SMTP id t6mr5356574lfe.49.1630827118879;
        Sun, 05 Sep 2021 00:31:58 -0700 (PDT)
Received: from ripxoarch.localdomain (h-158-174-82-95.A357.priv.bahnhof.se. [158.174.82.95])
        by smtp.gmail.com with ESMTPSA id n25sm545379ljj.42.2021.09.05.00.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 00:31:58 -0700 (PDT)
From:   "Philip K. Gisslow" <ripxorip@gmail.com>
Cc:     trivial@kernel.org, "Philip K. Gisslow" <ripxorip@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/tags.sh: Fix obsolete parameter for ctags
Date:   Sun,  5 Sep 2021 09:31:32 +0200
Message-Id: <20210905073133.21910-1-ripxorip@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Distros such as Fedora and Arch are using the maintained
universal-ctags implementation. This version has replaced
the obsolete --extra flag with --extras.

Signed-off-by: Philip K. Gisslow <ripxorip@gmail.com>
---
 scripts/tags.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index db8ba411860a..b24bfaec6290 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -247,6 +247,10 @@ setup_regex()
 
 exuberant()
 {
+	CTAGS_EXTRA="extra"
+	if $1 --version 2>&1 | grep -iq universal; then
+	    CTAGS_EXTRA="extras"
+	fi
 	setup_regex exuberant asm c
 	all_target_sources | xargs $1 -a                        \
 	-I __initdata,__exitdata,__initconst,__ro_after_init	\
@@ -261,7 +265,7 @@ exuberant()
 	-I EXPORT_SYMBOL,EXPORT_SYMBOL_GPL,ACPI_EXPORT_SYMBOL   \
 	-I DEFINE_TRACE,EXPORT_TRACEPOINT_SYMBOL,EXPORT_TRACEPOINT_SYMBOL_GPL \
 	-I static,const						\
-	--extra=+fq --c-kinds=+px --fields=+iaS --langmap=c:+.h \
+	--$CTAGS_EXTRA=+fq --c-kinds=+px --fields=+iaS --langmap=c:+.h \
 	"${regex[@]}"
 
 	setup_regex exuberant kconfig
-- 
2.33.0

