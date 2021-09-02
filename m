Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2583FEFAF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345446AbhIBOth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229941AbhIBOtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630594117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0wVKNF0XQtjZ9RbZFV3p67mUIOM94HpjWZkNzTpPK1k=;
        b=DUIB4zDYx07A5IJi1WB95AVnRFo25W2bWK8+9cb1Gd3kA+raxdWFo8eH9Xc5QX/QlZBOc9
        Cuicp3rpL61KRYcelaBX58hy6PUv/efkekgc9TcrED+Ovf3Aiw3N+Pl4nCdKQJ9Tv0vJvJ
        zWaSnTPkuStTf9kYX6sboz5CCBIFeGU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-dFfEdno1ORK2MHtdF93ssA-1; Thu, 02 Sep 2021 10:48:36 -0400
X-MC-Unique: dFfEdno1ORK2MHtdF93ssA-1
Received: by mail-qt1-f197.google.com with SMTP id t2-20020ac87382000000b002a0c1c918c3so957995qtp.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 07:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0wVKNF0XQtjZ9RbZFV3p67mUIOM94HpjWZkNzTpPK1k=;
        b=hWwtYUv3r5Pn8OgGmuEg7j0R57Aw9eI/OzlEA6EM7FRZDN0rbg0sifPamZ4AndHt0R
         LHoqBg0swM1GQsYFvRiGmLBSCZyGgDxNFC1Zib9cB1j5h7+IMtvY7UsXuhCQ/ZSIIMH+
         BgUgoiCMpSirhBBznoNXw87n7y10FGWDICJ3cap8QDKkYwUDH1CM23fqibLmeTdRtbXk
         DQDO23dddRsRx3MK8YiuaHnQDLAyUsYUbgAmEPzOrNRhGK5h6eijdvmVvVRfgCAvKt9e
         3bzS7h+OUKj2gdHHiid4NAXaqORORFrM/PQNdnUEmi3/Ta6wSTEhXmjiOI+GxhSr7+Lz
         r67g==
X-Gm-Message-State: AOAM5311fsyY37WFwzZ6rkFft2DlUrsRzayh0ggIs5W3Mp6jTNRD9CMY
        a57CK7j8WJBYggg+WtnRMbiqlmM0bPA6NaHwo3E0K5l53mrFT/wa576e0K9yCequMklu5wK/miE
        cfeHOEPdB0co0lg240O/Rht+0
X-Received: by 2002:a05:620a:4404:: with SMTP id v4mr3538352qkp.344.1630594115310;
        Thu, 02 Sep 2021 07:48:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxaosPn9uHdUrs1IrRUUqvUMsgR8b60qaNexWZOR8FDZJ8HYo9cMS23TOMY78uAbxFZwANGg==
X-Received: by 2002:a05:620a:4404:: with SMTP id v4mr3538331qkp.344.1630594115067;
        Thu, 02 Sep 2021 07:48:35 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id q7sm1565488qkm.68.2021.09.02.07.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 07:48:34 -0700 (PDT)
Date:   Thu, 2 Sep 2021 10:48:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH 4/5] mm: Introduce zap_details.zap_flags
Message-ID: <YTDkQMLhIfIVRGoG@t490s>
References: <20210901205622.6935-1-peterx@redhat.com>
 <20210901205722.7328-1-peterx@redhat.com>
 <5f3aa3fa-e877-02d1-8721-debbe688e7af@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f3aa3fa-e877-02d1-8721-debbe688e7af@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 09:28:42AM +0200, David Hildenbrand wrote:
> On 01.09.21 22:57, Peter Xu wrote:
> > Instead of trying to introduce one variable for every new zap_details fields,
> > let's introduce a flag so that it can start to encode true/false informations.
> > 
> > Let's start to use this flag first to clean up the only check_mapping variable.
> > Firstly, the name "check_mapping" implies this is a "boolean", but actually it
> > stores the mapping inside, just in a way that it won't be set if we don't want
> > to check the mapping.
> > 
> > To make things clearer, introduce the 1st zap flag ZAP_FLAG_CHECK_MAPPING, so
> > that we only check against the mapping if this bit set.  At the same time, we
> > can rename check_mapping into zap_mapping and set it always.
> > 
> > Since at it, introduce another helper zap_check_mapping_skip() and use it in
> > zap_pte_range() properly.
> > 
> > Some old comments have been removed in zap_pte_range() because they're
> > duplicated, and since now we're with ZAP_FLAG_CHECK_MAPPING flag, it'll be very
> > easy to grep this information by simply grepping the flag.
> > 
> > It'll also make life easier when we want to e.g. pass in zap_flags into the
> > callers like unmap_mapping_pages() (instead of adding new booleans besides the
> > even_cows parameter).
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/linux/mm.h | 19 ++++++++++++++++++-
> >   mm/memory.c        | 34 ++++++++++------------------------
> >   2 files changed, 28 insertions(+), 25 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 69259229f090..fcbc1c4f8e8e 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1716,14 +1716,31 @@ static inline bool can_do_mlock(void) { return false; }
> >   extern int user_shm_lock(size_t, struct ucounts *);
> >   extern void user_shm_unlock(size_t, struct ucounts *);
> > +/* Whether to check page->mapping when zapping */
> > +#define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
> 
> So we want to go full way, like:
> 
> typedef int __bitwise zap_flags_t;
> 
> #define  ZAP_FLAG_CHECK_MAPPING		((__force zap_flags_t)BIT(0))

Sure.

> 
> > +
> >   /*
> >    * Parameter block passed down to zap_pte_range in exceptional cases.
> >    */
> >   struct zap_details {
> > -	struct address_space *check_mapping;	/* Check page->mapping if set */
> > +	struct address_space *zap_mapping;
> >   	struct page *single_page;		/* Locked page to be unmapped */
> > +	unsigned long zap_flags;
> 
> Why call it "zap_*" if everything in the structure is related to zapping?
> IOW, simply "mapping", "flags" would be good enough.

Not sure if it's a good habit or bad - it's just for tagging system to be able
to identify other "mapping" variables, or a simple grep with the name.  So I
normally prefix fields with some special wording to avoid collisions.

> 
> >   };
> > +/* Return true if skip zapping this page, false otherwise */
> > +static inline bool
> > +zap_skip_check_mapping(struct zap_details *details, struct page *page)
> > +{
> > +	if (!details || !page)
> > +		return false;
> > +
> > +	if (!(details->zap_flags & ZAP_FLAG_CHECK_MAPPING))
> > +		return false;
> > +
> > +	return details->zap_mapping != page_rmapping(page);
> > +}
> 
> I'm confused, why isn't "!details->zap_mapping" vs. "details->zap_mapping"
> sufficient? I can see that you may need flags for other purposes (next
> patch), but why do we need it here?
> 
> Factoring it out into this helper is a nice cleanup, though. But I'd just
> not introduce ZAP_FLAG_CHECK_MAPPING.

Yes I think it's okay. I wanted to separate them as they're fundamentall two
things to me.  Example: what if the mapping we want to check is NULL itself
(remove private pages only; though it may not have a real user at least so
far)?  In that case one variable won't be able to cover it.

But indeed Matthew raised similar comment, so it seems to be a common
preference.  No strong opinion on my side, let me coordinate with it.

Thanks for looking,

-- 
Peter Xu

