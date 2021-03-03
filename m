Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D242132BFFE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386384AbhCCSOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:14:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230455AbhCCPqm (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:46:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5142E64EE3;
        Wed,  3 Mar 2021 15:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614786341;
        bh=Uztb3V5t1uv1l7fFRkll6pv7RzKcCHjqQDl33IP+Al0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EceJCyuXMg8eobQduEk/AfhNdWCf4dKT1O+9P8qFd9pO0o+tMQX78KMembGFCR2lv
         S/r3tsEmkX+oXk89k8pMA558cuZiKJfel2Du+XnBpXQp36Goo8n8MMCDbEoD9b1sGm
         UDX+iBsnj37pzYfVoivFF9oFM6qUAN0F0S6s3zihe6Mh7VfgnU6u9sExMH/BSvWcnS
         SRP2bt2wCBm7+t12eDaOyj34ukDYonxjyCUGPmSVN68f2kIdKJEC76+rJBxRw63FeL
         2tfN3v93ax+2mK5auNlm0Nv3E3Nh6inSO2Dyy5AwVUaZRdw6YNa9XZJ0cooBWgspFB
         S6HNN7Y7YnbLQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1F7C840CD9; Wed,  3 Mar 2021 12:45:39 -0300 (-03)
Date:   Wed, 3 Mar 2021 12:45:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        ying.huang@intel.com
Subject: Re: [PATCH v9] perf stat: Fix wrong skipping for per-die aggregation
Message-ID: <YD+vI+WuSCjX6dWu@kernel.org>
References: <20210128013417.25597-1-yao.jin@linux.intel.com>
 <YBcuvN106bsa7F+9@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBcuvN106bsa7F+9@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 31, 2021 at 11:27:08PM +0100, Jiri Olsa escreveu:
> On Thu, Jan 28, 2021 at 09:34:17AM +0800, Jin Yao wrote:
> > Uncore becomes die-scope on Xeon Cascade Lake-AP and perf has supported
> > --per-die aggregation yet.
> > 
> > One issue is found in check_per_pkg() for uncore events running on
> > AP system. On cascade Lake-AP, we have:
> > 
> > S0-D0
> > S0-D1
> > S1-D0
> > S1-D1
> > 
> > But in check_per_pkg(), S0-D1 and S1-D1 are skipped because the
> > mask bits for S0 and S1 have been set for S0-D0 and S1-D0. It doesn't
> > check die_id. So the counting for S0-D1 and S1-D1 are set to zero.
> > That's not correct.
> > 
> > root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
> >      1.001460963 S0-D0           1            1317376 Bytes llc_misses.mem_read
> >      1.001460963 S0-D1           1             998016 Bytes llc_misses.mem_read
> >      1.001460963 S1-D0           1             970496 Bytes llc_misses.mem_read
> >      1.001460963 S1-D1           1            1291264 Bytes llc_misses.mem_read
> >      2.003488021 S0-D0           1            1082048 Bytes llc_misses.mem_read
> >      2.003488021 S0-D1           1            1919040 Bytes llc_misses.mem_read
> >      2.003488021 S1-D0           1             890752 Bytes llc_misses.mem_read
> >      2.003488021 S1-D1           1            2380800 Bytes llc_misses.mem_read
> >      3.005613270 S0-D0           1            1126080 Bytes llc_misses.mem_read
> >      3.005613270 S0-D1           1            2898176 Bytes llc_misses.mem_read
> >      3.005613270 S1-D0           1             870912 Bytes llc_misses.mem_read
> >      3.005613270 S1-D1           1            3388608 Bytes llc_misses.mem_read
> >      4.007627598 S0-D0           1            1124608 Bytes llc_misses.mem_read
> >      4.007627598 S0-D1           1            3884416 Bytes llc_misses.mem_read
> >      4.007627598 S1-D0           1             921088 Bytes llc_misses.mem_read
> >      4.007627598 S1-D1           1            4451840 Bytes llc_misses.mem_read
> >      5.001479927 S0-D0           1             963328 Bytes llc_misses.mem_read
> >      5.001479927 S0-D1           1            4831936 Bytes llc_misses.mem_read
> >      5.001479927 S1-D0           1             895104 Bytes llc_misses.mem_read
> >      5.001479927 S1-D1           1            5496640 Bytes llc_misses.mem_read
> > 
> > From above output, we can see S0-D1 and S1-D1 don't report the interval
> > values, they are continued to grow. That's because check_per_pkg() wrongly
> > decides to use zero counts for S0-D1 and S1-D1.
> > 
> > So in check_per_pkg(), we should use hashmap(socket,die) to decide if
> > the cpu counts needs to skip. Only considering socket is not enough.
> > 
> > Now with this patch,
> > 
> > root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
> >      1.001586691 S0-D0           1            1229440 Bytes llc_misses.mem_read
> >      1.001586691 S0-D1           1             976832 Bytes llc_misses.mem_read
> >      1.001586691 S1-D0           1             938304 Bytes llc_misses.mem_read
> >      1.001586691 S1-D1           1            1227328 Bytes llc_misses.mem_read
> >      2.003776312 S0-D0           1            1586752 Bytes llc_misses.mem_read
> >      2.003776312 S0-D1           1             875392 Bytes llc_misses.mem_read
> >      2.003776312 S1-D0           1             855616 Bytes llc_misses.mem_read
> >      2.003776312 S1-D1           1             949376 Bytes llc_misses.mem_read
> >      3.006512788 S0-D0           1            1338880 Bytes llc_misses.mem_read
> >      3.006512788 S0-D1           1             920064 Bytes llc_misses.mem_read
> >      3.006512788 S1-D0           1             877184 Bytes llc_misses.mem_read
> >      3.006512788 S1-D1           1            1020736 Bytes llc_misses.mem_read
> >      4.008895291 S0-D0           1             926592 Bytes llc_misses.mem_read
> >      4.008895291 S0-D1           1             906368 Bytes llc_misses.mem_read
> >      4.008895291 S1-D0           1             892224 Bytes llc_misses.mem_read
> >      4.008895291 S1-D1           1             987712 Bytes llc_misses.mem_read
> >      5.001590993 S0-D0           1             962624 Bytes llc_misses.mem_read
> >      5.001590993 S0-D1           1             912512 Bytes llc_misses.mem_read
> >      5.001590993 S1-D0           1             891200 Bytes llc_misses.mem_read
> >      5.001590993 S1-D1           1             978432 Bytes llc_misses.mem_read
> > 
> > On no-die system, die_id is 0, actually it's hashmap(socket,0), original behavior
> > is not changed.
> > 
> > Reported-by: Huang Ying <ying.huang@intel.com>
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > ---
> > v9:
> >  Rename zero_per_pkg to evsel__zero_per_pkg and move it to evsel.c. Then
> >  evsel__zero_per_pkg can be called under different code path.
> > 
> >  Call evsel__zero_per_pkg in evsel__exit().
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

