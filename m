Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA6E39B50A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFDInc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhFDInc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:43:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0764761358;
        Fri,  4 Jun 2021 08:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622796106;
        bh=/78HkMXdp/BYRaD+gNhxW4gej7SZMxkqGiWkOR0DKWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b25rXbtQyega7nd7MsUImqLG7K8/+B3QuRUPbx8FjnvtMKrXwlCR9hgkI5WyJZQ6m
         crwMaD33/seD/j/Wt6W8e/RDhFflqxGqN+R6Ef65pE6EXguhHUN/8Wz5GHCYUgLu9I
         kOreHU0ZZFYUM6PQiWh5EBozCmXnuqO9qeFFTM6c=
Date:   Fri, 4 Jun 2021 10:41:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Fix debugfs_read_file_str()
Message-ID: <YLnnSO6yst2ogZ3Y@kroah.com>
References: <20210527091105.258457-1-dietmar.eggemann@arm.com>
 <YLnmz7dOek/aTJAn@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLnmz7dOek/aTJAn@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 10:39:43AM +0200, Peter Zijlstra wrote:
> On Thu, May 27, 2021 at 11:11:05AM +0200, Dietmar Eggemann wrote:
> > Read the entire size of the buffer, including the trailing new line
> > character.
> > Discovered while reading the sched domain names of CPU0:
> > 
> > before:
> > 
> > cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
> > SMTMCDIE
> > 
> > after:
> > 
> > cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
> > SMT
> > MC
> > DIE
> > 
> > Fixes: 9af0440ec86eb ("debugfs: Implement debugfs_create_str()")
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> Urgh.. so much for last minute changes :/
> 
> Greg, AFAICT that commit has since landed in Linus, will you take care
> of this?
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Yes, I'll pick it up now, thanks.

greg k-h
