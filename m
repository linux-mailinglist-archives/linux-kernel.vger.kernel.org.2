Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E903FD6B7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243514AbhIAJZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243420AbhIAJZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:25:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C985B60462;
        Wed,  1 Sep 2021 09:24:19 +0000 (UTC)
Date:   Wed, 1 Sep 2021 11:24:17 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sys fixes
Message-ID: <20210901092417.ulwfo3qriyptjkio@wittgenstein>
References: <20210831100326.2298176-1-christian.brauner@ubuntu.com>
 <CAHk-=wg557LzOM7Hg29UhVMn3FOpXs0yUwPGHgF7JxMA7gqOew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg557LzOM7Hg29UhVMn3FOpXs0yUwPGHgF7JxMA7gqOew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 12:23:57PM -0700, Linus Torvalds wrote:
> On Tue, Aug 31, 2021 at 3:03 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > This contains a single fix to set_user() which aligns permission checks with
> > the corresponding fork() codepath.
> 
> Pulled.
> 
> That single commit is odd, though. It has strange formatting, it got
> the first-line summary rule wrong, and it has the "cc:" list
> corruption that should just have been fixed up.
> 
> Not any real problems, but sloppy editing that I started looking at
> because the one-liner shortlog didn't make sense.

Hm, sorry about that. It seems that my git am scripts for b4 might be
getting in the way of older scripts. Strange. That won't happen again.
