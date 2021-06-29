Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A053B6FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhF2JHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhF2JHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:07:52 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EFAC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 02:05:25 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id u190so17920219pgd.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 02:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zxf0nNdDqyVoap8M6CG4HmjTediBPHub6WIWm3X9tdg=;
        b=oTXq0/zjuzYPodSFGvMyuSPm6dwszJ3EXXtGSdCk4pk1sIZN2jSadWGy9UglSbV4Id
         Ak/vFfrERdzVadO8t+3Ll8wZbk6NySFl1q6Iqmkt8moV4/trIjpr+Hil3Z99I73TixFJ
         zKkHDRWcaWS+vA4PTWDWT3GbCCsVwQp1MKHH/codd3Gg6YHr6rwlnVXsumEwnSAKd5mc
         fhwJHhDBxLyoun0TjEQi5HIvBhNjwOa8GHN46cwYv4tS8LA3sibk2GeFpXnPnU3mtcmc
         v75Nb3QrIXAHfdz0fZT0dZUmXyMGgivobj3/yRzZXqkLo03Tzk4GLHe0Cu8xkiBD6lZq
         l8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zxf0nNdDqyVoap8M6CG4HmjTediBPHub6WIWm3X9tdg=;
        b=KpZcP6hdOoHCUmC2UWL/94K7gZ9+qSc0UNUgCIQjeID4L0mM3nTtASBcCclD0B24h7
         11ZrxHAy/fsEDLvfZjD1YZgsr1WhGJ+wnioCRqM4VHYsXz6lMGBlgsxfx05mbDlZCe76
         TK66b8GJBtN4vmLn2zIgHluPinET3rUmwAEuo7xklcpYeExFTmF+IqRIuUkfgejiLr4K
         zpVkmNDAKnAXtN2a2jzFY+U5h8t9owpvlBzu8G64dtszrEq1SDVfz8+/9sIU/AyDj19M
         zYMzynOE9fn7Svr27WwthTmEoEzd5zeLDcdO/stqQY+prg1/CX9vqfjqqy3qxlEGLebQ
         VnxQ==
X-Gm-Message-State: AOAM532FQVhvNpWsuLDL5v/aE77Gfonq0YD6xfFZlmJLsehoualgIGFr
        TWow1Ei1JLFAr7qTJEBxUJpb/g==
X-Google-Smtp-Source: ABdhPJyUPZgwjS4wGEte0i7vATCyxhKkaNbcvSyv/AlwzZqne0dvhsrD9mp5zq7yjYCtC/F8sRmOQQ==
X-Received: by 2002:a05:6a00:8:b029:308:1d62:ba56 with SMTP id h8-20020a056a000008b02903081d62ba56mr27553764pfk.60.1624957524945;
        Tue, 29 Jun 2021 02:05:24 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id nr12sm2303013pjb.1.2021.06.29.02.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 02:05:24 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:35:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Hector Yuan <hector.yuan@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v12 1/2] cpufreq: mediatek-hw: Add support for CPUFREQ HW
Message-ID: <20210629090522.jsiwkrki6lavo33z@vireshk-i7>
References: <1622307153-3639-1-git-send-email-hector.yuan@mediatek.com>
 <1622307153-3639-2-git-send-email-hector.yuan@mediatek.com>
 <20210614104058.jdwb7godqzhf7rgd@vireshk-i7>
 <1624781848.1958.16.camel@mtkswgap22>
 <20210628072641.amqk5d3svwolvhic@vireshk-i7>
 <20210628090956.uwkrozdqvawsm3xp@bogus>
 <20210629024719.nmcygaigtx5wn7g5@vireshk-i7>
 <20210629090238.n23zcttkiqvzpbb5@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629090238.n23zcttkiqvzpbb5@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-21, 10:02, Sudeep Holla wrote:
> On Tue, Jun 29, 2021 at 08:17:19AM +0530, Viresh Kumar wrote:
> > On 28-06-21, 10:09, Sudeep Holla wrote:
> > > Probably in driver/cpufreq or some related headers if it needs to access
> > > related_cpus and is more cpufreq related in that way ?
> >
> > It just needs to set a mask, so doesn't really depend on cpufreq. I
> > was wondering if drivers/opp/of.c may be used for this, and I am not
> > sure.
> >
> 
> Sounds good to me.

Okay.

Hector, add the routine to of.c in OPP core.

-- 
viresh
