Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1871D35731D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243571AbhDGRZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhDGRZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:25:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27C6361242;
        Wed,  7 Apr 2021 17:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617816312;
        bh=/I9GfmleSBbs7R0HF64rsoxW4s6GV91+HDAdvacr2Fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWg++h/ZHMHODvvZK/EKo/6Ulry09nDEMt4yEgv6l7BmhERFEnKYorXfN8IcJ3H7D
         Ada1H1MrYxAMneIu91RjTR+UGFClLJ3kwxIm2Gbm5KwHdh7PPcESFN6kd4Wg2ISaRj
         +qrTcWO5swVafSNM054/mTa6eoxgM6nIunJMKxHw=
Date:   Wed, 7 Apr 2021 19:25:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: serial: 8250: deprecate
 aspeed,sirq-polarity-sense
Message-ID: <YG3q9brKTC4pkQbs@kroah.com>
References: <20210402182724.20848-1-zev@bewilderbeest.net>
 <20210402182724.20848-2-zev@bewilderbeest.net>
 <YG3NR4bGRjIGZhgx@kroah.com>
 <YG3kJC+6gLC6RzzQ@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG3kJC+6gLC6RzzQ@hatter.bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 11:56:04AM -0500, Zev Weiss wrote:
> On Wed, Apr 07, 2021 at 10:18:31AM CDT, Greg Kroah-Hartman wrote:
> > On Fri, Apr 02, 2021 at 01:27:21PM -0500, Zev Weiss wrote:
> > > This property ties SIRQ polarity to SCU register bits that don't
> > > necessarily have any direct relationship to it; the only use of it
> > > was removed in commit c82bf6e133d30e0f9172a20807814fa28aef0f67.
> > 
> > Please write that as:
> > 	c82bf6e133d3 ("ARM: aspeed: g5: Do not set sirq polarity")
> > 
> 
> Ack, will do.
> 
> > > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > > ---
> > >  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > What changed from previous versions?  That always goes below the ---
> > line.
> > 
> 
> I included an overview of that in the cover letter (https://lore.kernel.org/openbmc/20210402182724.20848-1-zev@bewilderbeest.net/);
> is it desirable to also have that duplicated in the individual patches in
> the series?

Any reason why you didn't include all of the relevant people and mailing
lists in that cover letter?  I've never seen it before :)

But yes, if you do send it to the right group, putting it in 00/XX is
fine.

thanks,

greg k-h
