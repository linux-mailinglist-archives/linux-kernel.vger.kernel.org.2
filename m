Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A153D525E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 06:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhGZDn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 23:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhGZDn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 23:43:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B35FC061760
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:24:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d1so2821009pll.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=78PJxn/L/No3mfXtKzF9xhDAGmfzmXdV4fCFIzVMd9s=;
        b=tqsyhbkrTWMeQGkonawVFcZt6NSFfrnDG6N5Tf++zKo3L9t0EeN8mo6y4vHgxqOXQT
         95JvJZ8vVgEehltZmXqq0VslqAZcAdh66WmmY4jw/DtjkwcCFGvqXa/soPaSbGzB2w/J
         /SkMzFSgG4jnw67x2mXjIcWIwuJAwDdj0mKqchVFVLl6bYeavQtFn6jrogGVm4cVc8RB
         lwUnjTenjaFfqJRM8S7gshbiXa+WeGMSUnC6EpkY3FH+vdqdmqAqNoweDcBq+U0wospm
         ld43Ftm4zAOIzsAfOQRdtE9eq+69il6xIkX34AYphY6kzlQn/sDXYjoTpU8e36FXHg8e
         KBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=78PJxn/L/No3mfXtKzF9xhDAGmfzmXdV4fCFIzVMd9s=;
        b=fZtmx4OTLwIt1Slk2FVePyBnDpl4N7XLjtRHZEG7lPDDcYBSdZfjXY3OXCtwvmX/e5
         CqBz7Q7g5NYQaLaJ7mRkV7feKPlvAJmHQWuh0wm4x4wfpQU5gnj8tyI9xx7sbEkTF1WI
         dgp3gCJpmujB7CNx+RU/axgkBYhqP9yoGShJFJnNGYwZxGLLxtQySS5ZG7RN1FCmYGsq
         afBXr2WuPTA+aKQr7MRY8V+oCgr5ORctwIpQyEx2Ml3Bs5YkLFHidp5Ts2uhawABM30z
         P7N533kWiQYCtSSo9AXwXYRppdjAQQmiI/tej7fLR9g/YsviIyPKdR9tO5x44V67xWEz
         /pCA==
X-Gm-Message-State: AOAM533wbZnGSIQJxXjcpGms3UhdYYdrlt8Fzy4h6t+1Ps8UNKiuIhtG
        KXtUguJw4fpTsHx9RP4OzWAWcg==
X-Google-Smtp-Source: ABdhPJyG6IGj4mrsCVLKPobTp1wpDXQChxmvXE++0EtMdAbNN9tYtV933i2cNjnOqhkGLd1zLcjGdw==
X-Received: by 2002:a05:6a00:cc1:b029:32b:8465:9b59 with SMTP id b1-20020a056a000cc1b029032b84659b59mr16076877pfv.66.1627273465000;
        Sun, 25 Jul 2021 21:24:25 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id s5sm11668787pfk.114.2021.07.25.21.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 21:24:23 -0700 (PDT)
Date:   Mon, 26 Jul 2021 09:54:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: blacklist Qualcomm sc8180x in cpufreq-dt-platdev
Message-ID: <20210726042421.ak3eau7lhx6pfeg4@vireshk-i7>
References: <20210725030214.3942250-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725030214.3942250-1-bjorn.andersson@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-07-21, 20:02, Bjorn Andersson wrote:
> The Qualcomm SC8180x platform uses the qcom-cpufreq-hw driver, so
> it in the cpufreq-dt-platdev driver's blocklist.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

-- 
viresh
