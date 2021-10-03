Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB202420365
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 20:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhJCSSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 14:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhJCSSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 14:18:44 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D836C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 11:16:57 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r201so8524947pgr.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GQhMyogHN7y8nehFLIZCJ9ROYU/DzWV4+WI3lnHC9VE=;
        b=HJXXYtLIklgXaY1BKE1WVSZvqJvgRFJ2bq1B/kZyIKmuyJio1QqAerURv3BoGAPnBP
         iFO1Q69rFetDZXN0JzSr5DJVZ7BI8+AlXG1hz+3f9vlBS48Tjk45M0iLdVaYND48Ctnk
         RugsYl8YFR9fUC6fv9pL/2LGvUNSedKbeNlZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GQhMyogHN7y8nehFLIZCJ9ROYU/DzWV4+WI3lnHC9VE=;
        b=fh3a1tGPWIU6d6/RxdZ04+Zaca8rU0Tl6VN+iD2mV5IhwPYk3YH+HYhqG8ctngdT7V
         Bmb8TbkOP4jxgUp5FRsCAeoBGDRLftV+O4+/CMAAkangYRNO7vq9sXP9n60LXAIE9Zl1
         RB07pAU7Nu4quQZ2/EGlwWZxiDRhUHRsZbpBzjKfmmB83Ed3So9YWOpT22/mzzYWDT+7
         IQamPmqlVma9Zxx+FXIiME6QoxkM0FaT4IDI3HNQ2tbSF85xTzMoWI3Z28hEPoLmNg4o
         PxYQNOMIdxUilx3zqGRqeFVkKr5nXn7fJhsnvZi+frHKNA+pDEcBmFDENTXXUdoKo3LR
         6ezQ==
X-Gm-Message-State: AOAM533o0DbCzwLC7IiXTd7ISgMuetWiGlfWbKXdcoQYml7raDiNuEoY
        0o/DG1aMRL9w8h+84aCjrOqYjaTW0vIcihLX
X-Google-Smtp-Source: ABdhPJyr4km4MCiJoBD0XdidzykZY8m5fGbJA0/LZPs13VQG6nURhAMkwoirnnMoaWuzJeCGvoRjIw==
X-Received: by 2002:a63:e516:: with SMTP id r22mr7622020pgh.197.1633285016627;
        Sun, 03 Oct 2021 11:16:56 -0700 (PDT)
Received: from ebadger-ThinkPad-T590 (cpe-75-80-179-40.san.res.rr.com. [75.80.179.40])
        by smtp.gmail.com with ESMTPSA id j7sm11028777pjf.18.2021.10.03.11.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 11:16:56 -0700 (PDT)
Date:   Sun, 3 Oct 2021 11:16:53 -0700
From:   Eric Badger <ebadger@purestorage.com>
To:     ebadger@purestorage.com
Cc:     Eric Badger <ebadger@purestorage.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC/mc_sysfs: Print MC-scope sysfs counters unsigned
Message-ID: <20211003181653.GA685515@ebadger-ThinkPad-T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is cosmetically nicer for counts > INT32_MAX, and aligns the
MC-scope format with that of the lower layer sysfs counter files.

Signed-off-by: Eric Badger <ebadger@purestorage.com>
---
 drivers/edac/edac_mc_sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 2f9f1e7..0a638c9 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -744,7 +744,7 @@ static ssize_t mci_ue_count_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
-	return sprintf(data, "%d\n", mci->ue_mc);
+	return sprintf(data, "%u\n", mci->ue_mc);
 }
 
 static ssize_t mci_ce_count_show(struct device *dev,
@@ -753,7 +753,7 @@ static ssize_t mci_ce_count_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
-	return sprintf(data, "%d\n", mci->ce_mc);
+	return sprintf(data, "%u\n", mci->ce_mc);
 }
 
 static ssize_t mci_ce_noinfo_show(struct device *dev,
@@ -762,7 +762,7 @@ static ssize_t mci_ce_noinfo_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
-	return sprintf(data, "%d\n", mci->ce_noinfo_count);
+	return sprintf(data, "%u\n", mci->ce_noinfo_count);
 }
 
 static ssize_t mci_ue_noinfo_show(struct device *dev,
@@ -771,7 +771,7 @@ static ssize_t mci_ue_noinfo_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
-	return sprintf(data, "%d\n", mci->ue_noinfo_count);
+	return sprintf(data, "%u\n", mci->ue_noinfo_count);
 }
 
 static ssize_t mci_seconds_show(struct device *dev,
-- 
1.9.1

