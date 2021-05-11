Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48B537A158
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhEKIGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhEKIGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:06:18 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDDBC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 01:05:11 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c17so15506433pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 01:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qowb1jCPuujd1IWsaK4vSQJT6KwxU2yyn+OfcNfTCs4=;
        b=X8L8UnWsuHK5IGqp7KD23AjgSrJhNLM8XDx2FxDwsZezIyv7RhI+opaPcSv8+AeDn+
         0t/thWkYZppBZn2Is3zdeMfElvob/hpiNoASEFxYSLyqB6KTti1XrYwGsLB3bYq28X4P
         AqYO2SXjby8YR7S4g8VALCgvtnFyUUjWBsj+Q4WxUmn1V5arDt1mneDC7gJpIjsQB/M0
         dlArazIN/Gt2tNbaiFKBtZn/nIpCWyZXCxQJcvXBx8pjTxyl8Fbg+NcqZA9VefIIdHE1
         dGx2Ov0lKUjwGVijfqZS8b/8mIjNBfseHJHzew5Jot+OCW0aAqWhS7/AzQ+ZS36wTeFG
         947Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qowb1jCPuujd1IWsaK4vSQJT6KwxU2yyn+OfcNfTCs4=;
        b=YVmeILiI4/iMA+QvBymi6F/SaYzwsCqmix2w9/qvtJObq888m7cLrzpc7DUsEoTOQ5
         dQWeXzVpRgMqNo+c1ju6oYW6EPzFi3Ez/QexQNWsk3hY9dqJbQCOT+WMU0qcCALZWFje
         jONsEPHc3OqO1rNCQPsttBshHRX9HLW4VZZRQOhr3kjQ3okCaNJInTEjzKjhKir29Cuw
         7/tFzKqvOaV9cf5sl0w8pZIATYj/Zx34f0xSY0/35dSbwTPLafe2WW9Z1DgYv7iBH+D2
         6w+xvIO6qqCUQLk76Hm5U82j8K16+84VFUy62bR2E4DdqpPBcJlqvQCOSDrmKdIsrs4A
         /Obg==
X-Gm-Message-State: AOAM531ZwC9V9RlpdlwuN/4zRq/VHnFpscsveZN3B3wdGOGDjsvRMt2j
        C+1RQD7hfPz/2p6qOwd1LUc6Pw==
X-Google-Smtp-Source: ABdhPJztvCw2v+qMSbbFPGpcKYFa9G6eBPQdix7Cv3054DAxJ4x2xcjGBH4FewuCg580zoUHJu8X7w==
X-Received: by 2002:a63:8149:: with SMTP id t70mr29797637pgd.299.1620720311243;
        Tue, 11 May 2021 01:05:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-90-4.ap-east-1.compute.amazonaws.com. [18.167.90.4])
        by smtp.gmail.com with ESMTPSA id j7sm1482312pjw.4.2021.05.11.01.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 01:05:10 -0700 (PDT)
Date:   Tue, 11 May 2021 16:05:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf cs-etm: Handle valid-but-zero timestamps
Message-ID: <20210511080504.GC8273@leoy-ThinkPad-X240s>
References: <20210507095814.17933-1-james.clark@arm.com>
 <3926c523-3fdb-66de-8b9c-b68290a5053e@arm.com>
 <20210510053904.GB4835@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510053904.GB4835@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 01:39:04PM +0800, Leo Yan wrote:
> On Fri, May 07, 2021 at 01:02:35PM +0300, James Clark wrote:
> > 
> > 
> > On 07/05/2021 12:58, James Clark wrote:
> > > There is an intermittent issue on Trogdor devices that
> > > results in all Coresight timestamps having a value of zero.
> > 
> > I've attached a file here that has the issue. From the dump you 
> > can see the zero timestamps:
> > 
> >         Idx:69; ID:10;  I_TIMESTAMP : Timestamp.; Updated val = 0x0
> >         Idx:71; ID:10;  I_ATOM_F1 : Atom format 1.; E
> >         Idx:72; ID:10;  I_ADDR_S_IS0 : Address, Short, IS0.; Addr=0xFFFFFFE723C65824 ~[0x5824]
> > 
> > This doesn't have an impact on decoding as they end up being
> > decoded in file order as in with timeless mode.
> 
> Just remind, as Mike has mentioned that if the timestamp is zero, it
> means the hardware setting for timestamp is not enabled properly.  So
> for system wide or per CPU mode tracing, it's better to double check
> what's the reason the timestamp is not enabled properly.
> 
> IIUC, this patch breaks the existed rational in the code.  Let's think
> about there have 4 CPUs, every CPU has its own AUX trace buffer, and
> when decode the trace data, it will use 4 queues to track the packets
> and every queue has its timestamp.
> 
>   CPU0: cs_etm_queue -> ... -> packet_queue->timestamp
>   CPU1: cs_etm_queue -> ... -> packet_queue->timestamp
>   CPU2: cs_etm_queue -> ... -> packet_queue->timestamp
>   CPU3: cs_etm_queue -> ... -> packet_queue->timestamp
> 
> The issue is if all CPUs' timestamp are zero, it's impossible to find
> a way to synthesize samples in the right time order.

I saw Denis's replying for the hardware issue for timestamp, wander if
can add a new option "--force-aux-ts-zero" to override the hardware
timestamp issue.  Without the option "--force-aux-ts-zero", the
developers still have chance to observe the failure case caused by the
abnormal timestamps.

Thanks,
Leo
