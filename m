Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62E53AE4F9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhFUIfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhFUIfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:35:09 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E089C061787
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:32:54 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id r9so4718883ual.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyR5BeTCOPiEzhLXOoP4zgcKDESexLdcdJu4pl65SiY=;
        b=Ts+cw78rGUGx1mzVOd0XZDx4w2BACVKVIHtmARCSf+GwfAQYzOr67ryufCc/Wx3cTt
         +FIa+a6iv+cUndApmhERphBKGwytNCLYq9lnfxZxOXH6ah55qdzGVO+70isk8YZhVMoA
         tNuHswn3UnHCUuKROkp8QWeCmBojXCkhgrb8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyR5BeTCOPiEzhLXOoP4zgcKDESexLdcdJu4pl65SiY=;
        b=Nxk4lzElPhX5gOVD9BoPDC2MtsX/5NjlC1uSuBD4zZQvcVpDtMGjxmspX3J8nj9+jD
         YdFreeWGG8WP+LLB0LwGe+AFa9BqR7XKIoWtA9CZ4eSU9xOSLxQPfILN6UtrNj9oMsNC
         mJ2M1MREdqOSVW+YV4T91ok16YEjNzGyFwYfXKy/xjaoy9BXB+QaVh1ByUHaMaOEQo78
         s9UbBIGHk7XKm7NfRaYWub/hWze9Z1sYQr8xDBWhNW80wkbTj3qkwVu2DyD6Vh+4MQnv
         2EM1O9l6V9tao5yYmrcxBPkp0UTti9U/2RJuL/MXJv9STq6VMKPge+8zF0PrE6tXUGQS
         Vwsg==
X-Gm-Message-State: AOAM530olDuhhI/eRK70kfy7mqjGHAJ3/SacfLlGKYPItlA8XCZrx8Uw
        sfUxJRL0AbGjGRt3oIqDyhy9dtf0qBqYAtDQJ5gR2A==
X-Google-Smtp-Source: ABdhPJyUn9WwHIOZk5yzmppXQ1vDz67GiVGVK8+LZL/EAAcUso75naYtNYNXQIxJbyU4gawA34Q+mmSYUHrwMXsACnA=
X-Received: by 2002:ab0:6998:: with SMTP id t24mr21315544uaq.72.1624264373720;
 Mon, 21 Jun 2021 01:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <1621928447-456653-1-git-send-email-wubo40@huawei.com>
In-Reply-To: <1621928447-456653-1-git-send-email-wubo40@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Jun 2021 10:32:43 +0200
Message-ID: <CAJfpegtyxmjD9gobfwD6aYwg718MM6dz2JpFtu20aNRU-ChHjA@mail.gmail.com>
Subject: Re: [PATCH] fuse: use DIV_ROUND_UP helper macro for calculations
To:     Wu Bo <wubo40@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong <linfeilong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 at 09:15, Wu Bo <wubo40@huawei.com> wrote:
>
> From: Wu Bo <wubo40@huawei.com>
>
> Replace open coded divisor calculations with the DIV_ROUND_UP kernel
> macro for better readability.

Applied, thanks.

Miklos
