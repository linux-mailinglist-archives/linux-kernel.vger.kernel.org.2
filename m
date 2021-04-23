Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EEF368C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbhDWFYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240428AbhDWFXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:23:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79047611AC;
        Fri, 23 Apr 2021 05:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619155394;
        bh=EHiyqkXyAYkMEFatPdUnpNaU4lxiIe2WnwL3Z9I4alw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PMstjOsfOLByJZmoC6x1NS1DsBXwMJMi3HnflLCvI+H8IVzbqI7OfCiWPcPdssFSU
         TA+9mIQaI4WFNWELX4ceEGVbJrk17m4XxGhQRAJnKuSwAJ5p8lxueB9FlB4oJIyIFZ
         TfRqz3mDSttFbH3RAfrmoNRKffCijtVJQJQBznDs=
Date:   Fri, 23 Apr 2021 07:23:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Ikjoon Jang <ikjn@chromium.org>, Yaqii Wu <Yaqii.Wu@mediatek.com>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] usb: xhci-mtk: remove unnecessary assignments in
 periodic TT scheduler
Message-ID: <YIJZvN8py7s+Zq6I@kroah.com>
References: <20210330080617.3746932-1-ikjn@chromium.org>
 <20210330160508.1.I797d214790033d0402d19ff6b47a34aff60d3062@changeid>
 <1617179455.2752.1.camel@mhfsdcap03>
 <YGq2YfURFApdJLxb@kroah.com>
 <1617675492.22435.4.camel@mhfsdcap03>
 <YIE3z7qYNtk7G/VB@kroah.com>
 <1619148391.4048.6.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619148391.4048.6.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 11:26:31AM +0800, Chunfeng Yun wrote:
> On Thu, 2021-04-22 at 10:46 +0200, Greg Kroah-Hartman wrote:
> > On Tue, Apr 06, 2021 at 10:18:12AM +0800, Chunfeng Yun wrote:
> > > On Mon, 2021-04-05 at 09:04 +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Mar 31, 2021 at 04:30:55PM +0800, Chunfeng Yun wrote:
> > > > > cc Yaqii Wu <Yaqii.Wu@mediatek.com>
> > > > > 
> > > > > I'll test it , thanks
> > > > 
> > > > Did you test this series and find any problems?  If not, I'll go queue
> > > > these up...
> > > Yes, found an issue on the start-split transaction, but not found the
> > > root cause yet :(
> > 
> > So you are objecting to these being merged at this point in time? 
> Yes
> 
> >  Can
> > you provide feedback to the author about what is wrong?
> Already provided feedback add discussed on issue tracker in private

That doesn't help us much as we can't see that :(

Please always keep us informed as to what is going on with publically
posted changes, otherwise you could find them being picked up and merged
into trees without an objection.

thanks,

greg k-h
