Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123233D0FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbhGUNAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbhGUM7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:59:05 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02187C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:39:34 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id r18so1439195vsa.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQWrEGJNf7d0De/tJqK3kQBt/v9xkOGr4BS+4HVg0EM=;
        b=EMMSRpjLlR8z+9dKBS1LOAQ5xvjsVXm5iI/uKPDfiPQplFAdN6hsuW8fNAN9mTsWFh
         EWKrfhq3e2QQZrG8+RaOxX5bhWvGSLvnxsyu6yJvQILSiYCBcz/AcLFuU9d/fsDOtb4Q
         zmddOdVeEak6hqr1ebmjixvSoYW8XJFz84Als=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQWrEGJNf7d0De/tJqK3kQBt/v9xkOGr4BS+4HVg0EM=;
        b=pvT8d/eC5UneCqG4ZvHu9S90ehuTVf0McO0ph+am9CyBDKoIRk5VKeqU8xqNLu536B
         nDEcX2bZ9+mVnsRYldZaLHnY54h2Oev+4gdFcV4xk1AW1P+Pd01phc/Ndj6R43D0TZgq
         BUBViPum11l7x7Vk/vY8phBPzBRo91AIQ5Mg8zxnEcjB7aZJGe/00AlB3VJ4BlgUYp3o
         uUPsv9SS5OkrEJx7QSqyBBHhUnYzSD7GeoW5cZAh5LaK2n4XOm48Nv/dr03Py+B4/grw
         BiS3z/l7pWTW9q68nXVcMqs4gmx0ftXKTSFfi/YnmdFyBgLFos0pyfOVX0+oU1Jc5FQn
         Bm3A==
X-Gm-Message-State: AOAM5332NYtVHF2cgK1VlNEmvnO9yRFGHaczSDrn9Sglwh6gGc5icD1H
        S6RaBYcWmE1mRlcVnk124Qkrpl3puqlAtDAEiQ0kg4PUebE=
X-Google-Smtp-Source: ABdhPJwH4yJ9S25IQ5rPLheaGef2e4VPv9oDKl8stXlTiIfMtNVD6W6giQawxkcYCrZSguYrZde3NJF/M4O9psaGr/w=
X-Received: by 2002:a67:87c6:: with SMTP id j189mr35364915vsd.0.1626874774049;
 Wed, 21 Jul 2021 06:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210720163832.544a2baf@canb.auug.org.au>
In-Reply-To: <20210720163832.544a2baf@canb.auug.org.au>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 21 Jul 2021 15:39:23 +0200
Message-ID: <CAJfpegvVyZXCb-RHBea6wmqOHPTzauXwSny0w666GJnm68ZLmQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the overlayfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2021 at 08:38, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the overlayfs tree, today's linux-next build (htmldocs)
> produced this warning:
>
> Documentation/filesystems/api-summary:95: fs/stat.c:67: WARNING: Unknown target name: "statx_attr".
>
> Introduced by commit
>
>   d1e717e0032c ("fs: add generic helper for filling statx attribute flags")

Thanks, fix folded and force pushed.

Miklos
