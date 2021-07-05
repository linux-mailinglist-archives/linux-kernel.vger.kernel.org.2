Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E523BB666
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 06:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhGEEf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 00:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhGEEf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 00:35:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301F4C061762
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 21:32:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a14so9372245pls.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 21:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hzs9/MPPqTbukCCd+SDEsivmHIJPRX7gx5UfTUvkO7w=;
        b=Ue5aGYTLaC8HcxL1/2BoBxtkAQIa1ZkefHZUYkQVM3UWIPu1+OOnNUXWhl4DwwYb9G
         dJNIXFekZQnf0jA9psHMJJlz+/O94nmrHk/TsGx2EIW6DcJuMX1ZjbJXyb+CUpJu3XC2
         uFieHD3yOm4nNasAMUaTljWiY1Y/DNlsQCI2he5/6KAqy84hLw7iq0cj0TAFQnhjPj1U
         MsatVP1pAbxSAK5M/6Sh9d1bPpnjFp/hFwryk/Qdrs2ChxdECWiBm+tM2saXf+2m8E2n
         +OLVO2jEhIl3srKnuzvsBBw4R6bhp5OQud6XOiCwFAUYHu4kMGMRGcQGOaVplGdsOFrq
         ynZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hzs9/MPPqTbukCCd+SDEsivmHIJPRX7gx5UfTUvkO7w=;
        b=IxDp8yiVIcWkDuHMfh4e4//3ocxeqVFWjYyYOmqrikKi3WGUGYszca9LlIyUFmLgH5
         zfZ8SAGZIBFT51JLD2BETAs7ItunT87J+Wd0vgf6FxJ6M2KggT65l+JOMkDpEFxwPAQ7
         WS/QVybQYWON0adpwEHXxC93lpcpIMEFNkntdks41R7/aSuAx4jKpUzXGJ4LD7y9ggWB
         uu7SxUqRa4Cf11D3QdF1IQCWk5lBEKQHvhZa+LdID2GXhDtPDKlia30cuilGDy7Wk1D9
         +IOW+8/H+zxK8FoPXSmIGMm4UtUSZoSs+GBkGfWgyYwQgCECSVgqYtRv7TaN3XXczpQR
         kFpg==
X-Gm-Message-State: AOAM532q6AFhoXclF30Txf7DFIZJj/Nao0044bT1fgq7eWkaB/M2dlqT
        4u5CJ6vOxOlnJ7Ki0dt/Pjql1Q==
X-Google-Smtp-Source: ABdhPJx4oNRUqlZr1vQ97rs7GdaVbmtY4QFUJ4jxXHLPcFSeovx9yoMEHeGGNU0D5JbwmK+kl4s44A==
X-Received: by 2002:a17:90a:d506:: with SMTP id t6mr12980439pju.26.1625459570574;
        Sun, 04 Jul 2021 21:32:50 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id z20sm12768901pgk.36.2021.07.04.21.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 21:32:49 -0700 (PDT)
Date:   Mon, 5 Jul 2021 10:02:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Subject: Re: [PATCH v12 1/2] cpufreq: mediatek-hw: Add support for CPUFREQ HW
Message-ID: <20210705043248.sivxgodszzhrax2d@vireshk-i7>
References: <1622307153-3639-1-git-send-email-hector.yuan@mediatek.com>
 <1622307153-3639-2-git-send-email-hector.yuan@mediatek.com>
 <20210614104058.jdwb7godqzhf7rgd@vireshk-i7>
 <1624781848.1958.16.camel@mtkswgap22>
 <20210628072641.amqk5d3svwolvhic@vireshk-i7>
 <20210628090956.uwkrozdqvawsm3xp@bogus>
 <20210629024719.nmcygaigtx5wn7g5@vireshk-i7>
 <20210629090238.n23zcttkiqvzpbb5@bogus>
 <20210629090522.jsiwkrki6lavo33z@vireshk-i7>
 <1625418089.1958.48.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625418089.1958.48.camel@mtkswgap22>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-21, 01:01, Hector Yuan wrote:
> Hi, Viresh:
> 
> OK, Thank you.
> 
> I'll add this routine in of.c.
> May I know the below prototype is okay to you?
> 
> static int _of_get_related_cpus(const char *list_name, const char
> *cell_name, int index, struct cpumask *m)

of_perf_domain_get_sharing_cpumask(int cpu, const char *list_name,
        const char *cell_name, struct cpumask *cpumask);

And actually add this in cpufreq.h, this doesn't have anything to do with OPP
and I can assume that a platform not enabling the OPP functionality to end up
using it later.

Rafael, will that be fine ? Or we add it in a completely new header ? The users
are going to be cpufreq drivers only I believe.

> And maybe I have to find somewhere to update my
> mtk_freq_domain_map[cpu]?
> 
> static int mtk_get_related_cpus(int index, struct cpufreq_mtk *c)
> {
> 	for_each_possible_cpu(cpu) {
> 		cpumask_set_cpu(cpu, &c->related_cpus);//related_cpu can copy policy
> cpus
> 		mtk_freq_domain_map[cpu] = c;//need to find somewhere to assign
> 
> 	}
> }

I am not sure I understood this part well.

-- 
viresh
