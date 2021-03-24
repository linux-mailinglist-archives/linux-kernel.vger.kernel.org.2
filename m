Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2476347757
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 12:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhCXL20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 07:28:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:20901 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234830AbhCXL17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:27:59 -0400
IronPort-SDR: ou0Cy9TVOfMO1f50r1mWKPg55IRgXUx1JIBD2XXzupGx9Kn9aShKqBPOSluVJezG/X38ghLa54
 O2Sg/rzyHPEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="170658488"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="170658488"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 04:27:59 -0700
IronPort-SDR: fLMOpPONO57CyouVGPnnVww2LfR3v3EznRnbU862tcto+BJRX/StsbcqvicnRBXdwRlcAhGWJc
 H9H32qRUt2UQ==
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="374610721"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 04:27:56 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lP1g1-00Fec4-2i; Wed, 24 Mar 2021 13:27:53 +0200
Date:   Wed, 24 Mar 2021 13:27:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Sasha Levin <sashal@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 07/12] scripts/decode_stacktrace.sh: Support debuginfod
Message-ID: <YFsiOe7RYjSDJ6A+@smile.fi.intel.com>
References: <20210324020443.1815557-1-swboyd@chromium.org>
 <20210324020443.1815557-8-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324020443.1815557-8-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 07:04:38PM -0700, Stephen Boyd wrote:
> Now that stacktraces contain the build ID information we can update this
> script to use debuginfod-find to locate the debuginfo for the vmlinux
> and modules automatically. This can replace the existing code that
> requires specifying a path to vmlinux or tries to find the vmlinux and
> modules automatically by using the release number. Work it into the
> script as a fallback option if the vmlinux isn't specified on the
> commandline.

One wish for the shell scripts: try to avoid bashisms as much as possible,
please.

-- 
With Best Regards,
Andy Shevchenko


