Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A833A840B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhFOPfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFOPfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:35:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A94D761603;
        Tue, 15 Jun 2021 15:33:14 +0000 (UTC)
Date:   Tue, 15 Jun 2021 11:33:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Song Hui <hui.song_1@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-rt-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Esben Haabendal <esben@geanix.com>
Subject: Re: commit 3d5bfbd97163 versus -rt
Message-ID: <20210615113312.0dad32bb@oasis.local.home>
In-Reply-To: <5afbc89e-dbc4-3f47-4e61-63a77165aaec@prevas.dk>
References: <5afbc89e-dbc4-3f47-4e61-63a77165aaec@prevas.dk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 14:35:27 +0200
Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:

> Reverting commit 3d5bfbd9716318b1ca5c38488aa69f64d38a9aa5 (gpio:
> mpc8xxx: change the gpio interrupt flags.) makes it go away, as does
> disabling CONFIG_PREEMPT_RT or simply booting a vanilla v5.10.42 (where
> that option exists but cannot be selected).

I'm curious if it will also trigger on vanilla v5.10.42 but add to the
kernel command line: threadirqs

Make sure you have CONFIG_IRQ_FORCED_THREADING set too.

Because it appears to be an issue with that being called by the generic
threaded irq infrastructure, which PREEMPT_RT enables automatically.


-- Steve
