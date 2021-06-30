Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BAD3B82A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhF3NIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234804AbhF3NIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:08:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62D9261466;
        Wed, 30 Jun 2021 13:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625058335;
        bh=+XFoT1s+yWmHl8v8zBGy1e6ffolKkthCOrD0n4FkztM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUt7RlMHo5hOs0C0jqodkLJSgZ8FWM75MJVVrhYeaN88Pd+1R1poPTP9gH+GObA9N
         tDdrFRnknUm1mSigS7Cc72/CZr6W+cBx5gNTWMNKpKrkp9CD2UFIQSUH/MrCfIlEbz
         4NuiY3K2v+TmFHWFqo4WZVaVkt31i+wC3kHpK2cE=
Date:   Wed, 30 Jun 2021 15:05:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com
Subject: Re: [PATCH V3 1/6] perf/x86/intel/uncore: Add Sapphire Rapids server
 support
Message-ID: <YNxsHfzX4PGdM1rP@kroah.com>
References: <1624990443-168533-1-git-send-email-kan.liang@linux.intel.com>
 <1624990443-168533-2-git-send-email-kan.liang@linux.intel.com>
 <YNw7KorfwK/OcrTw@kroah.com>
 <1b7ecd8e-ba0d-5448-5c43-f730ec7e5b35@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b7ecd8e-ba0d-5448-5c43-f730ec7e5b35@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 08:56:10AM -0400, Liang, Kan wrote:
> 
> 
> On 6/30/2021 5:36 AM, Greg KH wrote:
> > On Tue, Jun 29, 2021 at 11:13:58AM -0700, kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > Intel Sapphire Rapids supports a discovery mechanism, that allows an
> > > uncore driver to discover the different components ("boxes") of the
> > > chip.
> > > 
> > > All the generic information of the uncore boxes should be retrieved from
> > > the discovery tables. This has been enabled with the commit edae1f06c2cd
> > > ("perf/x86/intel/uncore: Parse uncore discovery tables"). Add
> > > use_discovery to indicate the case. The uncore driver doesn't need to
> > > hard code the generic information for each uncore box.
> > > 
> > > But we still need to enable various functionality that cannot be
> > > directly discovered. This is done here.
> > >   - Add a meaningful name for each uncore block.
> > >   - Add CHA filter support.
> > >   - The layout of the control registers for each uncore block is a little
> > >     bit different from the generic one. Set the platform specific format
> > >     and ops. Expose the common ops which can be reused.
> > >   - Add a fixed counter for IMC
> > > 
> > > All the undiscovered platform-specific features are hard code in the
> > > spr_uncores[]. Add uncore_type_customized_copy(), instead of the memcpy,
> > > to only overwrite these features.
> > > 
> > > Only the uncore blocks which are inculded in the discovery tables are
> > > enabled here. Other uncore blocks, e.g., free-running counters, will be
> > > supported in the following patch.
> > > 
> > > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > > ---
> > 
> > Why is there no other intel.com review on this before sending it out?
> > 
> 
> For the perf related code, currently I follow a loose internal review
> process. Before posting any patches to LKML, I start an internal review
> process by sending the patches to an internal mailing list. People (mainly
> Andi) will review the patches and give some comments.
> After several rounds of reviews, the reviewers may give a reviewed-by tag or
> just keep silent. I usually wait for several days. If there is no objection,
> I will post the patches in LKML for further review. That's why some patches
> have a reviewed-by, some doesn't in this patchset.
> But for the patches which you are the key maintainer, I followed the
> standard internal review process. As you can see, the reviewed-by from
> Rafael is tagged in the first patch of V1.

Thanks for the explaination, it does look very odd to see some patches
with a reviewed-by and others not.  Makes me thing that the reviewers
really did not read them all :(

> Please let me know if you'd like me to follow the standard internal review
> process in the future.

The "process" is there to help you all do better work.  If you feel it
is somehow making it harder then feel free to take it up with Intel
internally as people there know why it is in place.

thanks,

greg k-h
