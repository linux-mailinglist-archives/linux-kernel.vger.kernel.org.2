Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509213913D5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 11:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhEZJe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 05:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhEZJey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 05:34:54 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294A2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 02:33:22 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x188so494636pfd.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A4rqRTn1JtEUXra1zOwYdzFWXhA0XqgINkljPQQQrrI=;
        b=fnGxMYegsmhYnvJd30bapzcmve4AzbiPyaRRE1SvcsFix1s7IvmRx7FHBjXxGhadlP
         BiqQfP4ZNC4JtMy4Q9qgBHUNEAzx3pL+PSoznuiwCBw/6Jpd2YKCsLiG0/dobcBWbSCh
         e9uAoozDOH882msGG/oTtKKltCUsoDfPrzMoheGYO49oa5xsEE6nl4xhY8cONDqEWrIm
         iTziPU+WH+Cxbc7aPM5K2rsjDFzlLNvnA9HLQgTxfeMcfD/Z1xGz3/lJ6HoR5wdgZuGq
         o80r1oCSXK4DK3V7bxFrTO0H5cTvR8dlmx3Vy7tjJTKF3CHM8spmLbIAKl0QcqSsajm5
         qMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A4rqRTn1JtEUXra1zOwYdzFWXhA0XqgINkljPQQQrrI=;
        b=lbZ7d5ekF8aKaz2t/vIpAQiXlTUfPmkjDRfq94Wlyd67Lq8o5QgCDXlbVKllJoYHNM
         XDScLyVQtLencnXn6Z/AQjQmjI/cvO2JHRnBJAUF+gR5D731aFiGfuyJ5pOfXFFiwrFR
         DjYZlYtQBDzot349VGsLcOsVWKuMLLDLZ4moQ4H74gGPpx66wh+zqzIu6HxRGNbTKTQe
         5pFQYZbo06oe6wFYhcUICVElkZCQMBGBi5ahXbppGVGhhGcWnyv0xCpnEHIlT4TYg3VH
         /av55acD1sKO/6hGH0johwOfqohJR96Kqyn7h/K8juFpG8KEQ0WKSijZSSHiW+NVr1qG
         sgDg==
X-Gm-Message-State: AOAM5330gynzSa23TclrkdPe1vmbeDLwXxTWx7JWBYJEX3NvfVeLZKDT
        X5wTQJjkBurstSVyt/1C27rX1w==
X-Google-Smtp-Source: ABdhPJwooR2mO8WNgchnyK0kbR0L7sqjQsV9OtkD+9JxI8AxiPRZk72JGJIilck1WnXoG9P64IIuJA==
X-Received: by 2002:a63:7e13:: with SMTP id z19mr23712448pgc.184.1622021601657;
        Wed, 26 May 2021 02:33:21 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id b12sm3860135pjd.22.2021.05.26.02.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 02:33:20 -0700 (PDT)
Date:   Wed, 26 May 2021 15:03:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 0/3] EM / PM: Inefficient OPPs
Message-ID: <20210526093318.cbtjkybzwdchxi5y@vireshk-i7>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <20210526034751.5fl4kekq73gqy2wq@vireshk-i7>
 <068fa9c4-2b55-3d75-adc7-cf5ef2174b12@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <068fa9c4-2b55-3d75-adc7-cf5ef2174b12@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-05-21, 09:56, Lukasz Luba wrote:
> No, these OPPs have to stay because they are used in thermal for cooling
> states.

This won't break the thermal tables. Thermal just sets the max-freq for a CPU,
and it doesn't depend on the OPP table for that.

> DT cooling devices might have them set as a scope of possible
> states. We don't want to break existing platforms, don't we?

I don't think we will end up breaking anything here.

> We want to 'avoid' those OPPs when possible (no thermal pressure), but
> we might have to use them sometimes.

Why would we want to use them if they are inefficient ? Thermal or something
else as well ?

More in the other reply I am sending to Vincent.

-- 
viresh
