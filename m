Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A264548AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbhKQO2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:28:50 -0500
Received: from mail-vk1-f170.google.com ([209.85.221.170]:45656 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbhKQO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:28:48 -0500
Received: by mail-vk1-f170.google.com with SMTP id m19so1722507vko.12;
        Wed, 17 Nov 2021 06:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=lgl9BpbsUud0C8euZ8/m/mBaucmePFOdUSvOyanF4Vw=;
        b=gAogHr5PMulo665onOuhjzOo0GKmkfwifsNcPwxi9Tk2B18vxn01C0eYx8CfwEvix7
         fwmH3T0Z6PiFhtMXvYPJ9cgyMC631RDP01Y3aGMkhMCwxeV9BcleCQM3pzPxebxXYnPj
         Bcf6gk0iObxVTZ1KQgTWWSBPOBJpWt21mmTSpG7wVB9KD6DCEFJMH+hhFtfk+Xy6wWG8
         oYw5524Fbr8P3b2Z2gb/ah9H16bY9u/aishmzgzXRz7whGNYRhuhwspXotREamy4Wrre
         GRKEYVMz8fpyLweWkkjNVbdmzywl5WPp+3xYEeBslug6c+rV8yHaZg4XTl2NieRRylOj
         L0EQ==
X-Gm-Message-State: AOAM531ZxHDQWMIRE3KRRLFn9CWm7CDMicium3pORnc0YvGW0u2Wl5Uh
        XSb8d2fe3NyrFupBnp91AsbfnbVwC6Z2Yw==
X-Google-Smtp-Source: ABdhPJxxwFlO1c5VGguxVtSIT6faUBymOb879t64G5w9bFLbdj84F4QlCJWmeLFBT3mK9884zVZKMw==
X-Received: by 2002:a1f:e287:: with SMTP id z129mr88015912vkg.17.1637159149858;
        Wed, 17 Nov 2021 06:25:49 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id t11sm8698347vkt.34.2021.11.17.06.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 06:25:49 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id b17so6440703uas.0;
        Wed, 17 Nov 2021 06:25:49 -0800 (PST)
X-Received: by 2002:a67:fb41:: with SMTP id e1mr51636446vsr.28.1637159148368;
 Wed, 17 Nov 2021 06:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20211117140222.43692-1-robert.marko@sartura.hr>
In-Reply-To: <20211117140222.43692-1-robert.marko@sartura.hr>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 17 Nov 2021 22:25:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v677JvkwZnp+3ST0UNsOWLnzT2QfmYAq22t7T03AVuOSzQ@mail.gmail.com>
Message-ID: <CAGb2v677JvkwZnp+3ST0UNsOWLnzT2QfmYAq22t7T03AVuOSzQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: allwinner: orangepi-zero-plus: fix PHY mode
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ron Goossens <rgoossens@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 10:02 PM Robert Marko <robert.marko@sartura.hr> wrote:
>
> Orange Pi Zero Plus uses a Realtek RTL8211E RGMII Gigabit PHY, but its
> currently set to plain RGMII mode meaning that it doesn't introduce
> delays.
>
> With this setup, TX packets are completely lost and changing the mode to
> RGMII-ID so the PHY will add delays internally fixes the issue.
>
> Fixes: a7affb13b271 ("arm64: allwinner: H5: Add Xunlong Orange Pi Zero Plus")
>
> Tested-by: Ron Goossens <rgoossens@gmail.com>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Tested-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
