Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A7E3F5EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhHXNJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237436AbhHXNJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:09:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03F92611F0;
        Tue, 24 Aug 2021 13:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629810554;
        bh=KqcP7me8PNCkcN0KDp6ReGQRoQaBm1qn6C1o2xMKhmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eG+I0x2ckECH4pPu0i5WwcdPlv46JIwm4ZZYWy1h9TPuROGGNfIOL9f5Zue0jJp6+
         0VPGn845IQkBpChp07cDpondQefRpG3N9Z/nORI3iaYxzTYfeKqYhS4n/WsRtf2hZu
         UHGCZOP7X5sobw/bO71FmN44uviLu8udHY+xDnsg=
Date:   Tue, 24 Aug 2021 15:09:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.chiu@canonical.com
Subject: Re: [RFC PATCH 4/5] usb: core: hcd-pci: Let usb_hcd_pci_probe()
 indicate if RH has to be registered
Message-ID: <YSTvdxl0BipsQyB4@kroah.com>
References: <20210824105302.25382-1-kishon@ti.com>
 <20210824105302.25382-5-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824105302.25382-5-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 04:23:01PM +0530, Kishon Vijay Abraham I wrote:
> No functional change. Add __usb_hcd_pci_probe() which takes "register_hub"
> flag that indicates if roothub (RH) has to be registered or not. This is in
> preparation for allowing xhci-pci to register roothub after the shared hcd
> is created. The interface for usb_hcd_pci_probe() is not modified to make
> sure there are minimal code changes.

Same "add a flag" comment here, don't do that, make the function name
obvious please.

thanks,

greg k-h
