Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A8C3E118B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbhHEJly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:41:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239650AbhHEJlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:41:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFD8E60F22;
        Thu,  5 Aug 2021 09:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628156499;
        bh=NhFLwlHs4kG7ncNlAn7w5y4NU5vrgQsthU4UhEIvk/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eubwCFWz/jlA8ukedR5SHGlaNJBF7JMWYqySNZNndswo0I45H6Lt9o2k5scnS7OiF
         S6vcQDnZ34Q/c2UNuaLTjXRn03r7bP95E1Lfs4hEUdWnAVb1HofCXTKsNZ8ETgIRGg
         8/keiX2WE46ijvpNipyp+7dzF8wHYiwpimTT03Co=
Date:   Thu, 5 Aug 2021 11:41:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/2] usb: dwc2: rename DWC2_POWER_DOWN_PARAM_NONE state
Message-ID: <YQuyUA4gq/6GZVps@kroah.com>
References: <CGME20210804114433eucas1p134417b605abeb57728d358fc2f42162b@eucas1p1.samsung.com>
 <20210804114421.10282-1-m.szyprowski@samsung.com>
 <YQusPurbybrNly+b@kroah.com>
 <b7855705-892c-14e5-0290-ce7c49b87121@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7855705-892c-14e5-0290-ce7c49b87121@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 09:22:05AM +0000, Minas Harutyunyan wrote:
> Hi Greg,
> 
> On 8/5/2021 1:15 PM, Greg KH wrote:
> > On Wed, Aug 04, 2021 at 01:44:20PM +0200, Marek Szyprowski wrote:
> >> DWC2_POWER_DOWN_PARAM_NONE really means that the driver still uses clock
> >> gating to save power when hardware is not used. Rename the state name to
> >> DWC2_POWER_DOWN_PARAM_CLOCK_GATING to match the driver behavior.
> >>
> >> Suggested-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> ---
> >> This is a follow-up of this discussion:
> >> https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/26099de1-826f-42bf-0de7-759a47faf4a0@samsung.com/__;!!A4F2R9G_pg!LG012E4LzO4qVgWZHu_3eTbZ5zmdI4qENHbOuuLwm-IlhHF9KKIaYyJNaY2vXeg$
> >>
> >> This should be applied on top of v5.14-rc3.
> > 
> > What else would I apply it on top of, we can't go back in time :)
> > 
> > Where is this needed for 5.14-final, or for 5.15-rc1?
> > 
> 
> I would prefer to apply to 5.14-final. Just I need 1 more day to 
> complete testing. Have I this additional day?

Sure, I'll drop this from my queue, please resubmit when you are ready
to have them reviewed/accepted.

Also, if these "fix" a previous patch, please put a "Fixes:" tag in the
patch so we know that.

thanks,

greg k-h
