Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C05D388CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244449AbhESLfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:35:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:22027 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhESLfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:35:14 -0400
IronPort-SDR: Lpw5zyZt6/WodeMDEJpZeGtq48dI7/jRc8MLK8VtRuFJfO3tMg/vTQDqxWY4BeGns/A30Aj0q9
 15a1diuf1X0g==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="197862775"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="197862775"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 04:33:55 -0700
IronPort-SDR: fcQ6N0d5zcMYSZig/l2twvSPHWM2ptsG3Dx/LwZnmb/nyLafED1WPZUTTrghP7o04hctpbvAVW
 jUICdWmSzjmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="542515866"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 19 May 2021 04:33:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 19 May 2021 14:33:52 +0300
Date:   Wed, 19 May 2021 14:33:52 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benjamin Berg <bberg@redhat.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Clear pending after acking connector
 change
Message-ID: <YKT3oEt/9fX8k8mw@kuha.fi.intel.com>
References: <20210516040953.622409-1-bjorn.andersson@linaro.org>
 <YKI/XT8qpZDjDuqs@kuha.fi.intel.com>
 <YKJeYzIgvL/soGgw@kuha.fi.intel.com>
 <cd62e9a6d317e106db5e5d6b5f36170524ed7ad9.camel@redhat.com>
 <YKPBPqZ6zHBsCnsO@kuha.fi.intel.com>
 <7c09a6bf2ee0a644863f1ec8b333c871cf83d5b8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c09a6bf2ee0a644863f1ec8b333c871cf83d5b8.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 08:04:14PM +0200, Benjamin Berg wrote:
> On Tue, 2021-05-18 at 16:29 +0300, Heikki Krogerus wrote:
> > On Mon, May 17, 2021 at 02:57:28PM +0200, Benjamin Berg wrote:
> > > 
> > > [SNIP]
> > > Unfortunately, I don't feel it'll work. The problem that I was
> > > seeing
> > > looked like a race condition in the PPM itself, where the window is
> > > the
> > > time between the UCSI_GET_CONNECTOR_STATUS command and the
> > > subsequent
> > > ACK.
> > > For such a firmware level bug in the PPM, we need a way to detect
> > > the
> > > race condition when it happens (or get a fix for the firmware).
> > 
> > OK. Let me know does the patch bring the issue back for you.
> 
> So, I just tried the patch, and I can occasionally reproduce the issue
> where "online" for the ucsi power adapter is stuck at "1" after
> unplugging with the patch applied.

Thanks for testing it.

I'm still not sure that the PPM is the culprit here. I have a feeling
that the problem you are seeing is caused by the workaround (bad
workaround) that we have for the issue where the EC firmware does not
return with the BUSY bit set in the CCI when it should in many cases.
The UCSI ACPI driver has one minute timeout value for command
completion because of that, which is way too long. So if the EC
firmware decides to take its time before acknowledging command, the
driver is stuck, and we start loosing the events... Well, I guess
technically the PPM would be the culprit in the end in any case, but
I'm just not sure that there is any race like you suspected.

But this is off topic. I'll send you an RFC proposal what I think we
could do about that.


thanks,

-- 
heikki
