Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B172453C06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhKPWCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 17:02:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhKPWCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 17:02:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 558D26140A;
        Tue, 16 Nov 2021 21:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637099942;
        bh=oCeZdmJnuYgJgC3ZmFjJ2RmNhmO+2nr96HGCnF2I0Vg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q9ZjYmymPKUvkmNJIPoTK/U+lAIciPOaDPVpoPk6jeoSpp0go/XQ/rLFMv/7B2YfV
         3nJlRuYk+jS/WjTrSYnL6JpuiGEV/ZjNg6e2MQodgvqEuNbP0aGhtkO/eE40X0pQMw
         WqFgreTKyTPaKdOzMiDfJBsibg6YfNUcGK3Vet5ZBzaEGaiPV0aNcipyrjVVxlM17m
         /2QqNvUAJozzINUfQ3UF3cBkyn6iAPvTR+3DDFjBHfyxfS7ddOiOfB0kAhDuDJ+1/t
         /K1+0dfOW0CICQnCYd3og4tLGatvzwAY1qNty4AQPITThnc7QkmcBWFCjdGlued70V
         Ob4hREZHdBVGg==
Message-ID: <7d7de7ce5b6e6ab4ae497495f86ad65d86a613dc.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] tracing: Add helper functions to simplify
 event_command callback handling
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 16 Nov 2021 15:59:01 -0600
In-Reply-To: <20211116164120.0db8212b@gandalf.local.home>
References: <cover.1636748267.git.zanussi@kernel.org>
         <2b228845d7aa0466702ffc93db5f22bd6252c43b.1636748267.git.zanussi@kernel.org>
         <20211116164120.0db8212b@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-16 at 16:41 -0500, Steven Rostedt wrote:
> On Fri, 12 Nov 2021 14:23:39 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> >  
> > +int event_trigger_check(char *glob, char **trigger, char **param,
> > +			bool *remove, bool require_param, bool
> > separate_trigger)
> 
> All these functions are going to require having kerneldoc comments
> for
> them. I rather not have to try to figure out what these functions are
> for
> and just read the documentation.

Yeah, that make sense, will add documention for each one in the next
version.

Thanks,

Tom

> 
> -- Steve
> 
> 
> > +{
> > +	int ret = 0;
> > +
> > +	*remove = (glob && glob[0] == '!') ? true : false;
> > +

