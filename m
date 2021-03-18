Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E46340E67
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhCRTjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232674AbhCRTjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:39:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F343564E41;
        Thu, 18 Mar 2021 19:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616096365;
        bh=mTVxZHLII8Mk0b/8LXblonuHkjixS7jN/ITHKTh9oTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cVYQ+A+p7FHhZGhXvbVE9Hz7N6XqtKpsbMHbR2SpAYK2YDNH9F+EMAN3cqgL6+mXX
         LROkea3XgzwMKrCycOWWoFrotSYr4WrjoTPUXX1sb8Zb3gmyMuBozVL07uF7VV1cuv
         EcpHo1aACBlMyWnCrX6SR3MxAgSZi4vN7y6linOo6YFyOGNiQ224/BnTmJAyqFBbbL
         5JcaFhWgi7KMDuaJySBVsLjKv80qySMGG0glpvR/n3ZFNbPwxcG7BOo1adP2JGYARc
         aXK5Dn04DDJE4YRxoDEH8pnt7kI+S3Hup5IcxgSzQtw42oK1w1iWjnZQJ6NC6Sd66N
         nHe192rs4yvYw==
Date:   Thu, 18 Mar 2021 21:38:59 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com
Subject: Re: [PATCH 0/3] static_call() vs __exit fixes
Message-ID: <YFOsUztBWZo5oM2a@kernel.org>
References: <20210318113156.407406787@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318113156.407406787@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 12:31:56PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> After more poking a new set of patches to fix static_call() vs __exit
> functions. These patches replace the patch I posted yesterday:
> 
>   https://lkml.kernel.org/r/YFH6BR61b5GK8ITo@hirez.programming.kicks-ass.net
> 
> Since I've reproduced the problem locally, and these patches do seem to fully
> cure things, I'll shortly queue them for tip/locking/urgent.

For all:

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkkko
