Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279D63E2841
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244992AbhHFKKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244971AbhHFKK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:10:26 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928F2C06179B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:10:10 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id o10so11235107ljp.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 03:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYXVX/5RNLYmRt08PxMo/iqbC3LoTyV7kw364QsJWm8=;
        b=dt7l6IRvlF+TC4ZV/TMqDZBYDH8mq8sb9dogWJ2BVV3C3q+td6iGGV0W67Dal7WpaD
         r9WAdvf/VuvR50Ku1DwqTrUa1hl+vn9mn3oAAZRlt4xzCDUOmBwSQDVgdvFNSGw5mFJc
         sfiAPK4NOxjBo9v5NSApncO00h1qtn2dIp47y+l6IHnh6RmA9vSDNQJqxTqlBYcZ4/Ce
         fOjU3c0yNEOPCl/xesgddge+ssersVyGq4IwhS1SIPAaJHP0LYD3Q5vrFy5ZNCVeeW+t
         n4zSBuWvaNqW/XgZNXzzSR8QoInZDAmzIKLmrVR+ZuR1SOEu2OyRDROd6TjopsA5U0ks
         4tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYXVX/5RNLYmRt08PxMo/iqbC3LoTyV7kw364QsJWm8=;
        b=Lae98eOYwTnXzG3Ur1/nqT33PVE/kl7Nd/hEysrez+JVaerAjdWW+MaIC8gHHgeqwf
         anNt0Pj5FO+nS8a8Gcl5Hgn8VHCrRWb7SEUvAV9G71KshtubOkDbGhLgecPuzL4wGwz1
         QYwZKr6RWLlNYk57ELvlhrgvvzAlOUAfYmiCAdpBkyYZV7VfYjzaTh0OLgtV49IeiNl0
         3mQVB7LzRUDa7TKnHCl7/+dX/32MT9BqLwT0vudi+Vmo6TdCsnhcOsIHxBppXFrw05g/
         oY5WtkRPUv5+XV0bB07BAJOcY1fS7q4cGdd4iDFkS7xk3+Ku/WmKFnvCkczjiU/Vq4f8
         wMKQ==
X-Gm-Message-State: AOAM533PiaoNE4WeKdCGwk5AqQtFcmIT5chCFCOrbjNubbODDaeuqjd4
        +183gqIN5e6/7dPhibQ87sH/7QHz5G1W4Cu2WzbL6Q==
X-Google-Smtp-Source: ABdhPJxZly12gB+BCFacTNDn4MWwdJoWcTKyZ2XUyIcEEn10XmyeFaAwh8Hb5uo7yR+p9lSOen0WLrtK2q5IcPs+0B0=
X-Received: by 2002:a05:651c:93:: with SMTP id 19mr6019407ljq.421.1628244608814;
 Fri, 06 Aug 2021 03:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <9a57c9f837fa2c6f0070578a1bc4840688f62962.1628185335.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <9a57c9f837fa2c6f0070578a1bc4840688f62962.1628185335.git.christophe.jaillet@wanadoo.fr>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Fri, 6 Aug 2021 12:09:57 +0200
Message-ID: <CAJpMwyhd_=4vwKT6TXnyQ6sHyXSHUm44Z=OWK36smonZC=ucGg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: Remove a useless kfree
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jinpu Wang <jinpu.wang@ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 7:43 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'sess->rbufs' is known to be NULL here, so there is no point in kfree'ing
> it. It is just a no-op.
>
> Remove the useless kfree.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks
Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>

> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index ece3205531b8..fc440a08e112 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1844,7 +1844,6 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
>                 }
>
>                 if (!sess->rbufs) {
> -                       kfree(sess->rbufs);
>                         sess->rbufs = kcalloc(queue_depth, sizeof(*sess->rbufs),
>                                               GFP_KERNEL);
>                         if (!sess->rbufs)
> --
> 2.30.2
>
