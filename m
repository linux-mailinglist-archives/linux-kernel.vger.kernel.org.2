Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2651B33DD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbhCPTGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240281AbhCPTFR (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:05:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E152665143;
        Tue, 16 Mar 2021 19:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615921517;
        bh=hpKw8/XNIiNUw9sDP9huKpQsKF/yiplg1L+ot86OpaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lNgj6xtU/f1FvjzgEFop3oEEVkEBJ3E7ds0Nj6RpSohJ6u73GhYTQYMvOJTwgSkqL
         5QvPy9+m4vsqxj93stSZkHoYC8/pofFleRKcIy545HluuJFiPFB2+2DNk/P3b1JyCi
         I7cITtgHK/gGuXx+9jsRrRTd+UQKcDv+i2j9n5iWZ3j+AirqlRZ9wgwnACB1Pw1GsZ
         CqaxFoJh8tWrytvdiLIErvf3lAv9+XkddDMjCerOYUGy1IAyKnetK8SV7sqd834NST
         Wnq+3XFtPiE9BJ0DdLPgFT7xiG9pAnuUHH8o7YUxQdMytTEBgxRA2Q28lxqq+rzJr1
         o/5ApGOpbnxGA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CA02340647; Tue, 16 Mar 2021 16:05:13 -0300 (-03)
Date:   Tue, 16 Mar 2021 16:05:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Align CSV output for summary mode
Message-ID: <YFEBaVNDokSVW/34@kernel.org>
References: <20210316072900.1739-1-yao.jin@linux.intel.com>
 <YFCtfXlaKbIeEMwk@krava>
 <20210316163421.GQ203350@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316163421.GQ203350@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 16, 2021 at 09:34:21AM -0700, Andi Kleen escreveu:
> > looks ok, but maybe make the option more related to CVS, like:
> > 
> >   --x-summary, --cvs-summary  ...? 
> 
> Actually I don't think it should be a new option. I doubt
> anyone could parse the previous mess. So just make it default
> with -x

In these cases I always fear that people are already parsing that mess
by considering the summary lines to be the ones not starting with
spaces, and now we go on and change it to be "better" by prefixing it
with "summary" and... break existing scripts.

Can we do this with a new option?

I.e. like --cvs-summary?

- Arnaldo
