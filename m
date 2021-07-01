Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3612E3B932E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhGAOZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:25:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233099AbhGAOZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:25:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7E06613FE;
        Thu,  1 Jul 2021 14:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625149403;
        bh=71dtrSrZfrzS+xQNIPrnzH/rK7SELJ0qjeko7lo3GbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBv+FAd78+T0qfW/ZsK3Wa9bq9Zv+49V7xKPG+QuODWvzsomfzRUAHl+jo8FwR4Ab
         rg7IkFiKaya0h0w140sNdsdyUgqOmQEMQgNbMpUh+UyH1Mkiofxb51oHj52IDpQbnb
         39tok0eAaG4WsilBYj+VZVEhYd7ghIbutInXC1H4b/fZwLh/TzLaDzRTiimRxlZlHP
         hawNZl2XNhiqnozEnemp7T7q3Uuuuh3nB3jfr34XHAhFkT7krVj9Engd9fYSNFnS2j
         cZhdjf2q/z1Ik6yfIcOlqOIPDz/GUab67saHkI2z7xfWberoWyNV+PPa6NW+MN6NN6
         npNXp/fe+Nh/g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 11F1040B1A; Thu,  1 Jul 2021 11:23:19 -0300 (-03)
Date:   Thu, 1 Jul 2021 11:23:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v8 01/22] perf record: Introduce thread affinity and mmap
 masks
Message-ID: <YN3P1uHBkh7JXBDN@kernel.org>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <ab1e7917845cc175a9e1d7f149e07b000d24c881.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <YNyZCZ92W39inSD2@kernel.org>
 <b4e43f46-71d5-457b-dcbf-aada28d7ba95@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4e43f46-71d5-457b-dcbf-aada28d7ba95@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 01, 2021 at 04:05:09PM +0300, Bayduraev, Alexey V escreveu:
> Hi,
> 
> On 30.06.2021 19:17, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jun 30, 2021 at 06:54:40PM +0300, Alexey Bayduraev escreveu:
> [SNIP]
> >> +static void record__mmap_cpu_mask_free(struct mmap_cpu_mask *mask)
> >> +{
> >> +	bitmap_free(mask->bits);
> >> +	mask->nbits = 0;
> > 
> > Plese use NULL, as 'mask->nbits' is a pointer.
> 
> In perf/util/mmap.h "nbits" is size_t:
> 
> struct mmap_cpu_mask {
>         unsigned long *bits;
>         size_t nbits;
> };

My bad, I saw the pattern of:

    *_free(mask->bits);
    mask->bits = 0;

Nevermind :-)

- Arnaldo
