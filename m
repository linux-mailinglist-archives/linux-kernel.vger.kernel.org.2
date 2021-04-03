Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D213534B2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbhDCQRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 12:17:44 -0400
Received: from smtprelay0055.hostedemail.com ([216.40.44.55]:36610 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230450AbhDCQRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 12:17:43 -0400
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E4E811843912D;
        Sat,  3 Apr 2021 16:17:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id F0E622EBFA4;
        Sat,  3 Apr 2021 16:17:38 +0000 (UTC)
Message-ID: <7120836b08b680d54c15fd89b8630ccc67a53116.camel@perches.com>
Subject: Re: [PATCH v3 00/30] staging: rtl8723bs: remove RT_TRACE logs in
 core/*
From:   Joe Perches <joe@perches.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>, gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Sat, 03 Apr 2021 09:17:37 -0700
In-Reply-To: <20210403152143.GA1403@agape.jhs>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
         <1cd79d781cdcccf621ce8e104a9cdf1e90e7f803.camel@perches.com>
         <20210403152143.GA1403@agape.jhs>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.10
X-Rspamd-Server: rspamout02
X-Stat-Signature: cb67t64hhuz36xmx6sthh6axymjb9wwg
X-Rspamd-Queue-Id: F0E622EBFA4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/d0bwAguyxvRO74mFrz/saWwALiEImrkc=
X-HE-Tag: 1617466658-753426
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-04-03 at 17:21 +0200, Fabio Aiuto wrote:
> On Sat, Apr 03, 2021 at 08:02:25AM -0700, Joe Perches wrote:
> > On Sat, 2021-04-03 at 11:13 +0200, Fabio Aiuto wrote:
> > > This patchset removes all RT_TRACE usages in core/ files.
> > 
> > and hal and include and os_dep
> 
> Hi, 
> 
> I was just about to send the second patchset relative to hal/ files.
> The whole has been split up in directories in order to reduce the
> number of patch per patchset

> It's a good idea, but the patches relative to RT_TRACE removal
> could be huge

That's really not a significant issue.
Simplicity in review is also important.
Mechanization of patch creation can reduce review efforts.

Few people are actively working on this particular codebase.
As far as I can tell no logical defect is being corrected here.
None of this is likely to be backported.

Applying each individual patch has a 'cost' in maintainer time
and review effort.

Fewer patches create lower overall costs.

Good luck...

