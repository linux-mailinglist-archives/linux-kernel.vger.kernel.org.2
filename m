Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E983451678
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 22:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349081AbhKOVZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 16:25:14 -0500
Received: from foss.arm.com ([217.140.110.172]:59256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241268AbhKOSTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:19:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EC5B1FB;
        Mon, 15 Nov 2021 10:16:20 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D84343F70D;
        Mon, 15 Nov 2021 10:16:18 -0800 (PST)
Date:   Mon, 15 Nov 2021 18:16:16 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dvyukov@google.com, peterz@infradead.org,
        quic_qiancai@quicinc.com, will@kernel.org, woodylin@google.com
Subject: Re: [PATCH] Reset task stack state in bringup_cpu()
Message-ID: <20211115181616.GB36661@lakrids.cambridge.arm.com>
References: <20211115113310.35693-1-mark.rutland@arm.com>
 <87pmr1r4vl.mognet@arm.com>
 <YZJqF83s8LrV7Zei@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZJqF83s8LrV7Zei@FVFF77S0Q05N.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 02:09:27PM +0000, Mark Rutland wrote:
> On Mon, Nov 15, 2021 at 12:16:14PM +0000, Valentin Schneider wrote:
> > 
> > Hi Mark,
> > 
> > Thanks for tackling this and glueing the pieces back together. LGTM, though
> > I couldn't stop myself from playing changelog police - I also have a
> > question/comment wrt the BP.
> 
> I'll go fix the various typos for v2; replies to the more substantial comments
> below.

FWIW, I pushed out a version with an updated commit message to:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=sched/hotplug-stack-reset
  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git sched/hotplug-stack-reset

... and I'll wait a little bit before posting that in case there's
any further comment on the patch itself.

Thanks,
Mark.
