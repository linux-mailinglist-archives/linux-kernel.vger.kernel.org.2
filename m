Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C863CCBBB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 02:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhGSAVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 20:21:10 -0400
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:36062 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233819AbhGSAVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 20:21:10 -0400
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B4DAD182CED34;
        Mon, 19 Jul 2021 00:18:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 8F03527DD26;
        Mon, 19 Jul 2021 00:18:09 +0000 (UTC)
Message-ID: <c32293fc03a8673ade348ed4451c60dfdf9bb2c1.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add a rule to check general block
 comment style
From:   Joe Perches <joe@perches.com>
To:     Ani Sinha <ani@anisinha.ca>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        anirban.sinha@nokia.com, mikelley@microsoft.com,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 18 Jul 2021 17:18:07 -0700
In-Reply-To: <alpine.DEB.2.21.2107181853320.55905@ani-ubuntu>
References: <20210714063422.2164699-1-ani@anisinha.ca>
         <alpine.DEB.2.22.394.2107162145100.3277407@anisinha-lenovo>
         <CAKXUXMzxyQxYKdnuVbZnUFbYFuKMq+Vc5LxSR-_fKtH2dv-4wA@mail.gmail.com>
         <alpine.DEB.2.21.2107181853320.55905@ani-ubuntu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F03527DD26
X-Spam-Status: No, score=-1.10
X-Stat-Signature: na6nbnhgeref81f495s6wqx3kxhntktk
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+nFWO7HpewWlQ4WSnF4W4gbdTx64I2QIo=
X-HE-Tag: 1626653889-326291
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-07-18 at 19:08 +0530, Ani Sinha wrote:
> On Sun, 18 Jul 2021, Lukas Bulwahn wrote:
> > On Fri, Jul 16, 2021 at 6:15 PM Ani Sinha <ani@anisinha.ca> wrote:
> > > checkpatch maintainers, any comments?
> > > On Wed, 14 Jul 2021, Ani Sinha wrote:
> > > > The preferred style for long (multi-line) comments is:
> > > > 
> > > > .. code-block:: c
> > > > 
> > > >       /*
> > > >        * This is the preferred style for multi-line
> > > >        * comments in the Linux kernel source code.
> > > >        * Please use it consistently.
> > > >        *
> > > >        * Description:  A column of asterisks on the left side,
> > > >        * with beginning and ending almost-blank lines.
> > > >        */
> > > > 
> > > > It seems rule in checkpatch.pl is missing to ensure this for
> > > > non-networking related changes. This patch adds this rule.
[]
> > Honest feedback: IMHO, your commit message is unreadable and incomprehensible.
> 
> OK. However, I fail to see how your above comment is useful without any
> suggestion as to how to improve the commit log. I find having some test
> data with the commit message valuable so that there is some sort of record
> as to how the change was tested and with what arguments. Beyond that this
> is not something I am really worried about. The commit message can be
> modified and improved in any way reviewers like.
> 
> > 
> > Now to the feature you are proposing:
> > 
> > I do not think that it is good if checkpatch would point out a quite
> > trivial syntactic issue that probably is currently violated many times
> > (>10,000 or even >100,000 times?) in the overall repository. That will
> > make checkpatch warn on many commits with this check and divert the
> > attention from other checks that are more important than the style of
> > starting comments.
> 
> I have some strong opinions on this. Just because a rule has been violated
> in the past does not mean it can continue to be violated in the future.

Intensity of opinion varies considerably here.

> > Further, some evaluation by Aditya shows that the distinction between
> > NETWORKING COMMENT STYLE and GENERAL KERNEL COMMENT STYLE is not as
> > easily split as currently encoded in the checkpatch script,
> > https://lore.kernel.org/linux-kernel-mentees/cfff5784-9ca3-07f8-c51c-f1c82b2871e3@gmail.com/.
> > So, this checkpatch check is largely wrong already as of now and most
> > probably ignored by many contributors.

The only reason the rule exists at all is because the networking maintainer
was constantly telling people to change the comment style in patches.

I don't care one way or another.

// comments are fine
/* comments are fine */

In networking, multiline comments are almost exclusively like
what Linus himself does not like:

	/* comment
	 * ...
	 */

but in other subsystems, the styles of multiline comments varies.

Either works, there is no single standard.

And as the referenced link by Aditya somewhat shows, the nominal
rule compliance varies by the age of the code.  No one care much
about code submitted a couple decades ago for subsystems and drivers
that are effectively obsolete...


