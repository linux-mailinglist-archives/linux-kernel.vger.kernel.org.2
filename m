Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913AE43B535
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhJZPO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:14:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:45341 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhJZPO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:14:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="316139991"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="316139991"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 08:12:03 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="554742862"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 08:11:59 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id AD6E02015A;
        Tue, 26 Oct 2021 18:11:57 +0300 (EEST)
Date:   Tue, 26 Oct 2021 18:11:57 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Cc:     YE Chengfeng <cyeaa@connect.ust.hk>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: suspected null-pointer-reference problem for to_swnode
Message-ID: <YXgavSb+/NoGclFS@paasikivi.fi.intel.com>
References: <TYCP286MB11888DAE6D94FAE6A9F1CB438A839@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <YXbeF58NlV1o5tcG@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXbeF58NlV1o5tcG@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 07:40:55PM +0300, andriy.shevchenko@linux.intel.com wrote:
> On Mon, Oct 25, 2021 at 02:03:51PM +0000, YE Chengfeng wrote:
> > Hi, 
> > 
> > https://github.com/torvalds/linux/blob/master/drivers/base/swnode.c#L405
> > 
> > We notice that the return pointer of to_swnode is null check in some case, while in some case is not. For example, at line 416, the return pointer is null-check, but in line 405 is not. We want to know whether it would be a potential null pointer dereference problem, in the case that null-check is missing.
> > 
> > This problem is detected by our experimental static analysis tool, we are not familiar with the source code and it could just be a false positive. We send this email in case this is a real problem. Would you like to spare some time to have a look at it?
> 
> Thank you for the interest to our code!
> 
> Line #405 refers to software node operations and it means it won't be ever
> called if there is no swnode behind it, means it's backed with properties.
> If you think it will be a NULL pointer there, please describe in detail
> (with a traceback included) when and how it happens, because such bugs are
> serious.
> 
> Line #416 refers to the same stage when options are defined and we know we
> have been called against swnode. Seems to me like a dead code brought from
> day 1 by the commit bc0500c1e43d ("device property: Add fwnode_get_name
> for returning the name of a node").
> 
> Sakari?

Yeah, the check could be removed.

-- 
Sakari Ailus
