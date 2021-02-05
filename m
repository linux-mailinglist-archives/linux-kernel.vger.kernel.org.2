Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14A0311731
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhBEXgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhBEOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:21:42 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C50BC0617A7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:59:18 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id q9so6260808ilo.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3zypKCzWyxay+UIu/YEc9Osf3cOdr0Kv47aU++eg2A=;
        b=wHMwWR7atLxSylIAhPsg+XbGgy2ngza9cJiVuoTVVSRT0VYoznd3z5oa6u2NIK+423
         7ruKeIDQbtM7op5nTyQZmCjfIzSe2FJ2ZGzZp9qJtXTFOCDKC7YrV6YS1G+qT47ZCsEG
         yImFk7Z9WJdF99Z+PUzvlKEs+JTVCt7Ex3+iEc0Qw2h6zz/IN0CbNAY3178P1ufzwFHY
         2+mmqmYvTt/v2G9im0KE5xrUkTPqEuSwz1sduaV6b+TdaveBM45BWwxE2wq0IMMvINFJ
         Rn1jEa/YEN/wxt3xacyQMoyZFfx4F+KqRIkPAfe57u6t+tXRoUuhAllT1IDUT4MHIqH2
         ONPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3zypKCzWyxay+UIu/YEc9Osf3cOdr0Kv47aU++eg2A=;
        b=I/bQdm3xdtNGgk0rvbwwavMFLj572S3fK+l/mlWd/FCWHW3ps1x+tEto3kEEIwX97O
         TFTQCqBVNda+Um39LxzOv9y4crNl5as6FTD1DxyNabhMhbDqaTQiN12wh1HsXekb6D6c
         EySpJ9TYjwxdGUwmkDrn2qBqJxtOVTiNalXTqEUDJup/TNPtxHnbz20RlwyrnXGZKHAI
         axbBW7S/XzY4uI8xA2Cn70N+EtBsy4XCLK0G79MnPhArCa5f1bqef9p3zrqy90LtvwFc
         q5+gGVXdp4Q62t/R+2RFSXrvPLnnvNaCmxWZDvPIT0g05Qb7KWgF18tvOoXGPED+rE47
         ZmVQ==
X-Gm-Message-State: AOAM532NBzpbRRQCg0wVxKccEPREtLyF/5OcJ7mtzTEgm0KZDulOi8Xf
        F9VBKqPFyy3MpV1ywGXIdd0n5gisoAfn4qIzyYANch3EcN9Ps8Uo
X-Google-Smtp-Source: ABdhPJxe5vVd/CExVuPqdcTkzVFPRKKdBfU/HunhfInTRU8aAUoq7Spk84lhtpbSN+V7AcZIdO4t/9CQJ0/PFYf74d8=
X-Received: by 2002:a92:d3c7:: with SMTP id c7mr3834270ilh.137.1612534233334;
 Fri, 05 Feb 2021 06:10:33 -0800 (PST)
MIME-Version: 1.0
References: <20210204213146.4192368-1-eric.dumazet@gmail.com>
 <dbad0731e30c920cf4ab3458dfce3c73060e917c.camel@kernel.org>
 <CANn89iJ4ki9m6ne0W72QZuSJsBvrv9BMf9Me5hL9gw2tUnHhWg@mail.gmail.com> <20210205130238.5741-1-alobakin@pm.me>
In-Reply-To: <20210205130238.5741-1-alobakin@pm.me>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 5 Feb 2021 15:10:21 +0100
Message-ID: <CANn89i+Rpxw__Yexvcaga5aQ84CjqAzPZ6FyaO4Ua1yWhB069w@mail.gmail.com>
Subject: Re: [PATCH net] net: gro: do not keep too many GRO packets in napi->rx_list
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Saeed Mahameed <saeed@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Sperbeck <jsperbeck@google.com>,
        Jian Yang <jianyang@google.com>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Edward Cree <ecree@solarflare.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 2:03 PM Alexander Lobakin <alobakin@pm.me> wrote:
>

>
> It's strange why mailmap didn't pick up my active email at pm.me.

I took the signatures from c80794323e82, I CCed all people involved in
this recent patch.

It is very rare I use scripts/get_maintainer.pl since it tends to be noisy.

>
> Anyways, this fix is correct for me. It restores the original Edward's
> logics, but without spurious out-of-order deliveries.
> Moreover, the pre-patch behaviour can easily be achieved by increasing
> net.core.gro_normal_batch if needed.
>
> Thanks!
>
> Reviewed-by: Alexander Lobakin <alobakin@pm.me>
>

Thanks.
