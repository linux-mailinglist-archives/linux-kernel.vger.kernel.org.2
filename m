Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D8C4566F0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 01:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhKSAga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 19:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhKSAg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 19:36:29 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325C6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 16:33:29 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so7318028pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 16:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UkcM1rTecmJ25KsUoXFTZKIn9eyzcYLgTJdNQlzShK8=;
        b=nNONCxvj70orXmFEPPlUSDO3mt6Wtl927JrNDbPxGbq3nLI7dP4aUomf4ikpaAWno1
         E5tZ/1qd+TfTbpG3LKaqN3/Q005utHPSi5xYtFL481zC+BGznNHJIpSCAxcReahqhnBX
         tFfQGDSsOCTvTJzQl80RCaDg+QR/KouVZUOeNuIg3nccU7JjgzDrTQl0U/n93pd4wC6E
         XxzpObxnLdf9bS/XDIelOHQBYzAx3azq/h3nJh7vThyhUxl3MelJlTwXx+EMRGwpO58E
         rGWhe2M3G001XQnWRJJksjXDSpugEK1Sh26xTl+BRMz9DQbU6lo6LNZyYUXrfqgk+4MQ
         y+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UkcM1rTecmJ25KsUoXFTZKIn9eyzcYLgTJdNQlzShK8=;
        b=DrteGaXE2RPVEHavkQknblEMve8oP264k83uRzswjolFEF5Z7N86W8HNCdmWraJiJW
         KXeThoZsyAZV9Dms8ZgwHzTvC/3AAiwKBjQDalM8W+oqqyjpOkUgj3Nm1OlVjGUVC4or
         vHiirXaMbIf1XRkLGk8aAFAw+7kcUxh5xH14c9vxOMPCqMJL3aFfcQrpxP5zXA6XZt7a
         5OoZnmmPc2Wt18d7kU0qLphpiBVaPij6WQuRZb2Szh66AFSA5cLWbD96SMemJ+c+FBXl
         5UpZ5At3JEhgEK5fyLBXEKix/XB/GaTbULr7ICqSgr6tk2KcZOyUlTmXiP+RN8cUDvIy
         RIRA==
X-Gm-Message-State: AOAM530lHuqxCu6GkP55vkmTwdJ8awporqwADDF1omPbiwKhlBuYnxAw
        KQcsAGIcTkANdw4uTnUlkYC+BrPZxEaBI7XdzLf0Nw==
X-Google-Smtp-Source: ABdhPJx7HLZK7jaTa73RkUrjpdUhNrR+ZBGuDJ1erNCEFL+MslOqX3V7V8oW+JO6oH3Lu4UeiweKvA==
X-Received: by 2002:a17:90b:4a01:: with SMTP id kk1mr15807790pjb.7.1637282008706;
        Thu, 18 Nov 2021 16:33:28 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([66.23.193.242])
        by smtp.gmail.com with ESMTPSA id k8sm574903pgj.94.2021.11.18.16.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 16:33:28 -0800 (PST)
Date:   Fri, 19 Nov 2021 08:33:17 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf cs-etm: Pass -1 as pid value for
 machine__set_current_tid()
Message-ID: <20211119003317.GD69886@leoy-ThinkPad-X240s>
References: <20211113143540.53957-1-leo.yan@linaro.org>
 <20211118171412.GB2530497@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118171412.GB2530497@p14s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Thu, Nov 18, 2021 at 10:14:12AM -0700, Mathieu Poirier wrote:
> Good morning Leo,
> 
> On Sat, Nov 13, 2021 at 10:35:40PM +0800, Leo Yan wrote:
> > Currently, cs-etm passes the tid value for both tid and pid parameters
> > when calling machine__set_current_tid(), this can lead to confusion for
> > thread handling.  E.g. we arbitrarily pass the same value for pid and
> > tid, perf tool will be misled to consider it is a main thread (see
> > thread__main_thread()).
> > 
> > On the other hand, Perf tool only can retrieve tid from Arm CoreSight
> > context packet, and we have no chance to know pid (it maps to kernel's
> > task_struct::tgid) from hardware tracing data.  For this reason, this
> > patch passes -1 as pid for function machine__set_current_tid().
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index f323adb1af85..eed1a5930072 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1118,7 +1118,7 @@ int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
> >  	if (cs_etm__get_cpu(trace_chan_id, &cpu) < 0)
> >  		return err;
> >  
> > -	err = machine__set_current_tid(etm->machine, cpu, tid, tid);
> > +	err = machine__set_current_tid(etm->machine, cpu, -1, tid);
> 
> I remember wondering about what to do with the pid parameter when I wrote this
> patch... 
> 
> Do you have a before-and-after snapshot you can add to the changelog?

I tried to capture log but I didn't observe the difference introduced
by this patch, this might because I didn't per-process mode for
multi-threading case.  I will try more case for this.

> I also think it will require a "Fixes" tag.  In your next revision please CC James
> since you guys are working in that area nowadays.

Will do.  And will Cc James and German in next spin.

Thanks for review and suggestion.

Leo
