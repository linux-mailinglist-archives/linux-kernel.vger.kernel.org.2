Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAFF332F64
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhCITzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhCITzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:55:11 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE54CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 11:55:10 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id k9so29236470lfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 11:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vt6mkj0jVSFTyY251Tb+CgzT35tgzBSQBV+Cmr871e4=;
        b=HuwD6tNld4iJU8Mjzfb5DkBasrVtWUDLvxCey2JTv3AkO14FHWHCfvCBwVVm9qmad7
         XVSyULhL/IA06Np4AEJ6M0SLOPBYwCPPl3mkeVZblnO5S5Nb7yneY7pAgZy/IOR41zgQ
         F/1JI+UzQGWnuob1RvDgYA7ZEYuIgahwstCvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vt6mkj0jVSFTyY251Tb+CgzT35tgzBSQBV+Cmr871e4=;
        b=FiBcO3bO9tUAQhHfg86mVKf/+s7bo+5/vcX6Nu0idcIwsGIbuaKhnhykBYJtBLuHGP
         QkBsBHZEDhhuJ7pJ87iR7XYQgmKx2iW7EiE4TIv7/nf7k/4lRhKL3ZLqrcVpVQ7DaD6J
         kxq4PioB0ejpM7fMM9m1LC2JXKXW6NkjxGXy7S6T9yGppjAasxeRKFYe+hPbogghuiQ0
         MZP710w/C2cZgPkI7nnDJEGGLy1yTp75FnCIi87/eulDMrqFGOIlIN/4TVzMe02aUuc8
         9Wdi8NJA4uRxDQOHT9th97YD9Ug25UZ2aiTS0k+/+L3Lg/ru1KwKH543FHUb/0qBXH0F
         d6+A==
X-Gm-Message-State: AOAM532zVPBM1A1ZaigTG/WawgeH7UtA12rAp19UAPWs/cC0wEV1Hp42
        AxSocjOkVyOcLVwt8FllF6NjkCt/S2D5SQ==
X-Google-Smtp-Source: ABdhPJz34kfMSDvc3ed0675NMiFWPNv46z4GqQT/6LXmukTSaiHplAT1iB6YIMf2x6C6DBp9IsnBUA==
X-Received: by 2002:ac2:4474:: with SMTP id y20mr20100141lfl.230.1615319708977;
        Tue, 09 Mar 2021 11:55:08 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id w17sm2079242lfu.74.2021.03.09.11.55.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 11:55:08 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id m22so29253782lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 11:55:07 -0800 (PST)
X-Received: by 2002:a05:6512:a8c:: with SMTP id m12mr18981829lfu.253.1615319707578;
 Tue, 09 Mar 2021 11:55:07 -0800 (PST)
MIME-Version: 1.0
References: <20210309151737.345722-1-masahiroy@kernel.org> <20210309151737.345722-5-masahiroy@kernel.org>
In-Reply-To: <20210309151737.345722-5-masahiroy@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Mar 2021 11:54:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh8qKZYoN-M5a5-=ps7Cf_obtd0P_-0h+nMQEWkVqGFzg@mail.gmail.com>
Message-ID: <CAHk-=wh8qKZYoN-M5a5-=ps7Cf_obtd0P_-0h+nMQEWkVqGFzg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kbuild: remove guarding from TRIM_UNUSED_KSYMS
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jessica Yu <jeyu@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 7:18 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Now that the build time cost of this option is unnoticeable level,
> revert the following two:

It might still be a good idea to make it depend on EXPERT. Otherwise
you'll have problems with external modules..

Also, can you actually specify that "unnoticeable level" with numbers?

             Linus
