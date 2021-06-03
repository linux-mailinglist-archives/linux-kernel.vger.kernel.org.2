Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41A439AE02
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 00:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhFCWbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 18:31:11 -0400
Received: from mail-yb1-f176.google.com ([209.85.219.176]:35776 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCWbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 18:31:10 -0400
Received: by mail-yb1-f176.google.com with SMTP id i4so11021796ybe.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 15:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wMJVJeaokta2g6i5H2O3v8TDV7BZxRAM2P3Xsz6MtKA=;
        b=QvgMRSKFY447+AbwNLKbs5lBrX0Zxp9F40t/16dBGj3dcbCPdooBl0UKEyi1zJOeKE
         f4sOkj7SD/Eu9kNQTGc5CXFuXtBHXRuNcPThlQ+ZIKFjayg+gy4jasmXttrW1imMeegs
         Jgnmw/31vHSlhxO5Q//5+9PNTskXsTRyZ0eOrOLSBbuo4SAee7Wl1JQvL3gvxtUH01Rz
         ZRBjoH2Iotw4tK/q9oHSWe1U9L/FHoIqbzi7tBtHDcvF7D9LXyS6xN6R0Aody5nZNJBo
         kx6E1Zi3WAVrc8lUWUGp3PbAuQmQ0BHRWqdH/f4dSuOTVg0TrVS+H4XZINYVFwFYgvlL
         69pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMJVJeaokta2g6i5H2O3v8TDV7BZxRAM2P3Xsz6MtKA=;
        b=NTzBNsdKWtVu4oTqK/IjZZbbxNniDQ556LkABvjA1SWoWvu2unn2Ypgc+tBe8XdOyD
         3MLb9WD9gFidM+ejEAgfGNX/2XRB/y1aiWUTSr2Og527clGwXZV+d0hcrlO27D9leu4U
         Iepm6kRs2ldCC18iIipUEy4B9vzUYBgSowO+NeUPYYTRRxXkRKdultWpkHSFGEVbrqNZ
         TPmkfQNqKj3NRIM2nmKNFFnFi3cwerpeL7aXzKa2UZrpte+0/JtUAwEdO5L+iI4ujngr
         VGM38ZjSsjOCLFGi1nnqHNF2ooE5gYKf0oH9wb/faPdB+a53xxo1c56Es9NuN1aPYFMP
         MhOw==
X-Gm-Message-State: AOAM5328au1DxQ6vvI36D39KE/euFVKQkR89Pcys71DiwmCShas6L3pJ
        Vt+bF95lrBE+wJAcL/DuhtkBYiCh8N+TTGXwacC5cTSWn1c=
X-Google-Smtp-Source: ABdhPJxqqdNa+4k6LHwTnjgndHVEsh17CUcijA9p6q1lBmvzT0C0S1jBbtXArAuOlqR6cuo2jG9JKXwOdpB0K2rn298=
X-Received: by 2002:a25:cbc9:: with SMTP id b192mr1100458ybg.96.1622759293161;
 Thu, 03 Jun 2021 15:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210603202116.1841261-1-swboyd@chromium.org>
In-Reply-To: <20210603202116.1841261-1-swboyd@chromium.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 3 Jun 2021 15:27:37 -0700
Message-ID: <CAGETcx_G9iXgvRupZdeteHSwhAFZNYNn1ti4bGL8F0dQeDWhEg@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Make cycle dev_info() message dev_dbg()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 1:21 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This seems to mostly print debug information about device link stuff at
> boot. It doesn't seem very useful outside of debugging so move it to
> dev_dbg().

As before, Nak at least for now.

This code path really shouldn't be exercised on most systems. I might
be open to this once fw_delink bug reports stop coming in for at least
1 full kernel minor version.

-Saravana


>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1 (https://lore.kernel.org/r/20210603064849.1376107-1-swboyd@chromium.org)
>  * Dropped second hunk and rebased to -rc4
>
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 54ba506e5a89..378bb894869a 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1736,7 +1736,7 @@ static int fw_devlink_create_devlink(struct device *con,
>                  */
>                 if (!device_link_add(con, sup_dev, flags) &&
>                     !(flags & DL_FLAG_SYNC_STATE_ONLY)) {
> -                       dev_info(con, "Fixing up cyclic dependency with %s\n",
> +                       dev_dbg(con, "Fixing up cyclic dependency with %s\n",
>                                  dev_name(sup_dev));
>                         device_links_write_lock();
>                         fw_devlink_relax_cycle(con, sup_dev);
>
> base-commit: 8124c8a6b35386f73523d27eacb71b5364a68c4c
> --
> https://chromeos.dev
>
