Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A8E43B515
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhJZPI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:08:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhJZPIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:08:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B388B604AC;
        Tue, 26 Oct 2021 15:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635260790;
        bh=+Z01TEK+QyGY0xo8I0ZHZPD2JObUitun2+iJ1F+8ky0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zeRS4rWXDIOP7OcI42dfE34DbZ/0RnnieZyC47+iNVCm/OFDi4nOkgsyBw7uiyMEI
         AShlVrx5bJu6uI3UG3krgnJ1uq8IaFcddNSC/xWbhdKGEW/Jvyi4O82Xvx0noVbiZ3
         PlHeAJ55erDvywmbV2xmIsFf6sh0fyGshBd7DIvI=
Date:   Tue, 26 Oct 2021 17:06:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        "Gopal, Saranya" <saranya.gopal@intel.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] USB Power Delivery character device interface
Message-ID: <YXgZdFV2yTXAKxE9@kroah.com>
References: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 05:33:48PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> This is the proposal for USB PD character devices that we could use to
> communicate USB PD messages directly with the USB PD capable partners,
> ports and cable plugs from user space. Originally I proposed this idea
> here as a better way to get the PDOs from the partners (and ports and
> plugs): https://lkml.org/lkml/2021/10/8/331

You should put the info there (and please use lore.kernel.org in the
future, not lkml.org as we have no control over that site), into this
0/X message as I have no idea _why_ you need a char device and why the
sysfs interface will not work.

So, why not sysfs?  :)

thanks,

greg k-h
