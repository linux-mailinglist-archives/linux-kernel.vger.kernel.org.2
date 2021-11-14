Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201F044F9CF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 18:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbhKNRqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 12:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236157AbhKNRqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 12:46:05 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E6B760FE3;
        Sun, 14 Nov 2021 17:43:11 +0000 (UTC)
Date:   Sun, 14 Nov 2021 12:43:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] tracing: Three small fixes for 5.16
Message-ID: <20211114124309.799dc917@rorschach.local.home>
In-Reply-To: <CAHk-=wjREUihCGrtRBwfX47y_KrLCGjiq3t6QtoNJpmVrAEb1w@mail.gmail.com>
References: <20211113083520.26ec84ee@rorschach.local.home>
        <CAHk-=wjREUihCGrtRBwfX47y_KrLCGjiq3t6QtoNJpmVrAEb1w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2021 10:26:29 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Nov 13, 2021 at 5:35 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >  - Copy just actual size of histogram strings  
> 
> I have pulled this, but I think it's wrong. Or at least it looks
> _very_ suspicious.
> 
> > -                       strscpy(str, val_str, STR_VAR_LEN_MAX);
> > +                       strscpy(str, val_str, val->size);  
> 
> So now it doesn't overrun the source string any more, but I don't see
> what protects it from not overrunning the destination - which is
> indeed STR_VAR_LEN_MAX.
> 
> Maybe 'val->size' is guaranteed to be sufficiently limited, but that
> sure as hell isn't obvious at least lkocally.

Ideally this should be checked on the time the histogram is created.
But looking into it, the size could be determined by the size of a
string of an event field. Now in practice, no event field should be
bigger than 256 bytes, but nothing prevents it from happening.

I'll add logic here to include:

	size = min(val->size, STR_VAR_LEN_MAX);

and use that instead.

-- Steve
