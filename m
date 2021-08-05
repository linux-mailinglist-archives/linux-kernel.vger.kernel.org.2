Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F003E0E6B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 08:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbhHEGdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 02:33:54 -0400
Received: from smtprelay0170.hostedemail.com ([216.40.44.170]:38104 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234340AbhHEGdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 02:33:53 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 13E2F250AD;
        Thu,  5 Aug 2021 06:33:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 59F501E04D3;
        Thu,  5 Aug 2021 06:33:38 +0000 (UTC)
Message-ID: <3e8d8a3bcde7b0a2f4f1587c6febf88b7261db05.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Append parenthesis back to trimmed
 subsystem name
From:   Joe Perches <joe@perches.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     open list <linux-kernel@vger.kernel.org>
Date:   Wed, 04 Aug 2021 23:33:36 -0700
In-Reply-To: <CAAd53p4dXVkuBXShCesEQkPi52CuaVm3tRBnD4S13saLdEGsRQ@mail.gmail.com>
References: <20210804160949.592227-1-kai.heng.feng@canonical.com>
         <2d594d0b06401887debd5ec462edcffdc813318a.camel@perches.com>
         <CAAd53p4dXVkuBXShCesEQkPi52CuaVm3tRBnD4S13saLdEGsRQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=5.20
X-Stat-Signature: r5arxi7jze3keztck57srcru31tib1z8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 59F501E04D3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/yTU43nskkWAnEJaGkBimC4s3FymHDLvY=
X-HE-Tag: 1628145218-699893
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-08-05 at 14:17 +0800, Kai-Heng Feng wrote:
> On Thu, Aug 5, 2021 at 12:22 AM Joe Perches <joe@perches.com> wrote:
> > 
> > On Thu, 2021-08-05 at 00:09 +0800, Kai-Heng Feng wrote:
> > > When a closing parenthesis gets trimmed, there can be unmatched
> > > parenthesis in the subsystem name. This doesn't play well with
> > > git-send-email:
> > > (cc-cmd) Adding cc: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...) from: 'scripts/get_maintainer.pl'
> > > Unmatched () '(open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...)' '' at /usr/lib/git-core/git-send-email line 554.
> > > error: unable to extract a valid address from: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...)
> > > 
> > > So append parenthesis back if it was trimmed to make git-send-email
> > > work again:
> > > (cc-cmd) Adding cc: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Mooresto...)) from: 'scripts/get_maintainer.pl'
> > 
> > Probably better just to add --norolestats to the invoking command-line.
> 
> This can solve the issue beautifully, thanks!
> 
> > 
> > > diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> > []
> > > @@ -1252,9 +1252,10 @@ sub get_subsystem_name {
> > > 
> > > 
> > >      my $subsystem = $typevalue[$start];
> > >      if ($output_section_maxlen && length($subsystem) > $output_section_maxlen) {
> > > -     $subsystem = substr($subsystem, 0, $output_section_maxlen - 3);
> > > +     my $parenthesis = substr($subsystem, -1) eq ")";
> > > +     $subsystem = substr($subsystem, 0, $output_section_maxlen - ($parenthesis ? 4 : 3));
> > >       $subsystem =~ s/\s*$//;
> > > -     $subsystem = $subsystem . "...";
> > > +     $subsystem = $subsystem . "..." . ($parenthesis ? ")" : "");
> > 
> > Given an $output_section_maxlen number of possible parentheses, this should
> > probably use a while...
> 
> Or maybe count the parentheses in two runs?
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 2075db0c08b8e..08315074acffa 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -1252,9 +1252,21 @@ sub get_subsystem_name {
> 
>      my $subsystem = $typevalue[$start];
>      if ($output_section_maxlen && length($subsystem) >
> $output_section_maxlen) {
> +       my $need_closing = 0;
>         $subsystem = substr($subsystem, 0, $output_section_maxlen - 3);
>         $subsystem =~ s/\s*$//;
> -       $subsystem = $subsystem . "...";
> +
> +       if (substr($subsystem, -1) eq "(") {
> +           $subsystem = substr($subsystem, 0, -2);
> +       } else {
> +           my $opening = () = $subsystem =~ /\(/g;
> +           my $closing = () = $subsystem =~ /\)/g;
> +           if ($opening != $closing) {
> +               $need_closing = 1;
> +           }
> +       }
> +
> +       $subsystem = $subsystem . "..." . ($need_closing ? ")" : "");

This wouldn't necessarily work as you need to have balanced parentheses...

It could be something like:

	my $open_parens = () = $subsystem =~ /\(/g;
	my $close_parens = () = $subsystem =~ /\)/g;
	$subsystem .= ')' x ($open_parens - $close_parens);


