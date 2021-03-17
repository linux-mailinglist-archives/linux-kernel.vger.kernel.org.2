Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F49733F430
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 16:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhCQPsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 11:48:11 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59485 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232348AbhCQPsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:05 -0400
Received: (qmail 489791 invoked by uid 1000); 17 Mar 2021 11:11:59 -0400
Date:   Wed, 17 Mar 2021 11:11:59 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     taehyun cho <taehyun.cho@samsung.com>
Cc:     balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: remove 'pm_runtime_set_active' in resume
 callback
Message-ID: <20210317151159.GA488655@rowland.harvard.edu>
References: <CGME20210315074223epcas2p11ddf190ec730f8629c1310117135f813@epcas2p1.samsung.com>
 <20210315074317.7736-1-taehyun.cho@samsung.com>
 <20210315141335.GA402778@rowland.harvard.edu>
 <20210317082520.GB138912@rack03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317082520.GB138912@rack03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 05:25:20PM +0900, taehyun cho wrote:
> On Mon, Mar 15, 2021 at 10:13:35AM -0400, Alan Stern wrote:
> > On Mon, Mar 15, 2021 at 04:43:17PM +0900, taehyun cho wrote:
> > > 'pm_runtime_set_active' sets a flag to describe rumtime status.
> > > This flag is automatically set in pm_runtime_get_sync/put_sync API.
> > > 'pm_runtime_set_active' checks the runtime status of parent device.
> > > As a result, the below error message is printed.
> > > dwc3 11110000.dwc3: runtime PM trying to activate child device
> > > 11110000.dwc3 but parent (11110000.usb) is not active.
> > 
> > This is very suspicious.  That error message indicates a real error is 
> > present; removing these pm_runtime_set_active calls won't fix the error.
> > 
> > You need to determine why the parent platform device 11110000.usb isn't 
> > active when the dwc3 probe and resume routines are called.  It seems 
> > likely that there is a bug in the platform device's driver.
> > 
> > Alan Stern
> >
> 
> Alan,
> 
> Thanks to your comments, I checked our platform device driver and found
> the problem. Our parent platform device didn't set active in resume
> callback. This made a problem.

Ah, good.  Does the platform driver set the active flag in its probe 
routine?

>  Thank you for the help and sorry for
> disturbing you.

No problem at all.

Alan Stern
