Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085F339B61D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFDJlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:41:31 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:44657 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhFDJl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:41:29 -0400
Received: by mail-ed1-f45.google.com with SMTP id u24so10350055edy.11;
        Fri, 04 Jun 2021 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MhKXBp+zBZD4+PQrRnyrXa8bCID5+ELNG12yKRayxeU=;
        b=rV2RApyDiLp02f1KBrG2aGTBpbJkGHOPuhv53BpTBLR+5wp9uX7giCBypVeSytRTbv
         1TqGEsgJb0AgsSg1cVYZod+ZCihHs2id/DgqhRXqX0WjkNr12dxi7A3d1HQVK18foD6r
         5301LG+2tmvYcpkBMSYkrIBxt8JFXl3y/MdFS/r0VsTxBQmSOy+SuK/KyFiG8+j+GnT6
         XzbztuTHI/SjRNrEAxi7KuXQHErvziU5krr6HMxc8LTvFiTYkvlhIO7SHCUqC8oIKcQ7
         JJS7i7BvatplcuCHO10WkIHJCmJIxPP9DrUM66I4KGTwuw0GUz4L/2Nu0gQ7EAx+8Joz
         3WTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhKXBp+zBZD4+PQrRnyrXa8bCID5+ELNG12yKRayxeU=;
        b=kNKL8C8pB92u7ADDlW+Dw8CwtoPIYSrHYwpFpliFcK/zwDAbqjBSDQRTfnePRvjbwa
         4VNpuxOaMkM20B1lP8iSdRk8NPzXHFX4lsv5lf+J84f46Dr/ZZb9EIeVMP+yE0ogvvjb
         Bd1RohWdL48UXgVpdxjFzHitsB1z7MD7SraXEQnYj3S2HIIpNyZRht3tx26VKqaEXp6R
         xScx37qOG7g8QlXr09I5mTPN1DYIjwsWqG3L9cCE85cod6qZfhur2m+2a6dEBp1cBk3F
         u/KaY4ax4Y1S1f7dwL39oH+WkHwaOmapdhgy07mgkft2PdnRE8DnC0h2hRSAU0gfrcxZ
         QrIQ==
X-Gm-Message-State: AOAM533sBgHlM7cAtkCCqXIb4Fy+iV3p5eInosJDxNtI7Xb9DkbcZETQ
        mPdUmmGyX8iGyQOaICEMQfHlpcpMtWlUmgMStdvpxL/O
X-Google-Smtp-Source: ABdhPJxYes8F7Qb1r/i3YJINI7YG/rb4qomsfvplGMIFqj0vdnJFvju0RA5//BY9POtWG/sxD3UxS/sxizAb3u++8Ig=
X-Received: by 2002:a50:9346:: with SMTP id n6mr3683387eda.365.1622799522509;
 Fri, 04 Jun 2021 02:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210604032957.224496-1-xieqinick@gmail.com>
In-Reply-To: <20210604032957.224496-1-xieqinick@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 4 Jun 2021 11:38:31 +0200
Message-ID: <CAFBinCCLn+H174oSh+U6ARknDn7LFgN9QMHRdN2L5oSw2bcafw@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: g12a: Add missing NNA source clocks for g12b
To:     xieqinick@gmail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nick@khadas.com, artem@khadas.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 5:30 AM <xieqinick@gmail.com> wrote:
>
> From: Nick Xie <nick@khadas.com>
>
> This adds the Neural Network Accelerator source clocks for g12b.
>
> Initial support for sm1 already exist in
> commit 2f1efa5340ef
> ("clk: meson: g12a: Add support for NNA CLK source clocks")
>
> The sm1 and g12b share the same NNA source clocks.
> This patch add missing NNA clocks for A311D (g12b).
>
> Signed-off-by: Nick Xie <nick@khadas.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
