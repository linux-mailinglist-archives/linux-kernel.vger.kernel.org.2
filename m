Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB8234CCE7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhC2JUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:20:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:51336 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231657AbhC2JTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:19:45 -0400
IronPort-SDR: qd1V6B94AbMiOmBmT1N6edv9uZK5d3V0f5T5F/XzmoXeegZEhDP4LgRCiISuAWdprH+dMnE6b1
 mzCr9gxBQnpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="170914210"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="170914210"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 02:19:41 -0700
IronPort-SDR: SjMTix49eQ6USMEQCMKGBbcng3q9TXb5z3yTw0TwL5+pPkHcqyhwU8MrzftE9lLeFYd7sqQNaV
 XpjUY5f1LSVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="515931277"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 29 Mar 2021 02:19:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 29 Mar 2021 12:19:36 +0300
Date:   Mon, 29 Mar 2021 12:19:36 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] usb: typec: Link all ports during connector
 registration
Message-ID: <YGGbqLYXXIxmTiRT@kuha.fi.intel.com>
References: <20210329084426.78138-1-heikki.krogerus@linux.intel.com>
 <20210329084426.78138-7-heikki.krogerus@linux.intel.com>
 <YGGUU2z0qHsfgKrV@kroah.com>
 <YGGbQA/mIAu2JUWs@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGGbQA/mIAu2JUWs@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I could make a stub for the usb_for_each_port() function in case
> CONFIG_USB is not enable. Would that work?

Ah, I think that's what you meant :-)

I'll fix it.

thaks,

-- 
heikki
