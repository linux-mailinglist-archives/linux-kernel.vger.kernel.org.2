Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AE540F049
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243721AbhIQDTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbhIQDTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:19:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806DCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:17:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23-20020a17090a591700b001976d2db364so6317998pji.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbNHcb01vguljn3HU3vHlhpXKlPXw6Yq9g9yeJyPROY=;
        b=A7yVtKDyrR/CtjqI7IwFW5bwgxK7xUS/nDBrJ7n7rDYRpDdTYAjh4vuUMPTmKYaYLL
         E5Y3rCXgc5+DJBsO+bt32xGG9eHzP99Rwdd69zBtuMqo4uGXQQXAOTH8vXYEW/pMnL3d
         bsvh52njH9/V9oeZMphNcbzXqxUrCz5PBkpdSPuMkzKOiXcfCjmGASL0OJi0sv2KCXPm
         FKumvmOBRXQHSRr+JmiK5GEo51ySioNU5iwWACW1Zp7m9xEiZLNS8uc2k9BSNiKjZahp
         Ba3X8Da0rBm0EaDMI0MvNlbCl9AhyMYe/AN21TwITsyazX9Tdk4W3HDSrpaYltf6gOo3
         dUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbNHcb01vguljn3HU3vHlhpXKlPXw6Yq9g9yeJyPROY=;
        b=wzcZIhE7AIvRZeTBR2XGluScvcf3vL/waLZ/2MpNAQk1bVHIGoxQVgZ6pZKpsF4nDe
         +K9csZsvU6j1+Vig2asCk4/SEyblb8RjK7DG4hmKeVyQmBJ2b3XEnnphiCDspdbjxfK6
         TCP3OzHq8eIYu+MyT5KvxUgun8mUJf/KJ5TzI2TaVeBmac7C0nhoJ29Rt+a0sTx+0zli
         3UbqWDeJQaKLY4Ay9ciks11mU9mNgukiUV/mDZpLqQrw/A2qkumuc9arRFNht163Ts2r
         aupqalC0TkBSeeNwdGNa77h8QHyxLCHBJ8EbTx9/bfue4Px9f3kt649pQn0jG18qLjW3
         si9w==
X-Gm-Message-State: AOAM531mTRmt3mqLL14Vji2dkA1sqkLmhRlIWDBdMVkDivARwxq57ocE
        FsbddVLftrETPu3gwwS2o6GfO0dwrkVREsFVx587xw==
X-Google-Smtp-Source: ABdhPJx1CWuFGn4scE6+tio7BoIn9gU1H0Pn1kIyiI6cewMOVkInzQ1r//9k5NCeR/FqqbnYg0iCQhRy9Vdq4SHrg34=
X-Received: by 2002:a17:90a:1d4c:: with SMTP id u12mr9467178pju.95.1631848672994;
 Thu, 16 Sep 2021 20:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210916193014.80129-1-peterx@redhat.com>
In-Reply-To: <20210916193014.80129-1-peterx@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 17 Sep 2021 11:17:13 +0800
Message-ID: <CAMZfGtUGdDps_8RX5dvrakx9rJRTLYhKaf_uVD0bg+6yzWPPNw@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: Drop swp_entry_t* in mc_handle_file_pte()
To:     Peter Xu <peterx@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 3:30 AM Peter Xu <peterx@redhat.com> wrote:
>
> After the rework of f5df8635c5a3 ("mm: use find_get_incore_page in memcontrol",
> 2020-10-13) it's unused.
>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
