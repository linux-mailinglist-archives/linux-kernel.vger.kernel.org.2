Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1B838B2FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243888AbhETPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 11:23:19 -0400
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:34956 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243786AbhETPXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:23:07 -0400
Received: from omf01.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3155B181CC1BF;
        Thu, 20 May 2021 15:21:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id C005517275;
        Thu, 20 May 2021 15:21:41 +0000 (UTC)
Message-ID: <3173f7f10e0c212c8c828d9ca4450927f757e7d2.camel@perches.com>
Subject: Re: [PATCH 6/9] tty: hvc_console: Fix coding style issues of block
 comments
From:   Joe Perches <joe@perches.com>
To:     Johan Hovold <johan@kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linuxarm@openeuler.org
Date:   Thu, 20 May 2021 08:21:39 -0700
In-Reply-To: <YKYcFfKiHT39Gyey@hovoldconsulting.com>
References: <1621233433-27094-1-git-send-email-tanxiaofei@huawei.com>
         <1621233433-27094-7-git-send-email-tanxiaofei@huawei.com>
         <YKJ6ZjT8o5xJmBCr@hovoldconsulting.com>
         <e88b6fcd-bfe1-9812-905a-862825f420ce@huawei.com>
         <YKYcFfKiHT39Gyey@hovoldconsulting.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C005517275
X-Spam-Status: No, score=-2.90
X-Stat-Signature: gpzyzddmarn4jdsor9ep6g1wg5gtmhrf
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18KqlcSav5TvmdBlRG1J6AisdTKuL2Xz9w=
X-HE-Tag: 1621524101-433904
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-05-20 at 10:21 +0200, Johan Hovold wrote:
> On Tue, May 18, 2021 at 12:01:22PM +0800, Xiaofei Tan wrote:
> > On 2021/5/17 22:15, Johan Hovold wrote:
> > > On Mon, May 17, 2021 at 02:37:10PM +0800, Xiaofei Tan wrote:
> > > > Fix coding style issues of block comments, reported by checkpatch.pl.
> > > > Besides, add a period at the end of the sentenses.
[]
> > > > diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
[]
> > > > @@ -177,7 +177,8 @@ static void hvc_console_print(struct console *co, const char *b,
> > > >  			r = cons_ops[index]->put_chars(vtermnos[index], c, i);
> > > >  			if (r <= 0) {
> > > >  				/* throw away characters on error
> > > > -				 * but spin in case of -EAGAIN */
> > > > +				 * but spin in case of -EAGAIN.
> > > > +				 */
> > > 
> > > How is this an improvement? First, the multi-line comment style is
> > > 
> > > 	/*
> > > 	 * ...
> > > 	 */
> > > 
> > 
> > Yes, mostly we use this style. I can follow it if new version is needed.
> 
> This is the preferred style outside of networking.
> 
> > BTW, How about add the '/*' check into checkpatch.pl?
> 
> Checkpatch already has too many checks IMO

I sometimes agree.  What checkpatch messages do you think are excessive?

> and I'm a bit surprised that
> it doesn't check this already. Perhaps it's because you used the -f to
> run checkpatch on in-kernel code, which you should not.

Likely not.  If it was run on a suggested patch, checkpatch doesn't emit
many messages on unmodified patch context lines.  And it shouldn't.

> it's just that you
> introduce noise in the logs and do pointless changes of context which
> makes it harder to use tools like git blame and makes backporting harder
> for no good reason.

Pretty pointless metric IMO.  Context changes in comments are mostly harmless.
IMO: backporting of these sorts non-bug fix changes is done _far_ too often.

