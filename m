Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318FC45DF51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbhKYRGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:06:45 -0500
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:50712 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242135AbhKYREo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:04:44 -0500
Received: from omf03.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id DAD60180A9C6E;
        Thu, 25 Nov 2021 17:01:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id AFBEF9000EDB;
        Thu, 25 Nov 2021 17:01:29 +0000 (UTC)
Message-ID: <7a56a2431825bb71b76bb3e90d3ce0897596bd48.camel@perches.com>
Subject: Re: [PATCH 2/2] get_maintainer: ignore "my" e-mail address
From:   Joe Perches <joe@perches.com>
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 25 Nov 2021 09:01:30 -0800
In-Reply-To: <dleftjpmqob4c0.fsf%l.stelmach@samsung.com>
References: <a0bd71ce82c7c7b9cb72972b091f9f1054b6595c.camel@perches.com>
         <CGME20211125161420eucas1p2b3dbac252dab05d0a5406d0fca8ab945@eucas1p2.samsung.com>
         <dleftjpmqob4c0.fsf%l.stelmach@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.69
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: AFBEF9000EDB
X-Stat-Signature: ehfxejky8phpya5zyx67f55t3pbxoukp
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/fjjxGgLhj+DZkhN2bsufHdA2hn/jL5L8=
X-HE-Tag: 1637859689-388833
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I dislike my email client sometimes, apologies for the blank reply)

On Thu, 2021-11-25 at 17:14 +0100, Lukasz Stelmach wrote:
> It was <2021-11-16 wto 15:14>, when Joe Perches wrote:
> > On Tue, 2021-11-16 at 22:34 +0100, Łukasz Stelmach wrote:
> > > Ignore one's own e-mail address given as a parameter to --ignore-me
> > > or in the EMAIL environment variable.
> > 
> > Why is this useful?
> > 
> > git send-email already supports this.
> > 
> >        --suppress-cc=<category>
> >            Specify an additional category of recipients to suppress
> >            the auto-cc of:
> > 
> >            •   author will avoid including the patch author
> > 
> >            •   self will avoid including the sender
> > 
> >       --[no-]suppress-from
> >            If this is set, do not add the From: address to the cc:
> >            list. Default is the value of sendemail.suppressFrom
> >            configuration value; if that is unspecified, default to
> >            --no-suppress-from.
> > 
> 
> Not really, git send-email does not support --suppress-to, and with
> get_maintainers.pl coupled with git send-email as follows
> 
> --8<---------------cut here---------------start------------->8---
> [sendemail]
>         tocmd = "`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nol --"
>         cccmd = "`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nom --nor --nofixes --"
> --8<---------------cut here---------------end--------------->8---
> 
> my address is added to To: if I am a maintainer of the patched files.
> To avoid this the --ignore-me options can be added to tocmd.

Rather than add complexity to the original get_maintainer script, is
it possible to add a pipe like " | grep -v '<your_address>'" to tocmd ?

I think it better to have these cmds use scripts ala:

https://lore.kernel.org/all/1473862411.32273.25.camel@perches.com/

And if not a script and the complexity is warranted (though I think not)
I'd rather have something like --suppress-addresss "<addr>" added to
get_maintainer.pl to allow one or more addresses to be suppressed.


