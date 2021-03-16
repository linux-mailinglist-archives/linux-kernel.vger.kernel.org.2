Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A1433D1A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbhCPKSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:18:06 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:56198 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231430AbhCPKRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:17:54 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 29BC9B0060B; Tue, 16 Mar 2021 11:07:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 26ECEB002C3;
        Tue, 16 Mar 2021 11:07:36 +0100 (CET)
Date:   Tue, 16 Mar 2021 11:07:36 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Yang Shi <shy828301@gmail.com>
cc:     Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Pekka Enberg <penberg@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shu Ming <sming56@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        James Wang <jnwang@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 0/4] mm/slub: Fix count_partial() problem
In-Reply-To: <CAHbLzkqXpWWYmzGhTBALAQFx5KEWVdT2rz8GW836WOdWHuWAWA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2103161105430.342782@gentwo.de>
References: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com> <793c884a-9d60-baaf-fab8-3e5f4a024124@suse.cz> <YE+wBMuX1Q0rhPQj@carbon.dhcp.thefacebook.com> <CAHbLzkqXpWWYmzGhTBALAQFx5KEWVdT2rz8GW836WOdWHuWAWA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021, Yang Shi wrote:

> > It seems like CONFIG_SLUB_DEBUG is a more popular option than CONFIG_SLUB_STATS.
> > CONFIG_SLUB_DEBUG is enabled on my Fedora workstation, CONFIG_SLUB_STATS is off.
> > I doubt an average user needs this data, so I'd go with CONFIG_SLUB_STATS.
>
> I think CONFIG_SLUB_DEBUG is enabled by default on most distros since
> it is supposed not incur too much overhead unless specific debug (i.e.
> red_zone) is turned on on demand.

Correct. CONFIG_SLUB_DEBUG includes the code so the debugging can be
enabled on Distro kernels with a kernel command line option. So you dont
have to recompile the kernel to find weird memory corruption issues from
strange device drivers.

Somehow my email address dropped off this thread.

