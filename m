Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171B2349A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhCYTiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhCYThw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:37:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF238C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:37:51 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o10so4202304lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Rchlofo3lY1DcCDfOKw0G6YJBPElsf9bJrD+rPfL8o=;
        b=whXu5iCwH7F2SfCXqzL3qFdwsxuSdx8orWvvM3v+aWLsxB77Ms05tbnTywDXpO8QP5
         1iJZfD4PRVfLfLbMugZ9OoOw1sm8S++QzxfOxnqNgkIfWq1tUzAlPtNzTA6maxogahPP
         +4b5U/Ec14Gbo/Laa3hkw95j9ohgtR3CycIHT3kozy6tefKbcpTgsCL2x72lbjgOyBHp
         fAp5dSCMUE+sUNyB7CqGlj3aAfTMVz2/TsnmlwCvoprhTdX5vFnryBQ/m7UVz6iZUNLb
         ebUlysOo39r8ZeLPUZ51aJhdUe3mIsQPV2Ml0Uwc0yIigbkoabJ/W/Dheb6Q3+lrmWpU
         CjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Rchlofo3lY1DcCDfOKw0G6YJBPElsf9bJrD+rPfL8o=;
        b=Y29ijKc+98+/zQKk0OoxJ9fScKOi3lMyS0IHJaTxJKmLQ4MFzWTXjzchyvIalW2oDM
         hBRELfyMj4NxEy4iyLx2d6LymMnO1CNpxmrKrbhufS0CME8vQKbQAJ29oEWUbouP7vkx
         FDxSPJiKFRG0VyhnPAlpRrOcbmknezvMoYfxiuKSemmTMHhYOs1esgkPkLY8fnoHQq7W
         G38zseU8dJKxIQjkn5jEY0477l1r3IbNNoqsf3BX+0WUMOR2TZGJ9F4TSmbvLiF8tu37
         eYexIcdEM11UMuonKjG01HlVWHiau1hzJpzFOa2irZvhWjnnfoXwYcDmSxouEO/vhZgu
         KbHA==
X-Gm-Message-State: AOAM530ExooqvNnSLJ5EcNXQBcaz+dnRW+wqp1vZ1mt5U38cAFFWeJt9
        kqwAZf2GH0ipqQWBtXDBtXK88FW8bYT0nR5ntiRmew==
X-Google-Smtp-Source: ABdhPJzd6rrv4KZE6WdmHVIXwFAb0l+q4anvrdtyw7HhldUSXuAOFS1wJJLDGQJAgsBHBWym4gAnZEmwJ49Cy1OZYCQ=
X-Received: by 2002:a19:4c08:: with SMTP id z8mr5638855lfa.157.1616701070322;
 Thu, 25 Mar 2021 12:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210325175536.14695-1-rdunlap@infradead.org>
In-Reply-To: <20210325175536.14695-1-rdunlap@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Mar 2021 20:37:39 +0100
Message-ID: <CACRpkdaR9SMUaf7YNPRW3fsTLiz=5C-3Z=7-fgBw3wFzEM8gVA@mail.gmail.com>
Subject: Re: [PATCH] tools: gpio-utils: fix various kernel-doc warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 6:56 PM Randy Dunlap <rdunlap@infradead.org> wrote:

> Fix several problems in kernel-doc notation in gpio-utils.c.
>
> gpio-utils.c:37: warning: Incorrect use of kernel-doc format:  * gpiotools_request_line() - request gpio lines in a gpiochip
> gpio-utils.c:61: warning: expecting prototype for doc(). Prototype was for gpiotools_request_line() instead
> gpio-utils.c:265: warning: Excess function parameter 'value' description in 'gpiotools_sets'
> gpio-utils.c:1: warning: 'gpiotools_request_lines' not found
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
