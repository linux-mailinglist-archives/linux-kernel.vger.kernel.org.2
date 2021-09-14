Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093BE40A70C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbhINHGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:06:23 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:46869 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbhINHGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:06:21 -0400
Received: by mail-vs1-f43.google.com with SMTP id s15so10889205vst.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67bgZ/GAYXsLEm/hKOx5h/d/xvZ+H8UShpYIZIA8Aew=;
        b=utaph083GNaMSufDwk79WkBI0Harzv13kvOCvg1iCaGAlkUUQaj+Fg2/vNvxFtOESR
         m1bX5sRSopryuETXgyWhAIR4uBZZSOhyueJz3cYRC7+pL71cGZnlj/l87eAFUOIJtGPH
         s0tuuKFiE8a+EU8Z13f35hVw5c3tdZ2+XSkMVGcGg8xX7CdHK3mpuKL4DwshQX5UyjHf
         kn1jNcg7rHgK8yyKrRZib1bPimDL/Jzh/0HEa6GMPbX+v/zmOUXRYFbMvwpWtPLDZC4O
         7XDFPyf3SVMprL3YtIgT+YDYvQWP0dNce61A6ienzk36qCMNUMFT1Z0tcv27CmCpV5mA
         HHkw==
X-Gm-Message-State: AOAM5319g4SeBIR/HDJQPbFXRuYc8anYZPp+X0MS1TdTNrjYC44WmL5B
        z73OS28qS6bVmgnJnz+fErtiPe7dUWsp2tgr+qh0AwV/
X-Google-Smtp-Source: ABdhPJwbUoN+nbRmqwygPfTE+BwIdA/JzAcfkRBTNVN73CE8CUPvqnXx6FsVNFs2KdYfXNH89yoXKb1RtHH3RTYuph8=
X-Received: by 2002:a67:cc1c:: with SMTP id q28mr448339vsl.37.1631603104427;
 Tue, 14 Sep 2021 00:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com> <20210914043928.4066136-4-saravanak@google.com>
In-Reply-To: <20210914043928.4066136-4-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Sep 2021 09:04:53 +0200
Message-ID: <CAMuHMdViFMA4_k2Da=G2h3BWBdmwDJdh5pgRfbpUaoC_DHcmJA@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] driver core: Create __fwnode_link_del() helper function
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Tue, Sep 14, 2021 at 6:39 AM Saravana Kannan <saravanak@google.com> wrote:
> The same code is repeated in multiple locations. Create a helper
> function for it.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Thanks for your patch!

> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -101,6 +101,19 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
>         return ret;
>  }
>
> +/**
> + * __fwnode_link_del - Delete a link between two fwnode_handles.
> + * @link: the fwnode_link to be deleted
> + *
> + * The fwnode_link_lock needs to be held when this function is called.
> + */
> +static void __fwnode_link_del(struct fwnode_link *link)

Why the double underscore?

> +{
> +       list_del(&link->s_hook);
> +       list_del(&link->c_hook);
> +       kfree(link);
> +}

Apart from that:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
