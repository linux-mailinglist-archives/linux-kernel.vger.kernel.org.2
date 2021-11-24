Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9562B45CE51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 21:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbhKXUrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 15:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbhKXUr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:47:27 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0258CC061746
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:44:17 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z8so7993923ljz.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+gJSBFxED6ehQVz3JbYVzRIduuNBjN9QCQBt9+Tl8U=;
        b=Xtk3yKU4Z9YgRhsjRptKrOtJBPHHf3wchS3ML2iLysLtJ+w1Uc6wlfmpe7Pnl82Th4
         YBsPt3B1MG8rPfy1ds/uVHKukORdmc4lM3OCZEm7uG1vQLCfhx7FXOXntG2MMZuZkvRO
         jPR64FxVuOK7qIlhvSuv8UOMMiI9I9+eE2rQjoDUcz2sbNTB39v6e1NRqBrDk3ISLKts
         fkG/AL6750Sn06vFu6pkQSGulLQnIcgmpKuaCqjCmvpDwPXLY+EgH8fbZgyVAvnACPtL
         6RDIsWexjq+TEaon75yLn3XaLvnH55YB/ory4hheDTz/rguMpecD3PHmbRU5SfUsuHT8
         bqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+gJSBFxED6ehQVz3JbYVzRIduuNBjN9QCQBt9+Tl8U=;
        b=sa1Go9UQ9YbdrgSugBrD7/XbANqR7r/rbNUx++tQoskStMJUVQ5hXuAfrpS0rGTzTd
         E7BHvs/a1hSINZaJNZLjFU5NeHVc9KXiH8ocKJsX6mwat6y2eCb/GqE32MHobUkmCQUf
         fxcnu9uyK0OtbeSzKqgnfZoqFOdnRHk1xhn7BBGMY9/CsAAKyuvONoWMxC8Q/z8f3sKa
         qIHTQ41LurolPhWvWdfUKCzghdNbNZG5F4+1/sdjFYIVnVLv2cQrGPY8kMAIM1Rxn5+w
         3Gdjh6sQhIbxWwZrVPQT07He5VkmeICm+k0pDu7K7Vicyx1yDP1ktmnCz0Xo9EQ+w0sl
         GsRg==
X-Gm-Message-State: AOAM530b6BK20wb2cs974eMsDYrgdXHl1323JMw5BSJQ2n7ZA43ilNKz
        2ld92fVRC0c72UOFdBm42RegT/A7Snq3sVc7TBKVjQ==
X-Google-Smtp-Source: ABdhPJwefa8dMgRLrKBulOVpAsBgtFrSTMYXJWcmjQi7W2ymv70SjNCSDyakkVmtTsTGp72ciPfLpU9x3Xz4toKJCE8=
X-Received: by 2002:a2e:bd09:: with SMTP id n9mr18622372ljq.40.1637786654861;
 Wed, 24 Nov 2021 12:44:14 -0800 (PST)
MIME-Version: 1.0
References: <20211123190916.1738458-1-shakeelb@google.com> <20211124201238.3xzpy2b5zcv7j23s@box.shutemov.name>
In-Reply-To: <20211124201238.3xzpy2b5zcv7j23s@box.shutemov.name>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 24 Nov 2021 12:44:02 -0800
Message-ID: <CALvZod6zUsCajhYcQOod+Nf0Y34x_sS1nnc7zAXUwZX0w3jzTw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: thp: update split_queue_len correctly
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 12:12 PM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> On Tue, Nov 23, 2021 at 11:09:16AM -0800, Shakeel Butt wrote:
> > The deferred THPs are split on memory pressure through shrinker
> > callback and splitting of THP during reclaim can fail for several
> > reasons like unable to lock the THP, under writeback or unexpected
> > number of pins on the THP. Such pages are put back on the deferred split
> > list for consideration later. However kernel does not update the
> > deferred queue size on putting back the pages whose split was failed.
> > This patch fixes that.
>
> Hm. No. split_huge_page_to_list() updates the queue size on split success.
>

Right. This is really convoluted. split_huge_page_to_list() is just
assuming that if the given page is on a deferred list then it must be
on the list returned by get_deferred_split_queue(page). The
interaction of move_charge and deferred split seems broken.

Andrew, can you please drop this patch?
