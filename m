Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFB945D410
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 06:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbhKYFPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 00:15:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhKYFNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 00:13:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10D4661059;
        Thu, 25 Nov 2021 05:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637817039;
        bh=ufpErtWre1qj5/AerC8ZhaWk9fBM4xwsadc1DshDmBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K7WqKUKuE1aGCbcLl1Xay3yhLln2ksLALHasv2Ycm1JeJ09JdlcbdZn5niXvDy3I1
         5093kfrCVkI7s1NkpduRnnud52+NS30CJf3SjlSbzi6LEnNFJfMXVhU5YdKY6wrYFz
         bQ6dbj5Ah6Bq6RYejhF0KBMnmH9dbczNLd+LxAKqMe+AGF783KKYOHGqOCs/Tqp68y
         f7gcn2Oe+QQzrHVbvtZ1QQZckVpVbJ7Ya8ZGBVAf17tS7PnatxBje1Yec98uXs1Pio
         f9s6y5wgJHKmD8ChVb9jmhEvwj+MX95IVdc09uPxecB826KUTCSfbaRejTyEKduhv5
         lgZkTSHN2aw9g==
Date:   Thu, 25 Nov 2021 10:40:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Cc:     "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>
Subject: Re: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY
 multilink configuration
Message-ID: <YZ8aygJQoxie+Ddn@matsya>
References: <20211022170236.18839-1-sjakhade@cadence.com>
 <20211022170236.18839-14-sjakhade@cadence.com>
 <YZxyja2xEkpWvStR@matsya>
 <DM6PR07MB6154FB5EB84B7BE063965619C5619@DM6PR07MB6154.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR07MB6154FB5EB84B7BE063965619C5619@DM6PR07MB6154.namprd07.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-11-21, 07:33, Swapnil Kashinath Jakhade wrote:

> > so this is pcie->qsgmii ->ssc/external/internal ... ok
> > 
> > > +				[NO_SSC] =
> > &pcie_100_no_ssc_plllc_cmn_vals,
> > > +				[EXTERNAL_SSC] =
> > &pcie_100_ext_ssc_plllc_cmn_vals,
> > > +				[INTERNAL_SSC] =
> > &pcie_100_int_ssc_plllc_cmn_vals,
> > > +			},
> > >  		},
> > >  		[TYPE_USB] = {
> > >  			[TYPE_NONE] = {
> > >  				[EXTERNAL_SSC] =
> > &usb_100_ext_ssc_cmn_vals,
> > >  			},
> > >  		},
> > > +		[TYPE_QSGMII] = {
> > > +			[TYPE_PCIE] = {
> > 
> > now it is reverse! qsgmii -> pcie -> ... why?
> > 
> > what is meant by pcie->qsgmii and qsgmii-> pcie?
> > 
> 
> Multi-protocol configuration is done in 2 phases, each for one protocol.
> e.g. for PCIe + QSGMII case,
> [TYPE_PCIE][TYPE_QSGMII] will configure common and lane registers for PCIe and
> [TYPE_QSGMII][TYPE_PCIE] will configure common and lane registers for QSGMII.

Then it should be always common + protocol or protocol + common, not
both please! Pls make an order and stick to it everywhere... If that is
not possible, I would like to understand why

-- 
~Vinod
