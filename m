Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62A933E62E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 02:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCQBa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 21:30:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:40354 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhCQBa3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 21:30:29 -0400
IronPort-SDR: wTASfuCGl0M5Kz7Arte2V8tkd/JKlXQ4a0p56Kjb4Z4wOpQCINxSWlI+yUvF4sjqdshCYnDeg2
 t66AJQ4wMb1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="186006318"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="186006318"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 18:30:29 -0700
IronPort-SDR: J6Al5X435kM6nxaU0dcjd3WZPJ/3qExClmT6YtnIwJyOssL3KaBXbEXt8viPJ0Qw8OLg562xXd
 Cun3VnQtmwiw==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="405739565"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 18:30:29 -0700
Date:   Tue, 16 Mar 2021 18:30:28 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Align CSV output for summary mode
Message-ID: <20210317013028.GT203350@tassilo.jf.intel.com>
References: <20210316072900.1739-1-yao.jin@linux.intel.com>
 <YFCtfXlaKbIeEMwk@krava>
 <20210316163421.GQ203350@tassilo.jf.intel.com>
 <YFEBaVNDokSVW/34@kernel.org>
 <20210316200220.GS203350@tassilo.jf.intel.com>
 <YFEpQs4TnnxPPznF@krava>
 <ea1afc3b-0617-5b21-d0b1-9fd77bbcf0d1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea1afc3b-0617-5b21-d0b1-9fd77bbcf0d1@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it serious or just a joke? :)

I would prefer to not be compatible (at least not until someone complains),
but if compatibility is required then yes opting in to the broken
format would be better. Perhaps not with that name.

And the option could be hidden in the perf config file instead
of being on the command line.

-Andi
