Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD793620D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243838AbhDPNVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbhDPNVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:21:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0464AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 06:21:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nm3-20020a17090b19c3b029014e1bbf6c60so10418125pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jNEOUMLacDExesI1dUec+Ag9poKcQi7/Bd0G3kzBs+E=;
        b=D9/9AyaxROOMxeGsn1K8bCTaAQz95ClMBt4f11oG2tHr3a0M33smsXCK4q9FqRHGBh
         rJr717NgoXD6Xjlj0KIusADW3eOuGNlu6va6ZfniMI+gCRFsH04lKBZ3t+IYqN3AAggx
         JuLfL0nFO//BkVvzHzeY7uYBlFzBGZRnUuCpYIDi5d6NS77FI6UbzUYAGQyFqSQiBz+7
         wHOICFkSF0jU+ggXpXJf7pgFZKIOBfsIH/TyRMLY2mQjgN89BBvsPRBaAn4Cx16OTMNP
         Ru+6MiBawOLCueVpyWyWqsDR5GhtvGaYZ+iKz+/uNAhWQhb1oemX8vjWp4E6VVkauGqd
         h3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jNEOUMLacDExesI1dUec+Ag9poKcQi7/Bd0G3kzBs+E=;
        b=GY05gwG3vXxhjYKk0Sz+bvr8QVcAzcbCB1tIZjo4J/K4r+O5NLWFvshIZQUFMsSuUX
         AlZJT30NBvPMi67PqDVWW6KBZYHfJiTYwihO9fug87BrwrQad4C8Vviu/5re2BRhkpIs
         PRj1mDB7F17YydglZ0XkoZuK9347MbtooHMWKDvw5q2wMICZh8rvF9CbDbskIHiu7yfu
         YOPjo0LtD8omv0helSTG70zsgbDU3KPsGKr13nyC3np7MRoERZzdJ9orMZil9BKt86xf
         NCpQvykh9w+NDGRtAKDcgcZi5Npy4XESQhsOgS/uOziT3d1OBQAPlXstWvEQ4/xTieqH
         0U7Q==
X-Gm-Message-State: AOAM533cemWKTqWXSeD8c2+TLOytJ1IMVOiqJAyAkLRC5euI3ShIcZ6Z
        tswQXt07GUnbbc8eUIZIDbw6KQ==
X-Google-Smtp-Source: ABdhPJyveue9gtWWLnn5Yel0ovmrx50udM1NmcCIuMHesFmn1b5+ri0JefXJZCkA45mBIEbj4zuSzg==
X-Received: by 2002:a17:90a:150e:: with SMTP id l14mr6643850pja.208.1618579273482;
        Fri, 16 Apr 2021 06:21:13 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.180.30])
        by smtp.gmail.com with ESMTPSA id x13sm6617982pja.3.2021.04.16.06.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 06:21:12 -0700 (PDT)
Date:   Fri, 16 Apr 2021 21:21:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <Al.Grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] perf arm-spe: Assign kernel time to synthesized
 event
Message-ID: <20210416132104.GG1011890@leoy-ThinkPad-X240s>
References: <20210412091006.468557-1-leo.yan@linaro.org>
 <20210412091006.468557-5-leo.yan@linaro.org>
 <9036368a-e824-3d63-da5b-54cf32a86aed@arm.com>
 <20210415152348.GF1011890@leoy-ThinkPad-X240s>
 <c9c060d1-0884-b67d-7689-6b45ad10baa9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c060d1-0884-b67d-7689-6b45ad10baa9@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 03:51:25PM +0300, James Clark wrote:

[...]

> >> I noticed that in arm_spe_recording_options() the TIME sample bit is set regardless of any options.
> >> I don't know of a way to remove this, and if there isn't, does that mean that all the code in this
> >> file that looks at spe->timeless_decoding is untested and has never been hit?
> >>
> >> Unless there is a way to get a perf file with only the AUXTRACE event and no others? I think that one
> >> might have no timestamp set. Otherwise other events will always have timestamps so spe->timeless_decoding
> >> is always false.
> > 
> > Good point.  To be honest, I never noticed this issue until you
> > mentioned this.
> > 
> > We should fix for the "timeless" flow; and it's questionable for the
> > function arm_spe_recording_options(), except for setting
> > PERF_SAMPLE_TIME, it also hard codes for setting
> > PERF_SAMPLE_CPU and PERF_SAMPLE_TID.  Might need to carefully go
> > through this function.
> > 
> 
> Yeah, it's not strictly related to your change, which is definitely an improvement.
> But maybe we should have a look at the SPE implementation relating to timestamps as a whole.

Totally agree, at least this patch series should not introduce any
barrier for timeless case.  I will go back to verify it; if you'd
like to fix timeless issue, please feel free to go ahead.

Thanks,
Leo
