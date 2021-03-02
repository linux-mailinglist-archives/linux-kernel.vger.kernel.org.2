Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE3232AB5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377992AbhCBU0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347436AbhCBRga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:36:30 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9DEC06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 08:42:56 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t9so2284612pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 08:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DYMkSsxqtc5xY6umCzcFh2zzeVbRKHK+U/AETcq+WCs=;
        b=E4m/UJLawUTx4duU1bM3tWc3g6HFyjWBHrOTQiHkiDu5UE1mmsr638ruHoBOSxjrEm
         QqCGNgGgMbRVZs29k9qMTv4ezadL5J4w19oUxKJZUC64eyhlPNHM/caVAuHtRqlOnSq3
         BMeMhvff90y2BElOAteOMbZs6CCVjy7yo9W5Lt5moLifN3d50CHiLVBy+9JqNt8mJCTE
         0mzCjRQ5ZNYhMr/NThL7UQZTuRnSdu9Pa8r9pl5SN+acwixYJCOO2dd7ojmrHlZcyTBI
         mmK60sQbVduYm3r/wITcEyWzv5cuaDSugydd1un/uEngA2CiGz614SiG3JNrngADgPvN
         ZlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DYMkSsxqtc5xY6umCzcFh2zzeVbRKHK+U/AETcq+WCs=;
        b=iM1dXUAaUh7xmRMc7IQMATri9EaM3gTqlrB/EDpuR0gE/ogEaug5IfzgPNuaDtxwdh
         CJ2i0PA4n6D28VqvC9SHuM3QaPfduxI2S88gWJZFb/kfpsjn3ubQcBZllfBzbxCfTdnw
         rkmhMULXE/qAv8gPFpQuR1AxxORRITZyW8BXCuJ6wVdSyTV7NCmHENNRsHWdVetNjwS3
         VMgOP0K1CV4lLJlz31ECe6jwjrsBC0k/iL/aY6EG3P407rxxV8XZIiPDC8zY0xDTxJKI
         xPKUBt0a8jUQFXG+q10+1klLxZIyqxUglfKGuaooIJQCWh4rDhirptSMyyF5RkCrT+jO
         X8QA==
X-Gm-Message-State: AOAM533jZOxEPM1KwE75a4FLHMhCWKZGFkKctPP1FaOgQ8Gl1yWiIPlM
        nbKmDrJ6Rkb9FytFcovrB52KsDPICwRR5g==
X-Google-Smtp-Source: ABdhPJyjcPvG6qiHv/ehK14tPVu9bfmPDYvmiOIS7N0WmxxxMGv6/Tx0215bnecUsije6y9HZdi/QA==
X-Received: by 2002:a17:90a:2f22:: with SMTP id s31mr3345598pjd.99.1614703376471;
        Tue, 02 Mar 2021 08:42:56 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id m9sm3837773pjl.4.2021.03.02.08.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 08:42:56 -0800 (PST)
Date:   Tue, 2 Mar 2021 09:42:54 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] coresight: Patches for v5.12 (perf tools)
Message-ID: <20210302164254.GA3789438@xps15>
References: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
 <YD41GUtuq8fVa4Q6@kernel.org>
 <CAJ9a7ViKLg8vjBnuA1eWh8b5-PN7RryefyOV1qoX9Zu362Eq8Q@mail.gmail.com>
 <YD5mu7Df3fXiWZuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD5mu7Df3fXiWZuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 01:24:27PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 02, 2021 at 02:23:14PM +0000, Mike Leach escreveu:
> > On Tue, 2 Mar 2021 at 12:52, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Em Wed, Feb 24, 2021 at 09:48:29AM -0700, Mathieu Poirier escreveu:
> > > > I noticed there is a couple of patchsets [1][2] that haven't made it
> > > > to your tree for the coming v5.12 cycle.  Do you think that can still
> > > > be done?
> 
> > > > I tallied the patches here to make it easier for you to pick up.
> 
> > > > Applies cleanly on perf/core (84b7725536d8)
> 
> > > > [1]. https://lore.kernel.org/lkml/20210202214040.32349-1-mike.leach@linaro.org/
> > > > [2]. https://lore.kernel.org/lkml/20210213113220.292229-1-leo.yan@linaro.org/
> 
> > > These are not applying right now, I've pushed what I have to
> > > tmp.perf/core, please take a look, I'll get back to this after
> > > processing fixes for v5.12 and what is outstanding for v5.13.
>  
> > I've tried [1] on both Linux-5.12-rc1 and your tmp.perf/core and it
> > applies cleanly on both.
> 
> Can you please try one more time, these are the last csets on this
> branch:
> 
>   $ git log --oneline acme/tmp.perf/core -10
>   8e1488a46dcf73b1 (HEAD -> perf/core, five/perf/core, acme/tmp.perf/core, acme.korg/tmp.perf/core) perf cs-etm: Detect pid in VMID for kernel running at EL2
>   47f0d94c203751dd perf cs-etm: Add helper cs_etm__get_pid_fmt()
>   30cb76aabfb4deab perf cs-etm: Support PID tracing in config
>   8c559e8d68630d64 perf cs-etm: Fix bitmap for option
>   2bb4ccbd95d7fbf5 tools headers UAPI: Update tools' copy of linux/coresight-pmu.h
>   42b2b570b34afb5f perf cs-etm: Update ETM metadata format
>   83bf6fb8b076c72f perf vendor events power9: Remove unsupported metrics
>   34968b9327c83589 perf buildid-cache: Add test for PE executable
>   9bb8b74bdb186bd3 perf docs: Add man pages to see also
>   d9fd5a718977702f perf tools: Generate mips syscalls_n64.c syscall table
>   $

As far as I can tell you have all 6 patches.

> 
> I think it doesn't apply because I applied a series from Mathieu
> touching files affected by those two patchkits.
> 
> - Arnaldo
>  
> > Let me know if there is anything else I can try.
> > 
> > Thanks
> > 
> > Mike
> > 
> > 
> > 
> > -- 
> > Mike Leach
> > Principal Engineer, ARM Ltd.
> > Manchester Design Centre. UK
> 
> -- 
> 
> - Arnaldo
