Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0EA343789
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 04:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCVDkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 23:40:52 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:16392 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVDk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:40:27 -0400
X-AuditID: 0a580155-1f5ff7000005482e-ed-605809cbbef2
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 98.80.18478.BC908506; Mon, 22 Mar 2021 11:06:51 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 22 Mar
 2021 11:40:24 +0800
Date:   Mon, 22 Mar 2021 11:40:23 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <yangfeng1@kingsoft.com>,
        <sunhao2@kingsoft.com>, Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>, <yaoaili@kingsoft.com>
Subject: Re: [PATCH v3] mm/gup: check page posion status for coredump.
Message-ID: <20210322114023.79140596@alex-virtual-machine>
In-Reply-To: <20210320003516.GC3420@casper.infradead.org>
References: <20210317163714.328a038d@alex-virtual-machine>
        <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
        <20210318044600.GJ3420@casper.infradead.org>
        <20210318133412.12078eb7@alex-virtual-machine>
        <20210319104437.6f30e80d@alex-virtual-machine>
        <20210320003516.GC3420@casper.infradead.org>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsXCFcGooHuaMyLB4OEDAYs569ewWXxd/4vZ
        4vKuOWwW99b8Z7X4uD/Y4mLjAUaLM9OKLH7/mMPmwOGxeYWWx6ZPk9g9Tsz4zeLx4upGFo+P
        T2+xeLzfd5XNY/Ppao/Pm+QCOKK4bFJSczLLUov07RK4Ml7M0Sm4IVBxcdJt1gbGczxdjJwc
        EgImEkeur2DqYuTiEBKYziRxac4DKOcVo8S5z7uZQapYBFQlpvfuB7PZgOxd92axdjFycIgI
        aEi82WIEUs8ssIVJYnfLF7AaYQE3icU3ljCC2LwCVhKXP5xnA7E5BSwlzu2bzwixYB2TxKoF
        k1hBEvwCYhK9V/4zQZxkL9G2ZRFUs6DEyZlPWEBsZgEdiROrjjFD2PIS29/OAbOFBBQlDi/5
        xQ7RqyRxpHsGG4QdK7Fs3ivWCYzCs5CMmoVk1CwkoxYwMq9iZCnOTTfaxAiJltAdjDOaPuod
        YmTiYDzEKMHBrCTCeyI5JEGINyWxsiq1KD++qDQntfgQozQHi5I4r2NkQIKQQHpiSWp2ampB
        ahFMlomDU6qBab9IV3Nbmo7xw61HzWq+vnZ4EVP06kD9HUGF7H0KUzg2lCr6Ne0yzXEMU1sg
        8fi8c+6NDbt61l9aepbZpaldvOK3o+P7xRNtcpKO19RsUpe0q3v3eqLLieoI3RiGu2VHvPcc
        5uG72jR/15rJPzf8ZmBzkVdNtrTxmmIvylXbobJveuqdvd4P//uvPc4Qo3i55XLroZlXF1fG
        ppiuf8T6aa3h2qvs3QvVI3OYo/O7A7xPS7X9bFu3YI9wpGB1w+/PSwrOLTXczT/xHb+72OOd
        t+Kcpyvs1i79F3exRXjGv/c2B5X6YvZfTM644bBv+bbX6bNnf45vrvJkd5reIMSWEfrpkvUR
        3bl10p3qyutrlFiKMxINtZiLihMBGMtIVQUDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2021 00:35:16 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Mar 19, 2021 at 10:44:37AM +0800, Aili Yao wrote:
> > +++ b/mm/gup.c
> > @@ -1536,6 +1536,10 @@ struct page *get_dump_page(unsigned long addr)
> >  				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
> >  	if (locked)
> >  		mmap_read_unlock(mm);
> > +
> > +	if (ret == 1 && is_page_poisoned(page))
> > +		return NULL;
> > +
> >  	return (ret == 1) ? page : NULL;
> >  }
> >  #endif /* CONFIG_ELF_CORE */
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 25d2b2439..902d993 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -97,6 +97,27 @@ static inline void set_page_refcounted(struct page *page)
> >  	set_page_count(page, 1);
> >  }
> >  
> > +/*
> > + * When kernel touch the user page, the user page may be have been marked
> > + * poison but still mapped in user space, if without this page, the kernel
> > + * can guarantee the data integrity and operation success, the kernel is
> > + * better to check the posion status and avoid touching it, be good not to
> > + * panic, coredump for process fatal signal is a sample case matching this
> > + * scenario. Or if kernel can't guarantee the data integrity, it's better
> > + * not to call this function, let kernel touch the poison page and get to
> > + * panic.
> > + */
> > +static inline bool is_page_poisoned(struct page *page)
> > +{
> > +	if (page != NULL) {  
> 
> Why are you checking page for NULL here?  How can it possibly be NULL?

For this get_dump_page() case, it can't be NULL, I thougt may other place
will call this function and may not guarantee this, But yes, kernel is a more
safer place and checking page NULL is not a common behavior.

Better to remove it, Thanks you very much for pointing this!

> > +		if (PageHWPoison(page))
> > +			return true;
> > +		else if (PageHuge(page) && PageHWPoison(compound_head(page)))
> > +			return true;
> > +	}
> > +	return 0;
> > +}
> > +
> >  extern unsigned long highest_memmap_pfn;
> >  
> >  /*
> > -- 
> > 1.8.3.1
> > 
> >   
-- 
Thanks!
Aili Yao
