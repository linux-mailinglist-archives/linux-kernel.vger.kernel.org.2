Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D7435F8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346607AbhDNQMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:12:10 -0400
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:50798 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233932AbhDNQMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:12:09 -0400
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 27C7C182CCCA1;
        Wed, 14 Apr 2021 16:11:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 4525E255108;
        Wed, 14 Apr 2021 16:11:45 +0000 (UTC)
Message-ID: <c502a48ded02fb681a5978b5af888c74be9625ec.camel@perches.com>
Subject: Re: [PATCH] staging: greybus: Match parentheses alignment
From:   Joe Perches <joe@perches.com>
To:     Alex Elder <elder@ieee.org>, Greg KH <gregkh@linuxfoundation.org>,
        Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Wed, 14 Apr 2021 09:11:40 -0700
In-Reply-To: <78c88472-9ed9-bade-407c-23bd557f19bb@ieee.org>
References: <20210406124259.GA96537@zhans> <YGxhrLZPIPjILWUH@kroah.com>
         <7d7be8bcc0e80d826083890ed7791070ad25e603.camel@perches.com>
         <1607b040-6bc4-9a58-ae81-4ea0adf5885d@ieee.org>
         <b22ffa716ee871f7e09ad7321213a897156edab0.camel@perches.com>
         <78c88472-9ed9-bade-407c-23bd557f19bb@ieee.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4525E255108
X-Spam-Status: No, score=0.10
X-Stat-Signature: 81yw9jqkbykio1i5aqrot1ef8c8sizcx
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+sMqN7x+9JMu+tt9FlJx5gWwVR7LAVi4o=
X-HE-Tag: 1618416705-920260
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-04-14 at 09:35 -0500, Alex Elder wrote:
> On 4/14/21 9:29 AM, Joe Perches wrote:
> > On Wed, 2021-04-14 at 08:17 -0500, Alex Elder wrote:
> > > Perhaps (like the -W options for GCC) there
> > > could be a way to specify in a Makefile which checkpatch
> > > messages are reported/not reported?  I don't claim that's
> > > a good suggestion, but if I could optionally indicate
> > > somewhere that "two consecutive blank lines is OK for
> > > Greybus" (one example that comes to mind) I might do so.
> > 
> > checkpatch already has --ignore=<list> and --types=<list>
> > for the various classes of messages it emits.
> > 
> > see: $ ./scripts/checkpatch.pl --list-types --verbose
> > 
> > Dwaipayan Ray (cc'd) is supposedly working on expanding
> > the verbose descriptions of each type.
> > 
> 
> That's awesome, I wasn't aware of that.
> 
> Any suggestions on a standardized way to say "in this
> subtree, please provide these arguments to checkpatch.pl"?
> 
> I can probably stick it in a README file or something,
> but is there an existing best practice?

There is no standardized mechanism for this checkpatch use.

Putting something in a staging README is in general a good way for
it to _not_ be read by people doing 'my first kernel patch'.

I still think emitting a message for overly long identifiers could
be a decent checkpatch test.

https://lore.kernel.org/lkml/1518801207.13169.15.camel@perches.com/

