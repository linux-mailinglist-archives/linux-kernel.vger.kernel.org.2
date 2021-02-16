Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3E431D0BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 20:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhBPTMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 14:12:18 -0500
Received: from ec2-34-208-57-251.us-west-2.compute.amazonaws.com ([34.208.57.251]:58762
        "EHLO ip-172-31-12-36.us-west-2.compute.internal"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230378AbhBPTMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 14:12:17 -0500
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2021 14:12:17 EST
Received: by ip-172-31-12-36.us-west-2.compute.internal (Postfix, from userid 1001)
        id 744C640638; Tue, 16 Feb 2021 11:02:26 -0800 (PST)
Date:   Tue, 16 Feb 2021 11:02:26 -0800
From:   Daniel Walker <dwalker@fifo99.com>
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Walker <danielwa@cisco.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        linuxppc-dev@lists.ozlabs.org,
        Maksym Kokhan <maksym.kokhan@globallogic.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/4] add generic builtin command line
Message-ID: <20210216190226.GY22125@fifo99.com>
References: <20190319232448.45964-2-danielwa@cisco.com>
 <20190320155319.2cd3c0f73ef3cdefb65d5d1e@linux-foundation.org>
 <20190320232328.3bijcxek2yg43a25@zorba>
 <20190320201433.6c5c4782f4432d280c0e8361@linux-foundation.org>
 <20190321151308.yt6uc3mxgppm5zko@zorba>
 <20190321151519.1f4479d92228c8a8738e02cf@linux-foundation.org>
 <1613417521.3853.5.camel@chimera>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613417521.3853.5.camel@chimera>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 11:32:01AM -0800, Daniel Gimpelevich wrote:
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
> 

It was dropped silently by Andrew at some point. I wasn't watching -next closely
to know when. I have no idea why he dropped it.

We still use this series extensively in Cisco, and have extended it beyond this
current series.

We can re-submit.

Daniel
