Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC803124A3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhBGOQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBGOQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:16:17 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88230C061756
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:15:36 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id t5so15061279eds.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqJ8QFKv/gFx2X80fJrs6y2Ning8cod0yNlvrRWWx8A=;
        b=NX/rpkHPg5iyeAxZlPocGy19Fpggqui8QohhjAuJSBCNmhYo0XUk0aPDyX70pEnt5I
         3ocixxCoB7HqAI/g5xpizUytvK73KffLcirrHOmUaaRk4KKBqh6C401ni0dgNIrqFjB4
         RAya4GMcIHkxORRm4Vq4T2Wq/X5uekBgUau9YWW7z+p71L/ibwAMwJwE8/V6peqO3Uc1
         AhzoApTT5D7ZAa7kRdfSSEsmEiz9YLz1rT+OcQbYreJ7j9C4JlaE/DTlM6IBhmWvXvNj
         m0Kk+RHO+AGa8v0UvstMD2mbD38Su3IPCt84jpPCXELD1v6PTc2MJcgKkQR62FzsG1aV
         yJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqJ8QFKv/gFx2X80fJrs6y2Ning8cod0yNlvrRWWx8A=;
        b=mJIZ12neWQ6PHCRFjF94w5m8RvUu6SFc6SBa1vQ5XDfKXy1bGiSthPQvIoJFwglRWo
         Y2PK6aIZ68lzmhXsQo1E51CvJ4A5/IF9J92e2LF+bHVKB8Qov9tZe2u9ve1/rn6Fj9la
         7uF+dH8shOzNml2Sg+e7etbvAOGyGaM8cs6uEFTblvBB2nD7QX6lV81WdQl43/rgBmsU
         cTT96caEIIctOwqifH13C25CbDYZy12v9O/JJa4cv578hWnQbR7HIIc62llGDSGHEx98
         TJz6Yon7QurqHeZhJGRXNFe3rxjNY6OkOgzPPpasJOoAuM4eVzVa9rBElrYIITPOqdpG
         b8dA==
X-Gm-Message-State: AOAM531rMP2NcLrgNlqUSRLJPLgFVgNcvBPTgKvVKZct+0eOcl2rTgtz
        9ZbOkPUqUmQnlqLQ1tRo7NNcKa4o5ocaleYCZ0GDPPGxURtBmw==
X-Google-Smtp-Source: ABdhPJzXdQ5g37Yuow2FSR6LDKv0TzOp0c7pWJKYJuwgnXj9/Sw6ydXKWBn5U+qMDFKuwlhkJuco/EJ+3wEpjDhe3xs=
X-Received: by 2002:aa7:de10:: with SMTP id h16mr13111974edv.295.1612707335325;
 Sun, 07 Feb 2021 06:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20210207043200.2386-1-dong.menglong@zte.com.cn> <CAHp75VeecgGMtJr5jfx=1D+RNOHgYx34ZMrY+GMpCAayjJ7Lmg@mail.gmail.com>
In-Reply-To: <CAHp75VeecgGMtJr5jfx=1D+RNOHgYx34ZMrY+GMpCAayjJ7Lmg@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Sun, 7 Feb 2021 22:14:53 +0800
Message-ID: <CADxym3bCt9-gvfFc1cVxfibVzDAZXFO9Q9WrDKK_FUdD+6rLnA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net: socket: use BIT() for MSG_*
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Menglong Dong <dong.menglong@zte.com.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 7, 2021 at 7:52 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Feb 7, 2021 at 6:32 AM <menglong8.dong@gmail.com> wrote:
> >
> > From: Menglong Dong <dong.menglong@zte.com.cn>
> >
> > The bit mask for MSG_* seems a little confused here. Replace it
> > with BIT() to make it clear to understand.
>
> Now it's confusing which version maintainer should take (you forgot,
> it seems twice, to bump the patch version and mention the changes in
> the changelog).

Sorry, a 'BIT_MASK()' escaped in the first one, and I just thought that the
second one will override the first one, as long as I send it quick enough
before anyone see it:)

Thanks~
Menglong Dong
