Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F913FF8BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 03:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347201AbhICBxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 21:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347333AbhICBxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 21:53:13 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31211C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 18:52:14 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id q39so5056851oiw.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 18:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=fJ6dHpD3GNvelFyzfgcEEqTGVW548hBc/w/cwdZoxXo=;
        b=o5wGgjqoy5Wypn47ILH2PfB1fPMzxONkyeKsNK/ucG6hBFF1UqOy3mQYhBu5n42jzT
         bwsWPaj+bIf84sI/0LdRvyucZCbLAPJ+96yqtO1W0YNvaiNpAwg/pH3Srl/DqF1jBcbn
         uNMFUesRjHUeT7odYJ6xVGTcAzOh/xH1fs1130ngy67zKgpCnSk8dFeRSwBHD1lfW3z2
         xRBPCr8Vx8p8qnVyxzkNoqzInZU9IDrNH481FyEoC0OEDxqRZQdyA2hYYDSrf04WeLsY
         pNA9mSfEpHAhcM89+gxWw1yzpz1lEHHY/G+dJN+oO6nS4KU+ji5vw0yuyRo3Slobm1Ak
         weSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=fJ6dHpD3GNvelFyzfgcEEqTGVW548hBc/w/cwdZoxXo=;
        b=aBKDd97kJSTyLevWraefmjPhLXWAx1s9RLizibJyPHd0UyoNeG2PV5HfxqKbhPHbwe
         7h7pUZDFBpju/ZgAPT3NnTRf09oC4srXa460+xCbXATnjNF0FS4mPTrQGt7taWKov89u
         v8widCM5+YtjhRlAYrxAxkJ2PUjfHn6JrnEdlZfvAjhoDyQkcthPRBGrYtiuxak4G3Fk
         7NmzMQzug1t+j0yqoSFU+LyguRnAHelKy3XfZ5GzKrdgXIiuF54IIoHDcXeEtv0AbiZS
         /s25jOdcBOeVz1ACetEy2tevIwrugbZkfbYy1QkFoPLrV1Aypox1vMIkGVgwpjhgqQC3
         T7dw==
X-Gm-Message-State: AOAM5321yXGHtBmImLxXDb6doaUZsoY7LEiOTgysNq7haVzWAWuI4cQn
        gvu5Hk428n8Iai/sKimlU/LcsGlPEA==
X-Google-Smtp-Source: ABdhPJzNeiL7f0eAEUR9xjNEuOWjCTsyhykW7lhmG1ZQ9+Ss7OYiuLg0+6E5hUwPc3JdgolBcrUOFQ==
X-Received: by 2002:a05:6808:3a8:: with SMTP id n8mr4476992oie.10.1630633933476;
        Thu, 02 Sep 2021 18:52:13 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id a23sm690696otp.44.2021.09.02.18.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 18:52:12 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:5c43:c5c8:4983:ece])
        by serve.minyard.net (Postfix) with ESMTPSA id 6B17418000C;
        Fri,  3 Sep 2021 01:52:11 +0000 (UTC)
Date:   Thu, 2 Sep 2021 20:52:10 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cminyard@mvista.com, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom_kill: oom_score_adj broken for processes with small
 memory usage
Message-ID: <20210903015210.GF545073@minyard.net>
Reply-To: minyard@acm.org
References: <20210701125430.836308-1-minyard@acm.org>
 <YPEW3H+W/uiRYIfn@dhcp22.suse.cz>
 <20210716122547.GI3431@minyard.net>
 <20210902125501.c83101f27f1a02c58188e3f3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902125501.c83101f27f1a02c58188e3f3@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 12:55:01PM -0700, Andrew Morton wrote:
> On Fri, 16 Jul 2021 07:25:47 -0500 Corey Minyard <cminyard@mvista.com> wrote:
> 
> > On Fri, Jul 16, 2021 at 07:19:24AM +0200, Michal Hocko wrote:
> > > On Thu 01-07-21 07:54:30, minyard@acm.org wrote:
> > > > From: Corey Minyard <cminyard@mvista.com>
> > > > 
> > > > If you have a process with less than 1000 totalpages, the calculation:
> > > > 
> > > >   adj = (long)p->signal->oom_score_adj;
> > > >   ...
> > > >   adj *= totalpages / 1000;
> > > > 
> > > > will always result in adj being zero no matter what oom_score_adj is,
> > > > which could result in the wrong process being picked for killing.
> > > > 
> > > > Fix by adding 1000 to totalpages before dividing.
> > > 
> > > Yes, this is a known limitation of the oom_score_adj and its scale.
> > > Is this a practical problem to be solved though? I mean 0-1000 pages is
> > > not really that much different from imprecision at a larger scale where
> > > tasks are effectively considered equal.
> > 
> > Known limitation?  Is this documented?  I couldn't find anything that
> > said "oom_score_adj doesn't work at all with programs with <1000 pages
> > besides setting the value to -1000".
> > 
> > > 
> > > I have to say I do not really like the proposed workaround. It doesn't
> > > really solve the problem yet it adds another special case.
> > 
> > The problem is that if you have a small program, there is no way to
> > set it's priority besides completely disablling the OOM killer for
> > it.
> > 
> > I don't understand the special case comment.  How is this adding a
> > special case?  This patch removes a special case.  Small programs
> > working different than big programs is a special case.  Making them all
> > work the same is removing an element of surprise from someone expecting
> > things to work as documented.
> > 
> 
> Can we please get this resolved one way or the other?

My goal in submitting this is to avoid someone having to go through what
I went through.  I know it now, so it's not going to affect me again.

We could document this, but to me it seems silly when something can just
be made consistent to avoid having to document it.  I got no response to
my questions above, so I don't know what to make of it.

Thanks Andrew,

-corey
