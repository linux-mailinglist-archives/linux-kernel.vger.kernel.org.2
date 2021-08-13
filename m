Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC73EAFB1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 07:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbhHMFgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 01:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhHMFgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 01:36:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DBAC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 22:35:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gs8so16148251ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 22:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H66kUza9kjieCXDNO4cIhxNZROsB3ud0hLQkWH6ChG4=;
        b=dLvPb9L6KV6SsH/hl/dmFtyfa1NhSyXTPxtee2A15khhgvnTyVta8C3oV37tKKkXov
         fImKomeXcFk6fOawR6TKC7LkS6RoCiwvf7i6V/ZoVgbF8Qary13DSnazDclavtQ4c8va
         xk31w135Cz8Jc30NVTf4ESlUBb5nc2YF1chEUe0EIaiAMVDTAOBidY015SMhquMxSf2L
         DUeSWjK7b0mtHIb3+P3J5ut9/zzXiB6udOL5hQLODecBlW9IPo8/4r4NFhQw5nAKxgYu
         pSQlC3whcjdZmybohRj1QDfsNvPNVh0+BgJzhF4VzSCyAv/ceNGRzUU89qO2rtIgHfbo
         I41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H66kUza9kjieCXDNO4cIhxNZROsB3ud0hLQkWH6ChG4=;
        b=TWxFE4OBDUjNgcaSLOx1FaZ/gGfhyoFR/Kb0AtY4sqZDp/0NZUc2v5fr9AMGtpzvx0
         Qi4WEutvtSl8YgruGVjoPCOOkmHaC/rY3cb8TrjwVN9GsA9nyMAsEOYvbF5SD3J/r69r
         h6gwW8dR/2Gc4lVNHst+SYNRySy8rXeVDwLiBx2z6R53F3O5FkoizPC14lzVMSfib69E
         GP9xfDUZ1RDezQuW7jXpxwxxIXcox2NnKVIbgSIyKr1BTcsNPSBfgxLqk9b3SE8EGJMO
         yTvJZj+IheVhzdNn2PPv2ayiaOYjPhNmxmuc5sTmhs8VsLOfunDY/eSzfmZ3bNJHfghK
         uLcA==
X-Gm-Message-State: AOAM5335nz3CQnvX2QfmKpCnsnkv6t8LyZ2Qy5uH51eQegduF4YdPe/i
        mixkxuc8CCBrCXp9v2qgLMkUYlpLu5Y4HrcC254=
X-Google-Smtp-Source: ABdhPJxwlm8VqxU8r+al4a211nYhABlHXHs0cFTq5iZn1/qZTW1JxMrhW9mXyrKnf3I6/ntNe053+oV77TQDjrGXR2s=
X-Received: by 2002:a17:906:9747:: with SMTP id o7mr796798ejy.486.1628832940805;
 Thu, 12 Aug 2021 22:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210811163731.186125-1-masahiroy@kernel.org>
In-Reply-To: <20210811163731.186125-1-masahiroy@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 12 Aug 2021 22:35:29 -0700
Message-ID: <CAMo8BfJX-2Hnr3JFw-9tUGbeQKN=XV6nFC_0CHUqrii-kSb9DA@mail.gmail.com>
Subject: Re: [PATCH 1/4] xtensa: remove unneeded exports
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 9:38 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> These are not used in any of subdirectories.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/xtensa/Makefile | 2 --
>  1 file changed, 2 deletions(-)

Thanks, applied to my xtensa tree.

-- 
Thanks.
-- Max
