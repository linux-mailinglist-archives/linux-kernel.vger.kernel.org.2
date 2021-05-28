Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5EA393EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhE1I2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbhE1I2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:28:08 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67241C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:26:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id q1so4160751lfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zq5o+DLPuG61PjhQgI8+kLrm3pIXfLo+aZxZqsHuNkk=;
        b=zJ2ABZ4A7vmq2DcxuyXlsj6bcgBi0vy8Ig6WUO7joB5gYNKVRlZWarhvHwlsTRxNzN
         7viqsYExLxNY1uBPfy2GBWsw6lw1cbAeO1WqlIwZea3Dr6ZuhJPGwyanHjS/6UkL9WUE
         pYHhC7fEvD+qTrL6GgyFFrqzSGyMlkEZo6x4rBtHBq0aSgTeJMpOQsJSuRp8+9gIZHD9
         t1QAC3LVMEtkYhkekXzJMitJ/thRi202cQqSonaXgSEyd7tgFDUPOlbKo7F341bk+IiB
         VBZEXbmSEI/TDJjLf18vs7P3zZlh4ZiDExntJuTNNeeRX5m29oAkjuBF6w7pHZhto6ln
         I0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zq5o+DLPuG61PjhQgI8+kLrm3pIXfLo+aZxZqsHuNkk=;
        b=BlGAyMyvGknCo91lGL9lqw7r+5L6ViEK+JqJwzs63HY8PEKGBsIH4iNH+HKnc7yLk9
         08kFfNjd7ZmbydXIgfRExLYJW0haBzF021dXErWKb0GF/p+ymNHi2Qd2zDt1e3eEc8eN
         ORD/LrluzneeEJY2dJ65Zv97hcKm2qCuCVK6d/zO2p2qLhAX8sMbzs+kwakpwiQ3jZ2E
         TAPe/vCmwUrvstBF8NVUFR97lFU/pxYQ+Yzzf2gSz4JM8SujXfZp7IzFfplnD6wEMTgX
         hy3Ryat8jWfxPXgPmLNNgO1ML6MHXkF3fWpoDsOsWHtp9Pa6xeaWbnzJxLhUyti6x8OV
         gA2w==
X-Gm-Message-State: AOAM532M1OaKB12v5naV51oJjyMMQ/oQB0YvhvOD0j9HyAAjE9WZ995J
        XoV6sbm5Rm+xzS7vGV53dTj5FqSF8Y17QxXcVkWaG6ynd6w=
X-Google-Smtp-Source: ABdhPJzDGckvCASarcU2Hl/DxaIetWMJUiQvpwfAlKm+KCEj6vYQB9/KQVNt//05QQAZ91c4CQhTjwsxe7LqlP3odVE=
X-Received: by 2002:ac2:47e6:: with SMTP id b6mr4984338lfp.649.1622190391813;
 Fri, 28 May 2021 01:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210528040014.2160181-1-masahiroy@kernel.org>
In-Reply-To: <20210528040014.2160181-1-masahiroy@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 10:26:20 +0200
Message-ID: <CACRpkdbov_w0-bXdaUOdZs8f+QeVbPjmpr0U3VP7pwd+hSK6HQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: remove unneeded abi parameter to syscallnr.sh
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     patches@arm.linux.org.uk,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 6:00 AM Masahiro Yamada <masahiroy@kernel.org> wrote:

> You do not need to pass the abi parameter to syscallnr.sh because it
> parses all the lines of syscall.tbl except comments anyway.
>
> Simplify the code. Also, remove unneeded single-quoting.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
