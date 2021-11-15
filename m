Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A56451FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344150AbhKPApE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345112AbhKOT0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:26:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5FEC63715;
        Mon, 15 Nov 2021 19:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637003426;
        bh=DtHrB66HXLmxewymT8yGeifJxpPVREBisB7HVDuwLYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWDI6azBQctDhxtdF1G9iKbhqkN2qYhQctn9Q95ee03P+8wXH7qRA3GAepSUdZg2n
         uKk6RWow7OZupqCCke9iIi2MeT8WkPYc4AvR4GCkYQP6OBFfqIRBToDvoJHxCRdtmJ
         raMFBms7HRLxupcaecmEaqky9XClk8sQ0odpZa3o=
Date:   Mon, 15 Nov 2021 19:49:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 06/13] peci: Add device detection
Message-ID: <YZKr1Rqfx6Cmw+Ok@kroah.com>
References: <20211115182552.3830849-1-iwona.winiarska@intel.com>
 <20211115182552.3830849-7-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115182552.3830849-7-iwona.winiarska@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 07:25:45PM +0100, Iwona Winiarska wrote:
> +void peci_device_destroy(struct peci_device *device)
> +{
> +	bool killed;
> +
> +	device_lock(&device->dev);
> +	killed = kill_device(&device->dev);

Eeek, why call this?

> +	device_unlock(&device->dev);
> +
> +	if (!killed)
> +		return;

What happened if something changed after you unlocked it?

Why is kill_device() required at all?  That's a very rare function to
call, and one that only one "bus" calls today because it is very
special (i.e. crazy and broken...)

thanks,

greg k-h
