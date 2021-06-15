Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F733A8728
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhFORMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231540AbhFORMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:12:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DE426143D;
        Tue, 15 Jun 2021 17:10:00 +0000 (UTC)
Date:   Tue, 15 Jun 2021 13:09:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-rt-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Esben Haabendal <esben@geanix.com>
Subject: Re: commit 3d5bfbd97163 versus -rt
Message-ID: <20210615130959.1de1f52a@gandalf.local.home>
In-Reply-To: <37e28373-c6ec-2602-ec5c-cb0b65ce6697@prevas.dk>
References: <5afbc89e-dbc4-3f47-4e61-63a77165aaec@prevas.dk>
        <20210615113312.0dad32bb@oasis.local.home>
        <b66ff695-7f75-2a70-7feb-0df4f5ea0608@prevas.dk>
        <37e28373-c6ec-2602-ec5c-cb0b65ce6697@prevas.dk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 18:24:20 +0200
Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:

> > ~ # uname -r
> > 5.10.42-00001-g10216cf63a12
> > ~ # grep -ow threadirqs /proc/cmdline
> > threadirqs
> > ~ # zcat /proc/config.gz | grep FORCED_THREADING
> > CONFIG_IRQ_FORCED_THREADING=y
> > ~ # dmesg | grep WARNING
> > ~ #  
> 
> And as an extra data point, it also doesn't trigger on 5.10.41-rt42
> configured without PREEMPT_RT but with threadirqs on the command line.

Sounds to me that there's a "spin_lock_irq*" somewhere in the path, because
from what I can see, there's not much difference with the IRQ code between
5.10.41 and 5.10.41-rt42. But if you are seeing it only with PREEMPT_RT
set, that tells me that without PREEMPT_RT, interrupts are disabled at that
point, but not with PREEMPT_RT. The only thing I can think of that would do
that is a spin_lock_irq*() taken (not a raw_spin_lock_irq*()).

-- Steve
