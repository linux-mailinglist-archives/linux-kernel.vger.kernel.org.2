Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D092134949D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhCYOuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231229AbhCYOuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:50:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73CDA61A02
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616683824;
        bh=gXKf4S8+61HKOZyFOVaAxqwer2cxjoMEzIs0jhgOClQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RxqZiJ1+PE+fSHc0f7b8XlozK1UzYagYiD+XHk89yhBpm1wVn5K7nSND7k+VwdKTj
         O+Q+8xR2sF8JGgh9A5cbPJfPF1M8foWdILcNd7ONzIc4kfNgcXFuI4u3ZW+GbZDTh7
         sZ4Ss4+6fUv8WjxhFkF/5YFhVn4ohz2zacL1kk4vmpRo6X6RBKRcxwm2nD1gMiF4b9
         gkFQ9hnRIYrwxE8+Vsv4MPQgh7hLx72wOJ2uy8mY5bp5BL7MSDbLtkEXK1iar6NTF7
         REXP2Ltdcfe0DlCMlxK/c2ZpcZ8kSqxel7Pvi4cZOjDlzyAzCURlnbgHdX8BNBET5U
         N2BrC3rzmBq6A==
Received: by mail-ej1-f53.google.com with SMTP id u9so3365224ejj.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:50:24 -0700 (PDT)
X-Gm-Message-State: AOAM533WnPox3ziXO0zx6WoQPqqRJ/sEvWqDEWuRIrKq/T5nLAjkmQNF
        QdWr620lRRgyHbZIcIaAPXF21rfFVL0GYbZwVg==
X-Google-Smtp-Source: ABdhPJx3tGzBEWxXeZqHjtFE3s2YBfKCjbp0HdPAZ9VH4JPdIzt6nZLKrGikC9YrzzRcQ2af++5VziyxrNwMXikGiec=
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr9965188ejc.267.1616683822980;
 Thu, 25 Mar 2021 07:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210325130728.16634-1-dafna.hirschfeld@collabora.com>
In-Reply-To: <20210325130728.16634-1-dafna.hirschfeld@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 25 Mar 2021 22:50:11 +0800
X-Gmail-Original-Message-ID: <CAAOTY_80C++G3xM_Xmi+8uA7J9ixd8rQTZ4VKCtURH-8Cc6S6Q@mail.gmail.com>
Message-ID: <CAAOTY_80C++G3xM_Xmi+8uA7J9ixd8rQTZ4VKCtURH-8Cc6S6Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add linux-mediatek ML for drm Mediatek drivers
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Collabora Kernel ML <kernel@collabora.com>, dafna3@gmail.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dafna:

Dafna Hirschfeld <dafna.hirschfeld@collabora.com> =E6=96=BC 2021=E5=B9=B43=
=E6=9C=8825=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:07=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Add the linux-mediatek mailing list to drm Mediatek drivers
>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9e876927c60d..8260bc5afe66 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5963,6 +5963,7 @@ DRM DRIVERS FOR MEDIATEK
>  M:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
>  M:     Philipp Zabel <p.zabel@pengutronix.de>
>  L:     dri-devel@lists.freedesktop.org
> +L:     linux-mediatek@lists.infradead.org (moderated for non-subscribers=
)
>  S:     Supported
>  F:     Documentation/devicetree/bindings/display/mediatek/
>  F:     drivers/gpu/drm/mediatek/
> --
> 2.17.1
>
