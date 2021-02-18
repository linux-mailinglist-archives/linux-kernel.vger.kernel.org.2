Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C95231E74F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 09:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhBRIM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 03:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhBRHSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 02:18:42 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C00C061786
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 23:11:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id my11so2476773pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 23:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iytkFIO4hSXQIBWKY33k5dtDFRuVFbzG9ucqyGSbeCM=;
        b=O7YBggq+29bBa7kWdkXCRFHInLuywJb+OzXcrU2yGT22lP8MR3KzFLVpSWXBnzRDuW
         BZlZX8dlDADiraA/z2O18oCo3DaXFkOi4WqW0VT790TXVm5aYinhIKLH9yiJKh1Wsckk
         kiOKOGghLnZ0aUfWARRhO7N2gNIim03qJ2JgYkiv4Xe6gcW9L8DQ7FQkxi+5iO+OK2J9
         gEYJIPvcYQblY7IJY1AVbXcFRa0KwhGH6uD5gVQe9mzAEhNIN2DJZq/AEn1R49dcdOF9
         nP9D0/YAXSSMsD5QLvUBiADewDM2YvfKkYIz19QsVc5NjEgvXizn1/UzKFtS0A0KmxUI
         gG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iytkFIO4hSXQIBWKY33k5dtDFRuVFbzG9ucqyGSbeCM=;
        b=atm/oweKhpMHSO0/gp6UwV53VKrdeDl3C3NlM8dk+MrLZthI9ysvG7RoEF+ThkEqWL
         FJUvJe0gnxkMqs9HQtBwihaOX/DpKokDtAgYiR6GIS3q/S4bZ5zYJXmsJhvT2O8ByxR3
         hrPQ7IUIMfZz3Sv+SVZvbJzSXmriV7j6jYoBjVYdVBq5mzZOW6mnJcFgYhK9ECYaUE/J
         qxFzZ6VWCpl8UC2t4PgyaQAg9e5ALEk8JeREpaCx9E5j/G1zOH/hDJvxB7u8p2cB1VkY
         +G0769ZIhB6gfEalqFSHvOaYd3B9nDj39zzCBuD4+n2K0z1gE1uoSI6ytSx+iKRCHh/P
         XrpA==
X-Gm-Message-State: AOAM530uZFtrXneL6CpU18igXxkSYjg5bAz8T0UdhuhOhQYTjMzAdUCe
        DiSitqvVPi8U/NpGQ7pyDpGOtQ==
X-Google-Smtp-Source: ABdhPJwyY9fS2Jg6hyJv1RpisVeWu0tX+C73xXGJ+YhkEumeOgR+TNIbi6JGi/7jKWdaaPs3MkP5vg==
X-Received: by 2002:a17:90b:1bd2:: with SMTP id oa18mr2685662pjb.80.1613632272580;
        Wed, 17 Feb 2021 23:11:12 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id e21sm4487798pgv.74.2021.02.17.23.11.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2021 23:11:11 -0800 (PST)
Date:   Thu, 18 Feb 2021 12:41:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "open list:OPERATING PERFORMANCE POINTS (OPP)" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] opp: fix dev_pm_opp_set_rate for different frequency at
 the same opp level
Message-ID: <20210218071109.afxnlqkusl7b2xqp@vireshk-i7>
References: <20210216201030.19152-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216201030.19152-1-jonathan@marek.ca>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-02-21, 15:10, Jonathan Marek wrote:
> There is not "nothing to do" when the opp is the same. The frequency can
> be different from opp->rate.
> 
> Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/opp/core.c | 7 +++++--
>  drivers/opp/opp.h  | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)

Thanks, I have updated it a bit and applied, thanks.

-- 
viresh

-------------------------8<-------------------------

From: Jonathan Marek <jonathan@marek.ca>
Date: Tue, 16 Feb 2021 15:10:29 -0500
Subject: [PATCH] opp: Don't skip freq update for different frequency

We skip the OPP update if the current and target OPPs are same. This is
fine for the devices that don't support frequency but may cause issues
for the ones that need to program frequency.

An OPP entry doesn't really signify a single operating frequency but
rather the highest frequency at which the other properties of the OPP
entry apply. And we may reach here with different frequency values,
while all of them would point to the same OPP entry in the OPP table.

We just need to update the clock frequency in that case, though in order
to not add special exit points we reuse the code flow from a normal
path.

While at it, rearrange the conditionals in the 'if' statement to check
'enabled' flag at the end.

Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
[ Viresh: Improved commit log and subject, rename current_freq as
	  current_rate, document it, remove local variable and rearrange
	  code. ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 8 +++++---
 drivers/opp/opp.h  | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c3f3d9249cc5..c2689386a906 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -998,14 +998,15 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	old_opp = opp_table->current_opp;
 
 	/* Return early if nothing to do */
-	if (opp_table->enabled && old_opp == opp) {
+	if (old_opp == opp && opp_table->current_rate == freq &&
+	    opp_table->enabled) {
 		dev_dbg(dev, "%s: OPPs are same, nothing to do\n", __func__);
 		return 0;
 	}
 
 	dev_dbg(dev, "%s: switching OPP: Freq %lu -> %lu Hz, Level %u -> %u, Bw %u -> %u\n",
-		__func__, old_opp->rate, freq, old_opp->level, opp->level,
-		old_opp->bandwidth ? old_opp->bandwidth[0].peak : 0,
+		__func__, opp_table->current_rate, freq, old_opp->level,
+		opp->level, old_opp->bandwidth ? old_opp->bandwidth[0].peak : 0,
 		opp->bandwidth ? opp->bandwidth[0].peak : 0);
 
 	scaling_down = _opp_compare_key(old_opp, opp);
@@ -1061,6 +1062,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	/* Make sure current_opp doesn't get freed */
 	dev_pm_opp_get(opp);
 	opp_table->current_opp = opp;
+	opp_table->current_rate = freq;
 
 	return ret;
 }
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 9b9daf83b074..50fb9dced3c5 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -135,6 +135,7 @@ enum opp_table_access {
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @parsed_static_opps: Count of devices for which OPPs are initialized from DT.
  * @shared_opp: OPP is shared between multiple devices.
+ * @current_rate: Currently configured frequency.
  * @current_opp: Currently configured OPP for the table.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
  * @genpd_virt_dev_lock: Mutex protecting the genpd virtual device pointers.
@@ -184,6 +185,7 @@ struct opp_table {
 
 	unsigned int parsed_static_opps;
 	enum opp_table_access shared_opp;
+	unsigned long current_rate;
 	struct dev_pm_opp *current_opp;
 	struct dev_pm_opp *suspend_opp;
 
