Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2375F337411
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhCKNeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:34:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:63661 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233141AbhCKNdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:33:40 -0500
IronPort-SDR: j5rnmEWxdYfscKoQWBNQv/yPmvssziPkS4AMX2OAZ+xFvlwMF8zpT4eionkptcY0ZdKMPP9iGp
 KFHCpLJNKYpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="176259745"
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="176259745"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 05:33:40 -0800
IronPort-SDR: xB56w9PhDRnuDJ7f4Gg+yUIN1KI6NhLjx7ddXPmme6K+6CnoR3ZXXNPFSsBVclTvTijXxh3Le8
 ZHKshZq4ZIKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="510015485"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 Mar 2021 05:33:36 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 11 Mar 2021 15:33:36 +0200
Date:   Thu, 11 Mar 2021 15:33:36 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: typec: tcpci_maxim: configure charging & data
 paths
Message-ID: <YEocMN1aSdDZ2dl/@kuha.fi.intel.com>
References: <20210311100313.3591254-1-badhri@google.com>
 <20210311100313.3591254-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311100313.3591254-3-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 11, 2021 at 02:03:12AM -0800, Badhri Jagan Sridharan wrote:
> This change allows the driver to configure input current/voltage
> limit for the charging path. The driver sets current_max and voltage_max
> values of the power supply identified through chg-psy-name.
> 
> The change also exposes the data_role and the orientation as a extcon
> interface for configuring the USB data controller.

This looks wrong to me. Why wouldn't you just register your device as
a separate psy that supplies your charger (which is also a psy, right)?

thanks,

-- 
heikki
