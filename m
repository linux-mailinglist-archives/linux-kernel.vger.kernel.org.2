Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595EB39CA8D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 20:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFESyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 14:54:22 -0400
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:57466 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229978AbhFESyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 14:54:21 -0400
Received: from omf03.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 7F4E4100E7B40;
        Sat,  5 Jun 2021 18:52:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id CD57813D94;
        Sat,  5 Jun 2021 18:52:31 +0000 (UTC)
Message-ID: <c1eec80f7a48a9eb7696fc2801dfd974bd8f0281.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Fix check for embedded filename
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 05 Jun 2021 11:52:30 -0700
In-Reply-To: <CABJPP5AOcCWydstxqKN9tjFN9nigk1OQeJY3DFnd+rFP_2+qaQ@mail.gmail.com>
References: <20210605161219.26421-1-dwaipayanray1@gmail.com>
         <eac3b988f4993a77f8eea3550a6dd5980b25e92f.camel@perches.com>
         <CABJPP5B3jZHnAprT15uEkuAbYPUT49VXRFT+pkubVVep-2=XmA@mail.gmail.com>
         <294bb4a2c3f5f8cf4a744cf59bfd37562653afb9.camel@perches.com>
         <CABJPP5AOcCWydstxqKN9tjFN9nigk1OQeJY3DFnd+rFP_2+qaQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: CD57813D94
X-Spam-Status: No, score=-2.90
X-Stat-Signature: edki3jwmtncxxoccdudddjoeenr31p6x
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18xFUiZ5VOIoFu1VXZyB63cvufUd4cccLc=
X-HE-Tag: 1622919151-130688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-06-06 at 00:14 +0530, Dwaipayan Ray wrote:
> On Sun, Jun 6, 2021 at 12:03 AM Joe Perches <joe@perches.com> wrote:
> > On Sat, 2021-06-05 at 23:03 +0530, Dwaipayan Ray wrote:
> > > On Sat, Jun 5, 2021 at 10:51 PM Joe Perches <joe@perches.com> wrote:
> > > > On Sat, 2021-06-05 at 21:42 +0530, Dwaipayan Ray wrote:
> > > > > When checkpatch is run on file contents piped through stdin,
> > > > > it may generate false EMBEDDED_FILENAME warnings if the
> > > > > --file flag is used.
> > > > 
> > > > I think this is a "don't do that" scenario and this change
> > > > is not necessary.
> > > > 
> > > 
> > > Okay then. I will drop this.
> > > Sorry for the noise.
> > 
> > I think you want something like this:
> > ---
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -331,6 +331,7 @@ help(0) if ($help);
> > 
> >  die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
> >  die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);
> > +die "$P: -f/--file requires at least one filename\n" if ($file && $#ARGV < 0);
> > 
> >  if ($color =~ /^[01]$/) {
> >         $color = !$color;
> > 
> 
> Yes, that's nice.
> Most of the checks don't work with piped input when --file
> is specified. So disabling it will avoid any confusion.
> 
> I can send in a patch if it's okay with you.

Fine by me.  You noticed, your patch...


