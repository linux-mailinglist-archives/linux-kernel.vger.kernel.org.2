Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39521401E25
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbhIFQTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243510AbhIFQTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:19:43 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2796C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:18:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m4so12113099ljq.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jFOMTg1acDodXW4CLrNWKGTe84isP7AS0vQ+SeIQ3dM=;
        b=dQOuxteCo7OUUvTf+rZz/dtgPOwcfY4bRfeOZKUb3ckSueRCIcKCJzKjeJUkuRItPt
         2dXVyVTeW9AZNO0Qf+8+4k6c7WVKwWfWKwIlBki1vOnzLvHxcfGV+C96SR/nAf1FynMf
         fqiUg/OcLByOIAhDdEjcEndRhPOZOxFQk3ddE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jFOMTg1acDodXW4CLrNWKGTe84isP7AS0vQ+SeIQ3dM=;
        b=pNllOJtKqQMQUx5tNXYhCqzDL9hyioInTBLR0Oz8JtRCtG0gWYHq84f6DW0yN9qhmA
         8cs6JV7rs68xiLorY37L9QYN8mcl8sOgsDn70L9sTlWSsJTtdbJzoGjXzlVcg+k7sVAQ
         lB2KgxJKSRPUbmLmTD7Q8qXs5sef9WKihd5REXsPCqbYz1q8DV2YmWqHqQr17cnqoN8z
         6I17TMagCrvF6q/7dNCTGrmWNXCFhkDUSqFQiOeTEL5Y+f44/CuYMsraRdjfdcpiPY2D
         oSUpqhu01RB8ATdn/3uWIqkcUlGbzATOQPAMBU+U9b/kp7BwpD2DZZJNPCpI1fmPobJl
         qFcQ==
X-Gm-Message-State: AOAM532OEuaAm9BpSWz7/FIrEtQNS8U9Iw8SaLiwLoOmb01YcWOeWO+x
        L2q3O3DCCsWPQWQ6x5YWXDuRpq10cMEYxcozTGs=
X-Google-Smtp-Source: ABdhPJz7nkV0Oz/nwQtzqqnQJNbLZq5DtHxGUsQDAR6waZ05W18E+jG7IONiYOGyz4xUZevP1NdWtw==
X-Received: by 2002:a2e:b53a:: with SMTP id z26mr10787694ljm.95.1630945117086;
        Mon, 06 Sep 2021 09:18:37 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id w37sm773893lfu.291.2021.09.06.09.18.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 09:18:36 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id g14so12112461ljk.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:18:36 -0700 (PDT)
X-Received: by 2002:a2e:a363:: with SMTP id i3mr11055675ljn.56.1630945116038;
 Mon, 06 Sep 2021 09:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Sep 2021 09:18:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKXwDrTwsJDiL8Pmb9M=Eo3akUrnrRLMrbiQHOp_kEXA@mail.gmail.com>
Message-ID: <CAHk-=whKXwDrTwsJDiL8Pmb9M=Eo3akUrnrRLMrbiQHOp_kEXA@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 9:12 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I've got at least one sparc64 fix in my inbox. It _might_ fix some
> other cases too (syscall checking), but I suspect it's one of those
> "death by a thousand cuts" situations, not just one or two issues that
> show up.

I pushed out that "don't make the syscall checking produce errors from
warnings" patch by Stephen Rothwell.

One down, N to go.

                 Linus
