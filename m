Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1155A35304D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbhDBUai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhDBUah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:30:37 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C810C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 13:30:34 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id r189so1329534vkb.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 13:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpiYiPYqqN7tR3WWs4vXdHV3OFTJ2WT8sXLzAJnABRc=;
        b=haCN18pcrEsv3UXlaoRpsd6piLapDWVWpYOTLeB5TqquoDoE3qDGjSA9u6iGuM34H1
         I+sgmUsI2rkXTrjjcmnJqBi1u2D/Z3xjLf6/fvTbLngj9N3oJKJSNrpegrGntzQfPiso
         i7XviCv8nE3Q1hZFjkx7fygPKSkcHnhlPqqUEhoz3rT8L1D2AtKf5pNAWp+X42iHLdup
         mK3xr6bxD8Ly3/xml8+FV8Q8Ul0keB6/eCtdFu8d+3QWT8TGdEnL1MDFAfL0+zcdj6VM
         C7OkcldcaZOnwBI+p2CCyk8h+oIptLsRFCSybT92GQSoWH865XpGtFf+MoQvAxgVITIH
         J9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpiYiPYqqN7tR3WWs4vXdHV3OFTJ2WT8sXLzAJnABRc=;
        b=Y8aIFGTbzNDDuWsxsswOJQFPtyAgAxwmY9AAHt/+CpG4QuL/CP3sRZAofbF1HpJdxP
         BCxKF7ajKAQ26K1e+BqAI/V4g5GxXv3P12GNMMnDrmayNmMkb/YdKR7qQHFxhVqxxB83
         Rx0c+lLJhT0SBE4Z/Wj6bu/OP2vNq+erRoEoZDrBcz2nV3vF9WAw6Lnmh4ZD44kiszvq
         i/MilW+6YUY1I/fm+9FXEOlHCv32g7QO1jforIEaWr6ZmT5PCqYHwhnk60Kjn5TOb2xu
         kF+UPzkKekXH0TWhiNrjABJkgNXZ6bcEp3SIIRkM8xH6sq6BSDUVwQFjOFPC2flpKhXl
         GKKQ==
X-Gm-Message-State: AOAM533AIsHS16MP2kFDZbpUTWq+IHKdogBCHi+IkGWZqRR3jFRxCAlE
        TGVfATQOhIlAxGdX4JkcqpB6XGABoKa7+iIgSnw=
X-Google-Smtp-Source: ABdhPJwvWeIbKrs/SzZtBEn1ny8YJn5TP3TDcgpCXaIFdtCva7kvl00ZsoPfrswoZEOzSAUmdvt3bkKHDGTGU8SeOMs=
X-Received: by 2002:ac5:c84f:: with SMTP id g15mr10218660vkm.15.1617395432391;
 Fri, 02 Apr 2021 13:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210402202237.20334-1-urezki@gmail.com> <20210402202237.20334-5-urezki@gmail.com>
In-Reply-To: <20210402202237.20334-5-urezki@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 3 Apr 2021 02:00:20 +0530
Message-ID: <CAFqt6zbszFZKpbOg7A5L_keqUwsXMNCxa91+S7sCUij70u8pDw@mail.gmail.com>
Subject: Re: [PATCH-next 5/5] mm/vmalloc: remove an empty line
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 3, 2021 at 1:53 AM Uladzislau Rezki (Sony) <urezki@gmail.com> wrote:
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

How about merging it with patch [4/5] ?

> ---
>  mm/vmalloc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 093c7e034ca2..1e643280cbcf 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1503,7 +1503,6 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>         va->va_end = addr + size;
>         va->vm = NULL;
>
> -
>         spin_lock(&vmap_area_lock);
>         insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
>         spin_unlock(&vmap_area_lock);
> --
> 2.20.1
>
>
