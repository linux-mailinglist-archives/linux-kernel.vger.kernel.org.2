Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0108307F69
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhA1UTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:19:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhA1USr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:18:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F148B64E02;
        Thu, 28 Jan 2021 20:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611865086;
        bh=4MV8U7BKs4OER2nUzMgvslPs/0iUhgS+km8aEV68Rdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iTkRwqrwkBWprGP4mzn5VQEdEoYBNgHdSQmN3WfqApIz8UVAJydpf4GsCXAWn2AqA
         YDbnB9el+lTt2QtKAYfm5KBTySdOyNgAiIiq4OtUayYu2lIfUiVid+WYfRKOBC9JSH
         soh7KlnpxsQibd60gSKEIOpBiHV2etXg5xnwxFe9EgVXvMl3b/2H2sS4eBJfd51Cuk
         RXa22+o8Nl6aZi1lJ7B7+sZEH3IgWCaDkU066mwJFuxLHOJcqQY+PodEw0Qg7y8Wdh
         czVnkkXyU9F55uHOeuNO0RGTjheP6+H2gRJcP/NCVXoPQyoXHooVcYNJH/D1BNcZb8
         qzCX2WqoUaLeA==
Date:   Thu, 28 Jan 2021 20:18:01 +0000
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.org, acme@kernel.org,
        mark.rutland@arm.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.clark@arm.com, linuxarm@openeuler.org,
        nakamura.shun@fujitsu.com
Subject: Re: [PATCH v2 0/4] perf vendor events arm64: Some tidy-up/refactoring
Message-ID: <20210128201801.GC3016@willie-the-truck>
References: <1611835236-34696-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611835236-34696-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 08:00:32PM +0800, John Garry wrote:
> There is much event duplication in the common and uarch events for A76
> and Ampere eMag support, so factor out into a common JSON.
> 
> Since the wording for events may differ between CPU datasheet and
> the architecture reference manual, the current wording is kept. This
> is unless there are minor differences. In addition, event names are
> renamed to be same as architecture reference manual, to keep commonality.
> 
> Also a minor fix is included for the Ampere eMag JSON.
> 
> Differences to v1:
> - tidy some ',' misplaced
> 
> John Garry (4):
>   perf vendor events arm64: Fix Ampere eMag event typo
>   perf vendor events arm64: Add common and uarch event JSON
>   perf vendor events arm64: Reference common and uarch events for Ampere
>     eMag
>   perf vendor events arm64: Reference common and uarch events for A76

For the series:

Acked-by: Will Deacon <will@kernel.org>

Will
