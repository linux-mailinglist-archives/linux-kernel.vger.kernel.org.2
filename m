Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28003F6FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 09:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbhHYHCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 03:02:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:58094 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238342AbhHYHBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 03:01:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="204598664"
X-IronPort-AV: E=Sophos;i="5.84,349,1620716400"; 
   d="scan'208";a="204598664"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 00:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,349,1620716400"; 
   d="scan'208";a="597924473"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 25 Aug 2021 00:01:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 25 Aug 2021 10:01:05 +0300
Date:   Wed, 25 Aug 2021 10:01:05 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kun.liu2@amd.com,
        alexander.deucher@amd.com
Subject: Re: [RESEND PATCH 2/2] usb: dwc3: pci add property to allow user
 space role switch
Message-ID: <YSXqsXmuom2fFiKN@kuha.fi.intel.com>
References: <20210824192337.3100288-1-Nehal-Bakulchandra.shah@amd.com>
 <87ilzu5ap0.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilzu5ap0.fsf@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 08:55:41AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com> writes:
> 
> > For AMD platform there is a requirement to enable user space role
> > switch from host to device and device to host as customer platform is not
> > completely capable of OTG i.e. with type C controller it does not have PD
> > to support role switching. Hence, based ACPI/EC interrupt role switch is
> > triggered by the usemode script running in background.
>                    usermode ?

Couldn't you capture that ACPI/EC interrupt in kernel?

> > Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
> 
> I'm okay with this, just wondering if we need to Document the property
> somewhere.
> 
> @Heikki, is there a place to document these private properties that's
> not on DT binding document?

The build-in properties are not documented separately. I've always
tried to supply DT bindings for all new properties I've proposed.

In this case though, do we need the new property at all? Why not just
register a normal USB role switch on this platform? It can be either a
dummy role switch that only passes the user space input to dwc3, or,
perhaps ideally, it would also be a driver that captures that ACPI/EC
event/notification and then passes the information from it to dwc3.

thanks,

-- 
heikki
