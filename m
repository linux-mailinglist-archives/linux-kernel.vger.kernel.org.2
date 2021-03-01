Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E20432811F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbhCAOl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbhCAOly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:41:54 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55294C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:41:14 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id k12so10657089ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQHOCamLVrBefwufRiy5HU/E3AUjzZBUCizdUCoqKsc=;
        b=WIJFuYqpapaqFwvO9JFT6AAZi9S6uqxo754yC8msLiyL2gmrh8AIyddisgHDo530fx
         cqjfdvCHPWku2SNqQG6OGQ3pqcvQOST2jCoEStnuSraVWNHp76TzmvdDi0anWN1c6CZ/
         oKWn/JlHo+xeMAUJ459QRGzvs9Q2ZFhu7FUj3C40LbBZxn9ArzQ1YT8MkGxQprhgFP7A
         Kt8SFMP/C93C1lg2M9+T3UWehs83MORFdp1VgA+zaPiyMIQC+TMxUFZKYOhF0yOVRUXT
         xjTIe0kjPW9nyZYYgmVPPiBDygKbNf7HInMjTFQfxGdb5g0bLV7Nh01H2qigjDduyenS
         Lzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQHOCamLVrBefwufRiy5HU/E3AUjzZBUCizdUCoqKsc=;
        b=YspksPmJuVJT60xTlnZEpCC3uZXh5znE7QmF7nLJIuzl9vamaorctDkio6L1JhDI34
         4tDDcV++L7BqPgCKqAQSndRqBeWtfEgH3GC9zjbo0yBgcUK5eRF2bmelq7CrZvnvfeT7
         BqkKcsS+1aVwmmbCqu3r5RklWYNh4A240NCV3bNZMmfhxLvy/BwTX+fYwbhGCSdaAwpq
         ehL5cKtbAKYx1hOnL6ijyo/eWvne9vK3iQQb1iqmckFBccJfQXG2r6TpTJNeeMnyaEH1
         gGGEWNcyJKDSsQExIWApOv/6Q8Vv24d1NLErOKlXrKxCqOTz6aoYlTq+DUGJJsyuw+d6
         jsOg==
X-Gm-Message-State: AOAM532bI/Vp3Sr3J5wgRaafczZMauXUqECx213Hdr9pydgDfbCDaPTI
        Rjoum2+PO7ccZHHHHq+HoiybzE7SJHupo0CifS0iAuT9vs4=
X-Google-Smtp-Source: ABdhPJz+reTjyQve2V5YBMUITRz/pswBvIz/TpjH+zQKPEYyW2zJgDIAn7Ude42SHhV0tSGPR8WEeWLGAbRaMK4/Yew=
X-Received: by 2002:a2e:9004:: with SMTP id h4mr6081568ljg.326.1614609672923;
 Mon, 01 Mar 2021 06:41:12 -0800 (PST)
MIME-Version: 1.0
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain> <YDvMOp41h6UlCKMP@localhost.localdomain>
In-Reply-To: <YDvMOp41h6UlCKMP@localhost.localdomain>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Mar 2021 15:41:01 +0100
Message-ID: <CACRpkdYv+97S2D4pXqR9khccy2VD3bEB0GC8ou8TfmOjhZXTPA@mail.gmail.com>
Subject: Re: [PATCH 04/11] pragma once: convert drivers/gpu/drm/pl111/pl111_nomadik.h
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 6:00 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:

> From fe8504a1a0b5352cbc676b933c3dbb79ae9f59c9 Mon Sep 17 00:00:00 2001
> From: Alexey Dobriyan <adobriyan@gmail.com>
> Date: Tue, 9 Feb 2021 16:50:24 +0300
> Subject: [PATCH 04/11] pragma once: convert drivers/gpu/drm/pl111/pl111_nomadik.h
>
> This file has broken include guard, convert it manually.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Yeah that's right, I wonder how this happened.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
