Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2674934B782
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhC0OOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhC0OOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:14:32 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9CAC0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:14:31 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id i9so8922506ybp.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6fpeElc4M5+PM6uHW8/Tl/GT1heaHM/3+9S7sjw9VU=;
        b=FXl+nof9rwah2KtZEhr/lDkZ5AOSfd+mTcQYbCHcgmJ8xyQF4jHa7oipjoatOcmEaq
         FBTCFhXN5e3t7JVS2CUn7SzxOvIAApOyFxZvc0PIt62TDFomoLI8gxWBAve+NyrUHP3q
         6xJEdGnCEl2djboS5/3tpMj1mxHZNgYq35W/DKPP3iEgnjbP659z1ui+qtL0UZpqeP9r
         cWP+PmCNPxk2fhkXGdTQRqUV3eqXtlHmCamXBt50gNM7yI8RAcIiC7C0kgzbkF/+l2iT
         ZY9+u29A6KPYQdCZSjPEJJc5WOWRVAXh45eUcsaPa4kPsIms7EDZBf+e278sCJRzZIf4
         4Cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6fpeElc4M5+PM6uHW8/Tl/GT1heaHM/3+9S7sjw9VU=;
        b=Zz8VwUwnXPFBiib46iDsJRuuqXO9xMoVgwbfw4j5mVA729j6QoT6lY9/CywRYAW+yd
         tWWj0GrfJnTiyweJHonMPQornQRIxpNw/bYRe7ls+o8TK2nhAWGfafwwZPA/eLc4qvui
         m/qpbWxNNDrgqedAJb6PvZFs0MGbeqpe39ZDH8z/qEpLoi1BxHicb8+ztcXBJDf36zH4
         4eee4ma85KJ9J5fkLkqElY0H6JKGyuU3ZC/cM3Cr++cwOvwfaEw4QNEBfx1slHPAYlo2
         UcKbwp/U1evXxuBWyheGtQGfcNtY/gEOqSJ2ZZtTl1nchEBEy8X6hUTU9LBYXQfpzw/t
         MrBQ==
X-Gm-Message-State: AOAM532NsFNrzJ3j/Mf+u5MZfBwNzcBsA86iCe3EB5uzUnYXdHKxl+zm
        4z40r9Wz/kvNyv7lbBptI58JSvhwDy/Mhqi/9PkuTKRzbQoeK0Hs
X-Google-Smtp-Source: ABdhPJxDA2ginFOgkjj1wBR+qpi+eKYrxAoRziYzOq9zglxelOpD+23hYU4Pfelm88onmJtZYOCUSLMKccmWM3nnhm4=
X-Received: by 2002:a25:b21d:: with SMTP id i29mr17375005ybj.226.1616854471101;
 Sat, 27 Mar 2021 07:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210327130508.24849-1-johnchen902@gmail.com> <20210327130508.24849-5-johnchen902@gmail.com>
In-Reply-To: <20210327130508.24849-5-johnchen902@gmail.com>
From:   Pochang Chen <johnchen902@gmail.com>
Date:   Sat, 27 Mar 2021 22:14:19 +0800
Message-ID: <CAFv60hJgyyS8WmqzKciUCHCQ92Vr4_DA1Q3XNfZWf4EuU=+MEA@mail.gmail.com>
Subject: Re: [PATCH 4/4] HID: input: map battery capacity (00850065)
To:     linux-kernel@vger.kernel.org
Cc:     Rohit Pidaparthi <rohitpid@gmail.com>,
        RicardoEPRodrigues <ricardo.e.p.rodrigues@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 9:06 PM John Chen <johnchen902@gmail.com> wrote:
> +                       hidinput_setup_battery(device, HID_INPUT_REPORT, field);
> +                       usage->type = EV_PWR;
> +                       device->battery_min = 0;
> +                       device->battery_max = 100;

I just realized that this won't compile without CONFIG_HID_BATTERY_STRENGTH.
