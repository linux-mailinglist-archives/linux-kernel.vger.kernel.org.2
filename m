Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B25E3F89BD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbhHZOHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:07:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:33804 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242859AbhHZOHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:07:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="303326971"
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="303326971"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 07:06:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="598493202"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 26 Aug 2021 07:06:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 26 Aug 2021 17:06:08 +0300
Date:   Thu, 26 Aug 2021 17:06:08 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liu, Kun" <Kun.Liu2@amd.com>
Subject: Re: [RESEND PATCH 2/2] usb: dwc3: pci add property to allow user
 space role switch
Message-ID: <YSef0Iyr3oDWv6Kt@kuha.fi.intel.com>
References: <20210824192337.3100288-1-Nehal-Bakulchandra.shah@amd.com>
 <87ilzu5ap0.fsf@kernel.org>
 <YSXqsXmuom2fFiKN@kuha.fi.intel.com>
 <YSXwkKJ53d/uwnhy@kuha.fi.intel.com>
 <BL1PR12MB51443C94208DDE0AEBCB91A6F7C69@BL1PR12MB5144.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51443C94208DDE0AEBCB91A6F7C69@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Wed, Aug 25, 2021 at 01:50:48PM +0000, Deucher, Alexander wrote:
> I'm not a USB expert, but I think the idea was to pop up a message asking the
> user what role they wanted when they plugged in USB cable?  Then based on
> their input, the role could be changed.

What exactly is the ACPI/EC interrupt in this case?

Note, that simply selecting one role will only work if the partner
device happens to be in the opposite role at the same time (actually,
even that may not be enough). So for example by selecting host role
will only work if the partner happens to be in device role. If the
parter is also in host role, nothing happens, or both ends just fail
to enumerate each other.

So you always have to negotiate the role with the partner one way or
the other. Now we need to understand how that negotiation is handled
(or is expected to be handled) on this platform.

Which type of connector are we talking about here? Is it USB Type-C,
or is it something else?

thanks,

-- 
heikki
