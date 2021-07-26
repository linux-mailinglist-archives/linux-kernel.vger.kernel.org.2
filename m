Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252EF3D512B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 03:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhGZBSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 21:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhGZBSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 21:18:45 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449F3C061757;
        Sun, 25 Jul 2021 18:59:14 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t21so9642805plr.13;
        Sun, 25 Jul 2021 18:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hMKyEqYf8X5hGFIEsNNnn5xuXTqy9Dq0LGNuF1q/Xk8=;
        b=hfWaJtyh+tXrd8MbPH/NbNGAavG975DNjnDjtq3T6zjyx4nstEu09uASxlNi22amgH
         fKGbGqvi3fF2Pmo8nbs9VKhhQSjKAa163U8Peg0tDgMOvMB1pli8pD8rfg6qi1UQjsJa
         nTcw6jRk8I1j9VkGoQnO80FuQ6lPbf6KW2AzpIqpCIY+p8o/75CM2twHb5akc2ibkgxo
         7/+3iqAhM2ucMTeBiG0FxlfJTlqyHBqHmaQi5DV/7cRkXkPK1S+hFuvI7XEYPbCEFtRj
         XYmdqyZxbB1sqgEFl2nfc/jjukO3W88Gr/EIoweQ41rgRDHRbFuQCFlLtmTE2yF/aIEz
         uMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hMKyEqYf8X5hGFIEsNNnn5xuXTqy9Dq0LGNuF1q/Xk8=;
        b=ULvsZJIes9pEhJETBYHU2oMqKwkGc3bRyW2mk+vO0REzC+0465SvyPTpyy2E7uLhFP
         DTc5VZBlU0j0GrM8naY7CecRHdpVNmQn5AVrdGNlzXDXKxkIewRDnx3aFYay1MkfNFq+
         GTBPSQCkFbaKeHICUdQbciqqEkex34J4xAVEpb09BZGAGd4MeFb3V01EY/UsqoMih9ec
         O/UF2IdLFvAAjXDa4eVYoaqN0Ukorapge6rG0NejQWqX1i72Xlv2PYw4qVOPPy315RWR
         Ul7Vz3nH0z6iri/Dc4oONWZ/wKR/BjKuf09QZrxOlsybeJK/EtFQzkezN4Jvvr/0jgeT
         9U9g==
X-Gm-Message-State: AOAM532odg8EqQoeiCa7TdjhCPwMcY045GUx6NL0ebCb1vZASgaEWZ3t
        EYm7OSV4xXLi5TaQsz8fDhy0D88p6aydYcO4qXE=
X-Google-Smtp-Source: ABdhPJy1t04y7L+LIX/GRZ5v43NDhjA3mwsPy/vGfAaup9HSSkw/DF7OzDk2sQdkPBbOjiWN3rVbfvczQgGcb2lqnVM=
X-Received: by 2002:a05:6a00:1693:b029:333:da3a:8c86 with SMTP id
 k19-20020a056a001693b0290333da3a8c86mr15962273pfc.41.1627264753556; Sun, 25
 Jul 2021 18:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210724061105.486293-1-yang.yang29@zte.com.cn>
In-Reply-To: <20210724061105.486293-1-yang.yang29@zte.com.cn>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Mon, 26 Jul 2021 09:59:05 +0800
Message-ID: <CAMU9jJpOXda2zaMsF+WKTc9J2xDwBSHU48QhQg9_sS3_nS8tEQ@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Add zh_CN/accounting/psi.rst
To:     cgel.zte@gmail.com
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        yang.yang29@zte.com.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Good job!

But there's a bit of imperfection here.

Multiple operations can make one skilled, so please forgive me for not
making it clear all at once.  >_<

1:

       If I remember correctly, this should be the third version=EF=BC=8C[p=
atch v3]

<cgel.zte@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8824=E6=97=A5=E5=91=A8=
=E5=85=AD =E4=B8=8B=E5=8D=882:10=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Yang Yang <yang.yang29@zte.com.cn>
>
> Add translation zh_CN/accounting/psi.rst and zh_CN/accounting/index.rst.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>

2:

Pick my Reviewed-by tag here.

> ---

3:

Change log miss. Any changes you make between patch versions should be
recorded here.

>  .../translations/zh_CN/accounting/index.rst   |  25 +++


Thanks,

Yanteng
