Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D381032F15A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhCERgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:36:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhCERgC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:36:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24CBE65085;
        Fri,  5 Mar 2021 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614965762;
        bh=aL6LMurCCKW74w+tJob+wucDXaXSrgeZoIYrIPI9wVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d9oZXCvaqcOo7md42i3hUVQ42zZ3VQuvvcd01TFTZh8xvXUE6/X8D0tJXJb+/J7eB
         Z50Q0W4F0JtUzbSuSw+0CvXn4NQZHSWDOqCgkD3ltkwj46NIse6rwJAbqFxiV2YMbu
         97z1UXq3a0dVhYfikelll0IWJgdbf31eFqAbHZqRB8vRooc9rq6Ue7xdOOSzPi5bpa
         zf5YA72nHgoU+14MeWzjCQP7OweEPWwsYKO6ApEpo8BZJvoradMgUPN83r5LQl3epj
         T+olmbP/e0v+685CG71q3Q4asjSvXN9NfPSxZJGP3USZjO5sqU1uTYpdLxEHdLFOWD
         Fz++M4QZHGlRw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9527940647; Fri,  5 Mar 2021 14:35:58 -0300 (-03)
Date:   Fri, 5 Mar 2021 14:35:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf metricgroup: Fix segmentation fault for metrics
 with no pmu event
Message-ID: <YEJr/nvmhYhd0XO/@kernel.org>
References: <20210202022424.10787-1-yao.jin@linux.intel.com>
 <77af7dc5-eac4-4591-cba7-8937c94a058f@huawei.com>
 <c73fff2c-8525-f496-66da-2cb4a8ccbf94@linux.intel.com>
 <efb5c6b5-6759-b0b8-b934-9d68d9f2cbf5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efb5c6b5-6759-b0b8-b934-9d68d9f2cbf5@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 03, 2021 at 08:28:23AM +0000, John Garry escreveu:
> On 03/02/2021 00:46, Jin, Yao wrote:
> > > 
> > > This should be fixed in v5.11-rc6 - please check it.
> > > 
> > > 9c880c24cb0d perf metricgroup: Fix for metrics containing duration_time
> > > 
> > > Thanks,
> > > John
> > 
> > Oh, I see, your patch is in Arnaldo's perf/urgent branch. Sorry about
> > that, I just tested Arnaldo's perf/core branch. :(
> 
> Yeah, I'm not sure on the policy to merge back/rebase there. But sorry for
> the hassle with this issue.

I merge into perf/core as soon as perf/urgent is upstream.

- Arnaldo
