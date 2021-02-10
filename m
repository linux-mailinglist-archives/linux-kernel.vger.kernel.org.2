Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C49316C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhBJRMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:12:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231947AbhBJRLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:11:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 010A764E77;
        Wed, 10 Feb 2021 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612977072;
        bh=QsCt7T2lqx3md0Kk/pmfNyALuRx98S7Prgsfpxpjat0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=erAG6wnreljMkxYzAi49nk7IRU0rU8k+h0WvWeZHirxBWcxIj6aNRIH4NuGrJITe9
         q5hdpG695y7ceVziJEQTvLhKThL/0Tbby6miJEutl0RSl5+4B0u2YyuCM71j7oFnVm
         IRLlqs2+NBhUbFvRb3QWkkDR8v8NOfp93SN/qnek=
Date:   Wed, 10 Feb 2021 18:11:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] coresight: Patches for v5.12 (part 2)
Message-ID: <YCQTrSzWH2B/YaVr@kroah.com>
References: <20210210163610.2338491-1-mathieu.poirier@linaro.org>
 <YCQTineSi2DMPyHs@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCQTineSi2DMPyHs@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 06:10:34PM +0100, Greg KH wrote:
> On Wed, Feb 10, 2021 at 09:36:08AM -0700, Mathieu Poirier wrote:
> > Hi Greg,
> > 
> > Please see if you can add these 2 patches to your 5.12 tally.  No worries
> > if you think it is too close to the merge window, I'll simply queue them
> > for the next one.
> > 
> > Thanks,
> > Mathieu
> > 
> > Leo Yan (1):
> >   Documentation: coresight: Add PID tracing description
> > 
> > Suzuki K Poulose (1):
> >   coresight: etm-perf: Support PID tracing for kernel at EL2
> > 
> >  Documentation/trace/coresight/coresight.rst   | 32 +++++++++++++++++++
> >  .../hwtracing/coresight/coresight-etm-perf.c  | 27 +++++++++++++++-
> >  .../coresight/coresight-etm4x-core.c          | 13 ++++++++
> >  include/linux/coresight-pmu.h                 |  3 ++
> >  4 files changed, 74 insertions(+), 1 deletion(-)
> 
> This does not apply to my char-misc-next branch (the second patch does
> not apply, I'll take the first one.)  Can you fix it up and resend?

Oops, I mean the first one doesn't apply, so I'm not going to take
either.

thanks,

greg k-
