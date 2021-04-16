Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E553362647
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbhDPREV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:04:21 -0400
Received: from smtprelay0029.hostedemail.com ([216.40.44.29]:59734 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234774AbhDPREU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:04:20 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id F147A1800748F;
        Fri, 16 Apr 2021 17:03:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id E6F6CD1519;
        Fri, 16 Apr 2021 17:03:53 +0000 (UTC)
Message-ID: <698f8bef0fccd425a0f8d1928bc05dfc13787bbe.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Improve ALLOC_ARRAY_ARGS test
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        apw@canonical.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Fri, 16 Apr 2021 10:03:52 -0700
In-Reply-To: <ec273f46-6709-a1cd-7871-1e1d67fab7dd@wanadoo.fr>
References: <a1ac975aaabc9f71397b75254f833920428411e0.1618588673.git.christophe.jaillet@wanadoo.fr>
         <decdb749f0192bd886faa7e8470795fb2644e4f8.camel@perches.com>
         <ec273f46-6709-a1cd-7871-1e1d67fab7dd@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.60
X-Stat-Signature: gc6gorddt8fujtjq7mgqxdhgzm4as5wb
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: E6F6CD1519
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/f7EwSk0HILCi0wJ87ngPkXAeydXqkvus=
X-HE-Tag: 1618592633-125008
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-16 at 18:51 +0200, Christophe JAILLET wrote:
> Le 16/04/2021 à 18:11, Joe Perches a écrit :
> > On Fri, 2021-04-16 at 17:58 +0200, Christophe JAILLET wrote:
> > > The devm_ variant of 'kcalloc()' and 'kmalloc_array()' are not tested
> > > Add the corresponding check.
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -7006,9 +7006,9 @@ sub process {
> > >   		}
> > >   
> > > 
> > > 
> > >   # check for alloc argument mismatch
> > > -		if ($line =~ /\b(kcalloc|kmalloc_array)\s*\(\s*sizeof\b/) {
> > > +		if ($line =~ /\b(devm_|)(kcalloc|kmalloc_array)\s*\(\s*sizeof\b/) {
> > 
> > Perhaps nicer using
> I'll send a V2.
> 
> Thx for the feedback.
> 
> CJ
> 
> > 
> > 		if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\*\s*sizeof\b/) {

The \* above should be \(.

I can't type and apparently I don't proofread either.
I offer the excuse that the * and ( are adjacent on my keyboard...

cheers, Joe


