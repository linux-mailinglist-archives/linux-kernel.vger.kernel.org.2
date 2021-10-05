Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E344C422F7D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 19:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhJER6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 13:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhJER6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:58:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38C9F60F38;
        Tue,  5 Oct 2021 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633456620;
        bh=iPbB3UPu+IuyklPaQaInQtvh5gtG31PBa6E8q7kPb8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+aNc2Uz5332Vu0/WOYHkoROq2+qS2YMAGAFayyXDRtPPz8HFwlf2+5kb2nWJJIEJ
         TlDAARA51X9y131pnjed3ghz1b9zr5WLlaFxNXxnHwW4RqIHF4trlcNAK0aDAs1HL4
         exG/gdBXuGAh74l6IFSfKH1+hxXXBvfHGcCEphK4xut71/sKCXyrTpbQFa1t8Me85m
         guaahYBAUg5MmTq4+AL3jkhYFYbnItzzgzerGvSlIjiONM4XffwSpqZVB3pwH5KcWY
         x3Tdne9tLu7Sp9+5p4DAhYbzHeGRVf4N83sxSrUUhMJ5hTovXiMB5EnExzbWRwPRDV
         rRaq4V12WGjBA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D1ABA410A1; Tue,  5 Oct 2021 14:56:57 -0300 (-03)
Date:   Tue, 5 Oct 2021 14:56:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH] perf tests attr: Support Topdown metrics events
Message-ID: <YVyR6SuPuJRZIwRe@kernel.org>
References: <1633031566-176517-1-git-send-email-kan.liang@linux.intel.com>
 <YVshAMbqreNnGVnj@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVshAMbqreNnGVnj@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 04, 2021 at 05:42:56PM +0200, Jiri Olsa escreveu:
> On Thu, Sep 30, 2021 at 12:52:46PM -0700, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > The Topdown metrics events were added as perf stat default events since
> > commit 42641d6f4d15 ("perf stat: Add Topdown metrics events as default
> > events"). However, the perf attr tests were not updated accordingly.
> > 
> > The perf attr test fails on the platform which supports Topdown metrics.
> > perf test 17
> > 17: Setup struct perf_event_attr                        :FAILED!
> > 
> > Add Topdown metrics events into perf attr test cases. Make them optional
> > since they are only available on newer platforms.
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Fixes: 42641d6f4d15 ("perf stat: Add Topdown metrics events as default events")
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

