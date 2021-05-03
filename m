Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E3D3712F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 11:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhECJZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 05:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhECJZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 05:25:21 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E069FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 02:24:27 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso4475626otb.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 02:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+VJfKXp1p14Sm+gs5vQpJcBKQ4WQjXJ9DGqpFSWyuG0=;
        b=e56sClF+y8SAgaeuU0FLQNRkS7BEazbXNVFGQ4/xSlpwa689710GjcZwOQyeUPuxBi
         a+9uOTT9opTBsS+fmzTp0H3GTCEKwIjsBv1QCb/NQhBSDNO5WVTuaLwUaDkevmKQ3CmN
         26V2RlqlPy7TuJZhH6wdhpsLEvDj1E/QyHtR+JQgnHIPwJ6bC7mavVEe6HzbAvtnD7mC
         73PThoJm7XU7ylJXpcqZTVyhiMkZCpEzfMcmCuNuzpj+1fjGpqYR48soMadi9JyEFHIw
         hQuush82VlnWKAS6Ypt7bicm8BtwyNfArp0Xdo/R89rockOK1SqcKdkYVUD9CenFcaK5
         M2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+VJfKXp1p14Sm+gs5vQpJcBKQ4WQjXJ9DGqpFSWyuG0=;
        b=egzG2Osv0S8V2iSx1KZ+wYHZ1N7Dm/Pe9fJQF5GOXSue0NeE9oIz42NaZMTCQz7ccc
         9WBZAAwTZ2Qcb7Hj22eDLsXzYJYIT7+Uzcg+Zq761+eNz7sntNOn+vQ7nzoLN4ARPJrM
         bOGXYeuTyqLN9tS9DxBem9RpXsdDHezwYQaJba3QnOB0CRPhDoKubKTfyIiLJsvJvALM
         8uTIG4WNNFgSviwLzgWSBhi4cSwZhqmFLRT11+T48MkXpYC//beEUL9H6QCVBlZTPotK
         9cfFXudzUtFADfB8uGKsBSG9F/YVVsEG0UW9CXqBdIbzM4HlLp1pUfAi2RPgFkEpm/QI
         3LYQ==
X-Gm-Message-State: AOAM532TOBb/aeZjaupH1FamIibe/fV1ceLupaJl1E6EWX9KDWgolGIJ
        lfV+1dokpuRm6sfiJqEsVI3XLUkmrybHkGWYDFaJjOKkWwzAPw==
X-Google-Smtp-Source: ABdhPJwLE3DnCKCS1byVx211ccfNqe7C4yZwYzqYsFfx0gAP/nqhYeXllz6Im0QtUHriG2U8rf/IP0AZcZCQcwi6q7o=
X-Received: by 2002:a9d:4e9a:: with SMTP id v26mr13892957otk.74.1620033867265;
 Mon, 03 May 2021 02:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619794331.git.fabioaiuto83@gmail.com> <20210503075201.GN1981@kadam>
 <20210503081717.GA8953@agape.jhs>
In-Reply-To: <20210503081717.GA8953@agape.jhs>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 3 May 2021 11:24:16 +0200
Message-ID: <CAMhs-H9zgiP+u0jg8M4uJ6QPCs-BZ0SKaGzp85DoqnS_KkcFuQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/43] staging: rtl8723bs: clean up driver from private
 debug facilities
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Mon, May 3, 2021 at 10:17 AM Fabio Aiuto <fabioaiuto83@gmail.com> wrote:
>
> On Mon, May 03, 2021 at 10:52:01AM +0300, Dan Carpenter wrote:
> > Looks good.
> >
> > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > regards,
> > dan carpenter
> >
>
> thanks Dan,
>
> when a tag is offered this way, am I supposed to resend the patchset with
> the offered tag added on or it's just a tag which Greg is going to add when
> accept all in his tree?

Greg will take care of adding this tag when he adds all of these
patches to his tree.

>
> thank you in advance,
>
> fabio
>

Best regards,
    Sergio Paracuellos
