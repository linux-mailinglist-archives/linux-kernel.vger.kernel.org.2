Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065773716BC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhECOjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhECOjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:39:16 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E35C06174A;
        Mon,  3 May 2021 07:38:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u25so7047493ljg.7;
        Mon, 03 May 2021 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8Lo/WV2kqFhxQmXMHoOoER7UABS1SQ9sbACXw0e9is=;
        b=SJVqh+Z+OOiF0eEClzig7q1IqMClVMdQXArdRsKp08HSucCJa5qKqrMM/s1ENu9fn9
         tcr0psvLbXLq0P//8qG6nHuP/MP2vxRkNWV9xESQgdcBY3HBR2wv6qu5W8CGp1l1iWa8
         XrI5IMABRULUPCpkqAgXSBJREOwCV7AUUqbP/tlsJktDA4Mbo98xlU31+6A9ZCUyOHAT
         1Myy6Wnrwe3sx9Jz662PCZ7zLePWu45IkvB6HaDSwQMf/52vAnnwLv5Sr2ylTIw8215f
         wE/YUf+hAanbr9PAT3nyG8gU8bYXU5ieya8S3RYnEsPQwU/ZHW069DEyY1d0+ld+iisu
         rWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8Lo/WV2kqFhxQmXMHoOoER7UABS1SQ9sbACXw0e9is=;
        b=UnUfC3Bg6xO8rZ5ij1OOU5TX2OlGCCzBNtZxvyjdgfHQ8+YQXUmCL98zmYtLuYze0N
         o5xeZsYJ2jjXqU/wu5sgf0oqW5133wgijmccJMrz4oOqn2aSU1pMIt3wSoL27wmH9EKa
         kQkpq8ip3MnZIhHXyD5uUwFWfj87ZnFAUnuFRw7XbR6QVmRD9WR355MTXUgTXB69ymEh
         MaM7+8m88PmspqMlfHRh8tZdDWatpzpmVHetPLavHU5twSDYyWdz+DKm9DuCINY0UPwi
         lcUwIXwVIDzxrBLUyej15IPdjy5dvF3LCqHvx/bUpRPHkshsHSDrJfEEAQGMjL4tbLlz
         SScA==
X-Gm-Message-State: AOAM532FtBym3wrFM0WT5dW4Cm3ysmTyrkX7aRKtmlqC+zU5lMyq03FH
        sS5tlLk4sp8uhNIgXOZLGZNL1cq2S/KYd+0ylxo=
X-Google-Smtp-Source: ABdhPJwEv15x6ptc4fw/EL3SVKCJQyLxbmWTUsNm9n/jfWwYLjJol7TNNMSgufqERwbFLixHUPWvcNlUDOisAnMhlhQ=
X-Received: by 2002:a2e:5745:: with SMTP id r5mr5404608ljd.121.1620052701541;
 Mon, 03 May 2021 07:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <1619664627-12470-1-git-send-email-shengjiu.wang@nxp.com> <1619664627-12470-2-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1619664627-12470-2-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 3 May 2021 11:38:09 -0300
Message-ID: <CAOMZO5A3-GjEv_U4RmQXz__s=SmHkkJid-DXxr2Om6pB6_imAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6qdl-sabresd: Configure the gpio for hp detect
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Thu, Apr 29, 2021 at 12:06 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:

> +               pinctrl_hp: hpgrp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_SD3_RST__GPIO7_IO08          0x80000000
> +                               MX6QDL_PAD_GPIO_9__GPIO1_IO09           0x80000000

Please avoid using 0x80000000. Use the real PAD_CTL value instead.
