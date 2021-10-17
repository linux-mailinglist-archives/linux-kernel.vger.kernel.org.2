Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5B4430B5A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 20:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhJQSEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 14:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhJQSEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 14:04:52 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128B7C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 11:02:43 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mcAUX-0001MQ-QA; Sun, 17 Oct 2021 20:02:37 +0200
Date:   Sun, 17 Oct 2021 20:02:37 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: r8188eu: don't accept SIGTERM for cmd thread
Message-ID: <20211017180237.bvc6spwbj72zyjhi@viti.kaiser.cx>
References: <20211016181343.3686-1-martin@kaiser.cx>
 <2409617.cBYgoVRs56@localhost.localdomain>
 <YWv67ozbJGxMa69t@equinox>
 <1957621.GeRc3qvyWe@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1957621.GeRc3qvyWe@localhost.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio and all,

Thus wrote Fabio M. De Francesco (fmdefrancesco@gmail.com):

> On Sunday, October 17, 2021 12:29:02 PM CEST Phillip Potter wrote:

> > So I myself am a little confused on this one :-)

> > Based on my understanding, so correct me if I'm wrong, a process
> > (kthread or otherwise) can still be killed if marked TASK_KILLABLE,
> > even if ignoring SIGTERM. Indeed, from a userspace perspective,
> > SIGKILL is unblockable anyway - although of course kernel code can
> > choose how to respond to it.

> Correct.

And it seems that by default, a kthread can't be killed with SIGKILL.

> > So in other words, the kthread could still be killed while waiting
> > in the wait_for_completion_killable() call, even if we are ignoring
> > SIGTERM. From that perspective I guess, it is therefore not 'incorrect' as
> > such - if indeed we wanted that behaviour.

> No. This misunderstandings is my fault. :(

> In Martin's patch I read "SIGTERM" but for some reason I thought he was 
> talking of "SIGKILL".

> At the moment, without Martin's patch, the kthread can be terminated by the 
> command "kill -TERM <PID>". If we try "kill -KILL <PID>", nothing happens.
> This is because only "allow_signal(SIGTERM);" is present in the code.

Exactly. And this is probably not by intention. It would be consistent
to either allow both or none - the latter makes more sense, and it's
what most other drivers do.

> I think that kthreads must also allow  SIGKILL with "allow_signal(SIGKILL);" 
> for allowing root to make them terminate.

Probably. nfsd seems to do this.

> For what relates to my patch, it doesn't matter if I either leave 
> wait_for_completion_killable() as-is or change it to wait_for_completion().
> This is because at the moment SIGKILL cannot kill rtw_cmd_thread(), while 
> SIGTERM can.

> However, for consistency, I should better change it to the uninterruptible 
> version.

That makes sense to me.

Let's see what Greg and others say...

Best regards,
Martin
