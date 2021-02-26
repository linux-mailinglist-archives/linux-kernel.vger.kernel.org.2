Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D3B3269BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBZVzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBZVz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:55:29 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A2DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:54:49 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id u3so10357211ybk.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TFSTMI7ryRQxrtNhAxWEs+B7yYWo+lfhTGjsQMzxFP0=;
        b=B2/1Ao0Q94/ecvoT23XORi65LbOEqxem34O8qEn3v46TLm2Ufh9AdpQbNu+gShymBd
         DqIm9AAup8V+OjHchs3y6+rxGQSqBuABAUg4mG2ScHu3nET0vqJ8BMWVKW6uiXwEOteE
         Mmw42Oio2H0wehbJJW+QKGQvm/2ZYS7a5bHeZszvWKHaBmlSAF1auXBKvMVbJRJQl81t
         GgiVrduLaMAOr+1DiIRKorkLCL3+i103bj/T8MoeyOvjRgHaI/0k4q/1uzm1lRCcfBww
         2Rm9GI+ze0e013ITgqQCX4k1woIbe+MMWKzmEK1RrcibY18l48TKrnsbjW5Mqerj+x8A
         nwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFSTMI7ryRQxrtNhAxWEs+B7yYWo+lfhTGjsQMzxFP0=;
        b=BbGICyx2W/bkhb7FfAPPKgO+6mGblonsNq9GJJ1dZYRdYFrkEBZnYwamQuPoketukd
         8vxcmibKYtFth2RZje8gUJntIJCnXXZIUoqS06gFeE9W8bB5Gt6rIoOq2Y1qYZFP06tQ
         DyxCU/KcZHayDmc/WPUCicCOObpgS0UNY/LKEhaVL4TfAig7r/RNHRftfkB6cqrYI9YJ
         djddhIV3F7ptygASxT6/T7ASbIn0d+1AJERw2HqwLg2Sfh9BzYNJhx6Jo1q6onPWeYTC
         2ngBMPd4EWstHSGkQMQ/8JDJdNGgcJp2NAgr73lmMPES+bpBmsd332xwpsEnSLrFhKn5
         HfUQ==
X-Gm-Message-State: AOAM530bBcF0au3nnQ0M3lm7mZ8wEqmdFRPld3F+h6KIdy3EBRAJSmss
        HcpE5ZccK61wMvQl5CBkrzQYLtVA1yWApGqbqFrh0g==
X-Google-Smtp-Source: ABdhPJzP8p2qMENfeBoRsfOY6ITy1KLwEoJVReeXV6Va1b5sD8yhyRAUASCl1TzCHhUjBqv393Q5LYqaT9qZ7g+VsHw=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr7781569ybt.96.1614376488562;
 Fri, 26 Feb 2021 13:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20210226145246.1171-1-johan@kernel.org> <20210226145246.1171-2-johan@kernel.org>
In-Reply-To: <20210226145246.1171-2-johan@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 26 Feb 2021 13:54:12 -0800
Message-ID: <CAGETcx-4Q+SkdLO-rXE-zt2kdz=J1cnrPjv07mt0KRtCPa_OGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: fix NULL-deref-on-deregistration regression
To:     Johan Hovold <johan@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+d27b4c8adbbff70fbfde@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 6:55 AM Johan Hovold <johan@kernel.org> wrote:
>
> Fix a NULL-pointer deference when deregistering the gpio character
> device that was introduced by the recent stub-driver hack. When the new
> "driver" is unbound as part of deregistration, driver core clears the
> driver-data pointer which is used to retrieve the struct gpio_device in
> its release callback.
>
> Fix this by using container_of() in the release callback as should have
> been done all along.
>
> Fixes: 4731210c09f5 ("gpiolib: Bind gpio_device to a driver to enable fw_devlink=on by default")
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: syzbot+d27b4c8adbbff70fbfde@syzkaller.appspotmail.com
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index adf55db080d8..e1016bc8cf14 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -474,7 +474,7 @@ EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
>
>  static void gpiodevice_release(struct device *dev)
>  {
> -       struct gpio_device *gdev = dev_get_drvdata(dev);
> +       struct gpio_device *gdev = container_of(dev, struct gpio_device, dev);

Can you also delete the dev_set_drvdata() in
gpiochip_add_data_with_key() if the drvdata is not used
elsewhere anymore? I skimmed the code and it doesn't look like it, but
I could be wrong.

-Saravana
