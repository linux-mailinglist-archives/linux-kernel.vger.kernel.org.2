Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80683666F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhDUI1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234500AbhDUI1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:27:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CE1261421;
        Wed, 21 Apr 2021 08:26:40 +0000 (UTC)
Date:   Wed, 21 Apr 2021 10:26:37 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Andrew G. Morgan" <morgan@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Security Officers <security@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3.4] capabilities: require CAP_SETFCAP to map uid 0
Message-ID: <20210421082637.flydoq2pnxjlviuv@wittgenstein>
References: <20210416213453.GA29094@mail.hallyn.com>
 <20210417021945.GA687@mail.hallyn.com>
 <20210417200434.GA17430@mail.hallyn.com>
 <20210419122514.GA20598@mail.hallyn.com>
 <20210419160911.5pguvpj7kfuj6rnr@wittgenstein>
 <20210420034208.GA2830@mail.hallyn.com>
 <20210420083129.exyn7ptahx2fg72e@wittgenstein>
 <20210420134334.GA11582@mail.hallyn.com>
 <20210420164707.lzrpynsii3kqe2tm@wittgenstein>
 <CAHk-=wj3M87k8QKb5jn+SxK8u74_aEEE7ZsuvVY84usCAJEWrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj3M87k8QKb5jn+SxK8u74_aEEE7ZsuvVY84usCAJEWrA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 10:33:54AM -0700, Linus Torvalds wrote:
> On Tue, Apr 20, 2021 at 9:47 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > If there's no objections then Linus can probably just pick up the single
> > patch here directly:
> 
> I'm ok with that assuming I don't hear any last-minute concerns..
> 
> I'll plan on appling it later today, so anybody with concerns please
> holler quickly.
> 
> I don't want to leave it to much later in the week, and I may or may
> not be functional tomorrow (getting my second vaccine shot, some
> people react more strongly to it, so I'm leaving the possibility open
> of not getting out of bed ;)

We're a few short months away from that pleasure here... :)
At least the general plan is to still have 75% of the population
vaccinated by end of July (That's assuming supply holds up.).
And we're probably looking at another booster shot soon enough. With the
EU having cancelled J&J and AZ contracts for next year that's going to
be interesting as well. Let's hope they won't fumble it again.

Christian
