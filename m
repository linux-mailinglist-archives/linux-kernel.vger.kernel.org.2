Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099303B9C06
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 07:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhGBFbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 01:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhGBFbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 01:31:12 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85EEC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 22:28:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hc16so14222894ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 22:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OfQHxzo83zLbcvyp3l11o4o45GcwyCdrdu5e4fL5CV8=;
        b=K87Fquje6odx6fh0t3Z3kpYJhDV8J5NCT85XefSxglrv0QoqZRDZccoQ85zy0pzZNV
         B/wZbrJxXr5FYzU0dFXIs0JgAj0xZiaOt25NyemcKRzCsFOnQShj9vL/OlwbZ/dt+w9N
         jVlqV5ShfYZPYWz9A7/M10w2QVXQAPPXgPQoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfQHxzo83zLbcvyp3l11o4o45GcwyCdrdu5e4fL5CV8=;
        b=hjbQmiQhAk3Y+kJR0rLOiZfgbiDHDtKmk0TRk8m9ePs0mxhStPnIXsLgX0r4Zaukyd
         B4dg9aNf8NeH3uR0O8nSNsn6+v04NZ0iG41IGSLRw3CXhPimzfWAfU2zgDxGnFj2nK4s
         aVYIB4Uo97X2jmvliAP22hetXCGL2VHzuf6gKNUSL3VWNfd819WlUZdRLIZcxGXSZakq
         Vbwxg8IZLJC4oF4ST85H/kpLERtGubl4Ow0eaTFsyn3eiQidmJvq2EC1T1TZjJGKUrjq
         R9P3CEvkZQ9tcUY5u2gCHQo31L87AR4bmGVeln5CqQDoOJo9Q9ZIx2hl5P1j7wbbK2wR
         qmhQ==
X-Gm-Message-State: AOAM533AfTIrdyvoGvgy0h4F6AiRqoc5TnexxkTltzr44sW7yq23JfyF
        99/G+tWlEyzllwbHM1DZN/xicVrRg+KiSoh5p2BRtL2Gxy0=
X-Google-Smtp-Source: ABdhPJxrQSQn3GKuokaclwYT7Jrsb5n9LGKVoAahBuBiqBm0o3+Ylpe4HxYzRq8EE3svqcIp7ocrjD9DUtCGbJpzYvw=
X-Received: by 2002:a17:907:1c9b:: with SMTP id nb27mr3596069ejc.336.1625203718480;
 Thu, 01 Jul 2021 22:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210524184226.3064621-1-jagan@amarulasolutions.com>
In-Reply-To: <20210524184226.3064621-1-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 2 Jul 2021 10:58:27 +0530
Message-ID: <CAMty3ZDt8L70xHH5pMy0M-3ATt9jAXAy3VVeRV_iMkcoebn99w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: panel-simple: Fix proper bpc for ytc700tlag_05_201c
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam and Thierry,

On Tue, May 25, 2021 at 12:12 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> ytc700tlag_05_201c panel support 8 bpc not 6 bpc as per
> recent testing in i.MX8MM platform.
>
> Fix it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 9be050ab372f..6f4151729fb7 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -4164,7 +4164,7 @@ static const struct drm_display_mode yes_optoelectronics_ytc700tlag_05_201c_mode
>  static const struct panel_desc yes_optoelectronics_ytc700tlag_05_201c = {
>         .modes = &yes_optoelectronics_ytc700tlag_05_201c_mode,
>         .num_modes = 1,
> -       .bpc = 6,
> +       .bpc = 8,

Can you pick this, if all okay.

Jagan.
