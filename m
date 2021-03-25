Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C92834923D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhCYMk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230182AbhCYMke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:40:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E20DF61A17;
        Thu, 25 Mar 2021 12:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616676034;
        bh=S2vO/qvUTFHMvhduNIcSVXgSO71MdQmguTMFBzhHSR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mfS7CiYdyv9T6/pycpPiumGGUrEjjg6x+pxAlPrHNQ339NhUnPt/T0yN9unFQM9sC
         qiiEWo2Xgi2SgmqNKjcok+JcWubzdz4tTynrxXdOcAMaRXy4C8OslYLMZUWrZNiowf
         OfEu0Ewg1GzWND1X4EJTv6lQ1aczr2glG+JzqMaq/ViB5Qd6EkEwbMP9CJXKqI2ohD
         tj/1vEsDz7L/sdWDPAMGepybVj0lFACF44RgdOo6Hqd7QSifll6btO3jBVIlS3koCg
         RqLYWhu8Cq1XH5h0TdUIG4jVcJj0V/ah5ZOeYgAPfLqDxd+UNmWbEiVgZEWRIcRIUn
         WCI5sDupCg7Ug==
Date:   Thu, 25 Mar 2021 12:40:28 +0000
From:   Will Deacon <will@kernel.org>
To:     Gon Solo <gonsolo@gmail.com>
Cc:     John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andreas Wendleder <andreas.wendleder@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Perf: Clean generated directory, other archs.
Message-ID: <20210325124027.GA14551@willie-the-truck>
References: <20210307101942.254366-1-gonsolo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307101942.254366-1-gonsolo@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 11:19:42AM +0100, Gon Solo wrote:
> After a make clean there are generated directories left in the arch
> directories of perf. Clean them up.
> 
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Andreas Wendleder <andreas.wendleder@gmail.com>
> ---
>  tools/perf/arch/arm64/Makefile   | 5 +++--
>  tools/perf/arch/powerpc/Makefile | 5 +++--
>  tools/perf/arch/s390/Makefile    | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)

For arm64:

Acked-by: Will Deacon <will@kernel.org>

Will
