Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F7F3D7477
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbhG0Llo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbhG0Llm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:41:42 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5D6C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:41:42 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id a5-20020a05683012c5b029036edcf8f9a6so13163956otq.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DVk/roXn7MDuqTNl8/MPtBH5EOXDiRDcUKDft9jM5Cw=;
        b=S8/vNhxVJWViK6VZinPpJgk0KHS8SoxUwHNSM7XwV2ugslXwoRBevRd5Mh4xY5EcdY
         h9dtOd1SBp1Pc6i4VGMyZ+V4yvThgyrnlgXi5gvREFemZj/ExmaGrbuUbm0j+AmVzoPO
         HMl109nuyZL1XTYqCHKsMMno4W9Y9UKDY39e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVk/roXn7MDuqTNl8/MPtBH5EOXDiRDcUKDft9jM5Cw=;
        b=BbFxdbJqP5LtKlu8uYViu3XeuOUlntQpX34bh++x5v6NsLsvKUxqmiduF0yOgqS7Ak
         ZGdnwCMq8ZxqXVcur7VwlQW0bbb1l1A2iG2+LtAymMetnMySVXsmH2C/DGJQkDcLpIZb
         +qR/wCd3VhYSXGc6h/smK67Iv6ql4tUbM8hoevkcXbUvvNdqJCzRcxG+/LeUE3wNyEj3
         0SKNI3S7EBy0gWmGYE0oJaa/3YzBuntNf+7zJgtcyhdpNC7AlZdWlkMoKFWNXe7tuCn/
         2NLJgd5dPe2wE53R7v9vQqpFVbmVPJKMQrHgoWrK/M/N+rYrUsOrl4Cuq6cIjZAINtxW
         ZBQw==
X-Gm-Message-State: AOAM530G9YeH2z2UCia8x6i0w5d6nRYsd5J14WhsIsoXlEGv+cO8AlI5
        EPhvQ3uAWNLw1Jvbrweirs5ITjT74Ej0Cm8B6mZwRg==
X-Google-Smtp-Source: ABdhPJwwqUJE8UKjF7vKwaBCoePrBQHFhIEc5QZ1sCYFnwQrwt9cNdqIxKdScWiZ8ggu9u1j1HNhn1elDyZZOK7BcGg=
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr15331222otb.281.1627386101729;
 Tue, 27 Jul 2021 04:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210727111448.1443-1-broonie@kernel.org>
In-Reply-To: <20210727111448.1443-1-broonie@kernel.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 27 Jul 2021 13:41:30 +0200
Message-ID: <CAKMK7uFNFOTrcLbFW3eoziPaZaH9JFKJe1AVvJGT6wU_rqfUeA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm-misc tree with the drm-next tree
To:     Mark Brown <broonie@kernel.org>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zack Rusin <zackr@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 1:15 PM Mark Brown <broonie@kernel.org> wrote:
>
> Hi all,
>
> Today's linux-next merge of the drm-misc tree got a conflict in:
>
>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
>
> between commit:
>
>   ebc9ac7c3dfe ("drm/vmwgfx: Update device headers")
>
> from the drm-next tree and commit:
>
>   be4f77ac6884 ("drm/vmwgfx: Cleanup fifo mmio handling")
>
> from the drm-misc tree.

I got confused for a bit how we managed a conflict here because vmwgfx
flows drm-misc.git -> drm.git -> linus. The 2nd patch is in
drm-misc-fixes, which makes sense, not in drm-misc-next like I assumed
at first drm-misc means.
-Daniel

> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> diff --cc drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> index 356f82c26f59,5652d982b1ce..000000000000
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
