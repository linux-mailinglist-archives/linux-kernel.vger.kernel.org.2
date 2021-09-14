Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F92040B752
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhINS7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232359AbhINS7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:59:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EBA761130;
        Tue, 14 Sep 2021 18:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631645874;
        bh=dd5YBsKq0kKtdjlfugGsWrclHUSx6pYm7MzhzBwLRTI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BCkemMXYji7HDVg761E4H3PDpguL8jvcwoRW+aootTkauFiy92a9EoVbo/gacOd84
         NPzWME9JZ+mM3Fl9Oy5es8U5RU2VAi7SY8VPgjruP0LL84vz6dSoMPel04EpGJCX3d
         5IcWF9LoaipjKcsC0wKt//3yeZB4ocfgPegGf8xSFQC4naLa+bG9au9mCw1D8D64Yl
         LGhOjjVxJOmeCYg11m6Mg0LcIZJyTpQsBcdW4P6qGoAualZY0zroABSRGgQobuXGKJ
         OV4W68mrPp8UV7I1akHb7zEGl0MfmZDoP468vquN3mxuS6lrkFrwMpB3y3smC5y1Vs
         W3LkUQ91O+RGw==
Date:   Tue, 14 Sep 2021 13:57:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/29] ABI: sysfs-bus-usb: better document variable
 argument
Message-ID: <20210914185752.GA1444725@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf40784dd4169897f7a28cc4d9393e8eaae5b873.1631629496.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 04:32:16PM +0200, Mauro Carvalho Chehab wrote:
> On almost all ABI documents, variable arguments are declared
> as <foo_bar>. Change it here too, in order to allow replacing
> such wildcards by regexes on a scriptable way.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-usb | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
> index 73eb23bc1f34..42103f0f54d6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-usb
> +++ b/Documentation/ABI/testing/sysfs-bus-usb
> @@ -166,14 +166,14 @@ Description:
>  		The file will be present for all speeds of USB devices, and will
>  		always read "no" for USB 1.1 and USB 2.0 devices.
>  
> -What:		/sys/bus/usb/devices/.../(hub interface)/portX
> +What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>
>  Date:		August 2012
>  Contact:	Lan Tianyu <tianyu.lan@intel.com>
>  Description:
> -		The /sys/bus/usb/devices/.../(hub interface)/portX
> +		The /sys/bus/usb/devices/.../<hub_interface>/port<X>
>  		is usb port device's sysfs directory.
>  
> -What:		/sys/bus/usb/devices/.../(hub interface)/portX/connect_type
> +What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/connect_type
>  Date:		January 2013
>  Contact:	Lan Tianyu <tianyu.lan@intel.com>
>  Description:
> @@ -182,7 +182,7 @@ Description:
>  		The file will read "hotplug", "hardwired" and "not used" if the
>  		information is available, and "unknown" otherwise.
>  
> -What:		/sys/bus/usb/devices/.../(hub interface)/portX/location
> +What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/location
>  Date:		October 2018
>  Contact:	Bjørn Mork <bjorn@mork.no>
>  Description:
> @@ -192,7 +192,7 @@ Description:
>  		raw location value as a hex integer.
>  
>  
> -What:		/sys/bus/usb/devices/.../(hub interface)/portX/quirks
> +What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/quirks
>  Date:		May 2018
>  Contact:	Nicolas Boichat <drinkcat@chromium.org>
>  Description:
> @@ -216,7 +216,7 @@ Description:
>  		   used to help make enumeration work better on some high speed
>  		   devices.
>  
> -What:		/sys/bus/usb/devices/.../(hub interface)/portX/over_current_count
> +What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/over_current_count
>  Date:		February 2018
>  Contact:	Richard Leitner <richard.leitner@skidata.com>
>  Description:
> @@ -230,10 +230,10 @@ Description:
>  		Any time this value changes the corresponding hub device will send a
>  		udev event with the following attributes::
>  
> -		  OVER_CURRENT_PORT=/sys/bus/usb/devices/.../(hub interface)/portX
> +		  OVER_CURRENT_PORT=/sys/bus/usb/devices/.../<hub_interface>/port<X>
>  		  OVER_CURRENT_COUNT=[current value of this sysfs attribute]
>  
> -What:		/sys/bus/usb/devices/.../(hub interface)/portX/usb3_lpm_permit
> +What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/usb3_lpm_permit
>  Date:		November 2015
>  Contact:	Lu Baolu <baolu.lu@linux.intel.com>
>  Description:
> -- 
> 2.31.1
> 
