Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACF742C039
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhJMMmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhJMMmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:42:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BB0860EBB;
        Wed, 13 Oct 2021 12:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634128819;
        bh=b/pPEx0ey4x7fKozl7x8vGohle8yRo4JKIaeZWIr5OI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGuVbv+UqZlipVY+rZPFc2XQ0sGnb3USQrXkLAcFYDgAM5zQvyumMDbFusfj3511M
         Bf1GYXxRKvSsPFcL1oESeb3n5NtaSgRRFvFuHUl1Eyg1gwNQYAAFAZ3cPeQo3FVsqI
         yvkBZ/hexRFL2Zocp10MKPV0cYIege8W/OtfRHa4=
Date:   Wed, 13 Oct 2021 14:40:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dyndbg: refine verbosity 1-4 summary-detail
Message-ID: <YWbTsfXB7mq/z7qq@kroah.com>
References: <20211012183310.1016678-1-jim.cromie@gmail.com>
 <20211012183310.1016678-3-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012183310.1016678-3-jim.cromie@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 12:33:07PM -0600, Jim Cromie wrote:
> adjust current v*pr_info() calls to fit an overview..detail scheme:
> 
> -1 module level activity: add/remove, etc
> -2 command ingest, splitting, summary of effects.
>    per >control write
> -3 command parsing, 6 vpr-infos changed to this.
> -4 per-site change - was v2, too noisy there.
>    can yield 3k logs per command.
> 
> -2 is new, to isolate a problem where a stress-test script (which
> feeds large multi-command strings) would produce short writes,
> truncating last command and causing parsing errors, which confused
> test results.  The 1st fix was to use syswrite in the script, to
> deliver full proper commands.
> 
> -4 gets per-callsite "changed:" pr-infos, which are very noisy during
> stress tests, and formerly obscured v1-3 messages, and dominated the
> static-key workload being tested.
> 
> The verbose parameter has previously seen adjustment:
> commit 481c0e33f1e7 ("dyndbg: refine debug verbosity; 1 is basic, 2 more chatty")
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Where is this being documented?  How do we know what these different
"levels" mean?

thanks,

greg k-h
