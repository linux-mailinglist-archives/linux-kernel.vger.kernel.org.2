Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088253FA7DD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 00:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhH1WPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 18:15:16 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46436 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230253AbhH1WPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 18:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ykqrNZ5+xkEdOSCPLKtfepuHL8Oc2+H/B5h3rAqZXGc=; b=IrALU6x5Fkn8ESg+tD7b/KACL8
        IKQuwWtI9Zc4Xd7Mn4NRJbqLsKjw8pAJUkmxnlwM0SwbtmQN6hwgMgIbn6HwfXPM924HA+cpE0D1I
        2xlkD1h7tNNe5EM86mqUBaezjmlWn6qw6qvOFW80eKcVZPIrRaCCg3IYvEa4mT4RwPyQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mK6af-004KOJ-VM; Sun, 29 Aug 2021 00:14:17 +0200
Date:   Sun, 29 Aug 2021 00:14:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ARM: dts: NSP: Fix MDIO mux node names
Message-ID: <YSq1OS+z8KKcUdu5@lunn.ch>
References: <20210828112704.2283805-1-mnhagan88@gmail.com>
 <20210828112704.2283805-3-mnhagan88@gmail.com>
 <YSptPF8MKNahkMbm@lunn.ch>
 <858a86de-c06e-0221-64ea-bb1790db398a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <858a86de-c06e-0221-64ea-bb1790db398a@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 10:52:30PM +0100, Matthew Hagan wrote:
> On 28/08/2021 18:07, Andrew Lunn wrote:
> 
> > On Sat, Aug 28, 2021 at 11:27:01AM +0000, Matthew Hagan wrote:
> >> This patch fixes the following message by adding "mdio-mux" compatible:
> >> compatible: ['mdio-mux-mmioreg'] is too short
> >  
> > Err, what? This sounds like a workaround for a tool problem, not a
> > real fix. 
> >
> > What is actually wrong with:
> >
> > compatible = "mdio-mux-mmioreg";
> 
> Yes this does work fine either with or without "mdio-mux". The changes
> have been made to correspond with those submitted by Rafal Milecki for
> the BCM5301X platform[1] and to conform with
> Documentation/devicetree/bindings/net/mdio-mux-mmioreg.yaml
> which does state both as required items (and hence not a tool problem).

Hi Matthew

It would be good to expand the commit message a bit, since the error
'is too short' is particularly uninformative, and leads to questions
like this if not explained.

It would also good to get the tool improved, but that is out of scope
for this patch.

     Andrew
