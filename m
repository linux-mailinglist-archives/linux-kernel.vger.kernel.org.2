Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845B739CA85
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 20:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFESfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 14:35:39 -0400
Received: from smtprelay0135.hostedemail.com ([216.40.44.135]:38042 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229994AbhFESfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 14:35:37 -0400
Received: from omf05.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id A8334837F24D;
        Sat,  5 Jun 2021 18:33:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id EC46BB2793;
        Sat,  5 Jun 2021 18:33:46 +0000 (UTC)
Message-ID: <294bb4a2c3f5f8cf4a744cf59bfd37562653afb9.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Fix check for embedded filename
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 05 Jun 2021 11:33:45 -0700
In-Reply-To: <CABJPP5B3jZHnAprT15uEkuAbYPUT49VXRFT+pkubVVep-2=XmA@mail.gmail.com>
References: <20210605161219.26421-1-dwaipayanray1@gmail.com>
         <eac3b988f4993a77f8eea3550a6dd5980b25e92f.camel@perches.com>
         <CABJPP5B3jZHnAprT15uEkuAbYPUT49VXRFT+pkubVVep-2=XmA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: EC46BB2793
X-Spam-Status: No, score=-2.90
X-Stat-Signature: b5yzkn4qgyapqtuzt5tzciuzubqacscb
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19AREj44sKeK8Ez8ZCbYDzApueB4bwl2YQ=
X-HE-Tag: 1622918026-594305
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-06-05 at 23:03 +0530, Dwaipayan Ray wrote:
> On Sat, Jun 5, 2021 at 10:51 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Sat, 2021-06-05 at 21:42 +0530, Dwaipayan Ray wrote:
> > > When checkpatch is run on file contents piped through stdin,
> > > it may generate false EMBEDDED_FILENAME warnings if the
> > > --file flag is used.
> > 
> > I think this is a "don't do that" scenario and this change
> > is not necessary.
> > 
> 
> Okay then. I will drop this.
> Sorry for the noise.

I think you want something like this:
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index dad87c3686326..582f8e07d32d5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -331,6 +331,7 @@ help(0) if ($help);
 
 die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
 die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);
+die "$P: -f/--file requires at least one filename\n" if ($file && $#ARGV < 0);
 
 if ($color =~ /^[01]$/) {
 	$color = !$color;

