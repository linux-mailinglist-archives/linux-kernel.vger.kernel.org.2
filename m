Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240DD3301D6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 15:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhCGOEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 09:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhCGOEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 09:04:12 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC978C06174A;
        Sun,  7 Mar 2021 06:04:11 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m22so15127306lfg.5;
        Sun, 07 Mar 2021 06:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rf8qjKCOo4M0wP6NGEwtILnQLiGVv0BzHJQUDiTjqYk=;
        b=Vg6rIYnfWJB1vd+t6CiYOWEGOfO6CUZuEEIlpCz32FyhLoxYSIWjpb9Nm/klSO4Xxb
         jlINdc38r9My3SbbpSVuAEwc3W9RYXukA05/JcVKDWcnSJ9zzKgYKtanpJ5bk1WjKqDm
         uTSTyzymlcPazUjXI4ZFD5J3zL1v0O25gQW4Xs+bOZdAwinmp06g+WgxxVfxWmtG6pad
         YhDGKIPuvU/7xWjytirXczof5qmcHA6tRBU9zDE0CSjWOplRz+35UKvbvqU0e6+idVZp
         OuUgwNvS4LqY5CIMEL+KGwEQEP1uWDE21eBN0DKmSWpveJtONSoLmh1dGfGDfv15p1Nz
         NmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rf8qjKCOo4M0wP6NGEwtILnQLiGVv0BzHJQUDiTjqYk=;
        b=DCaMF1hcWAFabYshNdl4SSMBopTrVUPGuT879UFmlpumo3UIjXpo1q84JCCqrtP11F
         XIkIAKzX9xychbM8Ug/8U/gqODl7OOWuZzTOxrc+HLqQ8UCM/1KTHQ8wI68MMEsiKjTN
         1MVVrfAozYz9zwjFKEjI4EUdINuJ9326hq1cNSyUwWJXis/J2s85M6q3nF+s9TU9IED8
         RYWKNAJCpEabTgnG+tP8l2XN7+KXnizF+1qVC4V8c7xAKdMjbM5+/2wPVhK8UPzMqw1h
         UfxDP7lDVbzpWfTvjrhE1b03a6ibfwc79qFHSQI7vOQRwEAhSW2pdHoIzy5HE8LwpQeB
         2qGw==
X-Gm-Message-State: AOAM533v84HcQv6VmXFxofp1EAbC97SXCN6LyRlx3PzBa4PoqD7/hpgE
        eTbDzAtLQR6fRY+idnG5o8Aq/D2vhU98z7C/4t4=
X-Google-Smtp-Source: ABdhPJxSm83zB6Ds1ptab6Xa/77LCA/jk7L6/lEQJuc5u0mTW069vK8OWXSNFWCwRuL6in0qOGkcW5+5CzkD4HbYmD0=
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr11211119lff.443.1615125850227;
 Sun, 07 Mar 2021 06:04:10 -0800 (PST)
MIME-Version: 1.0
References: <1615113003-24612-1-git-send-email-peng.fan@oss.nxp.com>
In-Reply-To: <1615113003-24612-1-git-send-email-peng.fan@oss.nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 7 Mar 2021 11:03:59 -0300
Message-ID: <CAOMZO5Aa4EdUMXEqHd_W-ub7sH2SFhWpA1XZe6cdk_mHj5QUuQ@mail.gmail.com>
Subject: Re: [PATCH V2] arm64: dts: imx8mp: add wdog2/3 nodes
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 7, 2021 at 7:42 AM <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> There is wdog[2,3] in i.MX8MP, so add them.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
