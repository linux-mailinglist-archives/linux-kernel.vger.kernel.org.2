Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EE83451A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCVVQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhCVVP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616447758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cL8IkrAvZ/zpR6rx/dpaMoVEJoSiDr1kPTM/qqGWTFY=;
        b=ArQ/Rry6JgWFPBZd5Tal9vpDNbyoJrdp+dMa5tgeu+QSIkKpl4JIxSmwDmqelTXHSntBDD
        UMQ0uxgp8ids1N+Si26Izauf43Vyf6C9z+V7EDc2+v8A8bBJMXjgfOXPLZp8ZigGMPHQSw
        dyBUUYZQte/l9GIEqJgsWrezgep5g6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-q78jJv7gOdiMpIIPuREPHQ-1; Mon, 22 Mar 2021 17:15:54 -0400
X-MC-Unique: q78jJv7gOdiMpIIPuREPHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95AF210866A6;
        Mon, 22 Mar 2021 21:15:51 +0000 (UTC)
Received: from krava (unknown [10.40.195.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 71EB060C34;
        Mon, 22 Mar 2021 21:15:49 +0000 (UTC)
Date:   Mon, 22 Mar 2021 22:15:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 1/2] perf stat: Align CSV output for summary mode
Message-ID: <YFkJBD2laOM23pbk@krava>
References: <20210319070156.20394-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319070156.20394-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 03:01:55PM +0800, Jin Yao wrote:

SNIP

>   102107,,branch-misses,8012781751,100.00,4.15,of all branches
> 
> This option can be enabled in perf config by setting the variable
> 'stat.no-cvs-summary'.
> 
>   # perf config stat.no-cvs-summary=true
> 
>   # perf config -l
>   stat.no-cvs-summary=true
> 
>   # perf stat -x, -I1000 --interval-count 1 --summary
>        1.001330198,8013.28,msec,cpu-clock,8013279201,100.00,8.013,CPUs utilized
>        1.001330198,205,,context-switches,8013308394,100.00,25.583,/sec
>        1.001330198,10,,cpu-migrations,8013324681,100.00,1.248,/sec
>        1.001330198,0,,page-faults,8013340926,100.00,0.000,/sec
>        1.001330198,8027742,,cycles,8013344503,100.00,0.001,GHz
>        1.001330198,2871717,,instructions,8013356501,100.00,0.36,insn per cycle
>        1.001330198,553564,,branches,8013366204,100.00,69.081,K/sec
>        1.001330198,54021,,branch-misses,8013375952,100.00,9.76,of all branches
>   8013.28,msec,cpu-clock,8013279201,100.00,7.985,CPUs utilized
>   205,,context-switches,8013308394,100.00,25.583,/sec
>   10,,cpu-migrations,8013324681,100.00,1.248,/sec
>   0,,page-faults,8013340926,100.00,0.000,/sec
>   8027742,,cycles,8013344503,100.00,0.001,GHz
>   2871717,,instructions,8013356501,100.00,0.36,insn per cycle
>   553564,,branches,8013366204,100.00,69.081,K/sec
>   54021,,branch-misses,8013375952,100.00,9.76,of all branches
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

LGTM, for patchset:

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

