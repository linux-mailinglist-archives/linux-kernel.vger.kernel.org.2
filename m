Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEE7366562
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 08:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbhDUGYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 02:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235975AbhDUGY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 02:24:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5259361421;
        Wed, 21 Apr 2021 06:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618986237;
        bh=yl/EdA30w7Ubmk3pTbQcHXk9BFC3bs7ulum3Oyt71Mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cpw826sV/Y/ioGMC08dttXBmA6y/S/ZAPi4cG19VqhlH2lNJEw823qKkqknEVdrUy
         CxJSIFcJPItGOcTCgfxxG//FjPri5nrpjhZu/RMHdIXccVE/mDr90vaGa7A2p4K1ZP
         HPrWlwNir3054PONTwXYG0+Cgqi+4QGrCoMGPU+8=
Date:   Wed, 21 Apr 2021 08:23:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2] docs: driver-model: Update the documentation for
 device class
Message-ID: <YH/E90QVq7yP01ii@kroah.com>
References: <20210407061053.81940-1-manivannan.sadhasivam@linaro.org>
 <87czuoio8r.fsf@meer.lwn.net>
 <20210421061340.GA6522@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421061340.GA6522@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:43:40AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 20, 2021 at 04:29:24PM -0600, Jonathan Corbet wrote:
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> > 
> > > The current documentation about the device class is out of date such
> > > that it refers to non-existent APIs and structures. This commit updates
> > > them to the current device class APIs and structures, removes wordings
> > > that no longer valid while trying to keep the original content intact.
> > >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >
> > > Changes in v2:
> > >
> > > * Fixed CLASS_ATTR_RW as spotted by Greg
> > >
> > >  .../driver-api/driver-model/class.rst         | 144 ++++++++----------
> > >  1 file changed, 66 insertions(+), 78 deletions(-)
> > 
> > Note that this file was removed in commit 1364c6787525 back in
> > February by Geert (added to CC).  If you want to update this document,
> > you'll first want to bring it back.
> > 
> 
> Oh thanks for the info! Perhaps I could just revert 1364c6787525 and add this
> commit on top?

Nah, leave it removed for now, it needs lots of work to be relevant.

greg k-h
