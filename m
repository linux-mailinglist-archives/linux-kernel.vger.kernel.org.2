Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E083EB94C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 17:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241042AbhHMPbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 11:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236719AbhHMPbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 11:31:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 223B360F51;
        Fri, 13 Aug 2021 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628868665;
        bh=j/cq3RnilYjfjnkBy+wgYRioYjMOqrFWQpXfBHLhjRM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NB1nBQLNxxYUL21QD+hFeXDqZcf5qrOEyyIjW2wlRyrfkhAdNhhI6B2UdAzn+p+Ye
         DIG+I+9PIFjRZIqqwV/NWlHsEUDo9tQmdQbtbX3vvp50PXPAqv9B+fpvuTFcjHHcyo
         JvjKKPn6wwn9yRYgtoZ6ALY8Fli+Gix8Ly+/LIQR1MCA5k0ha+z4cQq2UPUyf/OwX4
         hj8jtiVIW7tFQDxGirAX8ghwQCKX1BAf3RDzibqxanVpy6Tv339cLqg1DrzDfUNaPH
         STiy8SJgcUXOz2ywp+QI1DkmfoGVLWAsgrqLrnOgVLSrAlHn/EoplV/HSlc4V4m3pT
         tRFgTn+BC6l9w==
Message-ID: <42a2672432301de9beee593765bb49f739ce493a.camel@kernel.org>
Subject: Re: [PATCH 0/1] tracing: Provide more parseable hist trigger output
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, bristot@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Fri, 13 Aug 2021 10:31:03 -0500
In-Reply-To: <20210813182436.0ca56fe333a80fb7188f0b14@kernel.org>
References: <cover.1628807056.git.zanussi@kernel.org>
         <20210813182436.0ca56fe333a80fb7188f0b14@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Fri, 2021-08-13 at 18:24 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Thu, 12 Aug 2021 17:43:23 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Hi Steve and Daniel,
> > 
> > Following our discussion last week about more parseable hist
> > trigger
> > output, I started trying to implement the 'csv' output you had
> > mentioned, but realized that since it was more than just table
> > output
> > that was needed, JSON would be a better fit, so implemented that in
> > this patch instead.
> 
> This seems really good feature! BTW, what about adding an tracing
> option to switch the hist output format?
> e.g.
> 
> $ echo 1 > /sys/kernel/tracing/options/hist-json
> 
> This will no need to add additional pseudo file but just add an
> option to
> the ftrace.
> 

That sounds like a good idea, thanks for the suggestion!

Tom


