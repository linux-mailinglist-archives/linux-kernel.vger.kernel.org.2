Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E38631628E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBJJmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:42:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230182AbhBJJk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:40:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29F3164E40;
        Wed, 10 Feb 2021 09:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612950009;
        bh=wHm5n85G54B+/iVWS1El6BGnS/7lrW7mFxfy2fLG91s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0qNF0wBOQ5hU+kOZkPANY6rKLFrOrvB4jDbc/cV4WW3QdZGTf0z5dZEvMA1rhiepl
         4NtVrS6Q8hOIAFsikfvMs1wurxEvcXoRsZkodl7F0zjSW25baickVKAUMwW+GOYXd6
         eZ+785HBe6ySbjGC/VtRW4azrY4QdqmABAiyPEfQ=
Date:   Wed, 10 Feb 2021 10:39:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: Re: [GIT PULL] phy: second round of fixes for v5.11
Message-ID: <YCOp7BU7nx8b0tXV@kroah.com>
References: <20210205115618.GG2656@vkoul-mobl.Dlink>
 <YCJI45rXLMpHRY1v@kroah.com>
 <20210210091249.GC2774@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210091249.GC2774@vkoul-mobl.Dlink>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 02:42:49PM +0530, Vinod Koul wrote:
> On 09-02-21, 09:33, Greg KH wrote:
> > On Fri, Feb 05, 2021 at 05:26:18PM +0530, Vinod Koul wrote:
> > > Hello Greg,
> > > 
> > > Please pull to receive few phy driver fixes for v5.11.
> > > Apologies for sending them bit late.
> > > 
> > > The following changes since commit d092bd9110494de3372722b317510b3692f1b2fe:
> > > 
> > >   phy: mediatek: allow compile-testing the dsi phy (2021-01-04 13:00:54 +0530)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes2-5.11
> > 
> > It's too late for this for my tree, sorry.  Can you send these as
> > patches and add a cc: stable on them to make sure they get into 5.11.y
> > properly (and further back if they are needed)?
> 
> Ok I understand. But would it be okay to merge the fixes. Some folks
> already use the tree and have requested the commits to be preserved.
> 
> I tested and it merges fine. I shall submit all these patches to stable
> for 5.11 or earlier as applicable once they hit Linus's tree

Ok, now merged and pushed out.

thanks,

greg k-h
