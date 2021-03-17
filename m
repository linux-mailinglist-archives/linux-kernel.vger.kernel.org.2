Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFBB33F9E1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhCQUST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbhCQURx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:17:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B02C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:17:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q29so870665lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCK1uQIcxm8OXGgRHg7NKZ1L0n8wQ50xR39kklU4ehs=;
        b=OdDYRPjwG/KffT3RPD1JqVqMXP9pAdHXLW3oaFjZzW8LxdCpwoYwGrfUD/JWgdqwfN
         inXEKwU2jOjNhWzYbJRuzNNT6NIc6Hh9gKSpG4ROQH/xpU5sNfXypE7m+LZRIbCHoMHE
         9EXVAVOaYqK1B0gheLVcUjP7mdS6AoWAXHeBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCK1uQIcxm8OXGgRHg7NKZ1L0n8wQ50xR39kklU4ehs=;
        b=b0XVuCDkqmcDwJ0u9YYlSSXU504hmR6zSb0i3RTtGltRTW8zcdt+PC9U3xVhSRcLXG
         uMOXvQA7dhIRtbWZBqw3Y4WXDYRHLcXzmIyDapcqtiFKhlrgWciWl2FzI/4jeD0QkGtY
         LAZtKM/peKLNTmLxBlCAvo7geJWAiCK32HBY7oIgg0RGsD1pjheafCNJ+n7L1RdsNfMZ
         /07eMVdvNgoV+LoZzT03i9EWN+11PyG3R7QT2SNKNqPP44OYK4YmX8lfPutspN6S+yqY
         nN15HrEEFoyXYxSXzKGapwTmf8GdQ0cTIafTILj/zegXAqXPFhrKVS6TpOIS845kWSee
         QuxA==
X-Gm-Message-State: AOAM532fZXMZML/KIsBW7pe8whzNJ/PMIxKhTseqrI12v9aMNXuHFz6R
        YN4Hoq6WsCJ0TL/vhCdfTGj3k0j1bxHtTw==
X-Google-Smtp-Source: ABdhPJzOBjgTYBvmzCzgtrjtqcrxkmNH6yXWluAHWR+QNVUJR2V/XmY3bb/gxBR9D7NqTkhgqqQVZw==
X-Received: by 2002:a05:6512:1284:: with SMTP id u4mr3441913lfs.175.1616012270725;
        Wed, 17 Mar 2021 13:17:50 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id b3sm310lji.36.2021.03.17.13.17.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 13:17:49 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id w37so882162lfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:17:49 -0700 (PDT)
X-Received: by 2002:a05:6512:a8c:: with SMTP id m12mr3271119lfu.253.1616012268802;
 Wed, 17 Mar 2021 13:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210317104547.442203-1-leon@kernel.org>
In-Reply-To: <20210317104547.442203-1-leon@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Mar 2021 13:17:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+Bsc1T41qziHxf9DvrBrYSBWKj27hEL0EbysCGRPzTA@mail.gmail.com>
Message-ID: <CAHk-=wj+Bsc1T41qziHxf9DvrBrYSBWKj27hEL0EbysCGRPzTA@mail.gmail.com>
Subject: Re: [PATCH master] module: remove never implemented MODULE_SUPPORTED_DEVICE
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 3:46 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> I'm sending this patch to you directly because it is much saner to
> apply it in one place instead of multiple patches saga that will
> span for at least two cycles if per-maintainer path will be taken.
>
> It applies cleanly on v5.12-rc2 and completely unharmful.

You have an odd whitespace-only part in the patch inside the comment
underneath the "remove RME,Hammerfall" case.

Also, your email seems to have swallowed spaces at the ends of lines.

I can (and did) apply the patch with "--whitespace=fix", but that then
causes git to fix some _other_ whitespace too, so the end result isn't
quite the same. Oh well.

Please check what's up with your email sending client that it seems to
remove space at end of lines in patches.

            Linus
