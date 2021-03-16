Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA9A33D1D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhCPKcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:32:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:47660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236695AbhCPKcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:32:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE31FAC5C;
        Tue, 16 Mar 2021 10:32:18 +0000 (UTC)
Subject: Re: [PATCH v3 0/4] mm/slub: Fix count_partial() problem
To:     Christoph Lameter <cl@gentwo.de>, Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>,
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
References: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com>
 <793c884a-9d60-baaf-fab8-3e5f4a024124@suse.cz>
 <YE+wBMuX1Q0rhPQj@carbon.dhcp.thefacebook.com>
 <CAHbLzkqXpWWYmzGhTBALAQFx5KEWVdT2rz8GW836WOdWHuWAWA@mail.gmail.com>
 <alpine.DEB.2.22.394.2103161105430.342782@gentwo.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0690ac12-e112-9e14-e228-4692af446265@suse.cz>
Date:   Tue, 16 Mar 2021 11:32:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2103161105430.342782@gentwo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 11:07 AM, Christoph Lameter wrote:
> On Mon, 15 Mar 2021, Yang Shi wrote:
> 
>> > It seems like CONFIG_SLUB_DEBUG is a more popular option than CONFIG_SLUB_STATS.
>> > CONFIG_SLUB_DEBUG is enabled on my Fedora workstation, CONFIG_SLUB_STATS is off.
>> > I doubt an average user needs this data, so I'd go with CONFIG_SLUB_STATS.

Hm I can imagine that (after due performance testing) we would consider having
accurate slabinfo in our distro kernel, just as we have CONFIG_SLUB_DEBUG but
not the full stats.

>> I think CONFIG_SLUB_DEBUG is enabled by default on most distros since
>> it is supposed not incur too much overhead unless specific debug (i.e.
>> red_zone) is turned on on demand.
> 
> Correct. CONFIG_SLUB_DEBUG includes the code so the debugging can be
> enabled on Distro kernels with a kernel command line option. So you dont
> have to recompile the kernel to find weird memory corruption issues from
> strange device drivers.
> 
> Somehow my email address dropped off this thread.

Hm I see cl@linux.com in all e-mails of the thread, but now you replaced it with
cl@gentwo.de ?

