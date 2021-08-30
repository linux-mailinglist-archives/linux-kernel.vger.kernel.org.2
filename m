Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E765F3FB1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhH3HYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233726AbhH3HYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:24:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F1FE60FC0;
        Mon, 30 Aug 2021 07:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630308239;
        bh=1kwa9P1J5AkDdW4mh3bIT4Z1ij9OVS1cy0X3yxbwL9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rucou6W/LjoP+nNu9OGkzi4IhIavOi4IYQvmoxzMZOCxjEyXUQSMDKRZ9H4UQohTX
         f6waQefsbF0Wj/XAPlc4wyfbLx0g38j6MXfx8BshQ797G1GVDEsTd9MYvSHhoRS2ec
         qAVEXOSz0gunCbQlztFVjqwYPZE8EeN4CRPa210tCbA3N7kjlgsX6+sq51mmnjYPXT
         b+O3ECFyEeE4zxx3BlfVDt7Rvx6GwLJVz0+y6RIYL8eGMAQI8c68VfiNhwyvjS1pzI
         YfrycD/lk0WaUJ35nu0FhhBscnn6N/+Nm8ToKdrT85IyycHQ2+J4A1qXog4oBL/CoO
         BekmV17GFo42A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mKbe1-00057v-VW; Mon, 30 Aug 2021 09:23:50 +0200
Date:   Mon, 30 Aug 2021 09:23:49 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: pl2303: fix GL type detection
Message-ID: <YSyHhf0zH96qaI0W@hovoldconsulting.com>
References: <20210826110239.5269-1-robert.marko@sartura.hr>
 <YSd2D92RL9pJMdQY@hovoldconsulting.com>
 <CA+HBbNFx45eapEZ3wiNCC5X+cvrJoCF01jaHTvj835P79AoN-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+HBbNFx45eapEZ3wiNCC5X+cvrJoCF01jaHTvj835P79AoN-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 01:09:20PM +0200, Robert Marko wrote:
> On Thu, Aug 26, 2021 at 1:08 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Aug 26, 2021 at 01:02:39PM +0200, Robert Marko wrote:
> > > At least some PL2303GL have a bcdDevice of 0x405 instead of 0x100 as the
> > > datasheet claims. Add it to the list of known release numbers for the
> > > HXN (G) type.
> > >
> > > Fixes: 894758d0571d ("USB: serial: pl2303: tighten type HXN (G) detection")
> > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> >
> > Thanks for the patch, looks good.
> >
> > Could you post the output of lsusb -v for your device as well for
> > completeness?
> 
> Sure, here it is:
> Bus 001 Device 003: ID 067b:23d3 Prolific Technology, Inc. USB-Serial Controller

Thanks! Now applied.

Johan
