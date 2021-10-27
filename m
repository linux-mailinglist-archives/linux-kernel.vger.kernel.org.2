Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B133D43C347
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 08:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbhJ0Gw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 02:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238398AbhJ0Gw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 02:52:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E85B610A5;
        Wed, 27 Oct 2021 06:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635317432;
        bh=fPqvyH9rDu7XomCHe97HHXFmx1217+zIxqi7oPNos1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xQf8y0/8rejCdmnUbr+A3jC74BQD9wIuIj1lvHHSZKI8l+8D7VuAL3BG9OZCHiHmS
         GH/G0rFCS4dc9c3ImjBkQOsbVvthXgwCyCkvzmSqFc84qiV0xbmvdzRKfzjjhswHtY
         f5qfyZvhQCaWRVEcPfOMVOzwqrU9ZBAXHzF7t8O0=
Date:   Wed, 27 Oct 2021 08:50:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v2] Coresight changes for v5.16
Message-ID: <YXj2trHe8XA0QtFO@kroah.com>
References: <20211026195545.3951306-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026195545.3951306-1-mathieu.poirier@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 01:55:45PM -0600, Mathieu Poirier wrote:
> The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:
> 
>   Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)
> 
> are available in the Git repository at:
> 
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v5.16

Better but I get the following errors when my scripts try to merge them.
Note, the linux-next scripts will give you the same complaint, so this
isn't a new thing:

Commit 6871138a7ab9 ("coresight: etm4x: Add ETM PID for Kryo-5XX")
	committer Signed-off-by missing
	author email:    quic_taozha@quicinc.com
	committer email: mathieu.poirier@linaro.org
	Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
	Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Commit 202d403ae3a9 ("coresight: Don't immediately close events that are run on invalid CPU/sink combos")
	committer Signed-off-by missing
	author email:    james.clark@arm.com
	committer email: mathieu.poirier@linaro.org
	Signed-off-by: James Clark <james.clark@arm.com>
	Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Commit ef095e61dc8f ("coresight: Update comments for removing cs_etm_find_snapshot()")
	committer Signed-off-by missing
	author email:    leo.yan@linaro.org
	committer email: mathieu.poirier@linaro.org
	Signed-off-by: Leo Yan <leo.yan@linaro.org>
	Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Commit 7be15eef996f ("coresight: tmc-etr: Use perf_output_handle::head for AUX ring buffer")
	committer Signed-off-by missing
	author email:    leo.yan@linaro.org
	committer email: mathieu.poirier@linaro.org
	Signed-off-by: Leo Yan <leo.yan@linaro.org>
	Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Commit 60067d5ab339 ("coresight: tmc-etf: Add comment for store ordering")
	committer Signed-off-by missing
	author email:    leo.yan@linaro.org
	committer email: mathieu.poirier@linaro.org
	Signed-off-by: Leo Yan <leo.yan@linaro.org>
	Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Commit 7c202525ff8c ("coresight: tmc-etr: Add barrier after updating AUX ring buffer")
	committer Signed-off-by missing
	author email:    leo.yan@linaro.org
	committer email: mathieu.poirier@linaro.org
	Signed-off-by: Leo Yan <leo.yan@linaro.org>
	Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Errors in tree with Signed-off-by, please fix!


Is there some reason you are committing changes to your tree and not signing
off on them?  That's not really a good idea :(

thanks,

greg k-h
