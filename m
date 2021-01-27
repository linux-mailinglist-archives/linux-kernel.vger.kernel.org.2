Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054E13057CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbhA0KFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbhA0KDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:03:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D109C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:02:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cq1so947814pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=il+kK31I8ias7ly7K5qOOufoBmh6u4lYQGwfOmvXgok=;
        b=umpaeJivTUc70rUr7oissDRdrd/NSPpIhzh+PzHhKbS1foIrTSpKsod+T8fwLF76Iz
         f69EfcMpINZhd3O81tqlo4Tpn+b5chdPRtrh+GV+jK3Bebs3S4i/eyAPRMMAJUKuKRw3
         VrsXTwbgqyLBfsYqxiFhAtRGgzvh3QUcZaDvOg50gDtwXRrhUwU/VtCAiejnZqu4Z4nF
         NP/Huu7uiHrHdzYDfuPUxa4WxFD7HmfvqJfcAyb2/QU8IkqdahlYOGwj3NJHWgOiOT8e
         RBTQH2tuP7jrHIez+K0hIVCP+8ncMQSCWCae+LFn5DWNmTtz0aF9uhjzz90wJA/sOTCH
         mbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=il+kK31I8ias7ly7K5qOOufoBmh6u4lYQGwfOmvXgok=;
        b=SQLUsbxTbytGanIXP/JZPDjucNAF2s6AXweE+F6aNdEUxt562+T56ZKgJscrxt80j6
         Nqw2sQGbUdPI10axb3AdVJs0L+5OzmzrFzDAAEihdh/N7ixttqGm6gmspgyNdGWmxttx
         4KwYVkk2dbvtazwsR9Oa3f5SO8eYhyHgZP5YRZCmghu6cJXW08UL3/S6/qgbJod3XUFd
         MA7/63olOtx3T5whPOvziohjfgpQafwEg6fpFxXn0wfIJKcywyzGYVR5sRrpa4ErPoc1
         nEugV0ZlLk5/X0Oxx4gCmxNPt6WrwN6mJZKO9AnAFQNx6f+F/ZQRlNR22JO7lRY6ZcJh
         stsA==
X-Gm-Message-State: AOAM532PGxTaM6LCKDDSpKwiEEmhdqxvNFbSsyXiFTdw1jVCe3rspX67
        YXTDP4A8V2ObOhCc2sHWxqC/SA==
X-Google-Smtp-Source: ABdhPJzkvUySvZLn2EAxK9+DgBWy4yFjNe77BjjPxrFYXjaE3UdsYOaIrfwTFZCpMvBSxOMLFsam5Q==
X-Received: by 2002:a17:902:bb8c:b029:dc:2e5e:2b2 with SMTP id m12-20020a170902bb8cb02900dc2e5e02b2mr10762965pls.10.1611741757318;
        Wed, 27 Jan 2021 02:02:37 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id gv22sm1601853pjb.56.2021.01.27.02.02.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 02:02:36 -0800 (PST)
Date:   Wed, 27 Jan 2021 15:32:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 11/13] devfreq: tegra30: Migrate to
 dev_pm_opp_set_opp()
Message-ID: <20210127100234.vl2wwe7rjrrz4btz@vireshk-i7>
References: <3345fd49f7987d022f4f61edb6c44f230f7354c4.1611227342.git.viresh.kumar@linaro.org>
 <f0341655361aa0107266ed9c838aa8bcfe50a3ed.1611738418.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0341655361aa0107266ed9c838aa8bcfe50a3ed.1611738418.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-01-21, 14:40, Viresh Kumar wrote:
> dev_pm_opp_set_bw() is getting removed and dev_pm_opp_set_opp() should
> be used instead. Migrate to the new API.
> 
> We don't want the OPP core to manage the clk for this driver, migrate to
> dev_pm_opp_of_add_table_noclk() to make sure dev_pm_opp_set_opp()
> doesn't have any side effects.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Dmitry,
> 
> This is based over the patches sent here:
> 
> https://lore.kernel.org/lkml/6c2160ff30a8f421563793020264cf9f533f293c.1611738228.git.viresh.kumar@linaro.org/
> 
> This should fix the problem you mentioned earlier. Will push this for
> linux-next unless you have any issues with it.
> 
>  drivers/devfreq/tegra30-devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 117cad7968ab..31f7dec5990b 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -647,7 +647,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  		return PTR_ERR(opp);
>  	}
>  
> -	ret = dev_pm_opp_set_bw(dev, opp);
> +	ret = dev_pm_opp_set_opp(dev, opp);
>  	dev_pm_opp_put(opp);
>  
>  	return ret;
> @@ -849,7 +849,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	err = dev_pm_opp_of_add_table(&pdev->dev);
> +	err = dev_pm_opp_of_add_table_noclk(&pdev->dev);

Plus this, somehow was left uncommited in my tree :(

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 31f7dec5990b..ce83f883ca65 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -849,7 +849,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
                return err;
        }
 
-       err = dev_pm_opp_of_add_table_noclk(&pdev->dev);
+       err = dev_pm_opp_of_add_table_noclk(&pdev->dev, 0);
        if (err) {
                dev_err(&pdev->dev, "Failed to add OPP table: %d\n", err);
                goto put_hw;

-- 
viresh
