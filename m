Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE893F4A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbhHWMPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbhHWMPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:15:19 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F95C061152
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:13:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o10so10086934plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=USD5OFknfQfTTpEURTjZ0WrHVrtGhEjlaRPsgw1f+QE=;
        b=vo8MOmKcUWIsLMfw5yQwAqFC5pN/iVnhcnEJibUyh0i31ox9NIt/BXe8Y4RoxpXIM3
         Cz3h2wPLXFnWY49bz6JhAOvaNezU6BOoqZ4U24k2Y5sBm/az7WAJi3ugoWTFzA3MkZGV
         DM9Vzs62DIVfiivf7wEvYLe60k1JW4kJroPlAHRE5zqXxE1mMUmOTBLmsXk1ZfX5TN+Z
         /kLQgLkjiIvt/7iipOdzyeY9jn6iWzvSz6dnUVRv8G7VgfcmA34XC0DIn+BVWfN4gWAJ
         KhVZo98NG+NHYz1F0SFSgy3+c3ouvnDwopWONF0u+si8JeBfaxDs6eopmJjY+2zaIFvu
         virQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=USD5OFknfQfTTpEURTjZ0WrHVrtGhEjlaRPsgw1f+QE=;
        b=HNEEycP6ovQFhWWW8+F0JGdCn88JBgsLXppslsh5ZZLo1eCkvRA10YW9DKlWEG6Oi0
         CxUu6ginX+59Xe4/zzJ4oFrkChQ3d8Eo0AyvYo/41eqz2VnuuURp0GVM6pxens0KfsEW
         Ip1txbnH+TiSAwnI7LMWzcB+Y3Fy7EiHmpY4uNaL/Q+cRtSzYmgV1aNH3mgur/bdlaB1
         ETdFrPDAgaPJeubxeXgDOZYWaLAVUNJxK5JE43K182Y9TMM8qsNYd+pJ4hda7kbSS5yW
         yTwWePOCgRX3x00nQ3cRLaFt0xizW8xZ7qskbfokissrMROx9glogX6fuPCjxffPODXN
         Pn0w==
X-Gm-Message-State: AOAM533n9Bt26zWjrOWGeoonz5VpRC/P+2yYBS9G2HcYLKL14ZACs8qt
        qHehpoSYDkfF0DO6wuSiE7mlZw==
X-Google-Smtp-Source: ABdhPJyNUbHpBwjyvMydx8DGbGbM8fWE1CehelWG1WvHoJPE237bsM++fPdTwPOlRbyrtdvtEU7sOw==
X-Received: by 2002:a17:902:76cb:b029:12b:2fb8:7c35 with SMTP id j11-20020a17090276cbb029012b2fb87c35mr28087072plt.16.1629720835386;
        Mon, 23 Aug 2021 05:13:55 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id w8sm16336627pjd.55.2021.08.23.05.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:13:54 -0700 (PDT)
Date:   Mon, 23 Aug 2021 20:13:48 +0800
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
Message-ID: <20210823121348.GE100516@leoy-ThinkPad-X240s>
References: <20210809112727.596876-1-leo.yan@linaro.org>
 <20210809112727.596876-3-leo.yan@linaro.org>
 <2b4e0c07-a8df-cca6-6a94-328560f4b0c6@arm.com>
 <20210823095155.GC100516@leoy-ThinkPad-X240s>
 <319ee11a-06f7-abde-6495-d2175928b9fe@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <319ee11a-06f7-abde-6495-d2175928b9fe@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 11:57:52AM +0100, James Clark wrote:

[...]

> Ok thanks for the explanation, that makes sense now. I do have one other
> point about the documentation for the function:

Welcome!

> > + * When update the AUX tail and detects any carrying in the high 32 bits, it
> > + * means there have two store operations in user space and it cannot promise
> > + * the atomicity for 64-bit write, so return '-1' in this case to tell the
> > + * caller an overflow error has happened.
> > + */
> 
> I couldn't see how it can ever return -1, it seems like it would loop forever
> until it reads the correct value.

I use this chunk comment to address the function
compat_auxtrace_mmap__write_tail():

+int __weak compat_auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
+{
+	struct perf_event_mmap_page *pc = mm->userpg;
+	u64 mask = (u64)(UINT32_MAX) << 32;
+
+	if (tail & mask)
+		return -1;
+
+	/* Ensure all reads are done before we write the tail out */
+	smp_mb();
+	WRITE_ONCE(pc->aux_tail, tail);
+	return 0;
+}

Please let me know if this is okay or not?  Otherwise, if you think
the format can cause confusion, I'd like to split the comments into
two sections, one section for reading AUX head and another is for
writing AUX tail.

Thanks,
Leo
