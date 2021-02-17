Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5AC31E120
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhBQVRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:17:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhBQVRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:17:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 960BF64E4B;
        Wed, 17 Feb 2021 21:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1613596584;
        bh=DBaMrQR3F5JOtPbp0XVz9+wx0qFmfjBV/goU8RfjcNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sO30w73rQ5z7kJkSNMJn07P8kHSLkdpJxMS9VRCXafBQGAzaSaqdTYzSfsxFfV4qv
         imggOSesENdOrOzDMCL4zBY3ysSoLMlGhD9PVyBbq6htSlb5Z0BvghVLnl0iQBV5UD
         QFpN3gvdv7jOr4GyUyLO488wBClo7Tm64QzMe0j4=
Date:   Wed, 17 Feb 2021 13:16:23 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Cc:     Daniel Walker <danielwa@cisco.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        linuxppc-dev@lists.ozlabs.org, Daniel Walker <dwalker@fifo99.com>,
        Maksym Kokhan <maksym.kokhan@globallogic.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/4] add generic builtin command line
Message-Id: <20210217131623.cb19ac2f8a143ba33e7623f1@linux-foundation.org>
In-Reply-To: <1613417521.3853.5.camel@chimera>
References: <20190319232448.45964-2-danielwa@cisco.com>
        <20190320155319.2cd3c0f73ef3cdefb65d5d1e@linux-foundation.org>
        <20190320232328.3bijcxek2yg43a25@zorba>
        <20190320201433.6c5c4782f4432d280c0e8361@linux-foundation.org>
        <20190321151308.yt6uc3mxgppm5zko@zorba>
        <20190321151519.1f4479d92228c8a8738e02cf@linux-foundation.org>
        <1613417521.3853.5.camel@chimera>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Feb 2021 11:32:01 -0800 Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us> wrote:

> On Thu, 2019-03-21 at 15:15 -0700, Andrew Morton wrote:
> > On Thu, 21 Mar 2019 08:13:08 -0700 Daniel Walker <danielwa@cisco.com> wrote:
> > > On Wed, Mar 20, 2019 at 08:14:33PM -0700, Andrew Morton wrote:
> > > > The patches (or some version of them) are already in linux-next,
> > > > which messes me up.  I'll disable them for now.
> > >  
> > > Those are from my tree, but I remove them when you picked up the series. The
> > > next linux-next should not have them.
> > 
> > Yup, thanks, all looks good now.
> 
> This patchset is currently neither in mainline nor in -next. May I ask
> what happened to it? Thanks.

Seems that I didn't bring them back after the confict with the powerpc
tree resolved itself.

Please resend everything for -rc1 and let's await the reviewer
feedback,

