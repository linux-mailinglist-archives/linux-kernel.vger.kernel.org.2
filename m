Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38E137919B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241977AbhEJO4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:56:15 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:35717 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241167AbhEJOyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:54:31 -0400
Received: by mail-ot1-f42.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so4474026otg.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENYFwy46bSDUBbys+yDjZtTjwjQzPJjEEd4HFb88HL0=;
        b=QiekncazwIbfO54Xo4yJ24pbNMD2B4G3t2Tkt6BVR5DPNdVU+jf0f/pRGBFaguKfyT
         P03yyibIPsMnq9M64AlMdDj5UslVCXGdDh0iGdIw2qHC8Q+xcGLoRYVReH3IVyyJU9FU
         vF/plHsca+7qtsLFdNUTOUaV5ZZYB5rYPNjBvFtD7NN41zBkEsb0Yk/R+XBjyq+o9QNQ
         aW1oA/TEbwaCaasd4jYWhgozZy4k8al0JBnAZ/4fGHU0qHtL6ppsS0GAfl24r0IIayGj
         tEErTDItvnLirnNEzhk6AiX9Lu1PtEjz306SzuaiDgVpNCA7fnloHXiYHBri4Dsy+V0o
         HiVg==
X-Gm-Message-State: AOAM5330sTpjIOY024emHqENA3d7ymGTcvbCynS+xqIiTgyEZ1eDwI9v
        OTP2hgNJD1KZQHuUJJ+hYL6a1uQ1K+6jocWz4dzHTAIl
X-Google-Smtp-Source: ABdhPJyzv3Qj04q1UZg4K8i/2nY8xOjz8Wz+sAYkTCuFQdWkkWfw4E3Fs8ewE9DJ1Kw72BENfk1zPZEOVcpEnkPIiaA=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr21407263otb.260.1620658406610;
 Mon, 10 May 2021 07:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210510095613.3302755-1-andy.shevchenko@gmail.com> <20210510095613.3302755-2-andy.shevchenko@gmail.com>
In-Reply-To: <20210510095613.3302755-2-andy.shevchenko@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 May 2021 16:53:15 +0200
Message-ID: <CAJZ5v0iLp7R6NC6CkV1hoDADGk9kETb3bO=8vbQCc=J2tDuoeA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] device property: Don't check for NULL twice in the loops
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 11:57 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> In fwnode_get_next_available_child_node() we check next_child for NULL
> twice. All the same in fwnode_get_next_parent_dev() we may avoid checking
> fwnode for NULL twice.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/base/property.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index dd98759d688b..62285f1b79e3 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -632,9 +632,10 @@ struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
>         fwnode_handle_get(fwnode);
>         do {
>                 fwnode = fwnode_get_next_parent(fwnode);
> -               if (fwnode)
> -                       dev = get_dev_from_fwnode(fwnode);
> -       } while (fwnode && !dev);
> +               if (!fwnode)
> +                       break;

I would return NULL from here right away.

> +               dev = get_dev_from_fwnode(fwnode);
> +       } while (!dev);
>         fwnode_handle_put(fwnode);
>         return dev;
>  }
> @@ -742,10 +743,9 @@ fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
>
>         do {
>                 next_child = fwnode_get_next_child_node(fwnode, next_child);
> -
> -               if (!next_child || fwnode_device_is_available(next_child))
> +               if (!next_child)
>                         break;

And from here too.

> -       } while (next_child);
> +       } while (!fwnode_device_is_available(next_child));
>
>         return next_child;
>  }
> --
> 2.31.1
>
