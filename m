Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E01C325F45
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhBZIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:41:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhBZIjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:39:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE37E64EED;
        Fri, 26 Feb 2021 08:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614328731;
        bh=JBRdyfOOhAxeZtwgphJWVpwodnRe56bgo0hVXgLRLJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNtnkwNaSDQCEwEx+wM8d7+4sZ7RwJjFgCmu74YPyY0GdmHIo7qcssWryZOWQGai3
         PJ81p8z57tD+LdyLRicar/IGFXYmVeP+0dT1ZrWExvcKdFwHx5V5uJQT+TXIyf8cHT
         XQOMgXt5gNTNNJWnrvdEJhzOFhEuRtjSmj+Krc2g=
Date:   Fri, 26 Feb 2021 09:38:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        yisen.zhuang@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] USB:XHCI:Modify XHCI driver for USB2.0 controller
Message-ID: <YDizmDmu6Kh264Pv@kroah.com>
References: <1614327697-1021-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614327697-1021-1-git-send-email-liulongfang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 04:21:37PM +0800, Longfang Liu wrote:
> Our current XHCI hardware controller has been customized to only
> support USB 2.0 ports.

That sounds like a spec violation, right?  Why do you want to do this?

greg k-h
