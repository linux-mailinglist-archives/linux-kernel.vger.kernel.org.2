Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6029631C7E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhBPJPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:15:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:8434 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhBPJOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:14:30 -0500
IronPort-SDR: dcTK4CFj/2S+r3D1wYwovg+km1zYH0RQa/m/tpjLCFTvSNh7orVjeFcizNcOl1YXqvz4sYTO1w
 o08RED0tev0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="246904342"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="246904342"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 01:12:28 -0800
IronPort-SDR: WLGJKMtOoQmjmODU33DL+6M/UYdsoM9BrVyC1fBaHG3rjmcBzP8i1saMwTyC4/LaqPcRPn8FCs
 msZzJ2cBNNkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="493133591"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 16 Feb 2021 01:12:26 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 16 Feb 2021 11:12:25 +0200
Date:   Tue, 16 Feb 2021 11:12:25 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Cristian.Birsan@microchip.com
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Using TCPM for ports without Power Delivery support
Message-ID: <YCuMeW6lbaSq8CIM@kuha.fi.intel.com>
References: <6cf411e1-8234-d1ca-541d-067665620945@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cf411e1-8234-d1ca-541d-067665620945@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

On Mon, Feb 15, 2021 at 05:25:29PM +0000, Cristian.Birsan@microchip.com wrote:
> My name is Cristian and I'm working on bringing up a USB Type-C Port Controller
> (TCPC) without Power Delivery support which is intended to work with USB 2.0
> Host/Device.
> 
> The IP is integrated into one of Microchip's SoCs, it is memory-mapped and it
> was designed based on USB Type-C Cable and Connector specification revision 1.2.
> 
> In brief, it has support for detecting the threshold voltages on CC1, CC2 lines,
> control of the current source (Ip), and pull-down resistors (Rd). The management
> of the controller is to be implemented in software (it is not autonomous).
> 
> Having in mind that the controller uses proprietary registers, I chose to
> implement it using TCPM directly and skip the TCPC Interface.
> 
> For the beginning, I would like to enable simple use cases like the ones
> described in Connection State Diagram: Source and Connection State Diagram: Sink
> from USB Type-C Cable and Connector Specification.
> 
> Some of the problems that I encountered until now are:
> 
> 1. tcpm_register_port() fails if set_pd_rx(), pd_transmit() or set_vconn()
> functions are missing.
> 
> 2. the port capabilities are specified in the connector DT bindings only through
> PDOs, even though PDOs are specific to PD mode.
> 
> 3. once I was able to start the TCPM state machine, it called pd_transmit() in
> the process to negotiate the capabilities. For my case I used a dummy function
> just to be able to register the port.
> 
> Please let me know what you think and if you have any advice. Am I going in the
> right direction or is there a better way to implement this?

Don't bother with tcpm if you don't have PD support. Just register
your port(s) and the partners directly with the connector class:
https://www.kernel.org/doc/html/latest/driver-api/usb/typec.html

You can use the driver for the TI HD3SS3220 controller as an example
how to do that (drivers/usb/typec/hd3ss3220.c). That thing is also
just USB Type-C PHY without PD support just like your port controller.


Br,

-- 
heikki
