Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBE931C4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 02:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBPBYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 20:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBPBYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 20:24:45 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3035C061786
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 17:24:04 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n14so8636351iog.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 17:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJye+kSqwOydCXOrUXNte65cKiZnVuosg0HZqWH3+fk=;
        b=Z6to2lyDuRB0FdW0XxBmvurM//wT02lgv7/r0jT3SZT8EoPCTJbQbu+21VSGtSFtnH
         f/1ZTL1soBUcwgxsnwyw9E9bOw+XPNRw7+WQydmwJvkO6vMhJnSDbmxLGOdgo+HgOJGm
         iTCONinJWFfd5/8g4wN2JvKprciXK1rqs+CeLZyHH/NYkfOtiT/r6Jut6Jl+Yx4pdle0
         I2UuvvHMKbTyPXo1BGr6kg6XaZA8559c7j7pRqWYlnMAoa/M3O5JIMy3xsjzAl4HxkaQ
         vKYKSR2g7om/Y1GK8W6j7oFr4ISm7mpYQr6qki4RexrpRuzJj5DWnota8scYukdXz68Y
         rxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJye+kSqwOydCXOrUXNte65cKiZnVuosg0HZqWH3+fk=;
        b=nra9sx1BYaAZeWYsxRm3omiSELQQYwm0EPlH0/aXCBSQE7TgSpelxHSCIzAPMvOCH/
         n8mW6fLXrYtLy0Mpd3FYgK2cNJrPkrqoLpHU7KiXePnsfH0i7PukKJd8pUhJ0xP6G0gf
         1P5AeihpXeKfDUuxb8F8SF0OLqZcteSBVKae6Q9ZkhThImbpiarJrC9wMwT/8ooeVJ7/
         rshiFUEIK4dCaJMudX/Z3QHMTEKYw/JZoMEkg8NSyyc8BE7Jv27EGj7DkwK1P3otn89Z
         E05rhDuBpVtwUw0H07mPkNywgo6pnZmpHSMXYDq+iT2EhTX0YN5h/BnHzqoWKrD2wYOl
         ohwQ==
X-Gm-Message-State: AOAM530uHD6TJrKhvvGFVAUU30467umK7iMJNkzd/SB6MK2MIxUIxc5Z
        DY04JY46g01Zq04SEcj0Nri6POmkGhD7PGyk9TnblA==
X-Google-Smtp-Source: ABdhPJxDD54VyBmmZk6hcwEaZpNgzwqtUXGhXQLDibQ32pTyRaCu4xXKAaLhN53SGJR9MGA2MDvqZyppcJER56VW1rI=
X-Received: by 2002:a5d:93c2:: with SMTP id j2mr15222418ioo.166.1613438643994;
 Mon, 15 Feb 2021 17:24:03 -0800 (PST)
MIME-Version: 1.0
References: <YCqZ3P53yyIg5cn7@mwanda>
In-Reply-To: <YCqZ3P53yyIg5cn7@mwanda>
From:   Lorenzo Colitti <lorenzo@google.com>
Date:   Tue, 16 Feb 2021 10:23:52 +0900
Message-ID: <CAKD1Yr3Gpa4KZXzWDMO4-V-+16FCYPb4nUZMLde+cQLk+zRxaQ@mail.gmail.com>
Subject: Re: [PATCH] USB: gadget: Fix a configfs return code
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        David Lechner <david@lechnology.com>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:57 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>         {                                                               \
>                 struct f_##_f_##_opts *opts = to_f_##_f_##_opts(item);  \
> -               int ret;                                                \
> +               int ret = -EINVAL;                                      \
>                 u8 val;                                                 \
>                                                                         \
>                 mutex_lock(&opts->lock);                                \
> -               ret = sscanf(page, "%02hhx", &val);                     \
> -               if (ret > 0) {                                          \
> +               if (sscanf(page, "%02hhx", &val) > 0) {                 \
>                         opts->_n_ = val;                                \
>                         ret = len;                                      \
>                 }                                                       \

Acked-by: Lorenzo Colitti <lorenzo@google.com>
