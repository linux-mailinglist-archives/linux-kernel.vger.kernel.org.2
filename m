Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1842134ECC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhC3Pl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhC3PlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:41:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A0DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:41:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u21so25461139ejo.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DrmbtE2dQXz59+Tv0kxMP5lgZLSi9Ve2ZbONo4ZS6cE=;
        b=alDstcpgm2rtv8wkKKY+5877CcuLLvwwEWcP1xQBr6vplqGdlOl795TVFQITWkWtUc
         pArS1nMnYliatNQ8hVVV6LKCrcwIFOrRI8I2gfcUc0flh68/LWLNQDWTYzbsIpVxTEt1
         /J3uh3uhNirsvmnmnrPZN/tD0uTYXeHOu5NSVuOGWkRefSiMAmqkV0muPsgG8yz82f8i
         BMqFkUN1rTuGWBk3h10RO5vm7PniWdqk6rBooE0XOyMaVaxXNrsM6Kdb7x3/NC29jydO
         v8j1Asj5WtEJZ3UPSsdHbEE88F8SDEvN7Vsdfd7duXUnr6VnKOzbN6j7qg9jAWGvy9et
         h2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DrmbtE2dQXz59+Tv0kxMP5lgZLSi9Ve2ZbONo4ZS6cE=;
        b=UyzXHTT/PbBV8vryuAoPpwnC3lSBJv5yDJxOGbWUHYeE0Hsp+wkxo8yqzBfiSkX2eP
         yG88SCgEjj8wf+xohNUCq6UKjX4FA5ige8qu+Hl5fS2pmNtlu9Gf0Kra93b1y1v7lcu2
         CdnInOAdEoLW2XZc6QwbGbmgxB8cREnCCIXAjQndXzLbtpBNWyuGmnEZcNIiWQvJ3H41
         tZDRiCBq1K3ewIAxSNmAT5wsY0TWkAeusUtySnytU1T4Xe1yAdn9PBapNMkPPMLNldZ8
         D3lgZG3xdXKgoMOhEvoD0g9362Kbva4d+IhNTgcd3uR+OKjDaHyN1xVJ03txUfAHCvQK
         5kxw==
X-Gm-Message-State: AOAM530KwqWcPYaseu1KnrirYH+uE6Faq1TNd4tnW00fcxHeO39EOjwW
        squIGplYCeF/4O51oXBalwNcRbxC6779f5EyTZA=
X-Google-Smtp-Source: ABdhPJzUUncsplACHM9EAxXmcqgIv0tIWc19SZ9rZOYZ61bk2/Z0mFIhqt5yBNTodZt1q0bPZx0fp7F6o3Un45jcLPI=
X-Received: by 2002:a17:907:d1b:: with SMTP id gn27mr33850149ejc.227.1617118872916;
 Tue, 30 Mar 2021 08:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210329125449.GA3805@willie-the-truck> <20210330081417.22011-1-lecopzer.chen@mediatek.com>
In-Reply-To: <20210330081417.22011-1-lecopzer.chen@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 30 Mar 2021 17:41:02 +0200
Message-ID: <CA+fCnZdugY3ei_iZ3OLukdgLnGx8b0h-TmbFARXQQWwww3EZmA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: Kconfig: select KASAN_VMALLOC if
 KANSAN_GENERIC is enabled
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>, gustavoars@kernel.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux@roeck-us.net,
        maz@kernel.org, rppt@kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        tyhicks@linux.microsoft.com, yj.chiang@mediatek.com,
        lecopzer@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 10:14 AM Lecopzer Chen
<lecopzer.chen@mediatek.com> wrote:
>
> > Do you know if anybody is working on this? It's really unfortunate that
> > we can't move exclusively to VMAP_STACK just because of SW_TAGS KASAN.
> >
> > That said, what is there to do? As things stand, won't kernel stack
> > addresses end up using KASAN_TAG_KERNEL?
>
> Hi Andrey,
>
> Do you or any KASAN developers have already had any plan for this?

Hi Will and Lecopzer,

We have an issue open to track this [1], but no immediate plans to work on this.

Now that we have GENERIC vmalloc support for arm64, there's a chance
that SW_TAGS vmalloc will just work once allowed via configs. However,
I would expect that we'll still need to at least add some
kasan_reset_tag() annotations here and there.

Thanks!

[1] https://bugzilla.kernel.org/show_bug.cgi?id=211777
