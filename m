Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3618F44ED2A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 20:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhKLTT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 14:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhKLTT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 14:19:26 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEC3C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 11:16:35 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g14so41703437edz.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 11:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwlhh4ObYgyftk3Vlxh5cZAmisObbbSfjfsVhj0VL5k=;
        b=WBO1QGe5ryegdVBB0z1xqEyX8/KxPOtp4x/mddlZjwJ6b3cRqtM/siROTqLKbfIqCn
         qHUhDIGY7J3FKL9YwXaoQBIlYZG9WpzhCNsUmWVmlwmVrfgav4tz/wWbYV4wIyrCOFZS
         jmV6eODZQN2FCb2KuHkxe28FQhpvkPrxswNoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwlhh4ObYgyftk3Vlxh5cZAmisObbbSfjfsVhj0VL5k=;
        b=majifqxxzkAI2Vuq1VdfIeUTVyUzln6xWIZIkkqhIMarTocmmtsWslESYQaX9snQ/Z
         ro97veZ8Q7p2PONGkS3bc7WFH7YO+UH7mflcbVUGZelcJENtzUACGTRk3p2ORcj+9cGd
         SVIcLkOL/uvciSlUtmKoIN7JWDwdxZ54iYyM8sVKkwP/oROe4CbpjhJGITtqqeTyQt+Y
         Gw+8lwttef7d+Mr0mqR13PPm8EMtCjc42+j+BbPulhCqsNjbxHoLbGyzeoZd49/DYskQ
         PDayLQNYDqomTNAfKy+WbzNt6ymJhB6Gn2ZSSbT6LOnGOWp//UnQgb7ph7NhFiaKgjzC
         AvRQ==
X-Gm-Message-State: AOAM531i8piubnx76odnNK+jN0faDp/pTIcZfEmuy+0n9HijNPOPER09
        kpcy5nnPIaPZEoheJZLal8qFcZPBblnfsaA72+c=
X-Google-Smtp-Source: ABdhPJzWWqP8jARFG6nqUUp05U4LLgDVfvIyrRIaLqaxzQ93Uz6LPXB3uXgyLA6w4Ba0bQzDBLvk0g==
X-Received: by 2002:a05:6402:10c5:: with SMTP id p5mr24203804edu.150.1636744593641;
        Fri, 12 Nov 2021 11:16:33 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id f25sm3354495edv.90.2021.11.12.11.16.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 11:16:31 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso7801048wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 11:16:31 -0800 (PST)
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr19634337wms.144.1636744590912;
 Fri, 12 Nov 2021 11:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20211112151602.1378857-1-sashal@kernel.org>
In-Reply-To: <20211112151602.1378857-1-sashal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Nov 2021 11:16:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiAWDZRzzG8T7fiBBESM9S-Uzy7OFVY9iv-UwjpAbhp-Q@mail.gmail.com>
Message-ID: <CAHk-=wiAWDZRzzG8T7fiBBESM9S-Uzy7OFVY9iv-UwjpAbhp-Q@mail.gmail.com>
Subject: Re: [PATCH] tools/lib/lockdep: drop liblockdep
To:     Sasha Levin <sashal@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 7:16 AM Sasha Levin <sashal@kernel.org> wrote:
>
> TL;DR: While a tool like liblockdep is useful, it probably doesn't
> belong within the kernel tree.

I have eagerly applied this patch, because I wasn't too happy with
that thing in the first place.

However - I do note that there's signs of liblockdep in the
tools/include/ directory still.

Some of those headers may now be dead, and should be removed, but I
didn't end up trying to figure it out, so I left them alone.

This stupid shell command

    git grep -il liblockdep tools/include/ |
        sed 's:tools/include/::' |
        while read i; do echo; echo $i:; echo; git grep $i tools/ ; done

seems to say that yes, the <linux/module.h> header in the tools
directory is still used, but the rest of them seem to only reference
other dead headers.

Hmm? It would be lovely to clean those headers up too and get rid of
them - because those headers are very much part of why I hated the
whole liblockdep mess, and why I was so happy to immediately apply
this patch..

              Linus
