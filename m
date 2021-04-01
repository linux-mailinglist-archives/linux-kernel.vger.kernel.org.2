Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1AB351397
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhDAK2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234239AbhDAK1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:27:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E779610EA;
        Thu,  1 Apr 2021 10:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617272843;
        bh=HQG16RWBrcoedAiIdR5UENpMwcX+yPeQNqIyyoyNUuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BTInuR9nePUquz2VTIc45uqzI1An1RggwZuVpd3dYxSCD9TpLH5E2yoCwFICX2go5
         jsIcScts5zJHO+8RXJbStT3BN60p2r8QyhdefkqYYfmzXYd9QBHzp8tZZfH7Fq04PU
         YMHbEm4NLTQvHaB5Fnfr+qOQG+n5Q5g322jl4JrVJFyjzRlKBZwcyt1euNA6Waf+Df
         MBUSS6JdXAyQZuGbCVEkHwAII0UgbbYyMUZbdtW9hG2WulSdgsM/fpbvH+JWJQ6K4I
         n2OWSVzL1mGaeWxSCJ7AlHxoc4aXXXfwHDjB4DyM0L+2XfgOLeQFFlxT8tNktjdj0T
         IlLZRR1SDi94A==
Date:   Thu, 1 Apr 2021 15:57:17 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add support for Actions Semi Owl socinfo
Message-ID: <20210401102717.GF14052@work>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <20210401052438.GB14052@work>
 <20210401094041.GA1993499@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401094041.GA1993499@BV030612LT>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 12:40:41PM +0300, Cristian Ciocaltea wrote:
> Hi Mani,
> 
> On Thu, Apr 01, 2021 at 10:54:38AM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Mar 30, 2021 at 04:48:15PM +0300, Cristian Ciocaltea wrote:
> > > This patchset adds a socinfo driver which provides information about
> > > Actions Semi Owl SoCs to user space via sysfs: machine, family, soc_id,
> > > serial_number.
> > > 
> > > Please note the serial number is currently available only for the S500
> > > SoC variant.
> > > 
> > > This has been tested on the S500 SoC based RoseapplePi SBC.
> > > 
> > 
> > Is this the soc_id provided by the vendor bootloader (uboot)? If so, under
> > what basis it provides? I don't think the SoC has the provision for
> > soc_id based on HW parameters.
> 
> No, the soc_id is not provided by the bootloader, or at least I couldn't
> identify any related implementation. Instead, I provided this via the
> driver itself, since I've encountered this approach in some other soc
> drivers as well (e.g. imx/soc-imx.c, versatile/soc-integrator.c). 
> 

Sorry, I was referring to serial_number. Since your comment says so, can
you point to the corresponding code?

Thanks,
Mani

> Thanks,
> Cristi
> 
> > Thanks,
> > Mani
>  
> [...]
