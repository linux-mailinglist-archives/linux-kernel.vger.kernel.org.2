Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8074330D224
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 04:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhBCDWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 22:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbhBCDNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 22:13:20 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7933C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 19:03:50 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id g15so3706789pjd.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 19:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q7fbDsjCyAXotFN7l5eRHmJwaN6iiM21G76v+vKrgro=;
        b=d8tY/p9uma4M9Ce+gxXdoujYFI693ZWw0zMABZW85jGVqHqSy+TS6kxJwSWx+yIti0
         ujRHZ7vLPXOWwjGgCIdflZeGTlwp4ILQ1Ecfxu1t8fe1YEHaN2kEhFZNnq5TWkKh3cQC
         gCHbrouT+g6VyvknmwlASX1pYhlYeIk/HrqtZyANo+KlcYNdQDbuspwX3pvmC0R8K/IS
         OOfgVh0myemON6oYNeRZBclOHzWJwzOxpDeSNP/DoxReomYN5smaZlDArMXPxahSumxN
         u/IroYdS0ZgxhRBXPft5KNCW8Lpca2KBYh2OmUErwKP+EWS8rE4Ubz74q+pFdyxau7ak
         TSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q7fbDsjCyAXotFN7l5eRHmJwaN6iiM21G76v+vKrgro=;
        b=QCPHwNKwUZaPEpI4IQN/MAlBnDkO2sHMMxFZuaCco5FVoGSkPaeXERzQkQi0uDTzEK
         EeWX+zeyjRQ3wSvkM66G/IbEkYexwFPEjjdPbYO3vu7NtQBEhs5P1owrTj517Y2i+D3g
         +yg1LqklioxFWkgl+34skfdI8arxMlntHihy3HPI501wq/kBc3xqZc0scAT5DIOZjoIU
         jXtz7EZn0zTMwdBFuQJB10Mq4BYuuNccn7rd+L6GJKHsgVpY2i2ObkYye34hcrDCFnZY
         xZ2UOk0Jkx3HXTFVgiZt3EQaWLNIBgiYt3AYZgWl1DI3RBxbj6oA8y+BBOt7ORSfR7Pz
         5nBw==
X-Gm-Message-State: AOAM5308SHbl/MiPKIbMOs0IcSK3s7tLUaHcJYQeDuGukSU5R9TbdVvp
        hLm0sNrIlKDJyNAMqBswKDGtZA==
X-Google-Smtp-Source: ABdhPJzlrik+5uaEVQ9WweKnlitUi9Ku7M3wOt2mVdaXYVotSXhc+VzFz9PkqEYbEtoGSZ9Xlgw0Hw==
X-Received: by 2002:a17:90a:a794:: with SMTP id f20mr938154pjq.185.1612321430327;
        Tue, 02 Feb 2021 19:03:50 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id f3sm323178pfg.120.2021.02.02.19.03.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2021 19:03:49 -0800 (PST)
Date:   Wed, 3 Feb 2021 08:33:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v6 13/37] cpufreq: scmi: port driver to the new
 scmi_perf_proto_ops interface
Message-ID: <20210203030345.7lwcafpginkkcgik@vireshk-i7>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
 <20210202221555.41167-14-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202221555.41167-14-cristian.marussi@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-02-21, 22:15, Cristian Marussi wrote:
> Port driver to the new SCMI Perf interface based on protocol handles
> and common devm_get_ops().
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v4 --> v5
> - using renamed devm_get/put_protocol

Can this go through the PM tree ?

-- 
viresh
