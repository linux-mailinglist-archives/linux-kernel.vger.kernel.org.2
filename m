Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3752E43DC37
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhJ1Him (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:38:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:30868 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhJ1Hik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:38:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="227799890"
X-IronPort-AV: E=Sophos;i="5.87,189,1631602800"; 
   d="scan'208";a="227799890"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 00:36:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,189,1631602800"; 
   d="scan'208";a="636115701"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 28 Oct 2021 00:36:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 28 Oct 2021 10:36:07 +0300
Date:   Thu, 28 Oct 2021 10:36:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Benson Leung <bleung@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        "Gopal, Saranya" <saranya.gopal@intel.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] usb: typec: Character device for USB Power
 Delivery devices
Message-ID: <YXpS58zozw93QXig@kuha.fi.intel.com>
References: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
 <20211026143352.78387-3-heikki.krogerus@linux.intel.com>
 <YXn2zCA9lasDY/Xl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXn2zCA9lasDY/Xl@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 27, 2021 at 06:03:08PM -0700, Prashant Malani wrote:
> Why is USBPDDEV_SUBMIT_MESSAGE different from USBPDDEV_SET_MESSAGE?
> Shouldn't "setting" a PDO or property automatically "submit" it (using TCPM
> or whatever interface is actually performing the PD messaging) if
> appropriate (e.g Source Caps?). Is there a situation where one would
> want to "set" a property but not "send" it?
> 
> It seems to me that the two can be combined into 1 rather than having
> a separate command just for ports.

USBPDDEV_SUBMIT_MESSAGE you use to send message directly to the partner.

USBPDDEV_SET_MESSAGE is meant to be used to store the values to a
cached message that the port manager should use next time there is
communication, but it does not send the message to the partner. So you
can use it even when there is no connection with a port, for example,
to store the values like the initial USB mode that should be used by
setting the EUDO message. Maybe the ioctl should be named
USBPDDEV_STORE_MESSAGE... I used "set" because it is sort of a
counterpart to USBPDDEV_GET_MESSAGE.

There is an explanation in include/uapi/linux/usb/pd_dev.h, please
check it. I'm curious also what you think about the idea with
USBPDDEV_CONFIGURE.

thanks,

-- 
heikki
