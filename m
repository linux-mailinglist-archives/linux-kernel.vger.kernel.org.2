Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C0731EE10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhBRSNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhBRPqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:46:50 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306D2C061788
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 07:46:06 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id o7so1389898pgl.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 07:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cn9DcIA9AN/PH1bnsLrw3E0sYTBmikm1mlLSEa4gBbY=;
        b=w4jPWHfJ0axD3jdPfZ9w/vGksv0PG41cYknVMb5Jus1JbW12FWeQDJF2+pcApVebQj
         jyHew4Ef8fcUlkrdj3IVLE5kg6FpM46q/z9aWvU84UJ4Wx+2BBvc/QSpVUoN1iZCBpfm
         xzrQyRp4cJ0n6k1CeV47QfXgzbe4MefUQ+rmuCdVvndjKGlQ189yhZP7JLd22vxdVvn4
         aeue3o/8M9lnnPjCuhQ7EswLzE/ey/HI56ScZ1VKKmFMpt78hr8jWperxv/IH+iu2xNm
         r1sfE9+w5X7ZC8eJfEq40J6SMm+EAiUU5XnwHEtUCnCcyfpMgiXYZE65KDMheWZmcaJj
         ouxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cn9DcIA9AN/PH1bnsLrw3E0sYTBmikm1mlLSEa4gBbY=;
        b=fAQMPTskhvmK7U4oZj+BqJAWUMSyxzgR/hvW8rjP7YBUHGRd9gWSvT76fErN9y/zUX
         OKFfKj9Lj4n09xzYPdaT+VMh4kDyCF+1xuVQGjU2j9/MEi0XV4kp2qJ3wdvrS/GdniSj
         TtZsrZzPXTo/D0pITb7ZVdOyk2UN8k/6WtESm7CRMUXoL0Y53rabXwDYPedTsGFH7PXd
         6qXXAF4bpyiGgGv04ngJbtfkjtZ3AEbN0oO8eTSsN5jjgBLup525jwYgF0s93GtprPea
         AvT/nVNWPbu5czkdSwCOEWZEqMO3s9DR0doFvWOSEODe3w/RKE0koZLtj9i487UJNARe
         jyjg==
X-Gm-Message-State: AOAM530GerzP6aruNRA1gNEoyogzx37Mijlw65wdzDV1IwRPDa4pPjwo
        MSxCXceYOBDoMmdrG9ZdYCPHFQ==
X-Google-Smtp-Source: ABdhPJy/ov6x/wJtjo+ZianbOXvKUJce+395QEvFvkq0/j4Yxe2OmzzygjWihqYA9y/RhdpiovURug==
X-Received: by 2002:a63:2947:: with SMTP id p68mr2677635pgp.113.1613663163320;
        Thu, 18 Feb 2021 07:46:03 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id s22sm6484397pfe.133.2021.02.18.07.46.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 07:46:01 -0800 (PST)
Date:   Thu, 18 Feb 2021 21:15:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rjw@rjwysocki.net, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: exclude boost frequencies from valid count if
 not enabled
Message-ID: <20210218154558.zrcymny7y64y3raz@vireshk-i7>
References: <20210217000013.4063289-1-thara.gopinath@linaro.org>
 <20210217055029.a25wjsyoosxageti@vireshk-i7>
 <4c9d9d44-5fa5-3ae1-e9bb-45cf6521b764@linaro.org>
 <20210218084847.743rttqwlmwyx6pz@vireshk-i7>
 <d693d999-7734-3e69-edb9-9e03fd2f0d1a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d693d999-7734-3e69-edb9-9e03fd2f0d1a@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-02-21, 10:03, Thara Gopinath wrote:
> Scheduling a notifier for max frequency change from the qos framework should
> do the work, right?

Not that, but we need to increase/decrease cooling states at run time,
create sysfs files/directories, etc. It isn't worth it.

-- 
viresh
