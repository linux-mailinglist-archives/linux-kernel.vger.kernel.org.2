Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7533F2DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbhHTOSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240831AbhHTOSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:18:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF40261101;
        Fri, 20 Aug 2021 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629469077;
        bh=3Id4i7Vn9AJMZd9GzoZIT4B2cIhgTAM9VcXua81KObk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jz6MZgqF4JMu1jNPrJEBkIeOYHd7xGaNsBNhJbQF6p5AND9uKXOOazw6LzY51nvcB
         iMgbBD6b1D7CuM4fXZJl8jO40fgmCn5KaoQZnyYVuHwa9PTSfMg9+PvKupwi9sxqip
         7HeIAlNoEtX25Xrk+d0OuQRXiMCo+pXnOqcgdVP+lcLxjp7UEBjT1Pm7yVZlVv9Pyy
         EekjMd9zCYxM/fx3QK6F4upMJTpabGJa47vgu6/RbA9/j02H1t/fZ5DMdECw0dtHh3
         Sw9a2cZFpl3ElWZX/Qg9lqiyi+0PIGj0v/9RSFvcmM4TsjvI52DxMSJ87Dhtbbwhb4
         0vKg9YUfnBMEQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E38DC4007E; Fri, 20 Aug 2021 11:17:53 -0300 (-03)
Date:   Fri, 20 Aug 2021 11:17:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests: dlfilter: free desc and long_desc in
 check_filter_desc
Message-ID: <YR+5kVUzkpY/ghgl@kernel.org>
References: <20210820113132.724034-1-rickyman7@gmail.com>
 <1c426e33-d918-23d4-59ca-b96071491933@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c426e33-d918-23d4-59ca-b96071491933@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 20, 2021 at 03:29:39PM +0300, Adrian Hunter escreveu:
> On 20/08/21 2:31 pm, Riccardo Mancini wrote:
> > In dlfilter-test, the function check_filter_desc calls get_filter_desc
> > which allocates desc and long_desc.
> > However, these variables are never deallocated.
> > 
> > This patch adds the missing frees.
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Fixes: 9f9c9a8de2d5e96c ("perf tests: Add dlfilter test")
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

