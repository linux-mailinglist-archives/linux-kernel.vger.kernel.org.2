Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51020435AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhJUGSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:18:55 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:47388 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229499AbhJUGSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:18:54 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 90BB1181D337B;
        Thu, 21 Oct 2021 06:16:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 6B3141E04D3;
        Thu, 21 Oct 2021 06:16:37 +0000 (UTC)
Message-ID: <6ce0c8301cadef76fd45f38ace1e20408f6e52e9.camel@perches.com>
Subject: Re: [GIT PULL] tracing: Fix to recursion protection for 5.15
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Wed, 20 Oct 2021 23:16:36 -0700
In-Reply-To: <CAHk-=wgBhyLhQLPem1vybKNt7BKP+=qF=veBgc7VirZaXn4FUw@mail.gmail.com>
References: <20211019091344.65629198@gandalf.local.home>
         <CAHk-=wjvGRtwMHDJ9VR8197+_rVveqE73Uv-MMFbvuUEbWKNtQ@mail.gmail.com>
         <20211020121727.57f46a15@gandalf.local.home>
         <CAHk-=whr2M-jzyv9B8Co0V0TMvCpnH24fWYwxXrN9YeGKicoVw@mail.gmail.com>
         <20211020181241.0e6a2b47@gandalf.local.home>
         <20211020184101.25b7e583@gandalf.local.home>
         <CAHk-=wgBhyLhQLPem1vybKNt7BKP+=qF=veBgc7VirZaXn4FUw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6B3141E04D3
X-Spam-Status: No, score=-0.62
X-Stat-Signature: abkgbifzbj47jmdoe1s5koiftr31cmsb
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/eGTB4DX0IVzSIqzGOwMOVoRFSmGtB9RY=
X-HE-Tag: 1634796997-962913
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-20 at 20:08 -1000, Linus Torvalds wrote:
> it's probably better to have too many cc's listed in the commit
> than too few - at least within reason.
> 
> Because if a commit turns out to cause problems, the list of email
> addresses mentioned in the commit message should be seen as the
> primary list of "hey people, this patch you were involved with has
> issues"

IMO: cc's aren't all that valuable as part of a commit message.

Generally, a tool like b4 should be able to create a list of any
email addresses in a thread linked commit.


