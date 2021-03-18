Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18203406A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhCRNQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCRNQD (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:16:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F253E64EBD;
        Thu, 18 Mar 2021 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616073363;
        bh=C/B1ZRpqStHnQqeimo2sxlW2jKXBlGaKxLvQVDQkiM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CT4KJ/2SkOFDD0MzdDQttNFq3f9C1TEw7AGovXjUdOa0SfaMWlZWMl7YoY58rpj/0
         RaX38caJC0BkeI0GhrNKkPqx4glLQQWfwllxlAWxDYVEFidwI83Ey3QQkasYJ89NMX
         W1R1B1OAWJBPzkOzzoWVfZyaUzOPQK+GsOk5zTaYBSEc8eoIJz6L5b2Sefo4fnqksP
         V6GHTHU4q65FCQx/ai2VAGqgioMpNw3qr2y/5QTXynUYxzthmxl5UDHhdsi76Tj6YI
         YpFhtxuonCOCrSLqFRo93LhxPhpXSOYNT6IywUa7lKvlEYH+7ESvpTT36pR5SXdbtl
         k92jISO+cSZfA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3D56A40647; Thu, 18 Mar 2021 10:15:56 -0300 (-03)
Date:   Thu, 18 Mar 2021 10:15:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf stat: Align CSV output for summary mode
Message-ID: <YFNSjP4LKnixkQWq@kernel.org>
References: <20210317070205.10315-1-yao.jin@linux.intel.com>
 <YFID6MjXSc21YzE2@kernel.org>
 <20210317215142.GB1369306@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317215142.GB1369306@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 17, 2021 at 02:51:42PM -0700, Andi Kleen escreveu:
> > If you care about not breaking existing scripts, then the output they
> > get with what they use as command line options must continue to produce
> > the same output.
> 
> It's not clear there are any useful ones (except for tools that handle
> both). It's really hard to parse the previous mess. It's simply not
> valid CSV.
> 
> That's why I'm arguing that keeping compatibility is not useful here.
> 
> We would be stuck with the broken mess as default forever.

Fair enough, lets fix the default then. Jin, can you please consider
adding a 'perf test' shell entry to parse the CSV mode with/without that
summary? This way we'll notice when the new normal gets broken.

- Arnaldo
