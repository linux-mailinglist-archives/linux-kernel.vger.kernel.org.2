Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC94E425777
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242559AbhJGQQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:16:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231495AbhJGQQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633623257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pRgvQy7zCNT4x1FLGa0VFDNRf/XMV/VudzeiNbniOTk=;
        b=bhdP2rApNJjsDWjBcUEyl7K7PbR26djJVQ4rZJFGcS98tauEWurxbGDn8x0c8CUSaDDs93
        TAPKbHzYuXbivy2y6paiChaKJCs/8sFph1OP0Ne8WkO34mpD6ChaLQ43dawtVu4mhnI453
        Wnu7fIU7YHP4mzUkuPdJuTf0IBSAWHU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-42YKIDhINUCjTSIoD95JVw-1; Thu, 07 Oct 2021 12:14:16 -0400
X-MC-Unique: 42YKIDhINUCjTSIoD95JVw-1
Received: by mail-qt1-f199.google.com with SMTP id d9-20020ac86149000000b002a6d33107c5so5571595qtm.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 09:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pRgvQy7zCNT4x1FLGa0VFDNRf/XMV/VudzeiNbniOTk=;
        b=MRH1zq5x5MyXKtdLvZf/0yi/Lhf3zPdxwhwiZiJo2g3Lvl9ecR+7AgD5ShbFwDjqQv
         /ewIFkCvDTsMfWdmMX3QQBumvia4NEXiUX5lLN1rVmLa8LgVrskYMAzt8e9lwM6kZVnh
         iv960+efZweMBl8JjqB/w9tpQ1TOfxZCOIJ/rJEC1aM8hmt7hW5wc9R159DVqpD8sCbd
         +36LLOzRt9YjE8E4ktxIiwya8pEWu2Spayv7DTPQHhstOUzzW/QC7KQwQ0rmX+4ne3Em
         ZUIkxq1Qo7PXjqXU00BwfXZLymQ7N17/OY5IcZX8uFYIrUGYqLGsRkJCYBKHVHOA5Zq0
         atqA==
X-Gm-Message-State: AOAM5339OjFISJzl2NjMPhBPCU1T2SL7z3DTMnlDJ55R/8+myl/iBKcw
        0P7xl2f6HIbS+iNwxJBGcNiHq0VcX2P7NxmFsFGpjkoIB0PiHIdRT7dNOXpZHvuIhPAsRNssYrL
        EfmtMwkDV1SXOCWp3x4sdC8/B
X-Received: by 2002:a05:620a:1677:: with SMTP id d23mr4266630qko.327.1633623255962;
        Thu, 07 Oct 2021 09:14:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRhDipkWMKBlUwNt0I0VU8YiJcFyvPa0zwdSqGd/2TPm7Sb3wfxySQ+irOIRCQ5YvPvWvFvQ==
X-Received: by 2002:a05:620a:1677:: with SMTP id d23mr4266603qko.327.1633623255749;
        Thu, 07 Oct 2021 09:14:15 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::bed8])
        by smtp.gmail.com with ESMTPSA id i18sm16970001qtx.60.2021.10.07.09.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 09:14:15 -0700 (PDT)
Date:   Thu, 7 Oct 2021 12:14:13 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <YV8c1ZoMveUUlG+v@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
 <20211004140637.qejvenbkmrulqdno@box.shutemov.name>
 <CAHbLzkp5d_j97MizSFCgfnHQj_tUQuHJqxWtrvRo_0kZMKCgtA@mail.gmail.com>
 <20211004194130.6hdzanjl2e2np4we@box.shutemov.name>
 <CAHbLzkqcrGCksMXbW5p75ZK2ODv4bLcdQWs7Jz0NG4-=5N20zw@mail.gmail.com>
 <YV3+6K3uupLit3aH@t490s>
 <CAHbLzkpWSM_HvCmgaLd748BLcmZ3cnDRQ577o_U+qDi1iSK3Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkpWSM_HvCmgaLd748BLcmZ3cnDRQ577o_U+qDi1iSK3Og@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 04:41:35PM -0700, Yang Shi wrote:
> > Or maybe we just don't touch it until there's need for a functional change?  I
> > feel it a pity to lose the git blame info for reindent-only patches, but no
> > strong opinion, because I know many people don't think the same and I'm fine
> > with either ways.
> 
> TBH I really don't think keeping old "git blame" info should be an
> excuse to avoid any coding style cleanup.

Sure.

> 
> >
> > Another side note: perhaps a comment above pageflags enum on PG_has_hwpoisoned
> > would be nice?  I saw that we've got a bunch of those already.
> 
> I was thinking about that, but it seems PG_double_map doesn't have
> comment there either so I didn't add.

IMHO that means we may just need even more documentations? :)

I won't ask for documenting doublemap bit in this series, but I just don't
think it's a good excuse to not provide documentations if we still can.
Especially to me PageHasHwpoisoned looks really so like PageHwpoisoned, so
it'll be still very nice to have some good document along with the patch it's
introduced.

Thanks,

-- 
Peter Xu

