Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C78D33B3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCONVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhCONV1 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:21:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFD4564EC4;
        Mon, 15 Mar 2021 13:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615814487;
        bh=9yu7FoDXN0uX3iH926FcF+/L33dySZiHAZekW55YXes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m5X7WXRzi0UmWgo/q3j98S7gZ0fkeLuxd6FM3kabAamjrz5pyOzdT6Cq0wiTxNiVm
         J3JZ8bRRBXX7YMHfgVW2JMaG0J1xVr4VHK+iVwXPoB8l+452ADKFFEcc86zbdIu2n1
         Pfa3qLUd7F0BBgizoDes/GHULn/x1tw2N9G/NKausg0wd7PHuU/MoOCCXEW57zjpWa
         qzFTdgADbuitXHeQHa5EwvUKzALFpCdjZZ5O9YZOlFmsdemUjEgOFbwA/3SITPMxj6
         vvLEHxySXu36lzCnNr+FrzkPymwrbmX8fM1gMw9kUx3UJ+W3ZPdcbSukpJYAyNv8CQ
         sAA+zykdZbGdg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AAD4B40647; Mon, 15 Mar 2021 10:21:24 -0300 (-03)
Date:   Mon, 15 Mar 2021 10:21:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4] perf pmu: Validate raw event with sysfs exported
 format bits
Message-ID: <YE9fVCiJJVviY8XW@kernel.org>
References: <20210310051138.12154-1-yao.jin@linux.intel.com>
 <YEivmv6WCWW9ae59@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEivmv6WCWW9ae59@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 10, 2021 at 12:38:02PM +0100, Jiri Olsa escreveu:
> On Wed, Mar 10, 2021 at 01:11:38PM +0800, Jin Yao wrote:
> > Warnings are reported for invalid bits.
> > 
> > Co-developed-by: Jiri Olsa <jolsa@redhat.com>
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> Reviewed-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

