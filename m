Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632EC3E85C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhHJV5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhHJV5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:57:37 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1460AC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:57:14 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so876254oth.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=3CKiUkciyqrhRNXWdxOMWFYpCxgAYsTB56M3DgbEbSE=;
        b=SNy/E/cWnLYbgGZnakp3SuCzfhohYLGhDVt70Hy8g6rR8xgblVfXSKFo6iDkjc1JJF
         h+Qikx6HkULyPm+zLK7+DFKCsHucfzVCk9U+uGXcWwmx5fBVd3h9btw5jv9GYdt7Je+g
         5HalV0IwtjRs7u15WidNmDX6IYv/Afp8uDm/ymD0L7qXVIOPHoiE86auJ9ZNKXTQlrUY
         Zx7GWvEQLkEmF2AZfpn0e3t6svZXfLajmK8WeCOws4shdyZRxql+qsfYmoaYr3yd85Ms
         Ouk2DYUthxYN5UbgqQDGNJIuGJowoEtFB4Nv9BuzQwxSOJlaWOHxpa6hVXGk4qkgf3vS
         woiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=3CKiUkciyqrhRNXWdxOMWFYpCxgAYsTB56M3DgbEbSE=;
        b=eIjg1odMbbzFFWBfyE58Yybgs2W7my+8TBg3WnlmIkLj1cbcNj688wbMf4MCZIOqkJ
         RkLh2uT3yRVVo1VdD00csYR0eZRBXKWm3XlyaaMdHgujP9RP9zy4HUSG/njk0Ukssg6p
         rU0VzU6tuR5B0cgY9UukbBVGIwj1Yhd/TDsdLcu46L+1xNX7Kgd5AcX6TYpzq6hecoOB
         7C+seW4RZms8XwCgebc2wTAY8abrnJEXGr/OI/wqYjo9/XAhVfOq5yOlI3jS+5uaVS1X
         HR1oifdwpLJpMf+VRkTHl5YgqSCO3cda9j2CTS8cL4Izvrg3R1//FiOaPRcr9oKaFjCG
         jCnw==
X-Gm-Message-State: AOAM533tZEY8X/K6Amp8UxSHfVfv7slgCjhFHHaqitqFa1xAkhPavad9
        uwa7PSylXGkhiCnbuoCyyl8YoA==
X-Google-Smtp-Source: ABdhPJxND1r3/Q/piPZkf2esSXXZ890/lZNgwNteO7rZbCT3vPjvRJEiQ+HfNA2tpcc4/vytKz4Bqg==
X-Received: by 2002:a9d:24e8:: with SMTP id z95mr14359964ota.181.1628632633289;
        Tue, 10 Aug 2021 14:57:13 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h60sm2678725oth.76.2021.08.10.14.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 14:57:12 -0700 (PDT)
Date:   Tue, 10 Aug 2021 14:57:02 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>, Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] Revert "mm: swap: check if swap backing device is
 congested or not"
In-Reply-To: <CAHbLzkqifgqAgytL_XGa=fE3tH-oU9x=uv-yNCYGzeO3QEGvFQ@mail.gmail.com>
Message-ID: <82e1c65e-f942-1421-5053-7b77679dfbb@google.com>
References: <20210810202936.2672-1-shy828301@gmail.com> <20210810202936.2672-3-shy828301@gmail.com> <3983c910-a02b-e67b-8c2b-7a379c3d22e1@google.com> <CAHbLzkqifgqAgytL_XGa=fE3tH-oU9x=uv-yNCYGzeO3QEGvFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021, Yang Shi wrote:
> On Tue, Aug 10, 2021 at 2:08 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > I guess 1/3 will vanish now, since what it's reverting has not yet gone
> > forward to Linus: it would have been nice for 2/3 to have mentioned that
> > what it's reverting is kindof buggy: but then you'd have to explain the
> > "kindof", and that takes more words than it's worth - maybe a lore Link
> > to the discussion?
> 
> It is fine, I think this one is the best elaborated the problem:
> https://lore.kernel.org/linux-mm/24187e5e-069-9f3f-cefe-39ac70783753@google.com/

Yes, that best elaborated the problem when I thought it was a problem, then
https://lore.kernel.org/linux-mm/e82380b9-3ad4-4a52-be50-6d45c7f2b5da@google.com/
explained why I later came to think that it wasn't a problem after all.

Hence "kindof" buggy: but good to be reverted anyway.

Whatever!
Thanks,
Hugh
