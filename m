Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED02352F57
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhDBSh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:37:27 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:48604 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229647AbhDBShY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:37:24 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 18B551848AB32;
        Fri,  2 Apr 2021 18:37:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id E522F1E04D5;
        Fri,  2 Apr 2021 18:37:20 +0000 (UTC)
Message-ID: <906c8d899a3840afab1e624736b44292eacc6c97.camel@perches.com>
Subject: Re: [PATCH 14/16] staging: rtl8723bs: remove all RT_TRACE logs in
 core/rtw_wlan_util.c
From:   Joe Perches <joe@perches.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Fri, 02 Apr 2021 11:37:17 -0700
In-Reply-To: <20210402174003.GA1399@agape.jhs>
References: <cover.1617356821.git.fabioaiuto83@gmail.com>
         <34bf6cdc7bdf5c64d47cb3525897970644de7052.1617356821.git.fabioaiuto83@gmail.com>
         <2014e0fc141d73d907c781ca31c822c96d3a7c47.camel@perches.com>
         <20210402125127.GB1420@agape.jhs>
         <c845d8ea7d0d8e7a613471edb53d780d660142a9.camel@perches.com>
         <20210402174003.GA1399@agape.jhs>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: E522F1E04D5
X-Spam-Status: No, score=0.10
X-Stat-Signature: naiaqt4b5fn5f7fstamd8n9znom8idsy
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/uc4cr6ntvwUF+AwVVlcVSiEqG4XhPtCI=
X-HE-Tag: 1617388640-394859
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-02 at 19:40 +0200, Fabio Aiuto wrote:
> On Fri, Apr 02, 2021 at 08:20:17AM -0700, Joe Perches wrote:
> > On Fri, 2021-04-02 at 14:51 +0200, Fabio Aiuto wrote:
> > > On Fri, Apr 02, 2021 at 03:37:57AM -0700, Joe Perches wrote:
> > > > On Fri, 2021-04-02 at 12:01 +0200, Fabio Aiuto wrote:
> > > > > remove all RT_TRACE logs
> > > > > 
> > > > > fix patch-related checkpatch issues
[]
> > > > Lastly, another suggestion would be to just submit a single patch
> > > > removing _ALL_ the RT_TRACE uses not intermixing various other cleanups
> > > > with the series and then do those other cleanups.
> > > > 
> > > > Using a coccinelle script like:
> > > > 
> > > > $ cat RT_TRACE.cocci
> > > > @@
> > > > expression a, b, c;
> > > > @@
> > > > 
> > > > -	RT_TRACE(a, b, (c));
> > > > 
> > > > $ spatch -sp-file RT_TRACE.cocci drivers/staging/rtl8723bs/
> > > > 
> > > > And then clean up the various bits you think are inappropriately done.
[]
> > > thank you Joe, I tried with (RT_TRACE.cocci in parent folder)
> > > 
> > > user@host:~/src/git/kernels/staging$ spatch -sp-file ../RT_TRACE.cocci drivers/staging/rtl8723bs/
> > > init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
> > > 0 files match
> > 
> > Likely you are running the script on the tree after you have
> > applied all your patches.
> > 
> > Try running the cocci script on a fresh copy of -next.
> > 
> > Using the script and adding the script in the commit message helps
> > others to verify that the changes you make do not have any other effect.
> > 
> > $ cat RT_TRACE.cocci
> > @@
> > expression a, b, c;
> > @@
> > 
> > -	RT_TRACE(a, b, (c));
> > 
> > $ git checkout next-20210401
> > $ spatch -sp-file RT_TRACE.cocci --in-place --no-show-diff --very-quiet drivers/staging/rtl8723bs/
> > 31 files match
> > $ git diff --stat -p
> >  drivers/staging/rtl8723bs/core/rtw_cmd.c          |  34 +------
[]
> >  28 files changed, 19 insertions(+), 935 deletions(-)
[]
> thank you Joe, this mail is so precious ;)

I'm not quite sure what you mean by that but you quoted
nearly 200k of the previous email.

Please remember to trim your replies.


