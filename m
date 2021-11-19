Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A7C456788
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 02:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhKSBp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 20:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhKSBp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 20:45:57 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D14AC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 17:42:56 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r26so18554448oiw.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 17:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+4PtbwP22GNL58EB2Kn0kBSekJZJrlBoC1EpDbCbXg=;
        b=IVpsHQisSXq61n+KCFmaFVTIZs1m7P8sptH88Rs2nCWyy05xN3D5zLggCYBoSoA+0l
         u7fcIUffkGErYpwi8Y3XHROuyUIsWALMQr5rqYfomny0130g5jsmqlK2y1NvQ2SMD9gQ
         ZWCyuZF6T+AUUWS/dQpyOovCAMnpSDbrezyWD2zyo5Eh3qjK/7Bl/65Y73GuXE0LngfN
         wdih7bwfGmPzfsEkdR5CQSc7llv9dtBiDwvvW8+9A3TUTvREyPh4+6iciM9Gpt/BXr2C
         d2R9FHaiAMfDTOUN6iEDX6lC8sX7K3olLhiiRDKeX/1I9SbrKt/1ceST/AfOyhCSB32R
         ECbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+4PtbwP22GNL58EB2Kn0kBSekJZJrlBoC1EpDbCbXg=;
        b=lSF7W9Lc8yZxd7cR44dYlFbFEFac+kM59UT5eNcIlYsiQ+q/rdc9jJ2tzdO4XimpYx
         iJ+FD00NNfw8y9AvbA+aMiCFlow0sNR+qSxqg+f8oQnNo3TxUxt/ER9UEhn3qHBZoh5u
         164TWZY1IDTpv/eAmfvZ8i3Oo88VmZNTn4EXFWa9ivnzq2Z6woRw+fNItZ7V7WUg05fk
         lupxe0uQjXL4Vr/jeF0xl059AU2w/q8HkWSHuCn/AbjY91jHM8/bXnnnTLPmznyv3Tkf
         N0msMx5yBTI1BGS22h3ozJhFTKAvetHSvwrAmuCC5zrxXR2Stcy1SJmTv9gD8arSm5YC
         2T5A==
X-Gm-Message-State: AOAM533pGveW0AFrIcxqxKSVVHeUykLWjQ3JwcWM6ox2rpknCPhjlenz
        OfwGC0ELuKVC5rbClPfS6hfAkOwqYTScYyXO+0JLIw==
X-Google-Smtp-Source: ABdhPJyivwAYVdXUPMbQ2Y5VnZ8qk/PZC4e3Bk2bhJcLGXxX5foQprxJzFpUAszMwIztcuhdwXgdbO39GFXWDz6eZ7Y=
X-Received: by 2002:a54:4791:: with SMTP id o17mr1587886oic.114.1637286175950;
 Thu, 18 Nov 2021 17:42:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com> <6645a55c05cf12954f97347ade1cf47ddf62bb86.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <6645a55c05cf12954f97347ade1cf47ddf62bb86.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 19 Nov 2021 02:42:44 +0100
Message-ID: <CACRpkda5YunVXZWp7dnY0qiKMXHSs4qviYuLVh1uc0jB9aaY9A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/9] power: supply: Add batinfo getters usable
 prior supply registration
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 1:26 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> In some cases it is beneficial to be able to query the static battery
> node properties prior power_supply registration. The device-tree
> parsing does not really depend on psy so add APIs which can
> be used without the power-supply. Also, convert APIs to operate on
> fwnode while at it.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

This looks quite useful!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
