Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E4F3C7110
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbhGMNNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbhGMNNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:13:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04ECC0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:10:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x16so19517859pfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VUU1Kwvq4GBakNNijA9o5ryuRCyw2WYxhJlpoTQmeDM=;
        b=F+19KqtKCMQP1/ZSGE0pKtTbAbaCy4Gy7dSnmcaKh6mlDPZcmZADNKNXMBl1BLmlgg
         fZEIrUhlTvD7ckmpRogdtNLrBgnsfug/fOz+izrAXCsBuGI0/sPaY1OJSok69hUjj9lv
         rVa5k8mLIVa4jvPEJ/12PMQYklfYqi7MASgtBYjPMYm9G1Evcn8hc8ckbGazly6vZYrR
         KwSrAj6hX0hr10iW7gIiUYzTx0HPlx4pYE0rPAQEtcRdax8KMDMXvkJD7TZ5c0qThQhg
         ehU1tXHaV5gJ7HbpAbO+ZJBWKRlgnzFrhikl7SigIricfVFBHxVVlvXoZZdzM1zalEFs
         QzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VUU1Kwvq4GBakNNijA9o5ryuRCyw2WYxhJlpoTQmeDM=;
        b=sehHIX1RLb1vZiVoh8thQig4y7xO7+xvUZP8iA5q+0R4HjLk6U4iofKihVz753JIZx
         xyiuESu7ZCXf29FAub1TdbqUGeBsry0vFofsQOzWgsCUEHNX3B0/fDMcX7WVlHcXYaZ+
         rspmZR6ZwxqhA0mUVkhojoqj+cnqgnnbSsT6wpkSosMOcp6BBGQesG7GLHf6HhrDVnOy
         JOlJlKz0yupWFnLcAPKZWbjalqC8MmaaaK5U2jWJSpJ8O562CvtqJAUVHB/IWZMvguqf
         V5LuJUhGMjOhZAphu0v9OsG/wVzaYdz7IB+D6r5zyXzVnfzc17jyfpykrK4OKvDJeOf4
         ZP7Q==
X-Gm-Message-State: AOAM533kS1dsLhDWNoH74mkrDtKg4cNA8P5UDwkT38rzGaRxMieS0h2p
        f4RxnZlx9T9Kll5LsUF7ePOvO6BnE/9aVmOp
X-Google-Smtp-Source: ABdhPJwPLGUmEVAkt/uYOyw07UUtKM7cvXZoj28ALl+IDI3I8DSEq4m+ESyjcRWzcjoCA9/lSdUCog==
X-Received: by 2002:a63:d709:: with SMTP id d9mr4258879pgg.337.1626181825205;
        Tue, 13 Jul 2021 06:10:25 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.131.71.237])
        by smtp.gmail.com with ESMTPSA id z13sm4449296pfn.94.2021.07.13.06.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 06:10:24 -0700 (PDT)
Date:   Tue, 13 Jul 2021 21:10:18 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 07/11] perf auxtrace: Remove
 auxtrace_mmap__read_snapshot_head()
Message-ID: <20210713131018.GB748506@leoy-ThinkPad-X240s>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-8-leo.yan@linaro.org>
 <4c65b6ba-2258-ff36-2ecc-92219e61e578@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c65b6ba-2258-ff36-2ecc-92219e61e578@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 05:32:11PM +0300, Adrian Hunter wrote:

[...]

> > --- a/tools/perf/util/auxtrace.c
> > +++ b/tools/perf/util/auxtrace.c
> > @@ -1686,13 +1686,12 @@ static int __auxtrace_mmap__read(struct mmap *map,
> >  	union perf_event ev;
> >  	void *data1, *data2;
> >  
> > +	head = auxtrace_mmap__read_head(mm);
> > +
> >  	if (snapshot) {
> > -		head = auxtrace_mmap__read_snapshot_head(mm);
> >  		if (auxtrace_record__find_snapshot(itr, mm->idx, mm, data,
> >  						   &head, &old))
> 
> That leaves a nested 'if' which is not kernel style i.e. could be
> 
> 	if (snapshot &&
> 	    auxtrace_record__find_snapshot(itr, mm->idx, mm, data, &head, &old))

Will refine in next spin, thanks for suggestion!

> >  			return -1;
> > -	} else {
> > -		head = auxtrace_mmap__read_head(mm);
> >  	}
> >  
> >  	if (old == head)
