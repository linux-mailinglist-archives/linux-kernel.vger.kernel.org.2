Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD53FD1E9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 05:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241839AbhIADrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 23:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241754AbhIADrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 23:47:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D01C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 20:46:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eb14so1702948edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 20:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MbuNJ6AQL86qsQ1Xnhu/tEYDLNw3wqiKq1TKFtDIHSI=;
        b=V8+dKyDWIxJq3KqvBhqnqbWOUcoOIAMkmOAR9HytZqqlK/C9bxciBAsOOeQ7Bgyoyh
         jtQsc7rtiNzaRliiI3M3GSFW3JdcHFkG2RKGCDgp1f0SNHlZoDBceDDeulwneZYwMlak
         Ykct7OZadYrQgwOWGddzIa5MaM0ZcdxNhfNPgxbA5y16ReSo+UjegTI3iFx5X5/UCUvV
         tP8Q4Dnd1RGcoSsW7g08iLtU3IU/56QDzxoGMqPg8vIPIMuZ4EyMnz4N8XyXcrAf9ak/
         6qAnD6Mbv6tzrHzCdYacF5Utbga5owTJXjKdllt6ijDLKGXVcdp3NKvNgfUiVVtpty9d
         j+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MbuNJ6AQL86qsQ1Xnhu/tEYDLNw3wqiKq1TKFtDIHSI=;
        b=QoYBWaPqsKRmH8HEoIuvPfBVbF7G1KZuOmwkh6GeJdeaDvhZlF99O26euaKtIA4GyV
         n9Ss85hK7B/MuqWt+VthNX5nht7kviSuN9OFudT5rvAOAsAIcuDnC+KygE8CnMFkdz4O
         TfKa5IAJJiLeloKx/OQQl5D/soup09fPA80iYtryIRxuKjsaiG8zZv/q/RW86nXFsAtH
         vCZ2V/H11B3REsbofP2USDWxJuj1PpIeTogJIGPd9dDr6+f+zVDR1Bv0F5QMk3nnLBYT
         gnAsKFwUcCGt3ySfZUwdZ75UOMrIMUTA4bN6ocfiL3lCluDi3cKTWmuwqiQAb5TM1lWE
         gOzw==
X-Gm-Message-State: AOAM532sDZXqbe8wqyWYVWhE9EPQcECDXCs9ykceHoh99njOFmWf3AUq
        hbr80CU+U1pGRHkgdIP49Ugu++DYTtMJ/ysO0bI=
X-Google-Smtp-Source: ABdhPJy9s+z+QUT6e6AwiRpwZUDZbAebS2l4PqraMxyCjwb+g0iO2x2R8F8cV79dQdDPVNcRmEYpJAup0Ee1IAnJOq0=
X-Received: by 2002:a05:6402:2751:: with SMTP id z17mr32892978edd.290.1630467984022;
 Tue, 31 Aug 2021 20:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210817202146.3218-1-shy828301@gmail.com> <CAHbLzkpkDXyEZ2izMwpkwLg9fN7qsQ+soR+iu6sd8RfOSqhS-A@mail.gmail.com>
 <20210831233839.afaenhn32nx6m2fq@box.shutemov.name>
In-Reply-To: <20210831233839.afaenhn32nx6m2fq@box.shutemov.name>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 31 Aug 2021 20:46:11 -0700
Message-ID: <CAHbLzkrXOM0Ow3YbZnj9RyvTJ8fwaUCzAizOMR5MP=TkxeLywg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: khugepaged: don't carry huge page to the next
 loop for !CONFIG_NUMA
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 4:38 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Mon, Aug 30, 2021 at 11:49:43AM -0700, Yang Shi wrote:
> > Gently ping...
> >
> > Does this patch make sense? BTW, I have a couple of other khugepaged
> > related patches in my queue. I plan to send them with this patch
> > together. It would be great to hear some feedback before resending
> > this one.
>
> I don't really care for !NUMA optimization. I believe that most of setups
> that benefit from THP has NUMA enabled compile time.

Agreed.

>
> But if you wanna to go this path, make an effort to cleanup other
> artifacts for the !NUMA optimization: the ifdef has to be gone and all
> callers of these helpers has to be revisited. There's more opportunities to
> cleanup. Like it is very odd that khugepaged_prealloc_page() frees the
> page.

Yes, they are gone in this patch. The only remaining for !NUMA is
khugepaged_find_target_node() which just returns 0.

>
>
> --
>  Kirill A. Shutemov
