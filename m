Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F3A32D79A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbhCDQXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbhCDQWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:22:54 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78185C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 08:22:14 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q204so18237147pfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 08:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/KqSTuRGvBZZfU9/Tuxxq5dN7bLMCDTOxPwoR3kZ0qA=;
        b=gPpDDRjjfrld0SN74QG3Msr8U0vE+ZrmZyHG+qVbIR1eTDrd5tPDPRxL8nF+vK/Jnh
         Sy80yOeN0qY2zGLK/Zg6b9H3JFcvWa61tEVTUou3N7gJH5ekrxjY1cug+K6j28B5plFS
         X1pSxL2cH0ESoQaHJzbz2ruLIYLkWdhAWK4PciRVdSQXtoCAVqz6IHRAmZkSHmOuMugj
         MGrhI3TFTKvcG7zx14Zdbz0QdrKW9plETDMAuaXg2nD437O3eIK2H/SG4u3t5eOpcQJC
         lm1B+8xhSsgBdCmZXz2FoI3UV8rmJhWaXKlSVWbO4+NDw6xlzp2yRXYY+EWGOrsWqBli
         8BPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/KqSTuRGvBZZfU9/Tuxxq5dN7bLMCDTOxPwoR3kZ0qA=;
        b=j9NqDx2HEeX/ZCqMMIAUvmIp3ASMKbnuqFcidiOAKHdVaTVWBnPJpZO3A7VzFC/ryC
         o6U9GYE5V2usrIWDV+gLJ0KviEUBReflq8m4fyaZlGOCyFF0m+EqImpvd6NvD62QqqMA
         qTlpk+afez93g6JQuBWOV56NBLX6a9LlI/uWXEtRYBVcT/yilieEf4Ga5VVyxBRmSEHY
         4SAPTf/8nJjRCTO49Ap7yXsFpPct+2+0LQX7oYbL/k0N3nlrAJLy8HkHmgLt/GIBA2yh
         8zVGLusjdq1rd371C5VcOFzwqpNcvBvQ8RKF1gwhew4St/uMfJGNrIPuwa8oN+QpYXPe
         I6Mg==
X-Gm-Message-State: AOAM533bk2O+5kSxKRD28zW4tqR5oXT5RIjH4gEA5pT1Z9ujT3ohic6m
        X8h0qNHJGT4wFxyayJ57ofs=
X-Google-Smtp-Source: ABdhPJzN4N4C4yfwhp0A/u6uQUgID7aRFY6103k61gbQj8BpKABeDqfrJuo7YYRvNZMWJD1G2VmyJA==
X-Received: by 2002:a63:4442:: with SMTP id t2mr4119280pgk.23.1614874934022;
        Thu, 04 Mar 2021 08:22:14 -0800 (PST)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id e10sm10536717pgd.63.2021.03.04.08.22.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Mar 2021 08:22:13 -0800 (PST)
Date:   Thu, 4 Mar 2021 16:22:09 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf stat: improve readability of shadow stats
Message-ID: <20210304162208.imn4vjjaf2hevxz3@mail.google.com>
References: <20210301172402.6794-1-changbin.du@gmail.com>
 <YD0+OAH9Ytii3b3V@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD0+OAH9Ytii3b3V@krava>
User-Agent: NeoMutt/20180716-508-7c9a6d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 08:19:20PM +0100, Jiri Olsa wrote:
> On Tue, Mar 02, 2021 at 01:24:02AM +0800, Changbin Du wrote:
> > This does follow two changes:
> >   1) Select appropriate unit between K/M/G.
> >   2) Use 'cpu-sec' instead of 'sec' to state this is not the wall-time.
> > 
> > $ sudo ./perf stat -a -- sleep 1
> > 
> > Before: Unit 'M' is selected even the number is very small.
> >  Performance counter stats for 'system wide':
> > 
> >           4,003.06 msec cpu-clock                 #    3.998 CPUs utilized
> >             16,179      context-switches          #    0.004 M/sec
> >                161      cpu-migrations            #    0.040 K/sec
> >              4,699      page-faults               #    0.001 M/sec
> >      6,135,801,925      cycles                    #    1.533 GHz                      (83.21%)
> >      5,783,308,491      stalled-cycles-frontend   #   94.26% frontend cycles idle     (83.21%)
> >      4,543,694,050      stalled-cycles-backend    #   74.05% backend cycles idle      (66.49%)
> >      4,720,130,587      instructions              #    0.77  insn per cycle
> >                                                   #    1.23  stalled cycles per insn  (83.28%)
> >        753,848,078      branches                  #  188.318 M/sec                    (83.61%)
> >         37,457,747      branch-misses             #    4.97% of all branches          (83.48%)
> > 
> >        1.001283725 seconds time elapsed
> > 
> > After:
> > $ sudo ./perf stat -a -- sleep 2
> > 
> >  Performance counter stats for 'system wide':
> > 
> >           8,003.20 msec cpu-clock                 #    3.998 CPUs utilized
> >              9,768      context-switches          #    1.221 K/cpu-sec
> >                164      cpu-migrations            #   20.492  /cpu-sec
> 
> should you remove also the leading '/' in ' /cpu-sec' ?
> 
> 
> SNIP
> 
> > @@ -1270,18 +1271,14 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >  		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
> >  				evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
> >  	} else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {
> > -		char unit = 'M';
> > +		char unit = ' ';
> >  		char unit_buf[10];
> >  
> >  		total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);
> > -
> >  		if (total)
> > -			ratio = 1000.0 * avg / total;
> > -		if (ratio < 0.001) {
> > -			ratio *= 1000;
> > -			unit = 'K';
> > -		}
> > -		snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
> > +			ratio = convert_unit_double(1000000000.0 * avg / total, &unit);
> > +
> > +		snprintf(unit_buf, sizeof(unit_buf), "%c/cpu-sec", unit);
> >  		print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
> 
> hum this will change -x output that people parse, so I don't think we can do that
okay, so skip this change and keep another.

-- 
Cheers,
Changbin Du
