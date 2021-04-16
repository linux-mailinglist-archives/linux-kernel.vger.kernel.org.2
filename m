Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F87336298F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbhDPUmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:42:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:54070 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236729AbhDPUml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:42:41 -0400
IronPort-SDR: Q8kzOYqd2g+FB7L+Ai4sI/A4+aVOulvfMcXKZQZ+cC8eHI+dy3r/mLtS4qlxTaVbFQyHMhmEA5
 oj9JQtjNpNqA==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="194666080"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="194666080"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 13:42:14 -0700
IronPort-SDR: VMN/yvwzUAEtqXtPbSENZpWF9mdx/VnKkASKc6KdSzTpPUKbwidcp1r9hmxyqJ1Sj+rfsJZLF9
 YrlZD7ZsNtUQ==
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="400016402"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 13:42:12 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lXVI2-004l93-3X; Fri, 16 Apr 2021 23:42:10 +0300
Date:   Fri, 16 Apr 2021 23:42:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>
Subject: Re: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
Message-ID: <YHn2oiP+2YpkFGXQ@smile.fi.intel.com>
References: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com>
 <YHnLCoeBDn3BcRx1@smile.fi.intel.com>
 <CAPcyv4iwiJwwgiisZTqk6F=A8hLJCGkK-4suqDMPYYiLzuLwFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iwiJwwgiisZTqk6F=A8hLJCGkK-4suqDMPYYiLzuLwFA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 01:08:06PM -0700, Dan Williams wrote:
> [ add Erik ]
> 
> On Fri, Apr 16, 2021 at 10:36 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Apr 15, 2021 at 05:37:54PM +0300, Andy Shevchenko wrote:
> > > Strictly speaking the comparison between guid_t and raw buffer
> > > is not correct. Return to plain memcmp() since the data structures
> > > haven't changed to use uuid_t / guid_t the current state of affairs
> > > is inconsistent. Either it should be changed altogether or left
> > > as is.
> >
> > Dan, please review this one as well. I think here you may agree with me.
> 
> You know, this is all a problem because ACPICA is using a raw buffer.

And this is fine. It might be any other representation as well.

> Erik, would it be possible to use the guid_t type in ACPICA? That
> would allow NFIT to drop some ugly casts.

guid_t is internal kernel type. If we ever decide to deviate from the current
representation it wouldn't be possible in case a 3rd party is using it 1:1
(via typedef or so).

-- 
With Best Regards,
Andy Shevchenko


