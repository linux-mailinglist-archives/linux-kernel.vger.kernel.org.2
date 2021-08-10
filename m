Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A97D3DEF96
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbhHCOBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbhHCOBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:01:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A769C061764
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:01:29 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so778271pji.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 07:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VYe459FmfkXTErN59NCMHFCl+MLvyaY1F16+cBRtvyA=;
        b=U4R2k3n2k48lS2BRwUYv76iVvyz815A6hgNrYm0rdpL3owrkeis3ox2cHOGxwnTULb
         3JWw5UmPhol7l4v0VbZPPUUGEX4QyaG8CXX5D/fmZl/TuW92zo+dQ4XtwC34QPhvnZtT
         Uxz1wPJHVORWUH6y48Brt5FBrZkfI7QJoyrigWC0wCA2K1nqEZn5czKPmsanCy8hSpkp
         RC0BIES+nR9gPex+tPgQtrdIL6mHn9tgr1Bt7ky0yfjoF6KosVcTkaj5rvJz9iJvMv1o
         o7FSD9Ri+SijuJa883XnKn1+zWeNY+9+R2l5yh7rmfCo9vtj8tJM4rebMAWB7k3i7e50
         PlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VYe459FmfkXTErN59NCMHFCl+MLvyaY1F16+cBRtvyA=;
        b=MO2x3YNe75yWdiIhdH9WJn1pNbPBIkitZ3Wpawt5SX7SG91Tj3KDpI8P6QyIGunHfN
         eBJft7cGORXgrTfAqDyxTrt6CtYTrb4dh1GsOE2EG3MLdOZnt2SHtsFdIKpDJzfyiM5S
         0Te2VRv42JBVCT9NK9BqvM2om1QbxZ5LmCKtk7Zr60fb1WIVVmsGmebzRWnnzpMidvqJ
         BbozafnIVEMLzeN+Fwib6oDVUWjMXrCxXDyaj8d1x4oD4D5dHwTMIG8PcrHyqEg5N1kk
         woMj77pXRCbq3RuRTR9MCdw9Vfmr8xaN0jkGV5m+6RP9kFo5fJE5neohQAHFHXoqX+jQ
         Hf+w==
X-Gm-Message-State: AOAM5322E6cVS2AueG67Bu9CuJ6xaYNHYQ92R+QFkqytfkZyG7SoX0nl
        r+3X4x1olmdhrr4gTgB4UqTg1g==
X-Google-Smtp-Source: ABdhPJzlGzqTO4i181dbcfsGbt7ky8G+pyW88/NT3ShzBrU98mbuEajn6etFhxKe1u8w8fsEvU/SRA==
X-Received: by 2002:a05:6a00:1a55:b029:3c3:2231:4d16 with SMTP id h21-20020a056a001a55b02903c322314d16mr5644219pfv.18.1627999288774;
        Tue, 03 Aug 2021 07:01:28 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id p20sm2904157pju.48.2021.08.03.07.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 07:01:27 -0700 (PDT)
Date:   Tue, 3 Aug 2021 22:01:22 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 6/6] perf cs-etm: Add warnings for missing DSOs
Message-ID: <20210803140122.GC247709@leoy-ThinkPad-X240s>
References: <20210729155805.2830-1-james.clark@arm.com>
 <20210729155805.2830-7-james.clark@arm.com>
 <20210802154145.GC148327@leoy-ThinkPad-X240s>
 <YQlDefz+g45dqFsP@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQlDefz+g45dqFsP@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 10:24:09AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 02, 2021 at 11:41:45PM +0800, Leo Yan escreveu:
> > On Thu, Jul 29, 2021 at 04:58:05PM +0100, James Clark wrote:
> > > Currently decode will silently fail if no binary data is available for
> > > the decode. This is made worse if only partial data is available because
> > > the decode will appear to work, but any trace from that missing DSO will
> > > silently not be generated.
> > > 
> > > Add a UI popup once if there is any data missing, and then warn in the
> > > bottom left for each individual DSO that's missing.
> > > 
> > > Signed-off-by: James Clark <james.clark@arm.com>
> > > ---
> > >  tools/perf/util/cs-etm.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > > index 32ad92d3e454..e6851260d059 100644
> > > --- a/tools/perf/util/cs-etm.c
> > > +++ b/tools/perf/util/cs-etm.c
> > > @@ -746,8 +746,16 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
> > >  
> > >  	len = dso__data_read_offset(al.map->dso, machine, offset, buffer, size);
> > >  
> > > -	if (len <= 0)
> > > +	if (len <= 0) {
> > > +		ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' to export data from the traced system.\n");
> > > +		if (!al.map->dso->auxtrace_warned) {
> > > +			pr_err("CS ETM Trace: Debug data not found for address %#"PRIx64" in %s\n",
> > > +				    address,
> > > +				    al.map->dso->long_name ? al.map->dso->long_name : "Unknown");
> > > +			al.map->dso->auxtrace_warned = true;
> > > +		}
> > 
> > This is very useful.
> > 
> > Just one comment: in particularly if the perf fails to find the kernel
> > symbols, the user needs to enable config "CONFIG_PROC_KCORE=y" or
> > specify option "-k /path/to/vmlinux".  In this case, using 'perf
> > archive' is not helpful.  So I think the UI warning can be imporved
> > like:
> > 
> >         ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' to export data from the traced system.\n"
> >                          " Enable CONFIG_PROC_KCORE or use option '-k /path/to/vmlinux' for kernel symbols\n");
> 
> one can also use debuginfod-client, which, as time passes, probably will
> be the main way of finding DSOs now that we have build-ids in
> PERF_RECORD_MMAP2 and debuginfod servers such as:
> 
> export DEBUGINFOD_URLS=https://debuginfod.fedoraproject.org/

If so, maybe should use more general description for missing DSO.

> https://fedoraproject.org/wiki/Debuginfod
>  
> > With this improvement, the patch looks good to me:
> > 
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
> Does this apply to the other 5 patches in this series?

I finished to reivew patches 01, 04, 05, 06/06, so my review tag can
apply on these patches.  Current patch 06/06 needs James to improve for
the comments.

Thanks,
Leo
