Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DED546052A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 09:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356892AbhK1IEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 03:04:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40968 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356225AbhK1ICl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 03:02:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3C7C60F77;
        Sun, 28 Nov 2021 07:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D599C004E1;
        Sun, 28 Nov 2021 07:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638086365;
        bh=a6PoP6w0dgSMozFtEq44fxJ8Ll3TFph3OgWy0g2LLbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v6qvUQbbjmF5H2dbKK0P9k5OB7LibOO2EI/uXwqyOsfKrWobgZ+UfMRokHR55G7+R
         5/r6FAbLPdw0BV3bRgc5PSw4E/IMCLBDRB5IDHiHO9uCSqa0yl30Yq1H3OFaZigMiZ
         pc7ViY8586+Kw2IycziZ3k45aZs2BZQpOwA/K3Vc=
Date:   Sun, 28 Nov 2021 08:59:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/auxiliary_bus: Clarify auxiliary_device
 creation
Message-ID: <YaM21w8V46v33VOd@kroah.com>
References: <87k0hq2oxc.fsf@meer.lwn.net>
 <20211102225310.3677785-1-ira.weiny@intel.com>
 <YaEIdmRV2A1yclub@kroah.com>
 <20211128053224.GU3538886@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128053224.GU3538886@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 09:32:24PM -0800, Ira Weiny wrote:
> On Fri, Nov 26, 2021 at 05:16:54PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Nov 02, 2021 at 03:53:10PM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > The documentation for creating an auxiliary device is a 3 step not a 2
> > > step process.  Specifically the requirements of setting the name, id,
> > > dev.release, and dev.parent fields was not clear as a precursor to the '2
> > > step' process documented.
> > > 
> > > Clarify by declaring this a 3 step process starting with setting the
> > > fields of struct auxiliary_device correctly.
> > > 
> > > Also add some sample code and tie the change into the rest of the
> > > documentation.
> > > 
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > ---
> > > Changes from V1:
> > > 	From Jonathan
> > > 		Fix auxiliary spelling
> > > ---
> > >  Documentation/driver-api/auxiliary_bus.rst | 77 +++++++++++++++++-----
> > >  1 file changed, 59 insertions(+), 18 deletions(-)
> > 
> > Can you please resend the whole series, trying to just resend one patch
> > in the middle is horrible for our tools and to try to figure this out.
> 
> Sorry I did not realize this was an issue.  Other maintainers have been ok with
> this because I think B4 works fine with this?
> 
> > 
> > Would you like to have to unwind this?  Please make it simple for
> > maintainers to review and if ok, apply your changes.
> 
> Regardless, I was planning on resending this as part of the c files as you
> requested before.  Did you still want me to make that conversion?

Yes.

> Or I can resend this and make the c conversion as a follow on patch?

That is up to you.

