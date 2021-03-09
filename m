Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E0E332589
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhCIMgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:36:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhCIMfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:35:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6ADE6523F;
        Tue,  9 Mar 2021 12:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615293347;
        bh=PzdBHv9A/D94ZQ+PYzPZx3jQMymmM/7oZH9V8vqLcFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZNaiJbVMZKT3h8tZ43ZSVDJ/7Rh4a3IFgSr5CLh5KW+DiGSlKpCZ7r+EYaMGueHAW
         HDBLm+W+N79AtlXP0jtAiUOnWO/HydzI7lhJuzcugEv3+7cDJ0G0lMh2n3WqULP2PO
         UBntNWIYeZ45Jr87BDpgU/CDOfRmGglV3LXk3f0P3GTqvBbFKAQ2sS4hmvtc5sdRmr
         58C8WWuq+VVuvLAmR53XA0Ld3GHn6gRHkIY5GQgWt3kcYpwpnVJ/QUcpTjMvYs35UM
         DjCKwShBZGSoxcXPcyjzPQ49cJkdi8oR9c2s+/WWzS7RsQILsnfv/ctjZ4C988JAa/
         GJbWnyAHsC50Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 390B840647; Tue,  9 Mar 2021 09:35:42 -0300 (-03)
Date:   Tue, 9 Mar 2021 09:35:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf auxtrace: Fix auxtrace queue conflict
Message-ID: <YEdrngHYJh3L6zXH@kernel.org>
References: <20210308151143.18338-1-adrian.hunter@intel.com>
 <20210308165437.GA203350@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308165437.GA203350@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 08, 2021 at 08:54:37AM -0800, Andi Kleen escreveu:
> On Mon, Mar 08, 2021 at 05:11:43PM +0200, Adrian Hunter wrote:
> > The only requirement of an auxtrace queue is that the buffers are in
> > time order.  That is achieved by making separate queues for separate
> > perf buffer or AUX area buffer mmaps.
> > 
> > That generally means a separate queue per cpu for per-cpu contexts,
> > and a separate queue per thread for per-task contexts.
> > 
> > When buffers are added to a queue, perf checks that the buffer cpu
> > and thread id (tid) match the queue cpu and thread id.
> > 
> > However, generally, that need not be true, and perf will queue
> > buffers correctly anyway, so the check is not needed.
> > 
> > In addition, the check gets erroneously hit when using sample mode
> > to trace multiple threads.
> > 
> > Consequently, fix that case by removing the check.
> 
> Thanks!
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.

- Arnaldo

