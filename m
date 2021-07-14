Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282063C85EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbhGNOU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:20:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:41190 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239479AbhGNOU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:20:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="190036409"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="190036409"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 07:17:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="488078545"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 07:17:34 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m3fhY-00DLm4-PW; Wed, 14 Jul 2021 17:17:28 +0300
Date:   Wed, 14 Jul 2021 17:17:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Justin He <Justin.He@arm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] make '%pD' print the full path of file
Message-ID: <YO7x+OA3Osq73ooP@smile.fi.intel.com>
References: <20210623055011.22916-1-justin.he@arm.com>
 <YNL8LlRLhr6Iq/OK@smile.fi.intel.com>
 <AM6PR08MB43763816EBF217940F5B3E15F7139@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB43763816EBF217940F5B3E15F7139@AM6PR08MB4376.eurprd08.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 01:24:48PM +0000, Justin He wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Wednesday, June 23, 2021 5:18 PM
> > On Wed, Jun 23, 2021 at 01:50:07PM +0800, Jia He wrote:

...

> > > v2:
> >
> > Should be v6 now. So, next v7, otherwise you confuse bots and people.
> >
> > My remark was for you for the future submission, this one is already
> > spoiled.
> >
> Sorry for the verbose, the next version of this series should be
> v7 or v3?

v7 with changelog explaining each version difference. I have no idea how many
you issued due to the numbering confusion.

...

> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

I think it's last time I'm answering message from you with this footer. Can you
please close this deal once for ever?

Ah, and usually I do not answer on private emails on Open Source matters. LKML is restored.

-- 
With Best Regards,
Andy Shevchenko


