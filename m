Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D539A42C21F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhJMOJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:09:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:4860 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235828AbhJMOHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:07:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="224875991"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="224875991"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:04:14 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="491477111"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:04:12 -0700
Date:   Wed, 13 Oct 2021 22:24:09 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Oliver Urbann <oliver.urbann@gmail.com>,
        linux-kernel@vger.kernel.org, lkp@intel.com, lkp@lists.01.org,
        vkoul@kernel.org
Subject: Re: [dmaengine] fe364a7d95:
 UBSAN:array-index-out-of-bounds_in_drivers/acpi/acpica/dswexec.c
Message-ID: <20211013142409.GA9406@xsang-OptiPlex-9020>
References: <20210918150130.GA30982@xsang-OptiPlex-9020>
 <246a5a73-6b85-98b3-3830-cfc46030c044@gmail.com>
 <YWXZOdYYuQA/Ddq4@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWXZOdYYuQA/Ddq4@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi All,


On Tue, Oct 12, 2021 at 09:51:37PM +0300, Andy Shevchenko wrote:
> On Sat, Oct 09, 2021 at 11:56:20PM +0200, Oliver Urbann wrote:
> > Hi all,
> > 
> > this actually crashes s2idle e.g. on Surface Book 1 and Surface Pro 4:
> 
> You mean the mentioned patch?
> 
> It's impossible. Surface Book 1 (at least) has no such devices, which that
> patch touches, at all!

sorry about this, seems a bad bisection maybe due to our test env issues.

but rerun test, we cannot reproduce the issue now.

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
