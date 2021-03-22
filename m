Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBEB34370E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 04:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhCVDCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 23:02:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:21928 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhCVDCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:02:20 -0400
IronPort-SDR: /NXRf68z2Yhs5mqFMnWOblWroPy0efmyo2zdAbEGRtKmrlg7FMVmCSy7B+YiIySCcX9BKpTV3L
 AUd92VgM+Vfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="187863171"
X-IronPort-AV: E=Sophos;i="5.81,266,1610438400"; 
   d="scan'208";a="187863171"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 20:02:19 -0700
IronPort-SDR: bzxpIJoCLJe84bVcqOaqUvNBq4JQkE58kQKsYSQGh97j8g9TnHd5uKKmg6Ogh18eBITXCjKXsp
 QWO9Oh0W9L7w==
X-IronPort-AV: E=Sophos;i="5.81,266,1610438400"; 
   d="scan'208";a="414305347"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 20:02:19 -0700
Date:   Sun, 21 Mar 2021 20:02:17 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] perf stat: improve readability of shadow stats
Message-ID: <20210322030217.GC1749465@tassilo.jf.intel.com>
References: <20210315143047.3867-1-changbin.du@gmail.com>
 <YFC4ZTOhm61QWDgh@krava>
 <20210318151240.ms4ic6xfa4xx7t2u@mail.google.com>
 <YFR2PbJ+zRLunsR1@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFR2PbJ+zRLunsR1@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > But is this a real problem?
> 
> perhaps not, Andi, any idea about this?

It's not a problem for my tools which don't use the unit,
but I could imagine one for other parsers. I would recommend
to not change it for CSV, which is expected to be parsed
by tools.

-Andi
