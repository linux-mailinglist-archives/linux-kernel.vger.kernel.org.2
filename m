Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D4A41EC82
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353892AbhJALuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:50:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:48246 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353688AbhJALuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:50:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="222209596"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="222209596"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 04:48:48 -0700
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="521002789"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 04:48:45 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mWH1u-007Qlq-8G;
        Fri, 01 Oct 2021 14:48:42 +0300
Date:   Fri, 1 Oct 2021 14:48:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Eric Tremblay <etremblay@distech-controls.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com
Subject: Re: [PATCH v2 1/3] serial: 8250: Handle UART without interrupt on
 TEMT using em485
Message-ID: <YVb1mvhDgbw7Oofz@smile.fi.intel.com>
References: <20210204161158.643-1-etremblay@distech-controls.com>
 <20210204161158.643-2-etremblay@distech-controls.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204161158.643-2-etremblay@distech-controls.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:11:56AM -0500, Eric Tremblay wrote:
> The patch introduce the UART_CAP_NOTEMT capability. The capability

s/The patch//

> indicate that the UART doesn't have an interrupt available on TEMT.

indicates

> In the case where the device does not support it, we calculate the
> maximum time it could take for the transmitter to empty the
> shift register. When we get in the situation where we get the
> THRE interrupt, we check if the TEMT bit is set. If it's not, we start
> the a timer and recall __stop_tx() after the delay.
> 
> The transmit sequence is a bit modified when the capability is set. The
> new timer is used between the last interrupt(THRE) and a potential
> stop_tx timer.

> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> [moved to use added UART_CAP_TEMT]
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> [moved to use added UART_CAP_NOTEMT, improve timeout]
> Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>

Does it need Co-developed-by tag(s)?

...

> +#define UART_CAP_NOTEMT	(1 << 18)	/* UART without interrupt on TEMT available*/

Missed space in the comment .

...

> +static inline void serial8250_em485_update_temt_delay(struct uart_8250_port *p,
> +			unsigned int cflag, unsigned int baud)
> +{
> +	unsigned int bits;
> +
> +	if (!p->em485)
> +		return;
> +
> +	bits = uart_get_byte_size(cflag);

Should be rebased. We have tty_get_frame_size() for a while.

> +	p->em485->no_temt_delay = bits * NSEC_PER_SEC / baud;
> +}

-- 
With Best Regards,
Andy Shevchenko


