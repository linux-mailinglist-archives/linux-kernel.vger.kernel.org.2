Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4293585DB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhDHOGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:06:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:8221 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231924AbhDHOGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:06:24 -0400
IronPort-SDR: SXQtDkgFO+sXdaVUPY/qAVdJrBWfCnqgPACWBi8N5b53tQyLWV8xSIK6PujQmEmhRnL4AyWgPh
 gpvjeYwhi9EA==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="213955020"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="213955020"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 07:06:01 -0700
IronPort-SDR: YeonUy7lZZP2WoUSifB3wyzd2TbbIJyqUpW6r0FdBjI6XXcJcyFhvggZKfJzlZGVeJIJTlNkmH
 EuAlnpTc9eGA==
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="448675712"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 07:05:58 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lUVIA-002Iyg-UR; Thu, 08 Apr 2021 17:05:54 +0300
Date:   Thu, 8 Apr 2021 17:05:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 04/12] module: Add printk format to add module build
 ID to stacktraces
Message-ID: <YG8NwgD3y/ydzVXI@smile.fi.intel.com>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-5-swboyd@chromium.org>
 <YG8I2dQWkOIkypqO@gunter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG8I2dQWkOIkypqO@gunter>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 03:44:57PM +0200, Jessica Yu wrote:
> +++ Stephen Boyd [30/03/21 20:05 -0700]:

...

> > +static void init_build_id(struct module *mod, const struct load_info *info)
> > +{
> > +	const Elf_Shdr *sechdr;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < info->hdr->e_shnum; i++) {
> > +		sechdr = &info->sechdrs[i];
> > +		if (!sect_empty(sechdr) && sechdr->sh_type == SHT_NOTE &&
> > +		    !build_id_parse_buf((void *)sechdr->sh_addr, mod->build_id,
> > +					sechdr->sh_size))
> > +			break;
> > +	}
> > +}
> 
> Why not just look for the .note.gnu.build-id section instead of trying
> to parse each note section? Doesn't it always contain the build id? At
> least the ld man page seems to suggest this section name should be
> consistent.

Interesting idea (in positive way!), I'm wondering what Clang does in such
case.

-- 
With Best Regards,
Andy Shevchenko


