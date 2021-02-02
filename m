Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D1430CF1F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhBBWfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:35:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235095AbhBBWfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:35:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DC9F64F63;
        Tue,  2 Feb 2021 22:34:38 +0000 (UTC)
Date:   Tue, 2 Feb 2021 17:34:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Timur Tabi <timur@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        john.ogness@linutronix.de, akinobu.mita@gmail.com
Subject: Re: [PATCH] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <20210202173436.6516c676@gandalf.local.home>
In-Reply-To: <9ce56a1c-9ea6-996b-84c6-cfde908c2ecd@kernel.org>
References: <20210202201846.716915-1-timur@kernel.org>
        <202102021351.AEDE896AB3@keescook>
        <9ce56a1c-9ea6-996b-84c6-cfde908c2ecd@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 16:19:20 -0600
Timur Tabi <timur@kernel.org> wrote:

> On 2/2/21 3:52 PM, Kees Cook wrote:
> >> A large warning message is displayed if this option is enabled,
> >> because unhashed addresses, while useful for debugging, exposes
> >> kernel addresses which can be a security risk.  
> 
> > Linus has expressly said "no" to things like this in the past:
> > https://lore.kernel.org/lkml/CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com/  
> Maybe I misunderstood, but I thought this is what Vlastimil, Petr, 
> Sergey, John, and Steven asked for.

Maybe Linus changed his mind since then?


  "I also suspect that everybody has already accepted that KASLR isn't
   really working locally anyway (due to all the hw leak models with
   cache and TLB timing), so anybody who can look at kernel messages
   already probably could figure most of those things out."

 https://lore.kernel.org/r/CAHk-=wjnEV2E6vCRxv5S5m27iOjHeVWNbfK=JV8qxot4Do-FgA@mail.gmail.com


-- Steve
