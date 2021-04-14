Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C035F744
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhDNPKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhDNPKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:10:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AF1361132;
        Wed, 14 Apr 2021 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618413000;
        bh=ZWvJN4HVnHD0g7ZiqQ+fUQ0ZaA8fRAMztyQFEK4IEkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YP3AjKElNyLCXGOxF4lZ35QmWabWZH8iqTASwD2E9ov/mgqcYT2GjIGH47BNQath8
         pV8ZO+/fDUKTunxNwlWjN7Hz+73+u9ZuQBl3Z53gtM0gzm9wV1hcmvLtuYvWs/K4QQ
         ng878uyuBLgA61AdeGIJ1O4aBiA0U2smHVhW6zvE=
Date:   Wed, 14 Apr 2021 17:09:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v4 2/3] usb: typec: tcpm: Allow slow charging loops to
 comply to pSnkStby
Message-ID: <YHcFxReUDYpbe+4s@kroah.com>
References: <20210414142656.63749-1-badhri@google.com>
 <20210414142656.63749-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414142656.63749-2-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 07:26:55AM -0700, Badhri Jagan Sridharan wrote:
> When a PD charger advertising Rp-3.0 is connected to a sink port, the
> sink port current limit would 3A, during SNK_DISCOVERY, till power
> negotiation starts. Once the negotiation starts the power limit needs
> to drop down to pSnkStby(500mA @ 5V) and to negotiated current limit
> once the explicit contract is in place. Not all charging loops can ramp
> up to 3A and drop down to 500mA within tSnkStdby which is 15ms. The port
> partner might hard reset if tSnkStdby is not met.
> 
> To solve this problem, this patch introduces slow-charger-loop which
> when set makes the port request PD_P_SNK_STDBY_MW upon entering
> SNK_DISCOVERY(instead of 3A or the 1.5A during SNK_DISCOVERY) and the
> actual currrent limit after RX of PD_CTRL_PSRDY for PD link or during
> SNK_READY for non-pd link.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> Changes since V3:
> * Added reviewed-by tag from Heikki

No need to add reviewed-by tags, my tools pick that up already.

Patches 1 and 2 now queued up.

thanks,

greg k-h
