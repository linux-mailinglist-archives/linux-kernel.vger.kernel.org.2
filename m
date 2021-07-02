Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21553BA063
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhGBMdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232051AbhGBMdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:33:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15680613C7;
        Fri,  2 Jul 2021 12:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625229034;
        bh=rOf2DBtg53PM6qdDIGYjC34kIW3KxmNQDyQcxwSMBAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hditZncX8oeuZ03UxXTlTTQnSrCvj5SuiV6lyWVyDa0LP54ovRzrjFeAb1bGC1L5d
         4kFMsQoq8fgMcFT5mg5JgOVVmbzcbfjqGshm1sy5/H1RzR5ftMphmwqqJQWXAMhmX4
         x0tXDS1ZvdSOMMztsOhk8xfg6K/O5vYbaLsrFUiZUGXBKlLKZAOMID4+Si6JTt+Ew8
         qzxB5Rb4k+5Ns2chEPhbS+nJ2aOoCO5KIefAW0wkCd4ee99BiKaZ2JPK2vxv24k5UV
         r2XxZDNPS8iacpkTW1Jm8G5xYUtmgZLAY93IsnsJrS3RkWiG7CW/mHgdZnZRrwRkrl
         e6WuOtthMbHRA==
Date:   Fri, 2 Jul 2021 14:30:32 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>
Subject: Re: [patch 0/5] optionally sync per-CPU vmstats counter on return to
 userspace
Message-ID: <20210702123032.GA72061@lothringen>
References: <20210701210336.358118649@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701210336.358118649@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 06:03:36PM -0300, Marcelo Tosatti wrote:
> The logic to disable vmstat worker thread, when entering
> nohz full, does not cover all scenarios. For example, it is possible
> for the following to happen:
> 
> 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> 2) app runs mlock, which increases counters for mlock'ed pages.
> 3) start -RT loop
> 
> Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> the mlock, vmstat shepherd can restart vmstat worker thread on
> the CPU in question.
>  
> To fix this, optionally sync the vmstat counters when returning
> from userspace, controllable by a new "vmstat_sync" isolcpus
> flags (default off).

Wasn't the plan for such finegrained isolation features to do it at
the per task level using prctl()?

Thanks.

> 
> See individual patches for details.
> 
> 
