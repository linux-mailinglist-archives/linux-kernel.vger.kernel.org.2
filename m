Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E681E4237F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhJFG3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 02:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhJFG3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DDA760EC0;
        Wed,  6 Oct 2021 06:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633501681;
        bh=spg2FfB33eWRaZlMimWllWmYIhAbe/hDa0jC2sb1vWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nu0KSdos8srKS5PIPAOZZNp8J/2y5CPh/+dnqB2466tL4XJzMDHY0vH2W7eGUsOYc
         CwnIoKUKrM8wQ76l6MJw2Q38dpQZHYi605sGDZ27T+ryGez1rmoQ5JHaX7o8kI0A+i
         sD8TBOVJACa3H17k+oxP6iQHDCcOoJIHajMgs3ro=
Date:   Wed, 6 Oct 2021 08:27:59 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "amelie.delaunay@foss.st.com" <amelie.delaunay@foss.st.com>
Subject: Re: [PATCH 1/3] usb: dwc2: add otg_rev and otg_caps information for
 gadget driver
Message-ID: <YV1B7/yP2L+0L1sQ@kroah.com>
References: <1631692473-8732-1-git-send-email-fabrice.gasnier@foss.st.com>
 <1631692473-8732-2-git-send-email-fabrice.gasnier@foss.st.com>
 <a183ddf9-c578-0b45-1aa2-4fcd1fbf17eb@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a183ddf9-c578-0b45-1aa2-4fcd1fbf17eb@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 11:10:19AM +0000, Minas Harutyunyan wrote:
> On 9/15/2021 11:54 AM, Fabrice Gasnier wrote:
> > Currently the dwc2 doesn't fill in the 'otg_caps' of usb_gadget structure.
> > When registering a gadget device (e.g. via configfs), the
> > usb_otg_descriptor_init() checks the 'otg_caps' and 'otg_rev'. It defaults
> > to HNP and SRP bmAttributes if unspecified. There may be a mismatch with
> > what's being set in dwc2 params structure. This result in the descriptors
> > to be miss-configured in this case.
> > 
> > So add an option to setup 'otg_caps' and 'otg_rev' in the params. It's
> > then provided to the gadget struct. These parameters can then be tuned
> > for each platform. In case it's not set, it will default to current
> > behavior.
> > Also add option to setup these from the device tree by calling
> > of_usb_update_otg_caps(). This provides support for standard properties
> > such as "otg-rev", "hnp-disable" and "srp-disable" (see usb-drd.yaml).
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
> 

Looks like this commit breaks the build on some configurations:
	https://lore.kernel.org/r/000000000000b01f1505cda8e03c@google.com

So I'll go drop this and the 2/3 patch from my tree.  Please fix up and
resend.

thanks,

greg k-h
