Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C46F33FAA9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCQVwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:52:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:38295 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhCQVvo (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:51:44 -0400
IronPort-SDR: i+mGVPX9xJlnun/1RByZOpVv2ShLsjhvHUCbpnswMkiLao388B1plx61AfbJkjrgsrjBCy6u9G
 e+N7YrfGE+BA==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="274603628"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="274603628"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 14:51:44 -0700
IronPort-SDR: geSoaf3xIPqi0U+RyRij9dGg3crcOoswPF7KDxhcepK7ej4h5gzxvesr9cmU1qwlkAm92lTM7Z
 3aKzTYIhxpQQ==
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="388992994"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 14:51:43 -0700
Date:   Wed, 17 Mar 2021 14:51:42 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf stat: Align CSV output for summary mode
Message-ID: <20210317215142.GB1369306@tassilo.jf.intel.com>
References: <20210317070205.10315-1-yao.jin@linux.intel.com>
 <YFID6MjXSc21YzE2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFID6MjXSc21YzE2@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you care about not breaking existing scripts, then the output they
> get with what they use as command line options must continue to produce
> the same output.

It's not clear there are any useful ones (except for tools that handle
both). It's really hard to parse the previous mess. It's simply not
valid CSV.

That's why I'm arguing that keeping compatibility is not useful here.

We would be stuck with the broken mess as default forever.

-Andi
