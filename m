Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F8939896B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFBM0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhFBM0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:26:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95796C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 05:24:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id c10so3508117eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwfKJOjaR7R6vzUo1s6BF5wo5oy1/Uxlj9t1SzL/r6g=;
        b=qTe44U4p6PT0wikwIdv6f+Q5KJDNZZuqRkp1TfXfFttdjmgLHZenydDf/bXghIRPb5
         NIXcq90EdZKu/DJYjR0L5KUXfaacanzLR4et6WuXoSaVfN+kRewPFQZ+XivUm7Oo/Tnn
         56E+sZl/FyqhlyFNzSwtF38MdwEgZnAjlx1TXZ2CS+0cPRQE6elf3byOwTAKN/x6XxlC
         U7HdA5KVta0YMTYFNY3xhMIg7QaTGGhl37bPIISJ2rUrutue0KJxsDpdELjxfrlte6cn
         JlA9JE9BhjlL7AGMhyzIC6MdnNVh7Ls53K6T2cS3UckLXEmZ4tSeMlbWFnb8x5gT/jwY
         uPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwfKJOjaR7R6vzUo1s6BF5wo5oy1/Uxlj9t1SzL/r6g=;
        b=jcny4NacEe8XlvHJ/8kxLk4Gqo7TqC6MA6PyJpxP7ku3ip875bj6EUFc9qzsCmyTwi
         3tmyKyq5aZzfPWpH0p71Djl0EBcr7Sr6U5Li2w3UKwli5o9pRfoKYV5A4wEBJ+775mNA
         6TcQat5XF1PmFt80RJ89nr9R+gmsjTVYYXc9YHqyM+xUIP6cfQqn/jbhxglanrQ61ovV
         4VBTsKGdhkmlqQRo6EP+XjeIISRg/sWyYtLQv/44c/L/33PD7JWLFkMrLoG+jWScxH01
         ZFA9yXgp+DjLGQxLafeYfu03MyEtSg/RAgQ/1PMEAt3/PAT/XOiMmfTpgFd06q3qNWHP
         GM1w==
X-Gm-Message-State: AOAM530obfPFB5wwcd3xXjzUsVGwB9UbBPK+QOOf2zKa7SgcJ7uOPtNS
        LAx4KuatEFr4nzZSuJE35/Tfvsy1UMJWz5N4RpltVOG/QKg=
X-Google-Smtp-Source: ABdhPJzsiXc2u5mECupMkkVWYnf84fFmvHy4h/CZTKleRGIQUTPrIA1mw8k9Xx4/IR8U7JKxpPZb4/J3+lfdiS+mNEo=
X-Received: by 2002:a17:906:a945:: with SMTP id hh5mr33928412ejb.227.1622636685254;
 Wed, 02 Jun 2021 05:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210530044708.7155-1-kylee0686026@gmail.com> <20210530044708.7155-2-kylee0686026@gmail.com>
 <YLSjUOVo5c+gTbzA@elver.google.com>
In-Reply-To: <YLSjUOVo5c+gTbzA@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 2 Jun 2021 15:24:34 +0300
Message-ID: <CA+fCnZdb_eueAqG_Ka5-ea3EurG4oCmFCQ9Zd+d1O+BvkdNXnQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] kasan: add memory corruption identification for
 hardware tag-based mode
To:     Marco Elver <elver@google.com>
Cc:     Kuan-Ying Lee <kylee0686026@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 11:50 AM Marco Elver <elver@google.com> wrote:
>
> On Sun, May 30, 2021 at 12:47PM +0800, Kuan-Ying Lee wrote:
> > Add memory corruption identification at bug report for hardware tag-based
> > mode. The report shows whether it is "use-after-free" or "out-of-bound"
> > error instead of "invalid-access" error. This will make it easier for
> > programmers to see the memory corruption problem.
> >
> > We extend the slab to store five old free pointer tag and free backtrace,
> > we can check if the tagged address is in the slab record and make a good
> > guess if the object is more like "use-after-free" or "out-of-bound".
> > therefore every slab memory corruption can be identified whether it's
> > "use-after-free" or "out-of-bound".
> >
> > Signed-off-by: Kuan-Ying Lee <kylee0686026@gmail.com>
>
> On a whole this makes sense because SW_TAGS mode supports this, too.
>
> My main complaints are the copy-paste of the SW_TAGS code.
>
> Does it make sense to refactor per my suggestions below?
>
> This is also a question to KASAN maintainers (Andrey, any preference?).

All of your comments are valid. Thank you, Marco.
