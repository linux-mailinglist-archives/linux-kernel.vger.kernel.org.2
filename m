Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A55B40C7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhIOPG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbhIOPGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:06:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07115C061764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 08:05:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d17so1779612plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 08:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tuZ5AJo9HYV72r//BB/nhJCCtA8J0cLgDUQf1Wa73oU=;
        b=AqTzpIsgPDCO3HJy4ctU22tG7V35oU3V+ofAVG3HhLBvwkxZqzp3LpsALS6nVYDedT
         eMz3lyh37h7vFtPORm/SZiEEuVt3GC7omw3sbfd0F5rlvBuKXiANq8qYQ8dklwizxk/t
         1ldrHdFd+PzmDFTI+BVF+yRpvzPnXS4k6ZKHAjcT9gHOcxopn7G/pEvYWyUo6jwOuwK7
         EwVXYQKijQjvGtkBRVX2IyhopAvmMkmkHPz42x3ePAD+N6120sVpz9s1acBQ7fJcmYuU
         WDVHoXJdQsCi4AQBpOzErgvdsLdvTeTzZ71N9gyWUPvp3au/xYfiJpx0b9jaczHLFDWG
         4Xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tuZ5AJo9HYV72r//BB/nhJCCtA8J0cLgDUQf1Wa73oU=;
        b=KX06xMfeuaMIBD1VBLWTYm6GCfJJiQ2kvSezqQVSptPCGZ+3Xch7deDX8qgYgNTzcu
         6NE3aJTQuajJ/3IUkG61uKJEzl9RpSTv5OehXiO5OeUUFJkavkt7dG+NWB/rdSp0YGDX
         pQL7rzQIhNHJ9AtSjlPzPiW5pLU2L9OAMwAVTuyxuy73xxHxxXqMZChGB0TWU2eokFm4
         rBLDUCQxtsiv7ZNaDJzCEPL4TrvYj2aN2BcyrsLqP6pJs1dEtSwkscdqhysvvPZlJH4M
         etGnla1U3ua1W31UoCmwlzHXnrQo2xxlsgbRX4TnVCefMBOMzTM1mznWBmIK6seKlKB/
         kCCg==
X-Gm-Message-State: AOAM530C8j26OA6CFdlh1BLmV2XnnFCM1kKFDd5+LJfSjWKtHQFDpFqg
        PCztyb0cQ89svQB8M8oReIKFgQ==
X-Google-Smtp-Source: ABdhPJy0Tg9oNP4ZFHBxknMHxgqD9Dk0JxCQuX5C2E5V0NQzkRuEYxefKNUn+Phg3g7CrFCnyeEKfw==
X-Received: by 2002:a17:90b:957:: with SMTP id dw23mr253699pjb.125.1631718336048;
        Wed, 15 Sep 2021 08:05:36 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id s10sm3795857pjn.38.2021.09.15.08.05.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Sep 2021 08:05:35 -0700 (PDT)
Date:   Wed, 15 Sep 2021 23:05:27 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] clk: qcom: smd-rpm: Add rate hooks for
 clk_smd_rpm_branch_ops
Message-ID: <20210915150526.GE25255@dragon>
References: <20210914025554.5686-1-shawn.guo@linaro.org>
 <20210914025554.5686-2-shawn.guo@linaro.org>
 <163165658855.763609.14080313241484048687@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163165658855.763609.14080313241484048687@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 02:56:28PM -0700, Stephen Boyd wrote:
> Quoting Shawn Guo (2021-09-13 19:55:52)
> > On QCM2290 platform, the clock xo_board runs at 38400000, while the
> > child clock bi_tcxo needs to run at 19200000.  That said,
> > clk_smd_rpm_branch_ops needs the capability of setting rate. Add rate
> > hooks into clk_smd_rpm_branch_ops to make it possible.
> 
> This doesn't sound right. The branch is a simple on/off. If xo_board is
> 38.4MHz, then there is an internal divider in the SoC that makes bi_tcxo
> (i.e. the root of the entire clk tree) be 19.2MHz. We don't model the
> divider, I guess because it isn't very important to. Instead, we tack on
> a divider field and implement recalc_rate op. See clk-rpmh.c in the qcom
> directory for this.

Thanks for the comment, Stephen!  To be honest, I copied the
implementation from vendor kernel, and wasn't really sure if it's
correct or the best.

So here is what I get based on your suggestion.  Let's me know if
it's how you wanted it to be.  Thanks!

Shawn

----8<---------

From 23dda79fee412738f046b89bdd20ef95a24c35cc Mon Sep 17 00:00:00 2001
From: Shawn Guo <shawn.guo@linaro.org>
Date: Wed, 15 Sep 2021 22:00:32 +0800
Subject: [PATCH] clk: qcom: smd-rpm: Add a divider field for branch clock

Similar to clk-rpmh, clk-smd-rpm has the same need to handle the case
where an internal divider is there between xo_board and bi_tcxo.  The
change is made in the a back compatible way below.

 - Add div field to struct clk_smd_rpm, and have
   __DEFINE_CLK_SMD_RPM_BRANCH() assign it.

 - Update all existing __DEFINE_CLK_SMD_RPM_BRANCH() wrappers to pass a
   zero div.

 - Add DEFINE_CLK_SMD_RPM_BRANCH_DIV() which doesn't take rate argument
   but div.

 - Update clk_smd_rpm_recalc_rate() to handle div and add it as
   .recalc_rate of clk_smd_rpm_branch_ops.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 66d7807ee38e..66ef0d3795fd 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -66,13 +66,14 @@
 	}
 
 #define __DEFINE_CLK_SMD_RPM_BRANCH(_platform, _name, _active, type, r_id,    \
-				    stat_id, r, key)			      \
+				    stat_id, r, key, _div)		      \
 	static struct clk_smd_rpm _platform##_##_active;		      \
 	static struct clk_smd_rpm _platform##_##_name = {		      \
 		.rpm_res_type = (type),					      \
 		.rpm_clk_id = (r_id),					      \
 		.rpm_status_id = (stat_id),				      \
 		.rpm_key = (key),					      \
+		.div = (_div),						      \
 		.branch = true,						      \
 		.peer = &_platform##_##_active,				      \
 		.rate = (r),						      \
@@ -92,6 +93,7 @@
 		.rpm_status_id = (stat_id),				      \
 		.active_only = true,					      \
 		.rpm_key = (key),					      \
+		.div = (_div),						      \
 		.branch = true,						      \
 		.peer = &_platform##_##_name,				      \
 		.rate = (r),						      \
@@ -112,7 +114,12 @@
 
 #define DEFINE_CLK_SMD_RPM_BRANCH(_platform, _name, _active, type, r_id, r)   \
 		__DEFINE_CLK_SMD_RPM_BRANCH(_platform, _name, _active, type,  \
-		r_id, 0, r, QCOM_RPM_SMD_KEY_ENABLE)
+		r_id, 0, r, QCOM_RPM_SMD_KEY_ENABLE, 0)
+
+#define DEFINE_CLK_SMD_RPM_BRANCH_DIV(_platform, _name, _active, type, r_id,  \
+				      _div)				      \
+		__DEFINE_CLK_SMD_RPM_BRANCH(_platform, _name, _active, type,  \
+		r_id, 0, 0, QCOM_RPM_SMD_KEY_ENABLE, _div)
 
 #define DEFINE_CLK_SMD_RPM_QDSS(_platform, _name, _active, type, r_id)	      \
 		__DEFINE_CLK_SMD_RPM(_platform, _name, _active, type, r_id,   \
@@ -121,12 +128,12 @@
 #define DEFINE_CLK_SMD_RPM_XO_BUFFER(_platform, _name, _active, r_id)	      \
 		__DEFINE_CLK_SMD_RPM_BRANCH(_platform, _name, _active,	      \
 		QCOM_SMD_RPM_CLK_BUF_A, r_id, 0, 1000,			      \
-		QCOM_RPM_KEY_SOFTWARE_ENABLE)
+		QCOM_RPM_KEY_SOFTWARE_ENABLE, 0)
 
 #define DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(_platform, _name, _active, r_id) \
 		__DEFINE_CLK_SMD_RPM_BRANCH(_platform, _name, _active,	      \
 		QCOM_SMD_RPM_CLK_BUF_A, r_id, 0, 1000,			      \
-		QCOM_RPM_KEY_PIN_CTRL_CLK_BUFFER_ENABLE_KEY)
+		QCOM_RPM_KEY_PIN_CTRL_CLK_BUFFER_ENABLE_KEY, 0)
 
 #define to_clk_smd_rpm(_hw) container_of(_hw, struct clk_smd_rpm, hw)
 
@@ -140,6 +147,7 @@ struct clk_smd_rpm {
 	bool branch;
 	struct clk_smd_rpm *peer;
 	struct clk_hw hw;
+	u8 div;
 	unsigned long rate;
 	struct qcom_smd_rpm *rpm;
 };
@@ -370,10 +378,10 @@ static unsigned long clk_smd_rpm_recalc_rate(struct clk_hw *hw,
 
 	/*
 	 * RPM handles rate rounding and we don't have a way to
-	 * know what the rate will be, so just return whatever
-	 * rate was set.
+	 * know what the rate will be, so just return divided parent
+	 * rate or whatever rate was set.
 	 */
-	return r->rate;
+	return r->div ? parent_rate / r->div : r->rate;
 }
 
 static int clk_smd_rpm_enable_scaling(struct qcom_smd_rpm *rpm)
@@ -416,6 +424,7 @@ static const struct clk_ops clk_smd_rpm_ops = {
 static const struct clk_ops clk_smd_rpm_branch_ops = {
 	.prepare	= clk_smd_rpm_prepare,
 	.unprepare	= clk_smd_rpm_unprepare,
+	.recalc_rate	= clk_smd_rpm_recalc_rate,
 };
 
 DEFINE_CLK_SMD_RPM(msm8916, pcnoc_clk, pcnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 0);
-- 
2.17.1

