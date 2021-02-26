Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A04326177
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhBZKkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231153AbhBZKjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:39:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 871D464EF3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 10:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614335943;
        bh=sYJ82XkX6uFJ+iJIFDN5aR1JbVOg/WJlNAEEYcCgjMA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n6onfYU9vCg57SaCDOPi3yFuU65Ht42R5kK7rRW/O939b+dO8zjwQRho5ER+4xsOA
         U8okrD3GwZozb5tT9cWYpZm2Mt7tUb14NF1XGYfXEr6WlCiiPlVttaofa4Y/CCIXmP
         6qUbxX6XCoGCF1hnCwEa1rU8wu2uV1OSplysdUEau9YksP4q8quRnxPJy4ZQ9Nikjc
         CnUr14pARyMTa73K0HRqsSfdv0fyOYBpeJu9q3tlV1GS+biaZ6qIf0C3z8+MQLF4jT
         wTm0Eb/ns+0+V291Y7e2Fpta5942w8T2MFqZoiu5SWUQwGot8R96zZHiFvpLeLv0sZ
         YoR8CoOJnHN4g==
Received: by mail-oi1-f169.google.com with SMTP id j1so9289227oiw.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 02:39:03 -0800 (PST)
X-Gm-Message-State: AOAM533tPBoIh4ffkbje3wiNJ1ZbvaLozgtLzp5g50zlBVYDvjQSqf72
        Cxeh6RsvA9tfDsomE66qeOcxg9x0FvgT12ZLq5I=
X-Google-Smtp-Source: ABdhPJwo+uI8OmcHVl56p139qDmQbi6AFQkG6a29WvyDMkD/gBVZO8CnUjA4Ef6lR70h+0/+4etB0XeUgE+FptO95Ag=
X-Received: by 2002:aca:4a47:: with SMTP id x68mr1478742oia.67.1614335942813;
 Fri, 26 Feb 2021 02:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20210226092236.99369-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20210226092236.99369-1-luc.vanoostenryck@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 26 Feb 2021 11:38:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a07tzCBO-eXy9eZ7yxaddRFiMn4+xPqLC64vKWw+QLCBg@mail.gmail.com>
Message-ID: <CAK8P3a07tzCBO-eXy9eZ7yxaddRFiMn4+xPqLC64vKWw+QLCBg@mail.gmail.com>
Subject: Re: [PATCH] sparse: can do constant folding of __builtin_bswap*()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:22 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Sparse can do constant folding of __builtin_bswap*() since 2017.
> Also, a much recent version of Sparse is needed anyway, see
> commit 6ec4476ac825 ("Raise gcc version requirement to 4.9").
>
> So, remove the comment about sparse not being yet able to constant
> fold __builtin_bswap*() and remove the corresponding test of __CHECKER__.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
