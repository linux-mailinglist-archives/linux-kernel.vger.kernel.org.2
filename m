Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07063CD046
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbhGSIdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbhGSIdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:33:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E593FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 01:14:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hd33so27485477ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5FkYygAP5aYXKhiToJncjQ4pnqt1axbUfxSA6M106E=;
        b=RUoz3S+OzJer2hQ2zynaEh0ahbOByD6Ye2U9E+aySsu09fb59vHB8xqBnMBTNjooXK
         J48srP6gvu9447896+hKmxhF7Yn3jmLZiyQCnSf7eqMm4aPtsMJWS8efN62jjFn9mbAr
         AQL95z7CfrzZnBYbnITt4xTYVjHmXWcnLWPNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5FkYygAP5aYXKhiToJncjQ4pnqt1axbUfxSA6M106E=;
        b=Gkc+yvLwu5gMDRi6oToVtVLs4uMbHp3yfign4ibk0Xy6D1i2sp4eKKBcQlwkeiwtm0
         79abqweW3rS6nr2tdKpL3geKGPrpGr2HH8n+g2NIzj0feSDWKtw16NrylHqDIycHbAlW
         xTknbn2kfWuS36i5vT59jW+iOQeV/IyDKdDBIQ8dAjueai4V0tlKzCLNG3REM60aX+pf
         LYtKlUCDVxMmaU6dWe7cmnYCtwZ6fQcTykVn/k3NBcqL0RhIDMtW9bcwmnJuVBVxbwA4
         QOhNWGHRVwI3yOgWXodv+LxhfE29rfno/WCGKgKzOsAc6/qYDY6DYvdYMujU5kPHPxId
         twMg==
X-Gm-Message-State: AOAM532gkEp7aA+xpoOwxDoxbaMfrfPnDqMAr2hmSCMqG2cR8R/BA/kA
        hBhFB9xqyABLQWoH2iTuGRm1X8bk1bY0cPPXx41H6UVSc0o=
X-Google-Smtp-Source: ABdhPJzlxqfFGaZrZ/5HCQxqAtoUQFd+tAAHV7lDvF2Cb/wf0Cnc0joQvV4k+SOZgE1RrpeWhEROVb9+ifjTZjQ6mgs=
X-Received: by 2002:ac2:43d4:: with SMTP id u20mr17544633lfl.451.1626684328396;
 Mon, 19 Jul 2021 01:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210716100452.113652-1-lmb@cloudflare.com> <CAEf4BzauzWhNag0z31krN_MTZTGLynAJvkh_7P3yLQCx5XLTAg@mail.gmail.com>
In-Reply-To: <CAEf4BzauzWhNag0z31krN_MTZTGLynAJvkh_7P3yLQCx5XLTAg@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 19 Jul 2021 09:45:16 +0100
Message-ID: <CACAyw98RaF8SgA9nkduXo-wBdsRN86cP=seX9d83i0Qhi0gbeQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix OOB read when printing XDP link fdinfo
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        kernel-team <kernel-team@cloudflare.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 at 21:44, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> Well, oops. Thanks for the fix!
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> It would be great to have a compilation error for something like this.
> I wonder if we can do something to detect this going forward?

I had a second patch that introduced MAX_BPF_LINK_TYPE, etc. and then
added explicit array initializers:

     [MAX_BPF_LINK_TYPE] = NULL,

That turns the OOB read into a NULL read. But it has to be done for
every inclusion of bpf_types.h so it's
a bit cumbersome. Maybe add MAX_BPF_LINK_TYPE and then add an entry in
bpf_types.h for it as well?

--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
