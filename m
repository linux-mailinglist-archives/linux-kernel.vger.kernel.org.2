Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5AC4316DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhJRLKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhJRLKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:10:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE44C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 04:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G5Cu0qEBL4VFE/qKE/uyMI2QAvj/eVnrcPAfSn5b3xg=; b=U2nv7UTJR2aVCCKvSp31a4r/rY
        6LkR+LfXoYBqfhMXEIzxqU42ApVBguBdYUhLK06W5EbPj+rekuZr0+VKwIqDcWpO4xMdZxWXWTIBc
        uq6oVokraHjVNPend+8swk57BjEGgZ8bXSGkTu6TAPaw/wrmOVl1NJtidgK4sKVLmuKy9a0LQeOog
        4s7N/b3boWDWx/dGWLas18nkZcxhqmlXyKIhQyVt343DTdfkh9WmZSKYm3zquDdP0UntlYydzI7Ya
        C+ixP52gg1fgpn501sA3kdaPGOAEsRNnfdX3EkcZ2FKdUZqTSrfHTT9834V7X5x/bn7StRboXBqGl
        If/lOTZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcQUl-00AXK6-Dp; Mon, 18 Oct 2021 11:07:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E818730024D;
        Mon, 18 Oct 2021 13:07:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8CB7286E0A07; Mon, 18 Oct 2021 13:07:54 +0200 (CEST)
Date:   Mon, 18 Oct 2021 13:07:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maddy@linux.vnet.ibm.com" <maddy@linux.vnet.ibm.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "eranian@google.com" <eranian@google.com>
Subject: Re: [V2] perf/core: Avoid calling perf_mux_hrtimer_restart multiple
 times when scheduling event groups
Message-ID: <YW1ViqOYaVi8NnqE@hirez.programming.kicks-ass.net>
References: <20211015070403.4809-1-atrajeev@linux.vnet.ibm.com>
 <6E561141-B584-4DB8-A33E-BCD3FF572FA4@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6E561141-B584-4DB8-A33E-BCD3FF572FA4@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 01:08:04AM +0000, Song Liu wrote:
> 
> 
> > On Oct 15, 2021, at 12:04 AM, Athira Rajeev <atrajeev@linux.vnet.ibm.com> wrote:
> > 
> > Perf uses multiplexing if there are more events to be scheduled than the
> > available counters. With multiplexing, event groups will be rotated at
> > specified interval of time which is set using "hrtimer". During event
> > scheduling, if any of the event group fails to schedule, multiplexing
> > gets enabled by setting "rotate_necessary" for that event context and
> > starting the hrtimer by calling "perf_mux_hrtimer_restart".
> > 
> > Patch adds an optimisation to avoid calling "perf_mux_hrtimer_restart"
> > multiple times if already rotate_necessary is set for that context.
> > Even though "perf_mux_hrtimer_restart" will just return if hrtimer is
> > already active, this could avoid the overhead of calling this function
> > multiple times if there are many event groups. Patch adds the check to
> > avoid calling perf_mux_hrtimer_restart() for each event group on
> > every schedule.
> > 
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> 
> Acked-by: Song Liu <song@kernel.org>

Thanks!
