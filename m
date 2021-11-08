Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A48447CF3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbhKHJke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:40:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:5699 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236038AbhKHJk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:40:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="232140155"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="232140155"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 01:37:43 -0800
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="668945420"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 01:37:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mk15k-004cdN-PA;
        Mon, 08 Nov 2021 11:37:28 +0200
Date:   Mon, 8 Nov 2021 11:37:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, 282827961@qq.com
Subject: Re: [PATCH v14] tty: Fix the keyboard led light display problem
Message-ID: <YYjv2A1T/uOacEtS@smile.fi.intel.com>
References: <20211108055139.7202-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108055139.7202-1-changlianzhi@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 01:51:39PM +0800, lianzhi chang wrote:
> Switching from the desktop environment to the tty environment,
> the state of the keyboard led lights and the state of the keyboard
> lock are inconsistent. This is because the attribute kb->kbdmode
> of the tty bound in the desktop environment (Xorg) is set to
> VC_OFF, which causes the ledstate and kb->ledflagstate
> values of the bound tty to always be 0, which causes the switch
> from the desktop When to the tty environment, the LED light
> status is inconsistent with the keyboard lock status.
> In order to ensure that the keyboard LED lights are displayed
> normally during the VT switching process, when the VT is
> switched, the current VT LED configuration is forced to be issued.

...

> Suggested-by: dmitry.torokhov <dmitry.torokhov@gmail.com>

Dmitry Torokhov

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

As per v13 and previous ones, I haven't suggested anything in the
_current_ implementation.

-- 
With Best Regards,
Andy Shevchenko


