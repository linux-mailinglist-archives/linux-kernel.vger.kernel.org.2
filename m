Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6915B3E4C1A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhHIS2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhHIS2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:28:13 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60521C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 11:27:52 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u10so24884372oiw.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4mNkfoQ58OXkFxY5lXT0JLBnZKMBlmPjenNWxHTzG5U=;
        b=HDi1+VGiQq4I0uS40zFvgbSs8RSxYe0sbWq3bJu/Bh/F5NZONXb8z9Wo2hupnakHQv
         A4Tct8GU+hqFrZD3cR9w+n/3P8+nk9a9imS4Uq4XlePYvIckSXTs9eZ2+zHtMcqy3sQA
         cpIGgkvpw8Y5C6el2nlFYfCHpg/v4OE97spIvpsgKawGEp49hGU3fzApUTbdUHCkP5Qw
         5DKUf47+LEbRqLCFcF5Gwi6KJvdDXCPrVTreYbedsJ1xmDgFidKujl/SoLGp08gDYpql
         sWaH+3gWW1XVj6QJloLbVWkKS91lpuaZk0OLQ98yNCTp+B3EFEdU/iFQ8sWjdkLbC+4U
         zgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4mNkfoQ58OXkFxY5lXT0JLBnZKMBlmPjenNWxHTzG5U=;
        b=gKhjJGsFhfhLZC/OF5+h4ntMhaMaxsGPnYV7vsEuSEzmnOy2pnngzb2365f96hYWHG
         xqCPVR/XZbhXgUkGvodEWJvhAqelzT7CfVmP7msqR9gizs6+9qytAHC7Qq7YQxNPqOyw
         zP5MWy2MhVM9ilox2x5DRVWsBn+l/3FRnA8GlJNUjn6IGhAkz0LHDwIipumoOuKU5C63
         RxFCmzMSB2WUS80qykzoEjtbK+lYGJEYkhpbe7vrD70ZS9psSulnvCPY2brW1XbNJMpG
         +Zc6YLfzlzpOV7/tix/Hc9k7dk1jSW+QMe4xZMVZtSQsJQ8/+aykO3A7p6aL8iN2ZLeU
         mn8w==
X-Gm-Message-State: AOAM533FAKj+T18/bv7fELKukQw0x+8COfudOC8aMMFTB0/wRx7/mvRO
        E69ht0/NpNd5xabYoROnVKywlnfTTKvIoDK+2vQ=
X-Google-Smtp-Source: ABdhPJw73VZa3ndUg9SSCAZTIxbMDiQHT+SywD30VuGs1/DnYxFu+7itTeGa/riMDHRl1ljZqNkD9Oo3pA/WtNcYnDo=
X-Received: by 2002:a05:6808:1390:: with SMTP id c16mr16992375oiw.123.1628533671832;
 Mon, 09 Aug 2021 11:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210809025208.10182-1-rdunlap@infradead.org>
In-Reply-To: <20210809025208.10182-1-rdunlap@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 9 Aug 2021 14:27:40 -0400
Message-ID: <CADnq5_OrWJSLNMJwZ8jY-RPTZRLHhxhOcoaxE5HFdu3qKfyqBw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: use do-while-0 for DC_TRACE_LEVEL_MESSAGE()
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wyatt Wood <wyatt.wood@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 8, 2021 at 10:52 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Building with W=3D1 complains about an empty 'else' statement, so use the
> usual do-nothing-while-0 loop to quieten this warning.
>
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:113:53: warnin=
g: suggest braces around empty body in an 'else' statement [-Wempty-body]
>   113 |                                 *state, retry_count);
>
> Fixes: b30eda8d416c ("drm/amd/display: Add ETW log to dmub_psr_get_state"=
)
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Wyatt Wood <wyatt.wood@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20210806.orig/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.=
c
> +++ linux-next-20210806/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> @@ -29,7 +29,7 @@
>  #include "dmub/dmub_srv.h"
>  #include "core_types.h"
>
> -#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
> +#define DC_TRACE_LEVEL_MESSAGE(...)    do {} while (0) /* do nothing */
>
>  #define MAX_PIPES 6
>
