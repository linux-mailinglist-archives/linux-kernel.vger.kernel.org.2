Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E90636A135
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 14:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbhDXMom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 08:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbhDXMoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 08:44:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED20C061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 05:43:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q22so18989268lfu.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kmejogR1ua3kAZAPWIQWCYPtuWPJkipEf0JrJfP0hZg=;
        b=dwnNwxf1KAU7qSW5U6/sZxN81GO2HMH9kHLtgD/sj2Ntnm9cVhgq+3KE4q5iLSTRDH
         bigKrZJjcUAo8ce5bHfW1vN2Wseh+fMf9UPoRGjGK4dTi7M9unW8VFZVs8VWy/xgvbIe
         Eges5vwYFQpkeVaL9cuShfXQEx9G2i+et3aZLWi+LZIZ2SYyekWb8+wBopQ7s3qjJPTT
         vT8kl/gxRPu4GTuKIeGfz8b1DZsz3zLaD1+GO9RsFneqz5JGaUUUogaF8xIQEGK7TReT
         er22O8nUiv2Cn7Cfh0Rbc1nwJgW12hIdUANU28aJntbwzKfr44ODrKsPENdD4uXrBFHY
         9evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kmejogR1ua3kAZAPWIQWCYPtuWPJkipEf0JrJfP0hZg=;
        b=Omj+zT3n9Y0XYNeExxip11L+rz5N1nwRma8ISQF+JcNI57l85c66Xn/Vrx8L1TvnQ1
         NdtndnvEsGPiY10pX9ZuoB0LW7ViiNfz3xZZKI8USS5DPsK3WBJYnZucw7UL7GgXP14C
         3qzYSurIbBROBxSDOTiG0Dqbpzzxu1pzUMtLZDRVuEIM/jjiav5io4xHAaBpkgf7ACep
         7FFpt585o2PM9TJNH160a+QuwPiN6/ywuv8RWk+nhXgAkFqqDqqsR7N9cw9LZCAoL0se
         du9ZkECu1HzCMU0xqLGnfEiiBgLNO+Sx5R7/u/2TfA2+/7ey5U5PGkOsUWKexmG5QiPL
         qhdA==
X-Gm-Message-State: AOAM530HzT8D6ncZecDZzR9DNLBh6WpLHQlhsr5u32JZfinbcbKvZGMQ
        qP02JfRLAjJXL83TfQXZNVgHZ57K14HSWWddcmM=
X-Google-Smtp-Source: ABdhPJwoAMvQa4szecNLkaR64GsEhPifdDetSzdKBbHkjjsJ7rZzTB0Oh5+z8E7gjmvWcLXT6n4Mzzqnm29m8BuDznI=
X-Received: by 2002:ac2:5297:: with SMTP id q23mr6117770lfm.229.1619268233484;
 Sat, 24 Apr 2021 05:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210424123729.578295-1-j.neuschaefer@gmx.net>
In-Reply-To: <20210424123729.578295-1-j.neuschaefer@gmx.net>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 24 Apr 2021 09:43:41 -0300
Message-ID: <CAOMZO5DjYQYjfLb4Sn496-inV9PqVG6C4YVunxLxTYa93_DbpA@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: pm-imx5: Fix references to imx5_cpu_suspend_info
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, Apr 24, 2021 at 9:39 AM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> The name of the struct, as defined in arch/arm/mach-imx/pm-imx5.c,
> is imx5_cpu_suspend_info.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Good catch:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
