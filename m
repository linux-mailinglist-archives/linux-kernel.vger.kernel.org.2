Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2F83574DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345336AbhDGTWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhDGTWd (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:22:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E359610E6;
        Wed,  7 Apr 2021 19:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617823343;
        bh=jmLZ+xusB+SeeHaJnYABY6/FQJgmA2KWVxD9y9+NHgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwJ0eT44knbKs6lzK8uFvsbB3bl23WD8zZ0eeMTGIVodipl/xA5W2RLvwoDL1ccfr
         aY9pkOsXrHXNMxxrNkEsJ0UauaN6C5X5DO1gbMuYMeF3/YizIMV5lvOAdlRbL51kl1
         00w4Kr9U3xHCFVF5CsUDU0jQUKIcl8rnJCjaVSZwhQOz1DXuj8zV63//wvTEfB9PNb
         zcM9ADorUUS4qv3rFmZrQUqoUJoX5LRgmXYdPW5kWLrPV76TLtt99K4wsDDaz6tDZY
         15MRz3WYjf+tQ/dLMfSGZ6yPPdkA2jouYCxCCyI6t849cnOk8lw5i0aotnFCBGwHJ3
         IZMiI6NC7L8jw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C1FC140647; Wed,  7 Apr 2021 16:22:19 -0300 (-03)
Date:   Wed, 7 Apr 2021 16:22:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf report: Fix wrong LBR block sorting
Message-ID: <YG4Ga9TJ3ljNP5ya@kernel.org>
References: <20210407024452.29988-1-yao.jin@linux.intel.com>
 <20210407134957.GL1285835@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407134957.GL1285835@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 07, 2021 at 06:49:57AM -0700, Andi Kleen escreveu:
> > Now the hottest block is reported at the top of output.
> > 
> > Fixes: b65a7d372b1a ("perf hist: Support block formats with compare/sort/display")
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.

- Arnaldo

