Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4993B003A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhFVJbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVJbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:31:32 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B03C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:29:15 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o6so2368524qkh.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iu3d+Ew+lBuYvRystq+F87ixcBpjW7lHGCUrqjjn8P4=;
        b=p4Ae5VQQTetVu33QUq+WJNrlBWiEu1PazVxU36/DcrVOkPvnk7rebdnxfy4aZQXKI1
         E+i9CdTP7D8DKo2T7m/ityi87O1KVakc5+KmBwnBj9k6DsAIHzlE+tJLgMx3c5/ewr/e
         /JndYrwZ9shKDLSZi+opT9gurc298PPdbwQo0JlhzjhSgoplBM/CUcdLz03MqPHq7TlD
         stumNqOnjM9/YEHKkrj6l22mkKemSBJH8NEL/3ZgcW3eZrCZdibnfFH3JFWj4IVeyCXF
         NH8S5RphPHk4WzqtyrQBjKQ/ptjcX/yKvEP/L747fdHbxAJFvb8zlZg4CzGjDZl1XwT3
         P9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iu3d+Ew+lBuYvRystq+F87ixcBpjW7lHGCUrqjjn8P4=;
        b=NXjbeCmEgUgEATuo8b9OBd2pVUdwFCZK2W+XSjpPVymSIIfPFN3Hll6xNfiqAjVu5f
         XEA+fzMMU4upHtHPjtRol+fiTGgOP7NARKfOFwwj7iNY0w6tExZ7ivu8mSaQmhNRWktD
         DS5IGZY9LqvA8MjR5no5EgbD2OKpdVV0HSNjXNzR7hiR9n8VPTpILrm8Sdx7qgJCn4Oo
         dwfqvB1OLQlc3r2pvS0Qnn9R5+TIVgJkJ/c8PaFNeOTwtYxzoGZEhuddN+R6q0WXz6jt
         K2J9D8yCBhYu/xhHTTpqTTmOeOBCDvHb3qNcvIhZFHXy2LhqhagwxDCFmj+NQj7i9lv6
         xTqg==
X-Gm-Message-State: AOAM530u4ByQszMTzHoow1FpUJcA9IS4Wf9Re54/Y4vvojDP1i7IguyV
        iA3Wr3bkpW78c46RBWVSSTMr0YJCQSXmQqoueG26qQ==
X-Google-Smtp-Source: ABdhPJwKINDkHhIiMoTOhbUCOSZQgE3ZDGjdG4LxhdluI5hPm00NWcESSEf6cFlcwNKT9t+CNT/63dRe4jTIaZOV/jA=
X-Received: by 2002:a37:e4d:: with SMTP id 74mr3207110qko.6.1624354154077;
 Tue, 22 Jun 2021 02:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210620114756.31304-1-Kuan-Ying.Lee@mediatek.com> <20210620114756.31304-2-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20210620114756.31304-2-Kuan-Ying.Lee@mediatek.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 22 Jun 2021 11:28:37 +0200
Message-ID: <CAG_fn=U8HiKU28goM+yzNrgq_LeygS6m1bz+k_xqGEw8x58sNw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan: rename CONFIG_KASAN_SW_TAGS_IDENTIFY to CONFIG_KASAN_TAGS_IDENTIFY
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 1:48 PM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> This patch renames CONFIG_KASAN_SW_TAGS_IDENTIFY to
> CONFIG_KASAN_TAGS_IDENTIFY in order to be compatible
> with hardware tag-based mode.
>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> Suggested-by: Marco Elver <elver@google.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Alexander Potapenko <glider@google.com>
