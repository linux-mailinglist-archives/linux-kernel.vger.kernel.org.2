Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB1F348B08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 09:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCYIDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 04:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhCYIDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:03:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0FCC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 01:03:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b83so1150006lfd.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 01:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUQQ17pfF98h7CsMopKhBpalX6SwViYZJyiCT0Dk6fk=;
        b=engkWQ7VAcLaLe+W/hLSlbhd27mHjU+Abo/v5CfcsmDbaEWOwBjQA9KsuBnRKc9A1p
         nfqTD2MdCPq10qveGeDsI5+OYOHJjzpa9HsUesPSdOI1YatKQYKIaJK9f4GgJmKRCXZp
         gleZYIEzE+zATlNgenryame7GnrkcNxLHDmkCrkUwePr6vwepgZfEBVzZDbh6j+SfJrj
         mgv49NUJx2IYYfN4fed5XGJrBLR7BO+BONb0zH7ZJ9Be6lA1U7QX7CMd55FjC+kfawK9
         u7WsWEahi1PS6VRhaRHE4PNEJIiz30AlhOD1teEfd6xgxrKJ6SP+bwhoPr2wlenmNgBh
         UHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUQQ17pfF98h7CsMopKhBpalX6SwViYZJyiCT0Dk6fk=;
        b=S939bnmI9PkGmMcYVm5GqGsmKlkB3LoaG/j3IwUJTpbwtDvqrfRwUJClD0160RrXys
         QehLxG9AI+VbmuZNIkNRw9swdRrtfto1QLe/AJ8iAKrgrQiVqT1DlcdJHG5ZucRcR77U
         5gDNdqhSGDFPiOhD5YGMcIVPXohzj9sZi2BGuioM0x+TfOA5qp/Vm3Yc9s0dTkDTLUXJ
         f5bfKfm95AwT/6VXT1lZWPv7cNhAlt4f9gaaix188C6xuEZOmvCXltw1YxTA+tFb7Yhn
         X6rckw4QxbzBkYmi+aW+udqAOJ38B4zIF9sPwvREaPbO0CuYiEJfhfxMTS1WXzr7ZqiV
         3hnA==
X-Gm-Message-State: AOAM5323K23Fq+JfN8zM8GmAhoYzvFxsQ6thW9XOBXxBdNIampg7vTwJ
        YiRXrcve2DpI7190SSRzjdk2ZK1WqIjOGmihHJPYnVGS0Y75x2JT
X-Google-Smtp-Source: ABdhPJwDfUh2m/FklwRPWs5IDoLHRwfoEvLvH70YnfgRuIL/9f344F4xGYJbD9HfvZUuGO5HcxBGYL1MR5lww1MI2Qo=
X-Received: by 2002:a19:4c08:: with SMTP id z8mr4095968lfa.157.1616659393242;
 Thu, 25 Mar 2021 01:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210323221905.19529-1-rdunlap@infradead.org>
In-Reply-To: <20210323221905.19529-1-rdunlap@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Mar 2021 09:03:02 +0100
Message-ID: <CACRpkdZjz2_BVWD3eD38jPy8Q5A0YO9AvkYhff7bM0_3aa0mew@mail.gmail.com>
Subject: Re: [PATCH] linux/gpio/driver.h: some edits for clarity
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 11:19 PM Randy Dunlap <rdunlap@infradead.org> wrote:

> Fix a few typos and some punctuation.
> Also, change CONFIG_OF to CONFIG_OF_GPIO in one comment.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: linux-gpio@vger.kernel.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
