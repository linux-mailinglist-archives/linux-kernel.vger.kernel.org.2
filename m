Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669E93DDBE3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhHBPIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:08:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:35026 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234755AbhHBPHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:07:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="235401798"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="235401798"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 08:07:19 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="520597918"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 08:07:16 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 02 Aug 2021 18:07:14 +0300
Date:   Mon, 2 Aug 2021 18:07:14 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rajatxjain@gmail.com
Subject: Re: [PATCH v3] thunderbolt: For dev authorization changes, include
 the actual event in udev change notification
Message-ID: <YQgKIok9DOTgmyvw@lahna>
References: <20210730235304.3179882-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730235304.3179882-1-rajatja@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

On Fri, Jul 30, 2021 at 04:53:04PM -0700, Rajat Jain wrote:
> For security, we would like to monitor and track when the thunderbolt
> devices are authorized and deauthorized (i.e. when the thunderbolt sysfs
> "authorized" attribute changes). Currently the userspace gets a udev
> change notification when there is a change, but the state may have
> changed (again) by the time we look at the authorized attribute in
> sysfs. So an authorization event may go unnoticed. Thus make it easier
> by informing the actual change (new value of authorized attribute) in
> the udev change notification.
> 
> The change is included as a key value "authorized=<val>" where <val>
> is the new value of sysfs attribute "authorized", and is described at
> Documentation/ABI/testing/sysfs-bus-thunderbolt under
> /sys/bus/thunderbolt/devices/.../authorized
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

I did some tiny changes to the title, commit message and the comment and
applied to thunderbolt.git/next, thanks!
