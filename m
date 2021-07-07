Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0043BED83
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 19:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhGGR4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 13:56:33 -0400
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:49510 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230089AbhGGR4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 13:56:32 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 7F992182251CC;
        Wed,  7 Jul 2021 17:53:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 826DFD1517;
        Wed,  7 Jul 2021 17:53:50 +0000 (UTC)
Message-ID: <5e5eaf6773a0dad42cd59e89f8e710666373f8f1.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Add check for common mailing list helper
 checks
From:   Joe Perches <joe@perches.com>
To:     John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
        linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 07 Jul 2021 10:53:49 -0700
In-Reply-To: <506ec749-63dc-3a08-48e7-5179c3df9a42@eaglescrag.net>
References: <20210702223743.1240694-1-warthog9@eaglescrag.net>
         <b1592f359a7e68704c0faac77015b9b2aa8e4073.camel@perches.com>
         <506ec749-63dc-3a08-48e7-5179c3df9a42@eaglescrag.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.40
X-Stat-Signature: 8c7465bx8k57gsohsk7q1mb97qse3ays
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 826DFD1517
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/DliC2RVn4bA5ocEuPRNRxF9Zk1c7Gy2g=
X-HE-Tag: 1625680430-61890
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-07-06 at 12:31 -0700, John 'Warthog9' Hawley wrote:
> On 7/3/21 11:39 AM, Joe Perches wrote:
> > On Fri, 2021-07-02 at 15:37 -0700, John 'Warthog9' Hawley (VMware)
> > wrote:
> > > From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> > > 
> > > Mailing lists in an attempt to try and avoid sending certain
> > > administrative e-mails to the list, will check the first few lines
> > > (usually ~10) looking for keywords.  If those key words are found it
> > > shunts the e-mail to the list admin contact instead of potentially
> > > passing it through to the list.
> > 
> > Perhaps the below is a bit better, but I believe a few of the tests
> > are going to be tripped a bit too often.
> > 
> > Especially "cancel", "config" and maybe "subscribe" too.
> > 
> > For instance:
> > 
> > $ git log --grep='\bcancel\b' -P -i --pretty=oneline -10000 | wc -l
> > 1693
> > 
> > $ git log --grep='^config\b' -P -i --pretty=oneline -10000 | wc -l
> > 890
> > 
> > $ git log --grep='\bsubscribe\b' -P -i --pretty=oneline -10000 | wc -l
> > 123
> 
> A part of getting this into checkpatch.pl is getting some better
> feedback mechanisms for why patches may not be passing through the list
> correctly with regexes that have been in place for at least 14 years.
> These, aren't tripped over often,

3000+ commits with regex matches seem rather a lot to me.

> but have run into a instance at least
> recently that triggered me trying to get at least some self check, and
> notification, pieces in place.

No worries, but perhaps the message might be reworded to
say something about possible mailing list moderation rather
than imply rejection.

> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -865,6 +865,37 @@ our $allowed_asm_includes = qr{(?x:
> >  )};
> >  # memory.h: ARM has a custom one
> > 
> > +our $mailing_list_phrases = qr{(?xi:
> > +	\bcancel\b |

Mere use of the word "cancel" in the commit description seems undesirable to me.

> > +# check if words in the commit message may trip up common mailing list helpers
> > +# to redirect email to the admin contact
> > +		if ($in_commit_log && $commit_log_lines < 10 &&
> > +		    $line =~ /($mailing_list_phrases)/) {
> > +			WARN("MAILING_LIST_HELPER",
> > +			     "Line matches common mailing list helpers and may not be delivered correctly - consider rewording '$1'\n" . $herecurr);

Maybe FILTERS for phrases and helpers

Maybe something like:

"Use of '$1' in this patch's commit description might cause mailing list moderation or rejection\n"


