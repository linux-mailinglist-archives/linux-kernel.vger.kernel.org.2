Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC551348853
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 06:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhCYFYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 01:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhCYFYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 01:24:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0029AC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 22:24:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y200so850937pfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 22:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tq8vn+5f9oX33yzgFPXAiKFwU/LaZuKd2l3zSLx5y3c=;
        b=KIXjvxFjejK8sYeWMw06166y0X5QSw7lKzwFeMn67YY612EN4MVLr6Z6+gXxj8OKGA
         7IAxeKRlpZmkqMbo6e35xdDp9woZyJF6E5diMjN93BhHODYupdnCGwu8Itg1zP8Nus6E
         mBW5UhbZ9CfLflLiEGeaz3Q73IdQnu7aeniPBVK3nPot3WguCz34ja4ISy/WKq8z0OGF
         jf/116O2xDIFIXavSf1cprE170+LZ+PmP+GBM6bilpc22zfje/Nh6THub5OZgguIlTt5
         HjlccTLisf804bvbQ1xKVdj5ZLO/JkXJWAY7hhynwEGyChlZUrIKUU0lsyQcRL8ONUHK
         DYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tq8vn+5f9oX33yzgFPXAiKFwU/LaZuKd2l3zSLx5y3c=;
        b=dHMS/4QVNbzHwjsyck4/nY3bMVSkSPkVz1wp+IOfzzyrBSsjV9SKJlzR5PBqPBLvBr
         rY1nKHkkUJq+99dSjKh1Izvy2D0+r4JJDsMf8JMtSm3aT5hODQykVU3rSm5fGeT1DTNT
         LTGfaPTvQiIBZ6u+aSAnFeshytpRMTzAZv4ZB7ZJyy+fRnN8ZBQEQkEZJHOSOsa+8hbl
         hRixWYxq7yH4OZjJL2EijOncIKtX9NSetHbnNehBY60iVhumJ1U8cJnPmfsCXi+PM18y
         5T8VNDIXVvZDDE7Ms0kAkt5Jnzndx+BwN+k+y2oLymrksB6uwpEJyfu0+brfPzfyIYfZ
         Gk2w==
X-Gm-Message-State: AOAM531EOGfbCosViWu3R2cZlgNDoDCGMJaCKLVFRsBpGup2JnynkevH
        yPdTC5ODJrhylx6y6KMlOvyimw==
X-Google-Smtp-Source: ABdhPJzI+Y+hT9bsUv3c2JMbUKfGShAxXBkf1LSnqINorsqbTtO07Io65JzIFFNseJUXtFdC6mkaoA==
X-Received: by 2002:a17:902:6b44:b029:e6:931c:2a4d with SMTP id g4-20020a1709026b44b02900e6931c2a4dmr7561351plt.77.1616649859538;
        Wed, 24 Mar 2021 22:24:19 -0700 (PDT)
Received: from localhost ([122.172.6.13])
        by smtp.gmail.com with ESMTPSA id z11sm4127836pgj.22.2021.03.24.22.24.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 22:24:19 -0700 (PDT)
Date:   Thu, 25 Mar 2021 10:54:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "quanyang.wang" <quanyang.wang@windriver.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: dt: check the error returned by
 dev_pm_opp_of_cpumask_add_table
Message-ID: <20210325052417.xyctxztqbozut3ck@vireshk-i7>
References: <20210325043129.2255918-1-quanyang.wang@windriver.com>
 <20210325044541.rsncitrmkpaes4dm@vireshk-i7>
 <2da8eb92-6082-35f3-b190-c7218edb35a3@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2da8eb92-6082-35f3-b190-c7218edb35a3@windriver.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-03-21, 13:15, quanyang.wang wrote:
> Thank you for pointing it out.  Do you mean that even if
> dev_pm_opp_of_cpumask_add_table returns
> 
> an error, dev_pm_opp_get_opp_count may still return count > 0 because
> someone may call dev_pm_opp_add
> 
> to add OPP to cpu succcessfully at somewhere else?

Yes.

There are two ways we can add OPPs today:

- Statically via device tree. This is what
  dev_pm_opp_of_cpumask_add_table() tries to do.

- Dynamically via call to dev_pm_opp_add(), which I described earlier.

What failed here is the static way of adding OPPs, we still need to
check if OPPs were added dynamically.

-- 
viresh
