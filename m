Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBD63B9163
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbhGAMBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 08:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbhGAMBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 08:01:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124BDC061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 04:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=FYHFyPNMs7ektzXfPfpbCo/kDILWq4D/qoEUsHcHhK8=; b=Vazh2/Pg+EvfWut0RdLDhYKwhN
        4ZmOqysXZLnDn9JIkKSoUFJ/63riyWnckj1EuYEZ1rA/LN6PyXQP899qDX2XVoxTo4EIlcd1hPzCu
        Q+j9LUD2G1S2+Vnr1jIgLbhMLwSeq2huvkEnFjC95wWMbRRU7TwcQz5Xtvdx6Vf2Ie6fe+54jsIPa
        Q5BIoGxGDVHGXoc5uItDuAaQy8T/TvoI4+v9lAgexdl6ife0hAS2ATHu3/QlmqeIILwhdblhos9ZC
        zulDMkuwTmyJThVMqguJYPNltcMIQmZjbLOpDy/Cc3c2MKZStIk++TUvomEJ9aWuK4XEepI+GU52E
        nI06CjbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyvKM-006WJc-Ap; Thu, 01 Jul 2021 11:57:59 +0000
Date:   Thu, 1 Jul 2021 12:57:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     =?utf-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: cleancache: fix potential race in cleancache apis
Message-ID: <YN2twnTaJvZTivGK@casper.infradead.org>
References: <YN1ZjHx74KUzA4Rs@kroah.com>
 <YNxjoxBNdWm604FU@kroah.com>
 <20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p2>
 <YNwnqOuFlIG6Jofy@kroah.com>
 <YNxVAZDttnWncNUy@casper.infradead.org>
 <20210701050644epcms1p5ceaf654fdabec4a126081f9edcbb3fff@epcms1p5>
 <CGME20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p3>
 <20210701085650epcms1p381d6d9c0052408c2ba011777fe3e74ba@epcms1p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210701085650epcms1p381d6d9c0052408c2ba011777fe3e74ba@epcms1p3>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 05:56:50PM +0900, 권오훈 wrote:
> On Thu, Jul 01, 2021 at 07:58:36AM +0200, gregkh@linuxfoundation.org wrote:
> > On Thu, Jul 01, 2021 at 02:06:44PM +0900, 권오훈 wrote:
> > > We are using Cleancache APIs for our proprietary feature in Samsung.
> > > As Wilcox mentioned, however, there is no cleancache backend in current kernel
> > > mainline.
> > > So if the race patch shall be accepted, then it seems unnecessary to patch 
> > > previous stable kernels.
> > > 
> > > Meanwhile, I personally think cleancache API still has potential to be a good
> > > material when used with new arising technologies such as pmem or NVMe.
> > > 
> > > So I suggest to postpone removing cleancache for a while.
> >  
> > If there are no in-kernel users, it needs to be removed.  If you rely on
> > this, wonderful, please submit your code as soon as possible.
> >  
> > thanks,
> >  
> > greg k-h
> > 
> We will discuss internally and see if we can submit our feature.

You have two months.  I'll submit the removal then if no new backend has
shown up.
