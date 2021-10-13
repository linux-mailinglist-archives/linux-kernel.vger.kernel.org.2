Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C45942B319
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhJMDJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229571AbhJMDJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634094423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g2lNgN2bb+PQK+zV9pywKYhDEw1L0D7XEUTIckJ/sQA=;
        b=KMBNw7cBm+YOy+8oCavlibiwGvvujKf6mqKXb708hgFVZQqAvZgK8TDQJ0N8mz3fuVPY7S
        yUXTR1XWnIzJxdHqRfb7+iFyqQjvSKwwdPQFkxPvNLQTeeG/ObbJTXrlnnoGPBK3KxHxGi
        bQoVuXzUPJ3dPpm0Mg1blHYKEkNI6D8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-oeBiO3E4O9SB6pth1Y3HHQ-1; Tue, 12 Oct 2021 23:07:02 -0400
X-MC-Unique: oeBiO3E4O9SB6pth1Y3HHQ-1
Received: by mail-pj1-f71.google.com with SMTP id b17-20020a17090a551100b001a03bb6c4f1so2752409pji.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g2lNgN2bb+PQK+zV9pywKYhDEw1L0D7XEUTIckJ/sQA=;
        b=0nMmzikqxLFLhDkyMOux0Qqq9QTA/xFxjJRxCPLZ5ZakCb182mzpW/0o/6U74tiSYZ
         5ssDoRM2kh8Rr08tWDvDfAR47Kuz+9yJFkW+3WUZBw8jfTwwxuA1iwAP/GwU6wFQf2MW
         IJ6SDMt9ItjsxLpxSufPk5FF9QhQS1TBi4zVGSL++T+1U2ZsiXpjKBjw/Rwlmc6H2D99
         uHpXTGG9lA1mo1lh8qPH5Fvu0vPQ3CWP6hbi+QGlyGqzbAnLRAAAOlp+Vu8FFILro8bS
         +ngs9cBrzCHO64aVaBDGVSEL/GiDaBvJ9cQnzTl9F3wBNM3aqQb/042hKrdx+Ji5tFU8
         o6cg==
X-Gm-Message-State: AOAM533F3nbwzrGaPssQA/qCBAkFael0D39JLyGQ7nefODb94ukrsB40
        LkSA0CWPKqKYZe5MvEScbJCB91uMZEi6T3vViSA045K6IFuI31YXtFZWcUeAdO2yODzwovtkmL1
        nlBjjBcbDWtqdOPha9z8nTVin
X-Received: by 2002:a17:90b:1e05:: with SMTP id pg5mr10730058pjb.173.1634094421193;
        Tue, 12 Oct 2021 20:07:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyAEOaTQBzAI1dUfTgWthY9LXxK8kwJ8csIS2Ux71iJLJM8lfWL0zdJifDKCfMEE6bwiFFPQ==
X-Received: by 2002:a17:90b:1e05:: with SMTP id pg5mr10730019pjb.173.1634094420827;
        Tue, 12 Oct 2021 20:07:00 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a17sm12770682pfd.54.2021.10.12.20.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 20:07:00 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:06:53 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 4/5] mm: shmem: don't truncate page if memory failure
 happens
Message-ID: <YWZNTUT4HQzdekzt@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-5-shy828301@gmail.com>
 <YWTrbgf0kpwayWHL@t490s>
 <CAHbLzkrJ9YZYUS+T64L9vFzg77qVg2SZ4DBGC013kgGTRvpieA@mail.gmail.com>
 <YWYLr3vOTgLDNiNL@t490s>
 <CAHbLzkrYBpbDN4QHGP_HYwcoxOxOpEK1Q=mUxcos3MtdZ5fEzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkrYBpbDN4QHGP_HYwcoxOxOpEK1Q=mUxcos3MtdZ5fEzw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 08:00:31PM -0700, Yang Shi wrote:
> The page refcount could stop collapsing hwpoison page. One could argue
> khugepaged could bail out earlier by checking hwpoison flag, but it is
> definitely not a must do. So it relies on refcount now.

I suppose you mean the page_ref_freeze() in collapse_file()?  Yeah that seems
to work too.  Thanks,

-- 
Peter Xu

