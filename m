Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0734F309F3E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 23:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhAaW3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 17:29:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhAaW2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 17:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612132038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vXexTKRib8BnpafoLTxdXdc/flCe03J50q0l1UI9szk=;
        b=GNWPH3ahebfFVFJUMgt8wGJUHXM90jXsRqkibVcoSBSU/2NxJVWhuLvDWZSKJ5oYHeUU8F
        2cTbCUqLabHjT7rav/WId9ioN6AZWupFDxXN9K1Xt9BBjVH+PTHUJo+nT5QTE1FYe6SU3a
        bxMPLHu8842X02Dv8uGmu4AOBRi5PY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-FSHJc7gdPZauGKVBxiJI1Q-1; Sun, 31 Jan 2021 17:27:14 -0500
X-MC-Unique: FSHJc7gdPZauGKVBxiJI1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 139E6180E476;
        Sun, 31 Jan 2021 22:27:12 +0000 (UTC)
Received: from krava (unknown [10.40.192.85])
        by smtp.corp.redhat.com (Postfix) with SMTP id B9F5962462;
        Sun, 31 Jan 2021 22:27:09 +0000 (UTC)
Date:   Sun, 31 Jan 2021 23:27:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com
Subject: Re: [PATCH v9] perf stat: Fix wrong skipping for per-die aggregation
Message-ID: <YBcuvN106bsa7F+9@krava>
References: <20210128013417.25597-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128013417.25597-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 09:34:17AM +0800, Jin Yao wrote:
> Uncore becomes die-scope on Xeon Cascade Lake-AP and perf has supported
> --per-die aggregation yet.
> 
> One issue is found in check_per_pkg() for uncore events running on
> AP system. On cascade Lake-AP, we have:
> 
> S0-D0
> S0-D1
> S1-D0
> S1-D1
> 
> But in check_per_pkg(), S0-D1 and S1-D1 are skipped because the
> mask bits for S0 and S1 have been set for S0-D0 and S1-D0. It doesn't
> check die_id. So the counting for S0-D1 and S1-D1 are set to zero.
> That's not correct.
> 
> root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
>      1.001460963 S0-D0           1            1317376 Bytes llc_misses.mem_read
>      1.001460963 S0-D1           1             998016 Bytes llc_misses.mem_read
>      1.001460963 S1-D0           1             970496 Bytes llc_misses.mem_read
>      1.001460963 S1-D1           1            1291264 Bytes llc_misses.mem_read
>      2.003488021 S0-D0           1            1082048 Bytes llc_misses.mem_read
>      2.003488021 S0-D1           1            1919040 Bytes llc_misses.mem_read
>      2.003488021 S1-D0           1             890752 Bytes llc_misses.mem_read
>      2.003488021 S1-D1           1            2380800 Bytes llc_misses.mem_read
>      3.005613270 S0-D0           1            1126080 Bytes llc_misses.mem_read
>      3.005613270 S0-D1           1            2898176 Bytes llc_misses.mem_read
>      3.005613270 S1-D0           1             870912 Bytes llc_misses.mem_read
>      3.005613270 S1-D1           1            3388608 Bytes llc_misses.mem_read
>      4.007627598 S0-D0           1            1124608 Bytes llc_misses.mem_read
>      4.007627598 S0-D1           1            3884416 Bytes llc_misses.mem_read
>      4.007627598 S1-D0           1             921088 Bytes llc_misses.mem_read
>      4.007627598 S1-D1           1            4451840 Bytes llc_misses.mem_read
>      5.001479927 S0-D0           1             963328 Bytes llc_misses.mem_read
>      5.001479927 S0-D1           1            4831936 Bytes llc_misses.mem_read
>      5.001479927 S1-D0           1             895104 Bytes llc_misses.mem_read
>      5.001479927 S1-D1           1            5496640 Bytes llc_misses.mem_read
> 
> From above output, we can see S0-D1 and S1-D1 don't report the interval
> values, they are continued to grow. That's because check_per_pkg() wrongly
> decides to use zero counts for S0-D1 and S1-D1.
> 
> So in check_per_pkg(), we should use hashmap(socket,die) to decide if
> the cpu counts needs to skip. Only considering socket is not enough.
> 
> Now with this patch,
> 
> root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
>      1.001586691 S0-D0           1            1229440 Bytes llc_misses.mem_read
>      1.001586691 S0-D1           1             976832 Bytes llc_misses.mem_read
>      1.001586691 S1-D0           1             938304 Bytes llc_misses.mem_read
>      1.001586691 S1-D1           1            1227328 Bytes llc_misses.mem_read
>      2.003776312 S0-D0           1            1586752 Bytes llc_misses.mem_read
>      2.003776312 S0-D1           1             875392 Bytes llc_misses.mem_read
>      2.003776312 S1-D0           1             855616 Bytes llc_misses.mem_read
>      2.003776312 S1-D1           1             949376 Bytes llc_misses.mem_read
>      3.006512788 S0-D0           1            1338880 Bytes llc_misses.mem_read
>      3.006512788 S0-D1           1             920064 Bytes llc_misses.mem_read
>      3.006512788 S1-D0           1             877184 Bytes llc_misses.mem_read
>      3.006512788 S1-D1           1            1020736 Bytes llc_misses.mem_read
>      4.008895291 S0-D0           1             926592 Bytes llc_misses.mem_read
>      4.008895291 S0-D1           1             906368 Bytes llc_misses.mem_read
>      4.008895291 S1-D0           1             892224 Bytes llc_misses.mem_read
>      4.008895291 S1-D1           1             987712 Bytes llc_misses.mem_read
>      5.001590993 S0-D0           1             962624 Bytes llc_misses.mem_read
>      5.001590993 S0-D1           1             912512 Bytes llc_misses.mem_read
>      5.001590993 S1-D0           1             891200 Bytes llc_misses.mem_read
>      5.001590993 S1-D1           1             978432 Bytes llc_misses.mem_read
> 
> On no-die system, die_id is 0, actually it's hashmap(socket,0), original behavior
> is not changed.
> 
> Reported-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
> v9:
>  Rename zero_per_pkg to evsel__zero_per_pkg and move it to evsel.c. Then
>  evsel__zero_per_pkg can be called under different code path.
> 
>  Call evsel__zero_per_pkg in evsel__exit().

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

