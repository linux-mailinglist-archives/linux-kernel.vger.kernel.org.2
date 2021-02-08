Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105A93129E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 06:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBHFBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 00:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhBHFBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 00:01:33 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0160C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 21:00:49 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b8so7150148plh.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 21:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mUDL/WmqX24EkRBa4QdzQZhiI7NIshJxn07vKLtmMHA=;
        b=LY7eqM4IuHwdFmMXZ763TcqaFYvBAm6w0IHOO0MK3mvSezjQNiiaPTaTB/HL2etgsH
         6Y/9ksY3KNcfPLbicJAd3/+r72BDtw6RfeHpVOFD0nOcdgyds/KMYXdGn5KTgYeowS7T
         y7pE2Qy+5SHxDMneBNeo5WEO3OB+K6YjzG4gpf4sYPRFLc37poMVBm9Aa2bBJrqGegEJ
         spwyKgKNFre74yHLXI/oKS4daPzowp4LaNKyEG3MtgNOO+YwFh9uJbTGwXpz/H+xjK6x
         e+GjcB1qZLCznqbiEDxtDm3Sv2DTw2Cywj/atDxVolAFO4H22WGe8jU6sT21M+7goBI6
         loGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mUDL/WmqX24EkRBa4QdzQZhiI7NIshJxn07vKLtmMHA=;
        b=JnU6bo10mMQjaCOL9IamuhsTvC2al7D55std6Mvur3ZO40F2XHD9KfDt61q+jnbiuG
         CdPkH9r9o0Dy9TGksy9MpCGGt+E+QLwqI50Z+p381+MTEZKQNUUHMmRnTN0QiWCuxsr2
         ut5kbhcMYkEWIX/fVv+feqk8BpWxhALgpI2I+R0eb82F9TDtqayOXTu+tfMAdcQN4ckJ
         d+JDHu51LN5zUhUey+uShtFy+tmLadyDCb0j1f9of0B0Tmtvt8xJx+JMnAwBZPqxsDOT
         OM8m7ZYAKtyNjhFTlvvomeQbQPvBbW6w+Dsanjqlqi8G/RYEDOBV6hXmfMKW0S1s87x3
         k4lQ==
X-Gm-Message-State: AOAM533LHCApk9qd8aXFHx161tYZ9B1YTUmJ7gKGQyXVR6E0oBzFEiLm
        9dej6M7aUGHkwOgEtc50vRiFI0y6iHmGLA==
X-Google-Smtp-Source: ABdhPJx4Fm6fIohHWzPXLTP+l6SZlpIrrIBikCvHEmSsZQlj6zYg7esZg5fpe6urlJuDZUHS1PjIPg==
X-Received: by 2002:a17:902:a5c9:b029:e0:8ef:1633 with SMTP id t9-20020a170902a5c9b02900e008ef1633mr14728621plq.13.1612760449162;
        Sun, 07 Feb 2021 21:00:49 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 123sm17795177pge.88.2021.02.07.21.00.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Feb 2021 21:00:47 -0800 (PST)
Date:   Mon, 8 Feb 2021 10:30:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/opp/of.c:842:12: warning: stack frame size of 2064 bytes
 in function '_of_add_opp_table_v2'
Message-ID: <20210208050045.zjm2s27ye7cxgfxq@vireshk-i7>
References: <202102070420.E5H63fqj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202102070420.E5H63fqj-lkp@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-02-21, 04:09, kernel test robot wrote:
> f47b72a15a9679 drivers/base/power/opp/of.c Viresh Kumar  2016-05-05  841  /* Initializes OPP tables based on new bindings */
> 5ed4cecd75e902 drivers/opp/of.c            Viresh Kumar  2018-09-12 @842  static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
> f47b72a15a9679 drivers/base/power/opp/of.c Viresh Kumar  2016-05-05  843  {
> f47b72a15a9679 drivers/base/power/opp/of.c Viresh Kumar  2016-05-05  844  	struct device_node *np;
> 283d55e68d8a0f drivers/opp/of.c            Viresh Kumar  2018-09-07  845  	int ret, count = 0, pstate_count = 0;
> 3ba98324e81add drivers/opp/of.c            Viresh Kumar  2016-11-18  846  	struct dev_pm_opp *opp;

I am not able to figure out why the stack frame warning will shoot off
for this routine, using just pointers, no big allocations on stack..

False positive ?

-- 
viresh
