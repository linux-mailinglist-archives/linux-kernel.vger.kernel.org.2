Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBBF3C36B3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 22:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhGJUFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 16:05:25 -0400
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:33510 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229515AbhGJUFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 16:05:25 -0400
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 06BE1182CED2A;
        Sat, 10 Jul 2021 20:02:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 2B7C51A29F9;
        Sat, 10 Jul 2021 20:02:38 +0000 (UTC)
Message-ID: <afd3a282ca57a4a400c8bae9879a7c57bc507c59.camel@perches.com>
Subject: Re: cocci script to convert linux-kernel allocs with BITS_TO_LONGS
 to bitmap_alloc
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci <cocci@systeme.lip6.fr>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Date:   Sat, 10 Jul 2021 13:02:36 -0700
In-Reply-To: <alpine.DEB.2.22.394.2107102149140.46528@hadrien>
References: <08b89608cfb1280624d1a89ead6547069f9a4c31.camel@perches.com>
         <alpine.DEB.2.22.394.2107102149140.46528@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.37
X-Stat-Signature: acaiyyzxzs3uxyr8edc374hez41ejw4g
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 2B7C51A29F9
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+IOF/X85f5HAaZl7mOKJZ2SwAmuy46KrU=
X-HE-Tag: 1625947358-191922
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-07-10 at 21:50 +0200, Julia Lawall wrote:
> On Fri, 9 Jul 2021, Joe Perches wrote:
> 
> > Here is a cocci script to convert various types of bitmap allocations
> > that use BITS_TO_LONGS to the more typical bitmap_alloc functions.
> > 
> > Perhaps something like it could be added to scripts/coccinelle.
> > The diff produced by the script is also below.
> > 
> > $ cat bitmap_allocs.cocci
> > // typical uses of bitmap allocations
[]
> > @@
> > expression val;
> > expression e1;
> > expression e2;
> > @@
> > 
> > -	val = kcalloc(BITS_TO_LONGS(e1), sizeof(*val), e2)
> > +	val = bitmap_zalloc(e1, e2)
> 
> Is there something that guarantees that val has a type that has a size that
> is the same as a long?

no, but afaict, all do.


