Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9D63810E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhENTd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:33:57 -0400
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:36100 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231386AbhENTdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:33:54 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 40FFD1810DA54;
        Fri, 14 May 2021 19:32:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id D7010315D74;
        Fri, 14 May 2021 19:32:40 +0000 (UTC)
Message-ID: <89a62ed669547eb989dd008b67165f3d0c9f4265.camel@perches.com>
Subject: Re: [PATCH] staging: greybus: fix gb_loopback_stats_attrs definition
From:   Joe Perches <joe@perches.com>
To:     Alex Elder <elder@ieee.org>, Greg KH <gregkh@linuxfoundation.org>,
        Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Cc:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Fri, 14 May 2021 12:32:39 -0700
In-Reply-To: <88d7da63-d03c-7fa3-a881-aff8e7b4a618@ieee.org>
References: <20210514133039.304760-1-chouhan.shreyansh630@gmail.com>
         <YJ582f3O9K9YD3QA@kroah.com> <YJ5/tqFfcjxOLsF0@fedora>
         <YJ6DrLiMsdkG5loA@kroah.com> <YJ6H/WsojYcN/bLO@fedora>
         <YJ6Jf+Z1ReVgDt64@kroah.com> <YJ6TUAowTI75h/sl@fedora>
         <YJ6XpUMliWQOS8MB@kroah.com>
         <bccbec1a0ffbf6c31b5e6a78cedd78cd64f2b8fe.camel@perches.com>
         <88d7da63-d03c-7fa3-a881-aff8e7b4a618@ieee.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D7010315D74
X-Spam-Status: No, score=-1.40
X-Stat-Signature: cwerr3zmihx55crpj6cfhty19yuuzfrx
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19FMxcCDKW900tDgf5rcwkgG+LUGqTv8gY=
X-HE-Tag: 1621020760-252553
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-05-14 at 13:53 -0500, Alex Elder wrote:
> On 5/14/21 10:56 AM, Joe Perches wrote:
> > On Fri, 2021-05-14 at 17:30 +0200, Greg KH wrote:
> > > On Fri, May 14, 2021 at 08:42:16PM +0530, Shreyansh Chouhan wrote:
> > []
> > > > I didn't look at how/where was the macro called and missed a very
> > > > obvious error. Now that I have looked at it, the only way I can think of
> > > > fixing this is changing the macro to a (inline?) function. Will
> > > > that be a desirable change?
> > > 
> > > No, it can't be a function, the code is fine as-is, checkpatch is just a
> > > perl script and does not always know what needs to be done.
> > 
> > true.
> > 
> > perhaps better though to rename these declaring macros to start with declare_
> 
> I don't disagree with your suggestion, but it's not clear it
> would have prevented submission of the erroneous initial patch
> (nor future ones from people who blindly follow checkpatch.pl
> suggestions).

With my checkpatch maintainer hat on:

Yeah Alex, I know.  checkpatch can't teach people c either.
There's not much to do other than try to make the code clearer.
Adding exceptions to checkpatch only leads to other exceptions
and false negatives...

> PS  Lots of negatives in that sentence.

Only positives...

cheers, Joe

