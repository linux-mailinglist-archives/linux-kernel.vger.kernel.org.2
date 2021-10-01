Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF8E41F823
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 01:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhJAXWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 19:22:03 -0400
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:37308 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231207AbhJAXWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 19:22:01 -0400
Received: from omf12.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id F0649837F24D;
        Fri,  1 Oct 2021 23:20:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 3690B24023A;
        Fri,  1 Oct 2021 23:20:15 +0000 (UTC)
Message-ID: <7c9103aee37509a28e426756bce7d6a5ae0ced16.camel@perches.com>
Subject: Re: [PATCH] memblock: Neaten logging
From:   Joe Perches <joe@perches.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 01 Oct 2021 16:20:14 -0700
In-Reply-To: <YVeVwL24j5P5ry2z@kernel.org>
References: <623750dd31aa3fe5e45c416be98ab37707e2c45d.camel@perches.com>
         <YVYoVNFBMER4bjrT@kernel.org>
         <6573ccd25ce80f5e28ed35e4c88c898b0f994fbc.camel@perches.com>
         <YVc5RYT+MovmWiiI@kernel.org>
         <06ede4d0c1bf66614c9e9e013098a876aeec883f.camel@perches.com>
         <YVeVwL24j5P5ry2z@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.80
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3690B24023A
X-Stat-Signature: er3ocr3e3ruyrdzysytghp9ggaxzfrrj
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+KTZ1DsDiZZssa0mGFdbvEO+ae1Z6kjbM=
X-HE-Tag: 1633130415-644694
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-10-01 at 16:12 -0700, Mike Rapoport wrote:
> On Fri, Oct 01, 2021 at 01:34:10PM -0700, Joe Perches wrote:
> > On Fri, 2021-10-01 at 09:37 -0700, Mike Rapoport wrote:
> > > On Thu, Sep 30, 2021 at 06:27:15PM -0700, Joe Perches wrote:
> > > > On Thu, 2021-09-30 at 14:12 -0700, Mike Rapoport wrote:
> > > > > Hi Joe,
> > > > > 
> > > > > On Wed, Sep 29, 2021 at 09:43:14PM -0700, Joe Perches wrote:
> > > > > > Use more typical kernel logging styles.
> > > > > > 
> > > > > > o Add and use #define pr_fmt KBUILD_MODNAME ": " fmt
> > > > > 
> > > > > I don't see it as an improvement. On the contrary, the output becomes
> > > > > somewhat tautological:
> > > > 
> > > > And rather easier to grep as the prefix is constant.
> > > 
> > > memblock_ is perfectly greppable
> > 
> > Of course, but only when it's there, 2 instances out of 9.
> 
> I didn't object to the patch as a whole. I just don't like the pr_fmt
> definition.

You should do what you like.  I did what I like.

cheers, Joe


