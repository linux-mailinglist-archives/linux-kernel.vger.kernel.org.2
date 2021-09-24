Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4B6417C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 22:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347121AbhIXURj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 16:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345611AbhIXURh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:17:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE17C06161E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:16:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y12so4315765edo.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dma3ODYRAwAqQNgxjoPPmrM71vwSjvGubtDE6+J/Uj4=;
        b=TCKaE7TNX17wekyhEJMq0Q25AVyKWiZRP+g/+Gp/8PWclgr/jK3NrgttQdr7wcLdXR
         Q7Vui+5HdK/XtCPVLRA1f3pBVqdfXx9tpC6sVw/nnEysSkKizl2mQK1SQUekXcJnHoZb
         iKS9R9k/fhu93FJDzD8w8K1oJinhGnJ23XrS0RrTKDPGUkbMcQkqosdn1u9ndrmaqYVX
         aY+QtdNzVtWH36uUWKCcNE6ZOBnMcRs/Ux8HSJmt9kBinzOvcfA/PBdBGjSEj4T5I68L
         agEiE1FY6qB/1zx1Jyhcyw1sMqbjO4VrSZY6VVVg4ZwmbJQMY9JC9tCVJhGtQbWB3EHK
         KETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dma3ODYRAwAqQNgxjoPPmrM71vwSjvGubtDE6+J/Uj4=;
        b=3M8vq66FHuOhLOA0DkFQBaJiSrKE2SYu7lybi62FejDgDHlRx7fxVWqs2q5qL02Xlu
         j6ynfe+EQTd9pOeZo7TuMiFggxmdd9JxQy32Do5ylqD7jjMHozlaDRRwRf19wFeWkbnz
         UhZuFxFF8M/s6pEU5EsaR8oWxfBK8d0eLi5TUQirDv6meXUnp5l2APlxsIYybLEDEQOa
         Zq14rviOvR4EVuvlm/WIBSXXz0Z+D/sKiQqxF4B2LbbvbRPOqu5FugjsgGIS4V0XN4wO
         eCKi4TnhGGO+a8PXzcFy9Vd0ztj37a9k6mZXe0z0hH4UwW+YpHlar6FhEXebUE5uqiY1
         0Avw==
X-Gm-Message-State: AOAM5330DCjhCYgUp/BeRjmj4fkXpzNYoOi06NpgxG3cCRC3e26QH20M
        MqbfHtOzwN7AA/pASYfkRBkI9ako3gj7aOAsKt6bJg==
X-Google-Smtp-Source: ABdhPJy+GO7D85GdcvOuwQ7T61FovB7Jo/xuxyb7T+18+fqF4fp9j9ohG6KW8vkKyjgJq4w4BsZG3i2clMRE46OOnIA=
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr13014432ejg.548.1632514562127;
 Fri, 24 Sep 2021 13:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210917210640.214211-1-bgeffon@google.com> <20210924161128.1508015-1-bgeffon@google.com>
 <20210924125422.358374d83cdb95db055a4467@linux-foundation.org>
In-Reply-To: <20210924125422.358374d83cdb95db055a4467@linux-foundation.org>
From:   Brian Geffon <bgeffon@google.com>
Date:   Fri, 24 Sep 2021 16:15:26 -0400
Message-ID: <CADyq12xAc4Y5P4n69oahPNs6M55cUb6=7Nku=J5iEOJVMBOPTQ@mail.gmail.com>
Subject: Re: [PATCH v5] zram: Introduce an aged idle interface
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Also this?
>
> --- a/drivers/block/zram/zram_drv.c~zram-introduce-an-aged-idle-interface-v5-fix
> +++ a/drivers/block/zram/zram_drv.c
> @@ -309,9 +309,8 @@ static void mark_idle(struct zram *zram,
>                 zram_slot_lock(zram, index);
>                 if (zram_allocated(zram, index) &&
>                                 !zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
> -#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> +                       if (IS_ENABLED(CONFIG_ZRAM_MEMORY_TRACKING))
>                                 is_idle = (!cutoff || ktime_after(cutoff, zram->table[index].ac_time));
> -#endif
>                         if (is_idle)
>                                 zram_set_flag(zram, index, ZRAM_IDLE);
>                 }
> _
>

Hi Andrew,
As written that patch won't compile when
CONFIG_ZRAM_MEMORY_TRACKING=n, my guess is that the compiler pass that
removes the dead branch only happens after it attempts to compile the
branch itself. So it appears that even though IS_ENABLED(..) always
evaluates to 0, the compile will fail because table[index].ac_time
does not exist. You should get an error like this:

drivers/block/zram/zram_drv.c:314:57: error: no member named 'ac_time'
in 'struct zram_table_entry'
                                                             (!cutoff
|| ktime_after(cutoff, zram->table[index].ac_time)))

Brian
