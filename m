Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198773E4E64
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 23:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbhHIVYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 17:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbhHIVYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 17:24:42 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB564C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 14:24:21 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id e3-20020a4ab9830000b029026ada3b6b90so4780671oop.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 14:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x7djV8cU9LbMV7kajT88pgm0cyo38YSmnH16cnh0+6c=;
        b=IQnIucvNHK0pfJNN2pnmEFU/wNLWyA3Qq2owDANrdlt2wnUmmlqmJ0h0UzI5GV53Xj
         SmkwwalgbcnonkWR2ftVHdWq6N5PvSo8LlW2U2q4z6uZbJefgvN7lGVojUr4edep6OW1
         P7RW6Su7ZYx3s8DWXw1RQRIJYFZu4e7KY9qfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x7djV8cU9LbMV7kajT88pgm0cyo38YSmnH16cnh0+6c=;
        b=KFiQst5bWaqYFI79gevh7MHTdPHiNcxRhMdkblmtgnLW4/Vbq/oT7x83ksKTBNmYHj
         WSKwGN1EAruAi6j/j/NFPhD1bmgVfA3EyMl25Bd1uEBslqKiTloUY5C5X19nESrrHN2+
         NGF6uNwfQ//nWokQlWnaW2yLva89HjAgtwg17eTbAWRG0HJOF+w+uq2l8sCSt0jTq7Vb
         67zd9wKG94Hd1E0Ip9qAW2lcpD2oYhurcp+Dk8jZIQ3zCQd4MbkoUWRD7zv69/I4cgkz
         GNKOi8uODvaqtZD9SoQsdGi/MIG5E9ApqTdMsjQ1tyFiTRum0vLBpEFm2jHbInXu/cUA
         1czw==
X-Gm-Message-State: AOAM5330uphiyuqL23d+eOZIykonmrASzYK4H+YlN7ERZEgEA+3HUt6z
        00Qb+T/z4eCKMH8Y9VNCLd12SgK8rjjZsw==
X-Google-Smtp-Source: ABdhPJw35KeFSqbLO0+gb80gRk+R8hv0hLj+U0FHQh773ZX2/Q8SopoLeqsamiEIKjf3suIEEQw9Gg==
X-Received: by 2002:a4a:2c96:: with SMTP id o144mr13276227ooo.50.1628544259695;
        Mon, 09 Aug 2021 14:24:19 -0700 (PDT)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id p8sm3260209otk.22.2021.08.09.14.24.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 14:24:19 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so4764539oos.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 14:24:18 -0700 (PDT)
X-Received: by 2002:a4a:4c55:: with SMTP id a82mr16548740oob.66.1628544258286;
 Mon, 09 Aug 2021 14:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210809211134.GA22488@embeddedor>
In-Reply-To: <20210809211134.GA22488@embeddedor>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 9 Aug 2021 14:24:07 -0700
X-Gmail-Original-Message-ID: <CA+ASDXO+GbP_WWVdO0=Uavh036ZhZiziE8DwGRKP-ooofd2QVw@mail.gmail.com>
Message-ID: <CA+ASDXO+GbP_WWVdO0=Uavh036ZhZiziE8DwGRKP-ooofd2QVw@mail.gmail.com>
Subject: Re: [PATCH][next] mwifiex: usb: Replace one-element array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 2:08 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use =E2=80=9Cflexible array members=E2=80=9D[1] for these c=
ases. The older
> style of one-element or zero-length arrays should no longer be used[2].
>
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
>
> This issue was found with the help of Coccinelle and audited and fixed,
> manually.
>
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-le=
ngth-and-one-element-arrays
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/109
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

An important part of your patch rationale should include determining
that the 1-length wasn't actually important anywhere. I double checked
for you, and nobody seemed to be relying on 'sizeof struct fw_data' at
all, so this should be OK:

Reviewed-by: Brian Norris <briannorris@chromium.org>
