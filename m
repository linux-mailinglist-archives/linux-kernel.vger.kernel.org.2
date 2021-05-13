Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E171C37F852
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhEMNCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:02:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232807AbhEMNCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:02:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E87F61264;
        Thu, 13 May 2021 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620910863;
        bh=hrJGgRMOGw+xsZEDwcg+4tkyQZO/1AY6HJA091YVM6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ThIx22U0furBY8A1UwOam6GZ9wDOuWbAQNwkKrTs5degWPKIo7aqO8TQdMi+9Rddg
         4h+wfRLldlMXkAxXShyEjJidmqGMrwmRRCIYdrehKnAzYgXGNjPbSbXifROi/XfIlX
         sbVRo0iHtr0ZTOvGZ17nVq6Wtj70qm0tcx4BkFQU=
Date:   Thu, 13 May 2021 15:01:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix SINK_DISCOVERY current limit for
 Rp-default
Message-ID: <YJ0jDcShxW8400ez@kroah.com>
References: <20210510211756.3346954-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210510211756.3346954-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 02:17:56PM -0700, Badhri Jagan Sridharan wrote:
> This is a regression introduced by
> <1373fefc6243cc96b3565f0ffffadfac4ccfb977>
> "Allow slow charging loops to comply to pSnkStby".
> 
> When Source advertises Rp-default, tcpm would request 500mA when in
> SINK_DISCOVERY, Type-C spec advises the sink to follow BC1.2 current
> limits when Rp-default is advertised.
> [12750.503381] Requesting mux state 1, usb-role 2, orientation 1
> [12750.503837] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS]
> [12751.003891] state change SNK_STARTUP -> SNK_DISCOVERY
> [12751.003900] Setting voltage/current limit 5000 mV 500 mA
> 
> This patch restores the behavior where the tcpm would request 0mA when
> Rp-default is advertised by the source.
> [   73.174252] Requesting mux state 1, usb-role 2, orientation 1
> [   73.174749] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS]
> [   73.674800] state change SNK_STARTUP -> SNK_DISCOVERY
> [   73.674808] Setting voltage/current limit 5000 mV 0 mA
> 
> During SNK_DISCOVERY, Cap the current limit to PD_P_SNK_STDBY_MW / 5 only
> for slow_charger_loop case.
> 
> Fixes: 1373fefc6243 ("Allow slow charging loops to comply to pSnkStby")

Your string here was incorrect, I'll fix it up this time, but please be
more careful in the future as it will get caught by our scripts.

thanks,

greg k-h
