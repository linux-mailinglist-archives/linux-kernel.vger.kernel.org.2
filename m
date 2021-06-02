Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077DE397F0B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhFBC2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbhFBC2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:28:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DB0561351;
        Wed,  2 Jun 2021 02:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622600792;
        bh=P+ozhEM6eflHK0MwGKnJouOmnGB98sXAB7sz7QooHj8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=izUDmZ0yW5RXom1irJcMa7khmSvK/tp6eQKZ3OE4277UMikg5+PhSgJxQfjmVlbV/
         YIi+X35/pT+n0Nl3KJYdAjzSSV6lUKKwV68DUoJp/RrgQa1cAMfYyuEaAfhv/2m1eC
         18K/W9I4IMnVV5TunslBdHnPtBzhKaNANy8YZwXk=
Date:   Tue, 1 Jun 2021 19:26:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     HAGIO =?UTF-8?B?S0FaVUhJVE8=?= (=?UTF-8?B?6JCp5bC+44CA5LiA5LuB?=) 
        <k-hagio-ab@nec.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH V2 4/6] mm: rename the global section array to
 mem_sections
Message-Id: <20210601192630.884b1f51b81f60f5f0823694@linux-foundation.org>
In-Reply-To: <TYYPR01MB67775E2EC60DEE1195A49577DD3D9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
        <20210531091908.1738465-5-aisheng.dong@nxp.com>
        <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
        <CAA+hA=Ss4j8qeoe7RtDJ14nuqy+TpOk2qi-A9+YN6=2y8c_CGg@mail.gmail.com>
        <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
        <20210601165246.99d7374d07661b7e91e49cb6@linux-foundation.org>
        <TYYPR01MB67775E2EC60DEE1195A49577DD3D9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 01:11:07 +0000 HAGIO KAZUHITO(萩尾　一仁) <k-hagio-ab@nec.com> wrote:

> -----Original Message-----
> > On Tue, 1 Jun 2021 10:40:09 +0200 David Hildenbrand <david@redhat.com> wrote:
> > 
> > > > Thanks, i explained the reason during my last reply.
> > > > Andrew has already picked this patch to -mm tree.
> > >
> > > Just because it's in Andrews tree doesn't mean it will end up upstream. ;)
> > >
> > > Anyhow, no really strong opinion, it's simply unnecessary code churn
> > > that makes bisecting harder without real value IMHO.
> > 
> > I think it's a good change - mem_sections refers to multiple instances
> > of a mem_section.  Churn is a pain, but that's the price we pay for more
> > readable code.  And for having screwed it up originally ;)
> 
> >From a makedumpfile/crash-utility viewpoint, I don't deny kernel improvement
> and probably the change will not be hard for them to support, but I'd like
> you to remember that the tool users will need to update them for the change.
> 
> The situation where we need to update the tools for new kernels is usual, but
> there are not many cases that they cannot even start session, and this change
> will cause it.  Personally I wonder the change is worth forcing users to update
> them.

Didn't know that.  I guess I'll drop it then.

We could do an assembly-level alias I assume..
