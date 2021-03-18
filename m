Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C624E33FEE7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhCRFe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:34:59 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:48652 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229512AbhCRFeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:34:17 -0400
X-AuditID: 0a580157-47bff70000021a79-00-6052df77c806
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id DB.61.06777.77FD2506; Thu, 18 Mar 2021 13:04:55 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 18 Mar
 2021 13:34:12 +0800
Date:   Thu, 18 Mar 2021 13:34:12 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <yangfeng1@kingsoft.com>,
        <sunhao2@kingsoft.com>, Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>, <yaoaili@kingsoft.com>
Subject: Re: [PATCH] mm/gup: check page posion status for coredump.
Message-ID: <20210318133412.12078eb7@alex-virtual-machine>
In-Reply-To: <20210318044600.GJ3420@casper.infradead.org>
References: <20210317163714.328a038d@alex-virtual-machine>
        <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
        <20210318044600.GJ3420@casper.infradead.org>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsXCFcGooFt+PyjBYOlEcYs569ewWXxd/4vZ
        4vKuOWwW99b8Z7X4uD/Y4mLjAUaLM9OKLH7/mMPmwOGxeYWWx6ZPk9g9Tsz4zeLx4upGFo+P
        T2+xeLzfd5XNY/Ppao/Pm+QCOKK4bFJSczLLUov07RK4Mq6dPMxWMJW74tOlrAbGBxxdjJwc
        EgImEm2Pf7N3MXJxCAlMZ5L4u+Q1E4TzilGid+07dpAqFgFViamn5zCB2GxA9q57s1i7GDk4
        RAQ0JN5sMQKpZxbYwiSxu+ULM0iNsICzxObjM8FsXgEriS+ft4P1cgpYSpyYuoYFYsFcRomT
        n6aCLeAXEJPovfKfCeIke4m2LYsYIZoFJU7OfMICYjML6EicWHWMGcKWl9j+dg6YLSSgKHF4
        yS92iF4liSPdM9gg7FiJZfNesU5gFJ6FZNQsJKNmIRm1gJF5FSNLcW664SZGSLSE72Cc1/RR
        7xAjEwfjIUYJDmYlEV7TvIAEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwiUUApgfTEktTs1NSC
        1CKYLBMHp1QDU9zyWZfZCiWXr5Oa+jJt0lJNJX7hIzxnQqaybH91ximVrePulsVK73oYY/+J
        O/wNkOVYtz5Ncsd/dukAg2el34UkHKO5bR2m7beWO/c/Y0vUAy1GjsWTfW6f8j/fWbBr+yy/
        55vOLlr5MUHB7KWOi02W6JVGxw/2h8Ibm1c9OpHbUbmYMch7yb5a7pfFzpNNuTKk4p9Lskad
        ff/oz4p/RnF3Y+2eZKft3JdrsdFUa634hTeyKfM1jQpXxGk0Lrp/ZVrTUt6I66dnCZ9l32A4
        i6fR8q3WlFjT7ibBKAVbmQ5bj7Vsf999apmtceFoiNqMBQu/VHhnqsWyrPTTLDMqTHhw5+RG
        3fX7TjH2pmSJKbEUZyQaajEXFScCABxGk1IFAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 04:46:00 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Mar 17, 2021 at 10:12:02AM +0100, David Hildenbrand wrote:
> > > +	if (IS_ENABLED(CONFIG_MEMORY_FAILURE) && ret == 1) {
> > > +		if (unlikely(PageHuge(page) && PageHWPoison(compound_head(page))))
> > > +			ret = 0;
> > > +		else if (unlikely(PageHWPoison(page)))
> > > +			ret = 0;
> > > +	}  
> > 
> > I wonder if a simple
> > 
> > if (PageHWPoison(compound_head(page)))
> > 	ret = 0;
> > 
> > won't suffice. But I guess the "issue" is compound pages that are not huge
> > pages or transparent huge pages.  
> 
> THPs don't set the HWPoison bit on the head page.
> 
> https://lore.kernel.org/linux-mm/20210316140947.GA3420@casper.infradead.org/
> 
> (and PAGEFLAG(HWPoison, hwpoison, PF_ANY))
> 
> By the way,
> 
> #ifdef CONFIG_MEMORY_FAILURE
> PAGEFLAG(HWPoison, hwpoison, PF_ANY)
> TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
> #define __PG_HWPOISON (1UL << PG_hwpoison)
> extern bool take_page_off_buddy(struct page *page);
> #else
> PAGEFLAG_FALSE(HWPoison)
> #define __PG_HWPOISON 0
> #endif
> 
> so there's no need for this 
> 	if (IS_ENABLED(CONFIG_MEMORY_FAILURE)
> check, as it simply turns into
> 
> 	if (PageHuge(page) && 0)
> 	else if (0)
> 
> and the compiler can optimise it all away.

Yes, You are right, I will modify this later.
Thanks for correction

-- 
Thanks!
Aili Yao
