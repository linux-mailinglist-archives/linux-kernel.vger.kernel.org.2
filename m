Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC969447F2F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbhKHMBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhKHMB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:01:29 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845B5C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 03:58:45 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z26so1341805iod.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 03:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylqDbxsbeGt4jJrQOrHP0W5dDr2VwFt1eu+TTFpHEK4=;
        b=ov/ebkmg26IvR4AYTe4quYd79E/Pd15OnFP7fNG08x461C419GBUTV7YM7OTnbC2kS
         f0MKJIVW6l3OUFrPLvQcJ31Ldi86adpVnCsEchds5wlRqt0psuZ0V+ubNuE7lGDvw3gd
         cDX9R+DFJiU3nVtidQ89v9ap0Csa131gG4XWEol+BVFtgbg1ljDMg3jmi2hLePMlmnX+
         CetYe4SrsEbhTgHjh1D66Lnm4g4JGyjXhS1TnhudWBt5hk7qxRpxhxQ2WxT5CTbhdT5t
         6uVpi9WSWRAL47gszWflN8mGAedYC6i0kHwfLKIh8nv+Fa1cieR7dAUF4GbXToa7M/nI
         ClrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylqDbxsbeGt4jJrQOrHP0W5dDr2VwFt1eu+TTFpHEK4=;
        b=xrH9fdCjzcTzF70Qo0tvbRs2yeUtu9xmJdVDq3mdzxROfwnMNabHuuksRqC/NcaN0f
         Nexd8HfDR69obT1s/yymlQ4gvx4xyHxYB8gqHRI7V6bVBjEwULFq7o8bi1dZLPVOv1ls
         gAiAYh25TgSS+zu9BRnitC1h0uxe2iKaMNvp5/8gTN5UrdjtBUp0OIUP8y8s8qGDzkIL
         mCzw1hFxAH3tNIU5eaH4RHch9Aik6WEg9cMNn6TveSb/k2MGOMLILTkiYBffL1FvVspX
         Fz0uR2o3mSweYwa0GK2Wr9B0wDlmFbW7fCLoCaGJ8rYVE0BVVfEpFliYU+0Xq+mq+iK7
         5jxQ==
X-Gm-Message-State: AOAM531CbUcNeXXpg8DWiHsaLL3kZLZiEHrQqZwq19d9iUb9gCu3IgS0
        DH++gryQmfhArm2tFElH5h5E2M1bf5XUafNXraA=
X-Google-Smtp-Source: ABdhPJzh0oRYTJRuCxumQBk9dj3vhsUJciZ8WtwxrHiJLWTGMYh4Zs0vptekDbSyqfqvu1wKeZOlHj60bFCCOhE2PJ8=
X-Received: by 2002:a05:6602:8ce:: with SMTP id h14mr2471749ioz.177.1636372725022;
 Mon, 08 Nov 2021 03:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20211107150304.3253-1-sampaio.ime@gmail.com> <20211107150304.3253-3-sampaio.ime@gmail.com>
In-Reply-To: <20211107150304.3253-3-sampaio.ime@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 8 Nov 2021 12:58:33 +0100
Message-ID: <CANiq72kgm-5CidoN8VRLnWokiDSWsQcMFbaUd4WKOnbPsON9RQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] auxdisplay: charlcd: checking for pointer reference
 before dereferencing
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 7, 2021 at 4:03 PM Luiz Sampaio <sampaio.ime@gmail.com> wrote:
>
> Check if the pointer lcd->ops->init_display exists before dereferencing it.
> If a driver called charlcd_init() without defining the ops, this would
> return segmentation fault, as happened to me when implementing a charlcd
> driver.  Checking the pointer before dereferencing protects from
> segmentation fault.

It can't hurt -- thanks! I think `EINVAL` makes more sense here, also
we could use `WARN_ON`:

    if (WARN_ON(!lcd->ops->init_display))
        return -EINVAL;

Cheers,
Miguel
