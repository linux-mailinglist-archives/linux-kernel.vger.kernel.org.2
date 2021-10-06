Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605194247D3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 22:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhJFUUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 16:20:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229922AbhJFUUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 16:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633551531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ndoPsgxw3pXa2WkzFUSKjNPOdhdtHbMEsZXh2h30JEc=;
        b=NPckKvoR1CHgo6deH3aBUg6HgcGywgu0mjDhueYLuXpwxY9PUKRPPzS5+FvI3+L8SccRwD
        pl2o6B692iKPuQkQokJdeH0HG8OODHjakNDGLaegNaY9iPlpn0L/xXTZIw4CBBrJ5X5TWL
        ZRy52nGZQEhxKJiUGGBTn+5lkRyGVZs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-0dwVXyRlN62Eh4dbWkWXqw-1; Wed, 06 Oct 2021 16:18:50 -0400
X-MC-Unique: 0dwVXyRlN62Eh4dbWkWXqw-1
Received: by mail-qk1-f199.google.com with SMTP id k3-20020a05620a414300b0045e623cd1afso3061610qko.20
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 13:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ndoPsgxw3pXa2WkzFUSKjNPOdhdtHbMEsZXh2h30JEc=;
        b=Ow3DxUT4561+/zINYLKldd+X3bM03QnkqKxk5SrMEhIRGRpVYN1lvP95tUE3gh59et
         /wXNQQmVNjtFG0FDnm1zAw7kq5UEOd25quUgzbZ007xOjx2uxf42Dn32CoX1vg7Xb7iv
         +sffUU9jZoE50Oe0bgla30t+u/M185C/X51YSJIl6LBqfO95Moj/LemH1IF1SCDywuBW
         MC1aX5Ed65/XTmBQXBoaJKeVNJ+N5GZq1i5Ft9LMIYAbXUeGf1t2xcDiw8HCL5WCDeBm
         fmwWnIdoaOTiFhqmHE+NjvOY4e+vrec2g56dThlJAUMfpSiX/fwI1SXNkjjIsh0oQG0O
         12jg==
X-Gm-Message-State: AOAM533aHWQuEkcTswriEmIWbIm/TBjDqzyE/+x6Goa6l40K1qJ/DfQM
        Qp5rX/6TaudKDPtfZXCT7BfmGejs/2Gf8pwS7CjZHj9QyvDOE/5SI+tXiVdvaTnbFVfKTvORhv7
        xf460EvufII2aFMXA+qtckznD
X-Received: by 2002:ac8:40da:: with SMTP id f26mr279399qtm.114.1633551530172;
        Wed, 06 Oct 2021 13:18:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKZ1/nqV2JLDLruE0ZKjTUxqTpHKJD6s6mBT9Z4jMzAijU04nZ79wKZ6V6d9P6rkNvidggIQ==
X-Received: by 2002:ac8:40da:: with SMTP id f26mr279377qtm.114.1633551529986;
        Wed, 06 Oct 2021 13:18:49 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::bed8])
        by smtp.gmail.com with ESMTPSA id q8sm13891462qtl.80.2021.10.06.13.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:18:49 -0700 (PDT)
Date:   Wed, 6 Oct 2021 16:18:48 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <YV4EqOpI580SKjnR@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930215311.240774-3-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> +#ifdef CONFIG_MEMORY_FAILURE
> +	/* Compound pages. Stored in first tail page's flags */
> +	PG_has_hwpoisoned = PG_mappedtodisk,
> +#endif

Sorry one more comment I missed: would PG_hwpoisoned_subpage better?  It's just
that "has_hwpoison" can be directly read as "this page has been hwpoisoned",
which sounds too close to PG_hwpoisoned.  No strong opinion either.  Thanks,

-- 
Peter Xu

