Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45B634A7A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhCZMzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhCZMzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:55:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1803C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 05:55:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id e14so8198482ejz.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9SuKX2NoEYak6u3D158Ip2tiJkKOlip4/1iUV6Bsqk=;
        b=ggap5Sp3+odxqMJh3RqglKX0EXcNL9fn7d2HwELaiIos+42uMG1miSZc3ROFkoYtgE
         VQq1uKuHyvzV5IvRpIflFhD+y4R1vLMJdHzi7VZd0d/yBosbQs0tB2BC9LWVR/myUHWv
         JU4HlRBTLCWvYU/9q2spPXtUtafjglSzBQi/JL4yZx7pNq9g0HuhphmxaHdrRjwLgBJn
         QP/FtcGv1oLy1a2BLq/+VksZ3JFTDtDIzcV2WKfc+foE7UEZDxX3WrzAozNJpxx1RB0Q
         DRa6Ad9IPrZk0PcI42ci3dOlOedVYriL6DtpWDszHPCktnLMq2iDv+EKGK8Tw4z7cidj
         hSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9SuKX2NoEYak6u3D158Ip2tiJkKOlip4/1iUV6Bsqk=;
        b=c2d3aiSJe7QZt9UjLNXv1Ysf5iW8jkTPT2Xfifpz5D32ObDjigX3HFSxu3w2lll7E3
         kDFKAr0g1TyxIm37UxXvCoIGAhpoFUqiMp9tGwxiuDSwjVh1ynQJL2cRFY9ns+J1xeYx
         P7KqokRbg8JM+ixrNK4dtNEyz4iZ1c5oqtgUwF9Q9VnyOHwTdyZ8Sz1626MO445H7n3Y
         CKyEJUp+f/HhP/KVIHz7waWYs/hvMH+sCxeGfXah+E7mGS/2GNphhOwKriDSAqbDj5qF
         a3f18R95BziD//Sfu8xHZ90/VxWbMd0l1gA7RlswFzUAkgEchDgxqSyvzrCNHAE3ZCqe
         I3hQ==
X-Gm-Message-State: AOAM532UY5pcISlBoYNy8T4MIP4CLxGLcGjTm6WW05P7jsCAFI9d0qKn
        k6grobvWVj6S6tx3EDjUKU0AwD0IP3p39unjlkL+OrNgago=
X-Google-Smtp-Source: ABdhPJzb++lSdMN0Um5MXgBROBDwVzJQUX1EAskpAuFjHJf/1X8hm9zb9e8EIhAk9iEY/AoAh5la/fxiA9AS7zKEiW0=
X-Received: by 2002:a17:907:20b7:: with SMTP id pw23mr15440690ejb.168.1616763320445;
 Fri, 26 Mar 2021 05:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210325175536.14695-1-rdunlap@infradead.org>
In-Reply-To: <20210325175536.14695-1-rdunlap@infradead.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 26 Mar 2021 13:55:09 +0100
Message-ID: <CAMpxmJVxA=1oYhQ72ZgWrWpupSENjWBDeXK4HTcmAL=dAd7JRA@mail.gmail.com>
Subject: Re: [PATCH] tools: gpio-utils: fix various kernel-doc warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 6:56 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
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
> ---

Applied, thanks!

Bartosz
