Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B853053D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhA0HAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhA0G7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 01:59:41 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935BDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 22:58:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id u4so749094pjn.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 22:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hdH070fYQGRrVFXSs6VUzPA20L1MAMda+ejAucezRlo=;
        b=bcxwQY9v7gG8/ZLRsynArRtdDbnVjaCQYtuVwVy4gAD09HJ0afvA9irJzEB9sle0aI
         rOJweiDeWGPx5J1nbkpKcf22eLrwJ2GJu8oNzqJ8NFQdlrkcsFG9hMMaPgx7ZnNralqJ
         bXiqaEZyrKKD9h9vOUiGT0e9cY0riXPAjo3ar9rJXXTr6rWQQGUnG+he/PyqPS0y9Mfd
         Yvg4RvXCCeorEy3smliUnT/OrysHSP6tcCR6b+dRweRZFZMMEaSNJbNh+CgICb4xryRf
         5PsnDzVJUqLlOHOjfIicTMFhn7pSqTUkxbScpKohKp3OB2avLlmBf0UsKnsITVnppNIw
         4Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hdH070fYQGRrVFXSs6VUzPA20L1MAMda+ejAucezRlo=;
        b=e7OVivGHmNg8sJ93a3tA8NUP2mk5G6MUxNIPy3vGD9IX++4bd9IJ1JXtdm0EopAUU2
         mlHT9XAaCbVJ86jdLtfQ0KCYWDvn9oyq7BHd26R12P7JrCxw2xzVs4onFX1PqwBxaD7d
         tO3DY3wmzobyeX1FI4f5hm92qxUa1vjR/l17nUZDirNKj2Qy3YRAMwmE7T0gRI0JuEAG
         pP/Bt3QEOYj2Hd9NPV4t0z6CObZAsJkkmRTPERe+D5vDlO0fMWFCnG42aBlSd+KniucL
         QviMJg3R5lmI9rvDzKyhSP+7DhkKOo4+OTeeLzvc5zLDGtfHYzuNwj1auWlXyCZZ6Fjk
         K+gA==
X-Gm-Message-State: AOAM531axSfShrOdm7mZ//uNL5uJ07sT0VHXh8kBXmTAWQFu/j5O4hBn
        rKbW8dE5xKpvhR7gc8J68ONrbw==
X-Google-Smtp-Source: ABdhPJyaTToGexohyPD3a1AnlyINM47VgWjzZWARW91p7Tk9RAH8ZSmplUpcdPIxJZ4yB7OyWIpFyA==
X-Received: by 2002:a17:90a:de2:: with SMTP id 89mr4105815pjv.26.1611730729086;
        Tue, 26 Jan 2021 22:58:49 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id j16sm947790pjj.18.2021.01.26.22.58.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 22:58:48 -0800 (PST)
Date:   Wed, 27 Jan 2021 12:28:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 07/13] opp: Allow _generic_set_opp_clk_only() to work for
 non-freq devices
Message-ID: <20210127065846.c2usquegqrqib45r@vireshk-i7>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <1585f6c21ea8aee64fe4da0bf72b36ea4d74a779.1611227342.git.viresh.kumar@linaro.org>
 <9b2638e6-b842-8737-e5a0-aeeb84927fce@gmail.com>
 <20210122043506.lm6yiefzlyubq5my@vireshk-i7>
 <7d6573e3-7885-fb0b-2290-c181e2c557f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d6573e3-7885-fb0b-2290-c181e2c557f9@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-01-21, 00:09, Dmitry Osipenko wrote:
> Please remove unlikely() around IS_ERR(), it already has the unlikely().

Right.

> https://elixir.bootlin.com/linux/v5.11-rc4/source/include/linux/err.h#L22
> 
> I'd also recommend to remove all the unlikely() from OPP code since it
> doesn't bring any value if not used in a very performance-critical code
> path. OPP core doesn't have such code paths. The [un]likely() only make
> code less readable and may result in a worse assembly.

The likely/unlikely() stuff is to optimize code, not necessarily the stuff in
the hot path alone, therwise stuff like IS_ERR() would never have it. It surely
does bring value by optimizing the code, surely the result isn't significant
enough but that is fine, every effort counts.

AFAIK, if we are sure of path the code will almost always take, then we should
rather use these and so I am inclined towards keeping them. Though I understand
that using them may result in bad behavior (performance) if they fail.

-- 
viresh
