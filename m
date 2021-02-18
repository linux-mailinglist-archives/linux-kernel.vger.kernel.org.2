Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C1131EFCF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhBRT1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230187AbhBRShU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:37:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61F3364EB3;
        Thu, 18 Feb 2021 18:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613673390;
        bh=cx/G9CiNCVf5iqa5R0DmzapVS1vER9219WbO5MMjo7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7WH7zn6oIgUXC5no7v4N1XikNFP1r1AY/X/DXCM5iEC6fI81qvm8wLU+1Xk4rkmd
         TSARXU+U8k45wk/pz3hxN4HtC+f6ULD6ZRDrenRvGvunDSlhpX9/N3Xebyg/YEprhr
         lrqaxU8nEeFhHdbVOmA1fJUaNX02wty+DN/S05GY=
Date:   Thu, 18 Feb 2021 19:36:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Scott Branden <scott.branden@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YC6zq3u2jciI2gyZ@kroah.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <20210218165104.GC2013@sasha-vm>
 <00b9e2fb-d818-58d6-edae-4dbd6aa814f7@gmail.com>
 <YC6ptKgsMh20tmu6@kroah.com>
 <20210218182050.GB15217@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218182050.GB15217@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 07:20:50PM +0100, Willy Tarreau wrote:
> On Thu, Feb 18, 2021 at 06:53:56PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Feb 18, 2021 at 09:21:13AM -0800, Florian Fainelli wrote:
> > > As a company, we are most likely shooting ourselves in the foot by not
> > > having a point of coordination with the Linux Foundation and key people
> > > like you, Greg and other participants in the stable kernel.
> > 
> > What does the LF have to do with this?
> > 
> > We are here, on the mailing lists, working with everyone.  Just test the
> > -rc releases we make and let us know if they work or not for you, it's
> > not a lot of "coordination" needed at all.
> > 
> > Otherwise, if no one is saying that they are going to need these for 6
> > years and are willing to use it in their project (i.e. and test it),
> > there's no need for us to maintain it for that long, right?
> 
> Greg, please remember I expressed I really need them for slightly more than
> 3 years (say 3.5-4) :-) I'm fine with helping a bit more as time permits if
> this saves me from having to take over these kernels after you, like in the
> past, but I cannot engage on the regularity of my availability.

Ok, great!

That's one person/company saying they can help out (along with what CIP
has been stating.)

What about others?  Broadcom started this conversation, odd that they
don't seem to want to help out :)

thanks,

greg k-h
