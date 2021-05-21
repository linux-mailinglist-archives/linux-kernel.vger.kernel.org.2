Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E80E38C84C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhEUNi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbhEUNiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:38:51 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8002C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:37:26 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p8so20079028iol.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enWZHbTX+1ralsrB94tU0j8mRNIc2ViVpX6p57Tm5zE=;
        b=NaZTtxcuBTlfaQI35LwHalM5DvO/FZwwhLZjRS7/FQdrOAtExKGt13R/NExTU//cQO
         3mcxfG1eN1ewoWzCRO/DxANKbfA8EnOqjsglH18Lj6wiS48ArQq6uLO8CAf8sRJgnkwm
         br20HeMG4mjA5VdvTfBOhrU4n9n07WGTKAOoHr54h/MLvlw/O7oR9DUPT11D1f4Ptj4s
         +yP0SJhcgYgVvs1c2UsG+idQzTnwZYfkxiQPlAg7Btf7EVYIMzQ7SlknsvAhZWdK4ZCg
         r1fbv9Qmq+oT5Ikvdjs7uyVrzLYW5lmrN8TXVv7SWNqUr4vaBYz7a941jQkeffMLbZ9J
         PRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enWZHbTX+1ralsrB94tU0j8mRNIc2ViVpX6p57Tm5zE=;
        b=IKWIqm758odF26hxnOHoZ7h+KM0znrVZW5PhUKI/j+xvnttZlGnKRD81+NqxGbd11y
         GC2ApTYDRD1bKv/t6usYqe3H8JkrAZOsGu9gNZm1gY8L4X+qA8hFeSirWHbi45fU4dQw
         21kxGhuJwMrwAQVuqYXhAdaWo0EiIV22Sq5BJ/3VEaEnIZlzRNG701IqNHwiGTTnLjVr
         Lx5t0eKIKmQ42yzpWjg1vjWgOgXed+5iLgEt0yX9U2qdg6GqTTqJyAoH07SItK2xA4Rk
         YGNcT4AqiVWhieoOQKJ/y0UcJHDMzQJ8JzBwhyRgy/69gQqO26B/lJpZ3wuPVPbuGLix
         obPA==
X-Gm-Message-State: AOAM533Pje5zSd6G0viQR592YavzuDNCPzqEI5+GMeOpWSEdW+yA5BJg
        CySLYHN8Eotfm/ywtsW50b9xLB304C5J4TIWPkRbFw==
X-Google-Smtp-Source: ABdhPJy9RIIy/dIbfHJJ+7svOf8eeI6VuDWRGhsHg+X4dKcXZPvG6VAJrWtvnvLALF0dNjytfTjlmvzM7zYFfkhhM2c=
X-Received: by 2002:a05:6638:3010:: with SMTP id r16mr4595070jak.126.1621604245913;
 Fri, 21 May 2021 06:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143011.1175546-1-acourbot@chromium.org> <20210519143011.1175546-5-acourbot@chromium.org>
In-Reply-To: <20210519143011.1175546-5-acourbot@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 21 May 2021 21:37:15 +0800
Message-ID: <CA+Px+wXuyWv53Hwk8zo_3R4mRJzm-ShZQ_qiJ8jupSfzLWaZgA@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] media: mtk-vcodec: make flush buffer reusable by encoder
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
