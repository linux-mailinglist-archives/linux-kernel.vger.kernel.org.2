Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DFA3C5A55
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbhGLJuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348887AbhGLJuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 05:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626083241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OsAxr7I5wY3GHXnm0dzu227J/w3T3hi+AUx2iyLrph4=;
        b=YRjKJ050sf3F5FYwrAj4EsxK1p9pnQ+stwJCtRKqrkmmZWFZPmGwGpsrjFbZgSE+8g1P6U
        etBradPyuKnnTOzTVaGLaatuxPF/oK++v6DytXQGIIOhnZC7YWbT82u1QKJAb9ohF/0kck
        oF+l8v3XSSLwXSILBooAuLallhI9Qak=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-lVdoIZizOIqEPccS_O2LbA-1; Mon, 12 Jul 2021 05:47:20 -0400
X-MC-Unique: lVdoIZizOIqEPccS_O2LbA-1
Received: by mail-wr1-f71.google.com with SMTP id g4-20020a5d64e40000b029013398ce8904so6940265wri.16
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 02:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OsAxr7I5wY3GHXnm0dzu227J/w3T3hi+AUx2iyLrph4=;
        b=sbt4iJOJqkrmgpRuNnz4y6G6x5B7WBvQHLSjT2ZiI8tJEW0XOnycVQzDCUvW+EAagK
         dWVJXEMg3hW+9jvTUwOORY8kI5RjKUiE1lLenwYvkQQQZYcaju/0HHmWubmVh7f8GYWp
         uSCiL7OCf9j0SOdYrYs5Ymlc9mmLTXCDNZRCFx4oYlnL4Vx77hDQN/wiMFRwxcLvnL14
         VngehK+YlopW8xT09owwfW9ggIoJeTCEBDzdpz+imT+Oyc8WI+i61xep0vJ/fGHuvS5C
         SEJROisupaEAnwElYZj/p0QxIz8pT/g+KLWzGVFNnnYIFDZvt19FlqFB6DfFN9FfHeZJ
         Jt9Q==
X-Gm-Message-State: AOAM532asRSt7bAIfRAhGKLPhBD8II9TyV1nBcojDf4wWr2y0UTlK+/9
        /igkoad+5CP8tvWmovqaLQGQimMmQgetUq0Z4u3SSaSH5sQq0DHMh104yepb+TpTzLbojp3tZoG
        Ii35/cskTY6JtBELAQnB9oS3YxxfL6R7QG/ykhgv+
X-Received: by 2002:adf:ec0c:: with SMTP id x12mr23662132wrn.113.1626083239400;
        Mon, 12 Jul 2021 02:47:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3sW8UYSOM/Q6qgJACh2S4VICMKyF4ZwsV6v+fR4fftaOEQT2tUBbmhmNCwT2qSaSR3qFgvPBKqWkCA/b7Jp8=
X-Received: by 2002:adf:ec0c:: with SMTP id x12mr23662105wrn.113.1626083239204;
 Mon, 12 Jul 2021 02:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210703072502.646239-1-gushengxian507419@gmail.com> <anhfX5shNJsdNd6vWMeQqNTawyT0AGuoZYI7yRItB-il7fywDu9_Ie1kKL7Wwv2ecVxiYaoymsZHpufnuxUBqvja2uq0_t-Qmhhc4uHT5f0=@emersion.fr>
In-Reply-To: <anhfX5shNJsdNd6vWMeQqNTawyT0AGuoZYI7yRItB-il7fywDu9_Ie1kKL7Wwv2ecVxiYaoymsZHpufnuxUBqvja2uq0_t-Qmhhc4uHT5f0=@emersion.fr>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 12 Jul 2021 11:47:08 +0200
Message-ID: <CACO55tvmvcrAHjFjJ9fMgcFspyfMLE2gR7f3Fxe0_cxxrfwaUg@mail.gmail.com>
Subject: Re: [PATCH] include/uapi/drm: fix spelling mistakes in header files
To:     Simon Ser <contact@emersion.fr>
Cc:     gushengxian <gushengxian507419@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-samsung-soc@vger.kernel.org, tzimmermann@suse.de,
        lima@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, Qiang Yu <yuq825@gmail.com>,
        gushengxian <gushengxian@yulong.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 3, 2021 at 11:00 AM Simon Ser <contact@emersion.fr> wrote:
>
> Reviewed-by: Simon Ser <contact@emersion.fr>
>
> But this this touches a lot of different drivers, not sure we can just
> merge this via drm-misc-next?
>
> In any case, please ping me again in a week if this hasn't been merged
> by then.
>

As long as it doesn't touch code I don't see why not. Just in case:
Reviewed-by: Karol Herbst <kherbst@redhat.com>

