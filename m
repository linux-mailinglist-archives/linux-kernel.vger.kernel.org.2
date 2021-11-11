Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C710944DC85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 21:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhKKUd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 15:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbhKKUd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 15:33:26 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC175C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 12:30:36 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso10706063ote.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 12:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzDzVYR0M79hyvBHJE7uEcbzBg19CocEHZEJQr1HHzQ=;
        b=NZlNS3eUQpdJ3o2/+AsrT/n/dxmcxrDHDhg1yvQbaochf9CZ2dWOE2nI+J2ZJz5BMC
         WT3qAHVZvZbF/66Jx4Ws9hcwsKSZtxnm5RsM9iZ43F49NSMr/8Y8l7N3T8PEE+lcwpxB
         oFdifq3Scxa8UW/VYxeSlEuSDRA2Zmlkn4rPT3t6W6VEr9U3/C4vMWv8OWnzIjxfNwnw
         WjyYkRsvuSLNEKLqeDWH13qIMiar0wGTIqCaTnYzyAKUD0uLF2ZtYMx4QhtjgF2hP0vj
         e181VIOKqUjibj1m9tqESyBJRmtA5mOom2Sjo9GyjsoF2iTfV9dth7hAUiAvjW32h99j
         IRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzDzVYR0M79hyvBHJE7uEcbzBg19CocEHZEJQr1HHzQ=;
        b=rhSbaSLelRWzlAVhiGS4Up8dDqTzkSvwRANc4yWY8za3Hg0kaVCZreSXI9s+08Jb+Y
         RIlSoj9Kj4Zv8xVd1LuQK2XuCNjPU6PZ1+n9KsijjTpGhFQqz5IqvZEoD2nhXy/kFH/f
         LnsAb2XNgBr/tariA6qcrOr1luP9GJ8Try3BT9XAC10grEO0Z48dgyOgdkKx8Pcg78bb
         rtuN9W0hWuW6PbJF91Jsqonr3br3WGKQfjpP37CEcXC1eKlHvxGcWPO8lDQQ6QDy8UWU
         mBOwJ1vSWnj4nYsJTHs5cwcBKPfk882iq1VMlijYzUdFKGkMLPMAMvW8PBNmjxO61sDM
         4eKg==
X-Gm-Message-State: AOAM5300Ci6/B/z6pOuJ70BpzzP1rteGo+dA4NiEGK6dfDfzwXJIicaG
        p5VHzxdK8v2+4Od4s3NyZHQynKisdUm3rfAbH9L0/J3crws=
X-Google-Smtp-Source: ABdhPJz3uUybVw3PcgXJ7g9JJ5cGGITzZNQRPuK3gNfmchhxxdGWbOxvN5+5U2L7vuPhsMx6ltALjgy8yqbnPQzgoMQ=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr8262289otk.179.1636662636167;
 Thu, 11 Nov 2021 12:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20211111202506.19459-1-brgl@bgdev.pl> <CACRpkdZ-DY3YVRDZmpU458wTqeNy0khdfJTNDk3UBjnX0zAUHw@mail.gmail.com>
In-Reply-To: <CACRpkdZ-DY3YVRDZmpU458wTqeNy0khdfJTNDk3UBjnX0zAUHw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Nov 2021 21:30:24 +0100
Message-ID: <CACRpkdY-_3LEZaLNXNLtuM-DUUS-DjMXM8GCsFx-MvnEU+bXQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpiolib: improve coding style for local variables
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 9:29 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Nov 11, 2021 at 9:25 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > Drop unneeded whitespaces and put the variables of the same type
> > together for consistency with the rest of the code.
> >
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>
> OK then (also results in inverse christmas-tree shape...)

i.e.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
