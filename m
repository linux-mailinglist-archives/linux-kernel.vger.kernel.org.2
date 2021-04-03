Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965DE35357B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 22:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbhDCUCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 16:02:11 -0400
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:35426 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231658AbhDCUCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 16:02:10 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id CD8A5180458DB;
        Sat,  3 Apr 2021 20:02:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id D32991124F4;
        Sat,  3 Apr 2021 20:02:05 +0000 (UTC)
Message-ID: <844503af879d05b209d9af98e378350b4f74ff9d.camel@perches.com>
Subject: Re: [PATCH v3 00/30] staging: rtl8723bs: remove RT_TRACE logs in
 core/*
From:   Joe Perches <joe@perches.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Sat, 03 Apr 2021 13:02:04 -0700
In-Reply-To: <20210403172858.GA2397@agape.jhs>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
         <1cd79d781cdcccf621ce8e104a9cdf1e90e7f803.camel@perches.com>
         <20210403152143.GA1403@agape.jhs>
         <7120836b08b680d54c15fd89b8630ccc67a53116.camel@perches.com>
         <20210403172858.GA2397@agape.jhs>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.10
X-Rspamd-Server: rspamout02
X-Stat-Signature: gabuok9ucs7h7afg833xcucuojww8dgz
X-Rspamd-Queue-Id: D32991124F4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/9nFMw3M0TUvd6otDijDvItut39GnlUgo=
X-HE-Tag: 1617480125-621146
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-04-03 at 19:28 +0200, Fabio Aiuto wrote:
> On Sat, Apr 03, 2021 at 09:17:37AM -0700, Joe Perches wrote:
> > On Sat, 2021-04-03 at 17:21 +0200, Fabio Aiuto wrote:
> > > On Sat, Apr 03, 2021 at 08:02:25AM -0700, Joe Perches wrote:
> > > > On Sat, 2021-04-03 at 11:13 +0200, Fabio Aiuto wrote:
> > > > > This patchset removes all RT_TRACE usages in core/ files.
> > > > 
> > > > and hal and include and os_dep
> > > 
> > > Hi, 
> > > 
> > > I was just about to send the second patchset relative to hal/ files.
> > > The whole has been split up in directories in order to reduce the
> > > number of patch per patchset
> > 
> > > It's a good idea, but the patches relative to RT_TRACE removal
> > > could be huge
> > 
> > That's really not a significant issue.
> > Simplicity in review is also important.
> > Mechanization of patch creation can reduce review efforts.
> 
> Maybe I wrongly associated simplicity with patch dimensions, but maybe
> for patches this simple have expert reviewers some tool for
> automatic review?

Coccinelle is a relatively trusted tool and using it as a scripting
mechanism where the script is shown as part of the commit message
gives confidence that the change it produces can be applied without
significant doubt.

To improve confidence that any change that does not have an output
object code delta, comparing the object code produced before and
after the change is useful.  Showing that the code has been both
compiled and compared in the commit message also improves confidence
that the change is useful and can be applied.


