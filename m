Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA95408A95
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbhIML5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:57:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:41795 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239705AbhIML4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:56:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10105"; a="201159271"
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="201159271"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 04:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="608946068"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 13 Sep 2021 04:55:13 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 13 Sep 2021 14:55:13 +0300
Date:   Mon, 13 Sep 2021 14:55:13 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] ABI: sysfs-bus-usb: better document variable argument
Message-ID: <YT88IYrNS4a48aPK@kuha.fi.intel.com>
References: <cover.1631112725.git.mchehab+huawei@kernel.org>
 <8b01bf910a236796e5571fd089619d5f51a874f6.1631112725.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b01bf910a236796e5571fd089619d5f51a874f6.1631112725.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 04:58:51PM +0200, Mauro Carvalho Chehab wrote:
> On almost all ABI documents, variable arguments are declared
> as <foo_bar>. Change it here too, in order to allow replacing
> such wildcards by regexes on a scriptable way.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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

-- 
heikki
