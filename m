Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BB6318BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhBKNOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:14:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhBKMzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:55:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84B3464E2E;
        Thu, 11 Feb 2021 12:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613048078;
        bh=+kGqLknISucOy4pNMTX8b5QT1DVhpmo3ucezgnkEk/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bt4yDDjUeoFd3GzryrZWCdBQLcWSE3OjSUF3+Q6xN8dchNFYgoiCW3fTAcnas6rvg
         Gb/O9b6GnGST28UyiRsVJsEqDV40DKfUXRWLCT3TEFJq8FDb5VVmPqVN/SgJbCI7KD
         z/nzwDJIogArwWFAURKZ7179mEvNPXn+5iTUay4s8IF+LDl1EirqM1XNzcUMrPi+vN
         arfqh8VHyFbq6A5k+NRCA/5oUox7aDGJe9XKcWMWjkJCH1DarzCSx/JwRD6PPtLNUb
         sPupiUUYaeHir0XGjb6bL7WZwZvdTY11GJd7DVNJKZt9lUt8wcHqBAQlfStTqNzjRy
         6pJqzZTJStutw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 18C3540513; Thu, 11 Feb 2021 09:54:36 -0300 (-03)
Date:   Thu, 11 Feb 2021 09:54:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] perf: Replace lkml.org links with lore
Message-ID: <20210211125436.GB1131885@kernel.org>
References: <20210210234220.2401035-1-keescook@chromium.org>
 <YCUCxyBVkWO0GTg0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCUCxyBVkWO0GTg0@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 11, 2021 at 11:11:19AM +0100, Peter Zijlstra escreveu:
> On Wed, Feb 10, 2021 at 03:42:19PM -0800, Kees Cook wrote:
> > As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
> > links with lore"), replace lkml.org links with lore to better use a
> > single source that's more likely to stay available long-term.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks, applied.

- Arnaldo
