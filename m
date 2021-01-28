Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFC1306FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhA1Hoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:44:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232034AbhA1HmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:42:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D815064DD1;
        Thu, 28 Jan 2021 07:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611819689;
        bh=UIZAl1ypNxIx0VC4863WBaN/fRN2pw975WDiM1ldZGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bXuKnZrNYpxXInKGae/o3bmzevQexIN83M+3UnxY8xgDrBJRnYGrfEMs2pKdOLMke
         1A/LQeDq0t99Hwa1TuLGNrAPTD355YKPfzazqeg85TyoVXyVxu++UCgN2Uco9EBDR+
         STnAyFRkCoI9UMSiMGJfm6xrrYEC1pqVuooxeT8k=
Date:   Thu, 28 Jan 2021 08:41:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Howard Yen <howardyen@google.com>,
        Mathias Nyman <mathias.nyman@intel.com>, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] add xhci hooks for USB offload
Message-ID: <YBJqpbspmXZknX4n@kroah.com>
References: <20210119101044.1637023-1-howardyen@google.com>
 <af91bbf1-6731-3e87-4086-de0dbba22c22@intel.com>
 <CAJDAHvbTY3Z_bRg+++uLefWSvCWo_nGq+3OOQX3QHJ2w3X1SQw@mail.gmail.com>
 <ca442ca7-a434-2527-9945-861dafa685cc@linux.intel.com>
 <YBAk795ccXBPgJWp@kroah.com>
 <CAJDAHvZ2CCm9tT+C=hNc_U1CaYJg3ZjifsYLik3UqfXwUm++Lg@mail.gmail.com>
 <f77d1149-7bd1-3914-8841-439cb67397fd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f77d1149-7bd1-3914-8841-439cb67397fd@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 08:31:14AM +0200, Mathias Nyman wrote:
> On 28.1.2021 5.38, Howard Yen wrote:
> > On Tue, Jan 26, 2021 at 10:19 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Fri, Jan 22, 2021 at 05:32:58PM +0200, Mathias Nyman wrote:
> >>>
> >>> Ok, before adding hooks like this I think we need to see how they are used.
> >>> Do you have the rest of the patches that go on top of this series?
> >>>
> >>> Maybe it could make sense to use overrides for the functions in struct hc_driver
> >>> instead in some cases? There is support for that already.
> >>
> >> What overrides could be done for these changes?  At first glance that
> >> would seem to require a lot of duplicated code in whatever override
> >> happens to be needed.
> >>
> >> thanks,
> >>
> >> greg k-h
> > 
> > This patch series is all the changes for the offload hooks currently.
> > 
> > I thought about this, but if I tried to override the functions in
> > struct hc_driver, that'll need to
> > copy many code to the override function, and it won't follow the
> > latest change in the core
> > xhci driver.
> > 
> > 
> > - Howard
> 
> Ok, I see. 
> 
> The point I'm trying to make is that there is no way for me to know if
> these hooks are the right solution before I see any code using them.
> 
> Is the offloading code ready and public somewhere?

There is offload code published in the last few Samsung phone kernels, I
want to get that ported to these hooks to see if that works properly.

Give me a few days and I'll see if I can get it working, I had a
half-finished port around here somewhere...

thanks,

greg k-h
