Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C00316C22
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhBJRLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:11:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhBJRLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:11:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A03E64E57;
        Wed, 10 Feb 2021 17:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612977036;
        bh=8z3OEsp9NKfuNay4ZjCe+TWdXCGEUczVdkYt0rCdCJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D8BXrhHbniEx4+PwPnlKPe/JPOMd8hxNLEBprrt65zIJ3WXLtnBAf90fZvR+O6jzD
         awyp7qz+mQHgH91J4H+/ilj+EX3CJ15fRRyft0cXk1eAC18iv+ORz973UXN+zSl8e/
         569IsHBmkptX5hcCWD6Oe90y8AN/+H0Nt1mlyOAg=
Date:   Wed, 10 Feb 2021 18:10:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] coresight: Patches for v5.12 (part 2)
Message-ID: <YCQTineSi2DMPyHs@kroah.com>
References: <20210210163610.2338491-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210163610.2338491-1-mathieu.poirier@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:36:08AM -0700, Mathieu Poirier wrote:
> Hi Greg,
> 
> Please see if you can add these 2 patches to your 5.12 tally.  No worries
> if you think it is too close to the merge window, I'll simply queue them
> for the next one.
> 
> Thanks,
> Mathieu
> 
> Leo Yan (1):
>   Documentation: coresight: Add PID tracing description
> 
> Suzuki K Poulose (1):
>   coresight: etm-perf: Support PID tracing for kernel at EL2
> 
>  Documentation/trace/coresight/coresight.rst   | 32 +++++++++++++++++++
>  .../hwtracing/coresight/coresight-etm-perf.c  | 27 +++++++++++++++-
>  .../coresight/coresight-etm4x-core.c          | 13 ++++++++
>  include/linux/coresight-pmu.h                 |  3 ++
>  4 files changed, 74 insertions(+), 1 deletion(-)

This does not apply to my char-misc-next branch (the second patch does
not apply, I'll take the first one.)  Can you fix it up and resend?

thanks,

greg k-h
