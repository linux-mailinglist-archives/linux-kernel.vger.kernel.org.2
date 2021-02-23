Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7EF323411
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 00:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhBWXA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhBWWrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:47:06 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4066CC06178B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:46:26 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id q23so106992lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w1loR0i9/IQnXQEFVUinQYQPT/pSvPKt4JZ95zXT3ww=;
        b=CoZ6zpVIQgeA5xgTs9DBjAfLnLxDYBcaUA5qu+4wMpweFUkZtrZDFvPY1bOdP8KCat
         Yw7SgjVJ0OIpTtJJGFpgBNLpBQjHp9hEuC4i0E6PrW6dnUMnQ7GTljuVzf2G1kZ/QGlw
         w+i5woCmmlqfEj4+T5/xQE5lpowxUC1v87bPOWGLmks/0LZS2hNYkBwwlC9AD25R2gQh
         OPtRwg5hYO7lCXcp93rlZmUTkex7vplr3TGgcQy9No/vEuOjLoF7U+KO7a59pZ6v2jTl
         wye7s5Ql15cO21DouXl7VLwy94XW1tBqcC+tHAlVxNIitn/CYM5ktP+Vz+j32MGMUwy4
         7P9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1loR0i9/IQnXQEFVUinQYQPT/pSvPKt4JZ95zXT3ww=;
        b=Qq+zNVf6vxUWk9p1uYzFJ58KRKVZ28fQ7i7rwvTJPtwOqBW/jo2Q9DbdgCF7Fv95r9
         OGFQhqYojHiPWQ7d/aZrIx5M2HFq5IzrR0Li9DE8yokMKWegmOfUoOqZj4qBT6F3zP7X
         5GJaDXVxzPmW4rePw0JLnmDMIuHezJF1QdePpFkgyHikCCnzsSK0h/9H7VoAhpAIzDJt
         qJg9FRddNcwV0vhCgXho+k0tGldrTvvFNGlaBKV0uuRwWD1xISZ/8qkfufnfGqN5N2LI
         4VWMbGYLeABgxc0bWyF7W1R58KZ3Qdc1++SPTUe2ZkkjN7VMVXa8sIKW67ubPBADQSWL
         ok0g==
X-Gm-Message-State: AOAM533HEA6PuJ8JMq8yb3cr5Pvn6eildp0ESOp9k5QPZYuWq43OgQ2f
        mqCLPH9s1FgI2yQc4oeg/eXEyj1JSJDGraTwMKeYyQ==
X-Google-Smtp-Source: ABdhPJxC9X92LlE0XE2ScJexcBEWrv3BiYeM/XqD2xAowgGVZYe5Lf/97bsSvv+mXzoDhIfbxn2RTRtVPemOMWSlxFg=
X-Received: by 2002:a2e:b0f9:: with SMTP id h25mr2979634ljl.232.1614120384650;
 Tue, 23 Feb 2021 14:46:24 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com>
 <20210223070408.GA16980@lst.de> <20210223072252.GA18035@lst.de>
In-Reply-To: <20210223072252.GA18035@lst.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 23 Feb 2021 14:46:13 -0800
Message-ID: <CALAqxLU5AU2jhEe=pa0=ye=8uYQeAw-4T86c36qCTipe9JE3OA@mail.gmail.com>
Subject: Re: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
To:     Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Anderson <dvander@google.com>,
        Alistair Delva <adelva@google.com>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 11:22 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Feb 23, 2021 at 08:04:08AM +0100, Christoph Hellwig wrote:
> > The problem is that the blk-crypto fallback code calls bio_split
> > with a NULL bioset.  That was aready broken before, as the mempool
> > needed to guarantee forward progress was missing, but is not fatal.
> >
> > Satya, can you look into adding a mempool that can guarantees forward
> > progress here?
>
> Something like this would be the minimum viable fix:

This seems to work for me!

Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
