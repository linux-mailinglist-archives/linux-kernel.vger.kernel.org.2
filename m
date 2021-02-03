Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE1330DDAD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhBCPJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:09:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:51753 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233796AbhBCPGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:06:13 -0500
IronPort-SDR: tT8lCRqIuYgiKo8kFSE9nHboPrWAm7Gkh1rms/cvbzq8VBg7+4CE/xArFh6lNMLAGlsWZg1fnz
 DU5+adpm5vBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="180281768"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="180281768"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 07:04:27 -0800
IronPort-SDR: 2QQFBWoqAbTNQelf2fckyQ/zE30yj7Fjb2BNNzFWo1C3p5aO2QuMDBM+ZLCk582IxGv4rTLi+2
 ybQHsFHreVHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="480378544"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 03 Feb 2021 07:04:23 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 03 Feb 2021 17:04:19 +0200
Date:   Wed, 3 Feb 2021 17:04:19 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kyle Tso <kyletso@google.com>, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, robh+dt@kernel.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/8] usb: typec: Manage SVDM version
Message-ID: <20210203150419.GJ1687065@kuha.fi.intel.com>
References: <20210202161733.932215-1-kyletso@google.com>
 <20210202161733.932215-2-kyletso@google.com>
 <20210203124724.GD1687065@kuha.fi.intel.com>
 <20210203145143.GA58095@roeck-us.net>
 <20210203150121.GI1687065@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203150121.GI1687065@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 05:01:26PM +0200, Heikki Krogerus wrote:
> On Wed, Feb 03, 2021 at 06:51:43AM -0800, Guenter Roeck wrote:
> > Thinking about it, would it make make sense to define the functions as
> > static inline ?
> 
> I (and I believe Guenter too)

s/I believe Guenter too/I thought you too/

> want to keep these structures protected
> for now. If the API starts to get too bloated, then I guess I have to
> reconsider that. But I don't think we are there yet.
> 
> I have been thinking about moving the USB PD negotiation details to a
> separate structure that could be more accessible for everybody. That
> should allow me continue to protect my precious structures. But I have
> not yet put much though into that.


-- 
heikki
