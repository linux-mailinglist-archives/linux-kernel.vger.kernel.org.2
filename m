Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EB336169A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 01:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhDOX40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 19:56:26 -0400
Received: from smtprelay0246.hostedemail.com ([216.40.44.246]:50916 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234716AbhDOX4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 19:56:24 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 9F0DB182CED34;
        Thu, 15 Apr 2021 23:56:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id C8F001D42F5;
        Thu, 15 Apr 2021 23:55:59 +0000 (UTC)
Message-ID: <3cf12c9eae59e4014865866529e580d7d0ede020.camel@perches.com>
Subject: Re: [PATCH 0/3] Detect suspicious indentation after conditional
From:   Joe Perches <joe@perches.com>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Ivo Sieben <meltedpianoman@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 15 Apr 2021 16:55:58 -0700
In-Reply-To: <CAODwPW_rdHnkKuAhCxbF9Lb3bPvAKR54G1wowFGyoDQ_sp-3Cg@mail.gmail.com>
References: <20210326035035.3057800-1-jwerner@chromium.org>
         <CAODwPW_rdHnkKuAhCxbF9Lb3bPvAKR54G1wowFGyoDQ_sp-3Cg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.10
X-Stat-Signature: wkmuitchcd9izo3g6f41xd7z1z93xt1q
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: C8F001D42F5
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/DomA8+lUqEF2ggRhEYBI0f3JkYR+NwpA=
X-HE-Tag: 1618530959-145970
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-04-14 at 14:18 -0700, Julius Werner wrote:
> *friendly ping*
> 
> Hi Andy, Joe,
> 
> Any comments on this patch series? Are you guys the right point of
> contact for checkpatch changes?

I don't have any issue with this patch set, but Andy is really
the person that should approve any changes to this block of code.

> On Thu, Mar 25, 2021 at 8:50 PM Julius Werner <jwerner@chromium.org> wrote:
> > 
> > This patch series is adding functionality to checkpatch.pl to test for
> > incorrect code indentation after a conditional statement, like this:
> > 
> >  if (a)
> >    b;
> >    c;
> > 
> > (Indentation implies that `c;` was guarded by the conditional, but it
> > isn't.) The main part is re-sending a patch from Ivo Sieben that was
> > already proposed in 2014 [1]. I don't know why it was never merged --
> > it seems that there was no discussion on it. I hope that it was only
> > overlooked, because it works great, and I think this is a very important
> > class of common error to catch.
> > 
> > I have tested it extensively on the kernel tree and in the course of
> > that found a few more edge cases that get fixed by the other two
> > patches. With all these applied, the vast majority of hits I get from
> > this check on the kernel tree are actual indentation errors or other
> > code style violations (e.g. case label and statement on the same line).
> > The only significant remaining group of false positives I found are
> > cases of macros being defined within a function, which are overall very
> > rare. I think the benefit of adding this check would far outweigh the
> > remaining amount of noise.
> > 
> > [1]: https://lore.kernel.org/patchwork/patch/465116
> > 
> > Ivo Sieben (1):
> >   Suspicious indentation detection after conditional statement
> > 
> > Julius Werner (2):
> >   checkpatch: ctx_statement_block: Fix preprocessor guard tracking
> >   checkpatch: Ignore labels when checking indentation
> > 
> >  scripts/checkpatch.pl | 56 +++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 52 insertions(+), 4 deletions(-)
> > 
> > --
> > 2.29.2
> > 


