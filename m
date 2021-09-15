Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8955C40C5CC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhIONBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:01:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:59959 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229670AbhIONBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:01:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="219125340"
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="219125340"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 06:00:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="472391558"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 15 Sep 2021 06:00:32 -0700
Date:   Wed, 15 Sep 2021 06:00:07 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Marcus =?iso-8859-1?Q?R=FCckert?= <mrueckert@suse.com>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/umip: Add a umip= cmdline switch
Message-ID: <20210915130007.GA7946@ranerica-svr.sc.intel.com>
References: <20210907200454.30458-1-bp@alien8.de>
 <20210911011459.GA11980@ranerica-svr.sc.intel.com>
 <YTx0+0pfyzHuX80L@zn.tnic>
 <20210913213836.GA10627@ranerica-svr.sc.intel.com>
 <YUDTCgEOZ3JOMSl7@zn.tnic>
 <20210915113410.GA7130@ranerica-svr.sc.intel.com>
 <20210915142123.49f8137b@fortress.home.nordisch.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210915142123.49f8137b@fortress.home.nordisch.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 02:21:23PM +0200, Marcus Rückert wrote:
> On Wed, 15 Sep 2021 04:34:10 -0700
> Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> > > They're all likely old, arcane applications or games run in wine
> > > which people have no access to the source code anyway so come to
> > > think of it, the once thing is starting to make more sense to me
> > > now.
> > 
> > Indeed, no one has reported "modern" application using these
> > instructions.
> 
> I am not sure if Blizzard Entertainment would tell us why they use this
> CPU instruction in Overwatch. And that game is "only" 5 years old.

Ah! 5 years old does not seem too old to me. Then it is not only old
applications. Then the warning did catch an app that could in theory be
fixed (if Overwatch is still maintained).

Thanks and BR,
Ricardo
