Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27FE3F55B1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 04:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhHXCOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 22:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhHXCOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 22:14:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A59FC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 19:13:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w6so11305129plg.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 19:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hTyHyLQYzEOA4uGWERB+WxPgnaDFfEzDVJ9NEcQymOA=;
        b=ravVzzjn1uN3ecrzUOIwEmyxWBG0Bqlfl4gAtOHZjf+4xRiy2kVXIMcyFiaqHPhGsV
         oVLQpyr3ttQdVbbH6cxkYmAJkZg2AYl6h1XR9BqavGNSC2EjVzBbgm/xTMq2gwto8qir
         UjsKMKIzGb0RNllfnlZHj1bqOsW6nIA/ZWqtBwuNYBRiib8Sb1zGNgOG/17AFGjZUdYR
         UeR5Jr+ZfM1sxHm8SfZu+IzfgsN8hwASZMRsE6sLjI7MPRIVfHv/7/6+uNqkRAq3JDhy
         QkKp1hzSbumGGYCS66x6h3CMI3JPRIJUEDVopLtbsjgJALodolwHIpait5gaxEaO0wn0
         vnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hTyHyLQYzEOA4uGWERB+WxPgnaDFfEzDVJ9NEcQymOA=;
        b=bHTf3mentZHH5fHzhOs7cpe+WhqFL5tzC50qgOZ3iroC683y965KOPlEBKYEzkW9KP
         Xz1SoiYGMHZ9fWUEgz68eRDJpVdsnXr/mmNcQviFxQaH2uuXg2nDlag2Q5RRam8ty/M6
         M+K6duyWNww/G2bFKbMOiRsykcoSavsZxlm7sq66BJOgMvIj1HzCVqvNcSaLCtfY9VnC
         ONBTtBYNxJfShZCKd8MfAt+oCvdcoAmFsSW9s3pkAEWf8re2vkr8GM3kn+b6ssAFgaeD
         RiI4sFvr/GQuthNjTDN2kIfSKCwUAszhikEHgWl1o5TEU6kcw1ZRJneXNsDLVStR1VN5
         zd7g==
X-Gm-Message-State: AOAM533xasj/FORvi5GmNoih0iR6VKBmLysLtzBv8JSKCKgYRUUa04EL
        hQokmL9huJD1g6YxcWULyhsVkw==
X-Google-Smtp-Source: ABdhPJw5H5ZKTPpbqVElGplnJQ/vrdCiMzI0zx7nxayb7jgjvyYy2Vk7apfHRO1XNDK+qpYPc5C61g==
X-Received: by 2002:a17:903:22c2:b0:12d:b609:a37e with SMTP id y2-20020a17090322c200b0012db609a37emr31041795plg.68.1629771207771;
        Mon, 23 Aug 2021 19:13:27 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([114.87.70.46])
        by smtp.gmail.com with ESMTPSA id l12sm16720326pff.182.2021.08.23.19.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 19:13:27 -0700 (PDT)
Date:   Tue, 24 Aug 2021 10:13:11 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Li Huafei <lihuafei1@huawei.com>, coresight@lists.linaro.org
Subject: Re: [PATCH v1 2/3] perf auxtrace: Add
 compat_auxtrace_mmap__{read_head|write_tail}
Message-ID: <20210824021311.GB169379@leoy-ThinkPad-X240s>
References: <20210809112727.596876-1-leo.yan@linaro.org>
 <20210809112727.596876-3-leo.yan@linaro.org>
 <2b4e0c07-a8df-cca6-6a94-328560f4b0c6@arm.com>
 <20210823095155.GC100516@leoy-ThinkPad-X240s>
 <319ee11a-06f7-abde-6495-d2175928b9fe@arm.com>
 <20210823121348.GE100516@leoy-ThinkPad-X240s>
 <1c0101fd-2ca6-4741-5d72-82d3e00bfeb6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c0101fd-2ca6-4741-5d72-82d3e00bfeb6@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 05:00:14PM +0100, James Clark wrote:

[...]

> >> I couldn't see how it can ever return -1, it seems like it would loop forever
> >> until it reads the correct value.
> > 
> > I use this chunk comment to address the function
> > compat_auxtrace_mmap__write_tail():
> > 
> > +int __weak compat_auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
> > +{
> > +	struct perf_event_mmap_page *pc = mm->userpg;
> > +	u64 mask = (u64)(UINT32_MAX) << 32;
> > +
> > +	if (tail & mask)
> > +		return -1;
> > +
> > +	/* Ensure all reads are done before we write the tail out */
> > +	smp_mb();
> > +	WRITE_ONCE(pc->aux_tail, tail);
> > +	return 0;
> > +}
> > 
> > Please let me know if this is okay or not?  Otherwise, if you think
> > the format can cause confusion, I'd like to split the comments into
> > two sections, one section for reading AUX head and another is for
> > writing AUX tail.
> 
> I see what you mean now, I think keeping it in one section is fine, I would just
> replace "When update the AUX tail and detects" with "When
> compat_auxtrace_mmap__write_tail() detects". If the function name is there then
> it's clear that it's not the return value of compat_auxtrace_mmap__read_head()

Sure, will update and send out the new patch.

Thanks for suggestion.
Leo
