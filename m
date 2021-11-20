Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4996A4580C5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 23:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhKTWQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 17:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhKTWQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 17:16:49 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0539C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 14:13:45 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z5so58761307edd.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 14:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryydMt5t5CJJGDbpw6CzjUPaIIEJppZiHMdgdEGKi3g=;
        b=S5zp2yK+g4hOZGDP89+yueOGCCvI0zWMM4AjbgrpVEUpexbUZapDBw4/8NNB8nxj1O
         BJF3xWxdpJQhIiexG2LbWpr/CG++qAT/zV4V+8UjlPWT/25iyfdXOBZVXrWqrG5aVYWa
         w0pEdyXu9L+pjGpATabj12qYfhEGirtP2iTrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryydMt5t5CJJGDbpw6CzjUPaIIEJppZiHMdgdEGKi3g=;
        b=kaXGy7OwQHm2Z1MGXupEKd8pNO1wkjcVcaxmRi/NJ96etNIwcDfqy/RkSMxHnGsRSJ
         /9GQN3C9gNazsKZuxIXQPXFuxZbagtq7M/WclbHcrZOHVLyoF1MiowykFUCm7fvaDVt1
         VkOLTSw2gu5mLyrGlBvpfY8ThLlpQPEHMbvP5UFRxDKSxb1fEAy9EaQmizZrkDU7lh0g
         QFc5lLWwJEEi+5GWzQGWkAYCAmgiVfQR2sFr2wEdTMnyl7nH4hqvYYEe9OmEdaZbU4HW
         wiXK4mw97t40StRlZJGXshURafnewcdiyT5KA9t7xaOz1LupHpisuYUKu5PpXIakzgLx
         Dzrw==
X-Gm-Message-State: AOAM532l/R2xThy6VyYNDp3nZ8xVd4j5aGk8Iol1A7lOxyQiR1OB5cBc
        6QtOKUQgrZnikkqBdu2fyNWXK4gCk/0Smv53
X-Google-Smtp-Source: ABdhPJwYCMTN5S1CGPy6v/0KUJDtetQl0/U4wp5vn1c4WMYLD5eInE4HgfjAy9QsN2TYu95Lb/9hCg==
X-Received: by 2002:a17:907:7896:: with SMTP id ku22mr24922586ejc.410.1637446423892;
        Sat, 20 Nov 2021 14:13:43 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id i5sm1658532ejw.121.2021.11.20.14.13.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 14:13:42 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso13374849wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 14:13:41 -0800 (PST)
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr13986880wms.144.1637446421065;
 Sat, 20 Nov 2021 14:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20211116193247.21102-1-shy828301@gmail.com> <CAHbLzkooDg-KbtBxofBYFvNF8nN=vTCwb6+srYZOHqqBLH58Zg@mail.gmail.com>
In-Reply-To: <CAHbLzkooDg-KbtBxofBYFvNF8nN=vTCwb6+srYZOHqqBLH58Zg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Nov 2021 14:13:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDwowy+Q_M74f=0AFW3izcqU9U1OL2agyOF7=4fvPefQ@mail.gmail.com>
Message-ID: <CAHk-=whDwowy+Q_M74f=0AFW3izcqU9U1OL2agyOF7=4fvPefQ@mail.gmail.com>
Subject: Re: [v2 UPDATE PATCH] mm: shmem: don't truncate page if memory
 failure happens
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        Peter Xu <peterx@redhat.com>,
        Ajay Garg <ajaygargnsit@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 10:55 AM Yang Shi <shy828301@gmail.com> wrote:
>
> Does this version look good to you? Would you please consider to apply
> this to -rc2? Or you prefer to get it from Andrew?

I don't see anything wrong, but yes, I'd prefer this to go through the
-mm tree and get at least that minimal testing (and maybe extra eyes)

         Linus
