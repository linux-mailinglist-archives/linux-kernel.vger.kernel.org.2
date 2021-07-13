Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822B73C79F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 01:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbhGMXMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 19:12:17 -0400
Received: from smtprelay0070.hostedemail.com ([216.40.44.70]:49996 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235417AbhGMXMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 19:12:16 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 508902C5A4;
        Tue, 13 Jul 2021 23:09:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 7F83A1E04D8;
        Tue, 13 Jul 2021 23:09:24 +0000 (UTC)
Message-ID: <42a843710a652e110b71ab6beafc3a3e6e11dfd3.camel@perches.com>
Subject: Re: cocci script to convert linux-kernel allocs with BITS_TO_LONGS
 to bitmap_alloc
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci <cocci@systeme.lip6.fr>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Date:   Tue, 13 Jul 2021 16:09:22 -0700
In-Reply-To: <alpine.DEB.2.22.394.2107132332030.3024@hadrien>
References: <08b89608cfb1280624d1a89ead6547069f9a4c31.camel@perches.com>
         <alpine.DEB.2.22.394.2107102149140.46528@hadrien>
         <afd3a282ca57a4a400c8bae9879a7c57bc507c59.camel@perches.com>
         <alpine.DEB.2.22.394.2107132332030.3024@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.02
X-Stat-Signature: uztexi7wie66gnpui9nawg7xurxs43hk
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 7F83A1E04D8
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19+E355a2jKrTaUCYH65AOx1cK8B6P3fac=
X-HE-Tag: 1626217764-847900
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-07-13 at 23:33 +0200, Julia Lawall wrote:
> > > On Fri, 9 Jul 2021, Joe Perches wrote:
> > > > Here is a cocci script to convert various types of bitmap allocations
> > > > that use BITS_TO_LONGS to the more typical bitmap_alloc functions.
> 
> I see that there is also a bitmap_free.  Maybe the rule should be
> introducing that as well?

Yes, but as far as I know, it's difficult for coccinelle to convert
the kfree() calls of any previous bitmap_alloc to bitmap_free as
most frequently the kfree() call is in a separate function.

Please do it if you know how, you're probably the best in the world
at coccinelle.  I don't know how...

cheers, Joe

