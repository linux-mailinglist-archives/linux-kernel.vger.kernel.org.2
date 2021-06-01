Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857513970D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhFAKDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAKDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:03:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF57C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 03:01:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a5so20905987lfm.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 03:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0LPdqfY5UxuP13pdo5l5+tdJaciBMttPQRiDpCqSbw4=;
        b=bFcRMfW3cF5FE2a+4yPnwXF6OT/PRyUu4T/SkZk9LOmkLM068sxIUx8/7W75UuVJSe
         XgXDBngCYhzfC/z6NyjyR09FaQeresjuA4J+yvKL2z2blQeoF+Kq+ojB5aL4FmEn6t+I
         wpPqSsP66owyPitk9W8c58DVAkaH8gO0aPNfuHVXTO//gIHKVwV2mZ1t3MkAYWZI4/xH
         BOoH9Kz2iUumwwDCYixQ+WqMvOm9HUr0+wouNnTDKxtBwoXe5k0ufToY2tJbGnoDlLuf
         DX+VVXzvvRGk93eSRVfNR+HtYGXDR21IC4PyCtpscmRURVlHBkLPqb4bsAgiMu+qlR2y
         83nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0LPdqfY5UxuP13pdo5l5+tdJaciBMttPQRiDpCqSbw4=;
        b=AMNFM/u40wStO7hiSGliK8Wn0zlB2KEts2+vGvoY42dEvDVYzgnbzJKt2gSkT7V2qk
         THh/yKXmFTSOmBg3mETQmhHcTo1Kx2IsW4RvcapzmtRuaZgz2cOB6ObY0QODaL+XmFiS
         ZOxeSlfdWyx7GlplGq7C8+84NNQSS4rz0Sv7K6Lv53PL6qi8JMbblGZ8xsw13MmAfPSh
         f8IAahiuEQ4l+BTcImuJesna0vFUtungMHTYl9C0lfL5aesFmV+1IUG53Z6lUZ4XqOGv
         bLTe8s24Ig6ftUh1Rwxfp2+mssQ7+Z8Yp+iMHB/f6eVZO7stWG7pzD7FS0wUsrbN6Fne
         bScA==
X-Gm-Message-State: AOAM532sPn3jBRTOck5OLbdtv9YRRcxcOE3J/rgrvbQQkJ0ts5YS/uEi
        UeMpk62vNTgnxNEf1e4KWC9jjBxgss3d14WyiKwnCg==
X-Google-Smtp-Source: ABdhPJxsC8nHM+jX2D1eZH8XWwfaR5Ia3VXOP7gAJ5fk2uc5czbdzEdIviZycaZeITkoEkT36xqkK8X1uE3aA3PwiY8=
X-Received: by 2002:a19:c753:: with SMTP id x80mr3622886lff.586.1622541677992;
 Tue, 01 Jun 2021 03:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210531052307.1433979-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20210531052307.1433979-1-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Jun 2021 12:01:07 +0200
Message-ID: <CACRpkdaq5gd3cAfR8oUHRzUkGHcN4wqQjURs0y_7omJUhY7Riw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: cyttsp - change maintainer
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 7:23 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Ferruh's email has been bouncing for quite some time ans Linus has agreed
> to look over the driver.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
