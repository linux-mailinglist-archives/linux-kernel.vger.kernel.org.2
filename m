Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73212434C06
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhJTN1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhJTN1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:27:46 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F34C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:25:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id k26so2967528pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B33cnf023fQm3GVfpEJD0Q4Wbg7jf3ZnWq/afLUKi2A=;
        b=wtq043pENV9t71jU6dkXGp3JuoV+Tmxr/Twpug4Ft3MPuTLvL3Bu7U3R+2Qq2NCzmN
         C6pwIotvkI1FGaORnHRPRxp37eM/kjEt46WyTH/il93Xadfnf2hB1dCMDe8hDnl/VRH1
         2dOnTQLlyGNikM3oncTi7YAs0RevhR9IfGJzlUQfPrwwHOp7XrRW+0VsmNuZjxsNhNiZ
         lvc9DnNq9eggcoKmhE0fHaP2nGXYaHYB4Imufa+7/CJZw3rb73+NNDwZsaqCRtl0+Tw4
         giSnZaU8kvv7mQebGHnud2d4nunRfckiwdzuh9a+Z5XUPOGIgqWjuTMcaJmVwXOQy9Ia
         EkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B33cnf023fQm3GVfpEJD0Q4Wbg7jf3ZnWq/afLUKi2A=;
        b=GTlEU4qCyk4uUuxejw70RJ7o1zZuOttQQWS0iamCCbaNr8bJjPd7KCgHLNkiGryGxP
         mGc2YtlfoJb9yUb2PU/zvvzRcvVjYWLcK8mMbjI7y2lWYTBg1veZqRL5uxlrtD8TNFh9
         anNtKwgsSFVAf/uOJVSx6zoCTndFJ6yWUJnNaHxYMYeWgFv7pYFAyOa2RsMiWKCcbS6u
         gtzxIGO4DKxoO2qPXInBVh1Ov4Jr/vOV9ZJo5mqgfN9qPrS6RVgU5zyEhuuIHAHofZPG
         PPyQslm64xH+z8wEKf3+x+VLmW5RsYzA0xL4J8pNIYlKmpNOXw6324EskbHW8DsXYFMc
         hgVA==
X-Gm-Message-State: AOAM532yJqlcdaT2Jih3mkBefMY6ucueMEl6mMESZB8GC30v4AugwICD
        8rr9EEZgwi8Alx+2QC572XPt7A==
X-Google-Smtp-Source: ABdhPJxoviIBSwiDcJEmG16PcZ8QdakQCFNojHcMiD05xwwnHTJx5SfEXyklwzSJ8KbWzjavaY4TPA==
X-Received: by 2002:a05:6a00:1781:b0:44d:faef:f2c0 with SMTP id s1-20020a056a00178100b0044dfaeff2c0mr5651pfg.68.1634736331411;
        Wed, 20 Oct 2021 06:25:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id oc8sm2718291pjb.15.2021.10.20.06.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:25:30 -0700 (PDT)
Date:   Wed, 20 Oct 2021 21:25:20 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
Message-ID: <20211020132520.GH49614@leoy-ThinkPad-X240s>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-4-german.gomez@arm.com>
 <20211017120546.GB130233@leoy-ThinkPad-X240s>
 <0661828d-f7d9-fd8f-2a57-19364d2e5218@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0661828d-f7d9-fd8f-2a57-19364d2e5218@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 06:34:24PM +0100, German Gomez wrote:
> Hi Leo,
> 
> On 17/10/2021 13:05, Leo Yan wrote:
> > On Thu, Sep 16, 2021 at 04:46:34PM +0100, German Gomez wrote:
> >
> > [...]
> >
> > If run a test case (the test is pasted at the end of the reply), I
> > can get quite different AUX trace data with passing different wait
> > period before sending the first USR2 signal.
> >
> >   # sh test_arm_spe_snapshot.sh 2
> >   Couldn't synthesize bpf events.
> >   stress: info: [5768] dispatching hogs: 1 cpu, 0 io, 0 vm, 0 hdd
> >   [ perf record: Woken up 3 times to write data ]
> >   [ perf record: Captured and wrote 2.833 MB perf.data ]
> >
> >   # sh test_arm_spe_snapshot.sh 10
> >   Couldn't synthesize bpf events.
> >   stress: info: [5776] dispatching hogs: 1 cpu, 0 io, 0 vm, 0 hdd
> >   [ perf record: Woken up 3 times to write data ]
> >   [ perf record: Captured and wrote 24.356 MB perf.data ]
> >
> > The first command passes argument '2' so the test will wait for 2
> > seconds before send USR2 signal for snapshot, and the perf data file is
> > 2.833 MB (so this means the Arm SPE trace data is about 2MB) for three
> > snapshots.  In the second command, the argument '10' means it will wait
> > for 10 seconds before sending the USR2 signals, and every time it records
> > the trace data from the full AUX buffer (8MB), at the end it gets 24MB
> > AUX trace data.
> >
> > The issue happens in the second command, waiting for 10 seconds leads
> > to the *full* AUX ring buffer is filled by Arm SPE, so the function
> > arm_spe_buffer_has_wrapped() always return back true for this case.
> > Afterwards, arm_spe_find_snapshot() doesn't respect the passed old
> > header (from '*old') and assumes the trace data size is 'mm->len'.
> 
> Returning the entire contents of the buffer once the first wrap-around
> was detected was the intention of the patch, so I don't currently see it
> as wrong. What were the values you were expecting to see in the test?

I expect the second command takes three snapshots: the first time it
should record AUX trace data with full buffer size (8MB) after waiting
for 10 seconds, and later two times will take small AUX trace data since
the interval (0.03s) is short and Arm SPE has not filled the full AUX
buffer.

> If the handling of snapshot mode by the perf tool can be improved after
> upstreaming the changes to the driver, we could submit a followup patch
> after that has been fixed.

Okay, I understand now the main concern is for kernel driver changes,
this patch for perf tool is fine for me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

[...]

> I will try these and the other driver changes and discuss them with the
> team internally, thanks!

Thanks a lot!
