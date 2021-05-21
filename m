Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F25F38C85B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbhEUNjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbhEUNjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:39:22 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CB4C061763
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:37:59 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id g11so14235486ilq.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enWZHbTX+1ralsrB94tU0j8mRNIc2ViVpX6p57Tm5zE=;
        b=q8LFiLJgz4erZaFk6fj4JM/AmedcsEm3aD+Osbe6jj0ySryG5lhha91+zewIWEJt3d
         UM0xdVW/ax/BEOt22B871ZJjSoA7uVKzGl+K0LYup0myRmKy0OTLtyGatHZrvhopvcYr
         x7pzJmuc5eQ2oBeQnp7JAt84/JjAYYqjGiUjzcy6SMN6bSaVxVca3VN8lSgEH/iOEp6o
         IbWODivDaA1mXl6UczSvfR2+HqwUxnkO/LXvjlSVCFJtq9pkPXLLnYMFSobb75QcAqFW
         /DGPOMj7yTGq8rlfo7gGKMaNQvAPX3IHlSl7C4qgLqf54lMlSxIveOOZHKHbrJow9wv8
         sZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enWZHbTX+1ralsrB94tU0j8mRNIc2ViVpX6p57Tm5zE=;
        b=UIu0cchltttAwl6zxsOCHh5z8p8/3crTRxYW23/KntEQWu/FlSsnPyrC1b8+la6V4G
         hN7HjPiEpMiv1KNXYFW+1r5/wXJR3JT8Xtzf7wuX1OWIWSJq2btx+D7tBdxQlN9IdXA+
         2s1VoKnzi50zEXSkkyM0MLytxXRZhmsouE5qe0iua6TaiHdnjp3SN+cWHu9/d0Se1RZW
         YRn7291YE4YpnCjDKAhoPjXaCW/7gE5YwIKfocwz/bsd6lo/KA0sa92Q/AkpkaFLf8lT
         TNYblRgkljRpKcPssZuSubX0NLp0kTEX2Qi6qj3mECXQm9dWqWgCl9vDEfzweWeMiJVj
         3gOg==
X-Gm-Message-State: AOAM530kGh8gJt3mnG3hoR1EHE/Gs0o2dVhkrBRlsQKJZU7fH6RHgOzD
        YvVLsKUmadsJcHABcBNtFcXlxtFsvG5PruZ+gCqXxg==
X-Google-Smtp-Source: ABdhPJzQgYOhfJwS+6mJoi9CYzpcQz7dqQ+cPJ0vJ+ySWWNPgClzxGdsXTiVO2tXclv8vakUGfjzP783wYoVtgk2NGU=
X-Received: by 2002:a92:520e:: with SMTP id g14mr12213261ilb.218.1621604279076;
 Fri, 21 May 2021 06:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143011.1175546-1-acourbot@chromium.org> <20210519143011.1175546-8-acourbot@chromium.org>
In-Reply-To: <20210519143011.1175546-8-acourbot@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 21 May 2021 21:37:48 +0800
Message-ID: <CA+Px+wVj45oozC01RKcnvwLLWdSmFtoOC9rrLAbCVCmrYWKBdA@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] media: mtk-vcodec: vdec: handle firmware version field
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:31 PM Alexandre Courbot
<acourbot@chromium.org> wrote:
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
