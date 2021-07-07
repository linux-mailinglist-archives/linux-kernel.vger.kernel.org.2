Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C353BE993
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 16:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhGGOWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhGGOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:22:45 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0348C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 07:20:04 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7BF0D92009C; Wed,  7 Jul 2021 16:20:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6D06B92009B;
        Wed,  7 Jul 2021 16:20:03 +0200 (CEST)
Date:   Wed, 7 Jul 2021 16:20:03 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     David Sterba <dsterba@suse.cz>
cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: super.c:undefined reference to `__umoddi3'
In-Reply-To: <20210707134743.GJ2610@twin.jikos.cz>
Message-ID: <alpine.DEB.2.21.2107071613010.1711@angie.orcam.me.uk>
References: <202107061952.nZ61qqwh-lkp@intel.com> <20210707134743.GJ2610@twin.jikos.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2021, David Sterba wrote:

> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   79160a603bdb51916226caf4a6616cc4e1c58a58
> > commit: c49f71f60754acbff37505e1d16ca796bf8a8140 MIPS: Reinstate platform `__div64_32' handler
> 
> Is it caused by this patch? It seems to be only MIPS-related, otherwise
> we'd get reports from other 32bit arches in case of the emulated 64bit
> division.

 Not really, cf. 
<https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2105200927570.1771368@ramsan.of.borg/>.

 I've seen an earlier report already and will do a test build as a matter 
of interest to see why it triggered around the MIPS change only, once I'm 
done with the current stuff.

  Maciej
