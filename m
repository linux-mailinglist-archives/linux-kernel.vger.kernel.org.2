Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0AA3B3BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhFYFNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhFYFNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:13:39 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CE6C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 22:11:18 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w11so34740ilm.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 22:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57iRP0TyZJaJvCo9zaWn65f6DCvfYNmLe//EEF6wtFI=;
        b=G6+6+qUtWHt/mqMvaRgc+Gqz00z1xMlxhpRYQaYaJeWU6yyTNZO7do743gVv4jHK7c
         Cf5fa4oH+l8dQtBujIa2tJFrQRypUsbuJ2g8w6/YNwhK2cvn75uo+BnD2640X3Jfvh+o
         wFfQo/c1oKk8n/1bkCxzeyTec06Fcim6K/v6kY42xxpa7N4xaoLzFD/9k8in9l1u6iTD
         O55APOWGyjaWFYwJ584SyR2fdNogeMoVGUqYZX0zNBFYopgk0bB5ZB+CItgZTzzguukZ
         /tesrwRM2nHhFov0bwkPo49Sx87WDir775v9FI0XrjZc4u5WWKqhO8YiqyaFfgqmthnl
         vbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57iRP0TyZJaJvCo9zaWn65f6DCvfYNmLe//EEF6wtFI=;
        b=nvCH+9o1OuNOd4dAQR4EG45UIOS3+h31JVPzKxVqLNeCa76LH9/jBmVKMFscUYiCPA
         dkQ8pk/0bM9jc8SmBQi5mIDJ5KEtA6aCdpf5TLy+HlkM8ygZ50s1up5n86Q2bKQ/g5Nv
         9kjZWO/Iv5AWVnUPgipNq/4p1+/kPq3cuEeexj9v2Iid+QgNGsTrvp4W+gYYofwtljfE
         MKb41bunKF35Vn9Hec5e/li+SK8T5SUeEmFd4itfLTZfGE5NBUXYIjkKbl7yyzT8IzIu
         OFfafsXum3Jf7QPjBRQFzPh6Vjbs4+7L+2gjk7dfiSOg0aND2cdX6vZKLGI4W16OT52k
         DBEQ==
X-Gm-Message-State: AOAM531nTpcU3bFa1ClJ6GWO+1q5RsP7kf+MFXGIkqYsNniQRzPt1t8C
        Sc/axFcqPGX902VEFngdPy+DtkPNHjxEe3UxhzHlew==
X-Google-Smtp-Source: ABdhPJwzLav6Dz0Iv39Al05WGPtRKLaG6fOQ1SvXRk6WVJyGlBBTuVK9ecDEQXceJq+eiH2V6GoNaWQum484UavOJCU=
X-Received: by 2002:a05:6e02:1064:: with SMTP id q4mr6269901ilj.127.1624597878160;
 Thu, 24 Jun 2021 22:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210623123854.21941-1-Christine.Zhu@mediatek.com> <20210623123854.21941-4-Christine.Zhu@mediatek.com>
In-Reply-To: <20210623123854.21941-4-Christine.Zhu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 25 Jun 2021 13:11:07 +0800
Message-ID: <CA+Px+wX7yBvuzj=KWf0MhLkTQOi4Rfn8F6z_+g-T66K3iMfb=w@mail.gmail.com>
Subject: Re: [v4,3/3] watchdog: mediatek: mt8195: add wdt support
To:     Christine Zhu <christine.zhu@mediatek.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        matthias.bgg@gmail.com, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        seiya.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 8:44 PM Christine Zhu
<Christine.Zhu@mediatek.com> wrote:
> From: "Christine Zhu" <Christine.Zhu@mediatek.com>
>
> Support MT8195 watchdog device.
>
> Signed-off-by: christine.zhu <Christine.Zhu@mediatek.com>
Still missed this part per suggestion in [1].

[1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20210623092917.4447-2-Christine.Zhu@mediatek.com/#24270619
