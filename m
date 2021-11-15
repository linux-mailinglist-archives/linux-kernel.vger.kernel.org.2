Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D06F450486
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 13:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhKOMkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 07:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhKOMjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 07:39:44 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBFEC061570
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 04:36:48 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso15654023wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 04:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGeR1CYA0nOepzga/lW+MyC7CZoKv/5cIE4HKl14y2U=;
        b=LPnXRjL12JekM9l6cCqszCn8R5/uNcStXne5wq62VrzVi/Nz26smlZOqmpe3sc354K
         Umdj5dsLRbbvVIbdvIkrgL8XNJPnmgmKHloUDom4REePV2GVgyyhc2m9VMpF1Wv1UfrR
         20DYDo8cxWmBMJr4u99Hd6BUCEmXniPgfR2OZsDheKgoW6G0xn3Wx7kYS9sFQFTbQUoR
         sTJGjuPUs7T47Frbnbfo6EIaUrejJbeKDGIah3pjkbVOwaHDqQ9BCfVjHHdf61UD7sIr
         ay97C8JJEDimM/EUyfxmGk+QuUP63qkwHz+WX+ams3b7hnSFpaKPISI1SAWeJvTSdFXB
         K8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGeR1CYA0nOepzga/lW+MyC7CZoKv/5cIE4HKl14y2U=;
        b=g9a4bXNSf7nbqMhrSYDVAAztz84FZMOUxrtYOzOiTfk9qveXRt7voEHQRcvZ1Izd7u
         ok2uPSazhgBfA69ug3GbzbY8W+7V9H1WbMptY/ejXMJVT9y7t/4zPF4xTjzz9VxGJ/2L
         xnh77Bq/fDqaUtSjQttCo+MXq/5FyLEEWmI3xrPAORmp1wUXNYqe9m/AzuRy8NGVkxf0
         we4h2x7ieex8Lkx+wAgPqSHnZm0RqI/5Vs00zjG892GU35FzQz7ax+ustVq1IIQRaPRH
         CFH0jXTRxtxgKeKs6uaZXFqPsnUCyCGjVWu4RzLb7IfG+fYm9IkNZuGiKEg4AxfIbxzR
         cEoA==
X-Gm-Message-State: AOAM532RM21+TeErxmVdelkjV2apbNSk95Z1I9Py0pqO0Xtxa3i6rSv0
        fy+adYTas8MbhvJRQHK/bkQSaX8Bcq0Yscftig66gA==
X-Google-Smtp-Source: ABdhPJwhVtDACuhL73HuoWAGG/z/OvgZRvkBItjXbskaLVI7I4PuWaKfS7bdkNtPK0ol+B/5umtnZQ62wSr55zFxvrU=
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr42353617wmf.177.1636979807273;
 Mon, 15 Nov 2021 04:36:47 -0800 (PST)
MIME-Version: 1.0
References: <20211104113047.28585-1-lv.ruyi@zte.com.cn> <CAFA6WYPOz1g+-6=Roo88qwcSv9W5vsbVHFWTzv_ALXxyMsLJ8w@mail.gmail.com>
In-Reply-To: <CAFA6WYPOz1g+-6=Roo88qwcSv9W5vsbVHFWTzv_ALXxyMsLJ8w@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 15 Nov 2021 13:36:36 +0100
Message-ID: <CAHUa44FvNiyZ_S=G49UbbjdBScKXvtgtsMVYjfG_RE7--N7azw@mail.gmail.com>
Subject: Re: [PATCH] optee: fix kfree NULL pointer
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     cgel.zte@gmail.com, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 6:34 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 4 Nov 2021 at 17:00, <cgel.zte@gmail.com> wrote:
> >
> > From: Lv Ruyi <lv.ruyi@zte.com.cn>
> >
> > This patch fixes the following Coccinelle error:
> > drivers/tee/optee/ffa_abi.c: 877: ERROR  optee is NULL but dereferenced.
> >
> > If memory allocation fails, optee is null pointer. the code will goto err
> >  and release optee.
> >
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> > ---
> >  drivers/tee/optee/ffa_abi.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index 6defd1ec982a..8d9d189557f9 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -811,8 +811,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> >
> >         optee = kzalloc(sizeof(*optee), GFP_KERNEL);
> >         if (!optee) {
> > -               rc = -ENOMEM;
> > -               goto err;
> > +               return -ENOMEM;
> >         }
>
> So the braces are redundant after this change, hence can be dropped.
>
> With that addressed:
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'll fix up the commit and pick it up now.

Thanks,
Jens
