Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FF044B458
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 21:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244754AbhKIU6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 15:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241667AbhKIU6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:58:02 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDDFC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 12:55:15 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c4so154109wrd.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 12:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=fqJ/uUSQOOJeQ/NToZmRTiysQAgxW5D2ydD9TI56BRA=;
        b=KUoefx1FVjs4aHS8ZUnzbpbDF8ZAOtb7cf08WQz3J8WBn4EG8gB9tHIwL4VM5a6MfC
         dFmesGlTiXDYvaRYl1unthUC6rj/heX5ly6ZmBZ4R5ajynozK9w0z8xbvdBt26kZSBDl
         OuRL2c982hGDBoUl84PCOsQs5pfnUger0YVhWZgbLWFIIJbnkbZsWnuqxpV5DRHsXbkJ
         /fpq6p7ygqbliXG4B8HnqMcI6ouoPixFgFKEJTCOuArWCeHWB2tjO/8u7BMuo5NibAfu
         ClZIWja+475vuvDXPkz4fjBR1wByiBaY9pEkDVGX+jKOhvy7jeFaFXMoNYXc0WpUp2kj
         lERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=fqJ/uUSQOOJeQ/NToZmRTiysQAgxW5D2ydD9TI56BRA=;
        b=B1VIy7e50gvkz1xQD7A0pzgzQrNn2z+l9RzcWbwv4zaLPeBvTmeQvls3ERQ0POtRiA
         X/BtqJGKUf40pOLoWh/7KYzIqH6TwIQYK9W9Ap235iyvBAa+nZKE68KNS8j4dtN1Msep
         CznPntnnLGyAFoqIBD6iUEk+3r4ojQQiyWmsx2oiqzrbqSx945aCcYzoiaif9ZvxE4gy
         fLcwpdh+bB0RhlXmPJ+wzi+oL4QO/icApF6Z0ZEUVWzxX+Mqt7Jeb9OJNYBdJq9wf9Ut
         2tIJlHV9Cnn6cKl3kvH8kOnUIeieEkMeBY1N3X9kze6DzboIbna5z+M0YR/Q1uSoOgkj
         ckEw==
X-Gm-Message-State: AOAM533Cpt+GOMN3oXd11d0VhMR5RT/TqxwMwK3/nhDYwFkvY+pxp3em
        gqmfArzgY6WXGGkBZbals/Y=
X-Google-Smtp-Source: ABdhPJwg2E0jpLEN9qnTTnDXyz5jxaCHJKNQjaRRZZjEc4raKBoRVbdEfvwvauzZb/Aaba7koe1dEw==
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr13175426wrn.287.1636491314082;
        Tue, 09 Nov 2021 12:55:14 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:381e:82e6:1dfe:78ca? (p200300ea8f1a0f00381e82e61dfe78ca.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:381e:82e6:1dfe:78ca])
        by smtp.googlemail.com with ESMTPSA id g18sm20803792wrv.42.2021.11.09.12.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 12:55:13 -0800 (PST)
Message-ID: <8f13ba8d-03b5-76de-4d59-4ca8786afb83@gmail.com>
Date:   Tue, 9 Nov 2021 21:55:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] clocksource: Improve cs_watchdog_read()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If max_cswd_read_retries is set to 0 or 1 then the current warning
behavior doesn't seem to make too much sense to me.
If set to 0, then we'd warn with each watchdog run.
If set to 1, then we'd warn at the first retry, even though the commit
description of db3a34e17433 states that one retry is expected behavior.
If printing a message at all in this case, then it should be debug
level.

Whilst being at it, move declaration of wd_end and wd_delta into the
loop and remove not needed braces.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 kernel/time/clocksource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index f29d1a524..8c0be9c02 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -208,10 +208,11 @@ module_param(verify_n_cpus, int, 0644);
 static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 {
 	unsigned int nretries;
-	u64 wd_end, wd_delta;
 	int64_t wd_delay;
 
 	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
+		u64 wd_end, wd_delta;
+
 		local_irq_disable();
 		*wdnow = watchdog->read(watchdog);
 		*csnow = cs->read(cs);
@@ -222,10 +223,9 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
 					      watchdog->shift);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
-			if (nretries > 1 || nretries >= max_cswd_read_retries) {
+			if (nretries > 1)
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
-			}
 			return true;
 		}
 	}
-- 
2.33.1

