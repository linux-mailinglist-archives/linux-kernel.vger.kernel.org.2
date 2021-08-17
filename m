Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453F13EE4CF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 05:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbhHQDNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 23:13:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:23689 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233690AbhHQDNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 23:13:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="203184454"
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="scan'208";a="203184454"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 20:12:43 -0700
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="scan'208";a="530849800"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 20:12:42 -0700
Date:   Mon, 16 Aug 2021 20:12:42 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH V7 14/18] memremap_pages: Add memremap.pks_fault_mode
Message-ID: <20210817031242.GF3169279@iweiny-DESK2.sc.intel.com>
References: <20210804043231.2655537-1-ira.weiny@intel.com>
 <20210804043231.2655537-15-ira.weiny@intel.com>
 <506157336072463bf08562176eff0bb068cd0e9d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <506157336072463bf08562176eff0bb068cd0e9d.camel@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:01:28PM -0700, Edgecombe, Rick P wrote:
> On Tue, 2021-08-03 at 21:32 -0700, ira.weiny@intel.com wrote:
> > +static int param_set_pks_fault_mode(const char *val, const struct
> > kernel_param *kp)
> > +{
> > +       int ret = -EINVAL;
> > +
> > +       if (!sysfs_streq(val, "relaxed")) {
> > +               pks_fault_mode = PKS_MODE_RELAXED;
> > +               ret = 0;
> > +       } else if (!sysfs_streq(val, "strict")) {
> > +               pks_fault_mode = PKS_MODE_STRICT;
> > +               ret = 0;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> 
> Looks like !sysfs_streq() should be just sysfs_streq().

Indeed. Fixed.

Thanks!
Ira

