Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8B335137B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhDAK2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:28:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:23074 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233985AbhDAKUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:20:22 -0400
IronPort-SDR: n27evUeVa9ikOqkYsKHdg1seF0T6VVWRJ7QwgaYBrYklCiXAVTcf6/QQiYdZ68xsUGE/i0oDlC
 SX6rZlTUxDXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="192314880"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="192314880"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 03:20:21 -0700
IronPort-SDR: WqOawMIMeiqpoTx+iitqHhEl43Oqq8lsbKjMPkMdr6i2Hb07m1HpujGAhSct7qQC3dLPutEOnJ
 u86ImlpnMnig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="517286034"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 01 Apr 2021 03:20:04 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 01 Apr 2021 13:20:04 +0300
Date:   Thu, 1 Apr 2021 13:20:04 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] usb: Linking ports to their Type-C connectors
Message-ID: <YGWeVLnYJw7RKuj7@kuha.fi.intel.com>
References: <20210401065347.4010-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401065347.4010-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 09:53:41AM +0300, Heikki Krogerus wrote:
> Hi,
> 
> One more version. I used #ifdef when I should have used #if
> IS_DEFINED(). Thanks Guenter for pointing that out.
> 
> I'm sending this version right away because of the holidays. I'm not
> changing anything else except that one fix.

I have to prepare one more version.

Unfortunately we can not use IS_DEFINED() either. I have to use
IS_REACHABLE() instead.

I'm sorry about this.


thanks,

-- 
heikki
