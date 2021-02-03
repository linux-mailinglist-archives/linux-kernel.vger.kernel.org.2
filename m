Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEFA30E7DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 00:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhBCXup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 18:50:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:53836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233033AbhBCXun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 18:50:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E14C964F60;
        Wed,  3 Feb 2021 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612396203;
        bh=iX9N3b62XCRX0H6lTs7UlkSgFTUsJaxLKRwpNp5kUOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f+tAN3oiEV0vM20SDHxNzv67/hsEu1N/hMQgJfMODnm1rC9y5AKKrnwcDr9SZvMuV
         FTu8tM/uRFGEQ13ynAVJ16HARp9GPFHHOFlCZwkVsSfOwYPlt5JF6KEGq+fYXUCn8n
         PtyxRNTBMj6WXtIl3vdR5KN/p70sBLvT4pRQ83dI=
Date:   Thu, 4 Feb 2021 00:50:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: usb: generic-ohci: Add missing
 compatible strings
Message-ID: <YBs2qcfSKfeBHBlr@kroah.com>
References: <20210202175439.3904060-1-robh@kernel.org>
 <20210202175439.3904060-2-robh@kernel.org>
 <YBpn4zqGk6mV0aII@kroah.com>
 <20210203210834.GD3706951@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203210834.GD3706951@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 03:08:34PM -0600, Rob Herring wrote:
> On Wed, Feb 03, 2021 at 10:07:47AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Feb 02, 2021 at 11:54:39AM -0600, Rob Herring wrote:
> > > The generic OHCI binding needs to document all the specific compatible
> > > strings so we can track undocumented compatible strings. Add all the
> > > compatible strings from in tree users.
> > > 
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: linux-usb@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/usb/generic-ohci.yaml | 34 +++++++++++++++++--
> > >  1 file changed, 32 insertions(+), 2 deletions(-)
> > 
> > Both look fine to me, do you want me to take this through my trees or
> > will you take them?
> 
> You'd better take them. I don't think they conflict with any of the 
> other USB binding changes, but there have been a few this cycle IIRC.

Ok, now queued up, thanks!

greg k-h
