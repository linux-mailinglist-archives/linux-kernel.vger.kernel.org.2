Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4A73479BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhCXNiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbhCXNhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:37:46 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C8CC061763;
        Wed, 24 Mar 2021 06:37:45 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b83so32009379lfd.11;
        Wed, 24 Mar 2021 06:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IL5kwDSryJAVi6JEN0sFtKcKcm1GU6ESrLzLBduwMNM=;
        b=UAxBKj2xpmkGpMklipBQXcmGNCHlcldt/VmwdLzhIXoc3bICW4snghhzXUkaZXKDD/
         lUb7COhUBMLGn/zmOo24BD+KRD3j5uII37PcfeGCKFDxMJclIgDHihhlGujeUQ5v0sgz
         nSfS7MuuXSzbiYmEo7Td5gvRElZ7vky3SLuGwvMLQIeqw3af0aLXPpOdcRcuQZKInRfc
         Esz1RIjEqkFUekID4cvq6ZcVEE4NrYGck3H8zF4pWQ3hUa7+fZi0CIcK3iAAui8bgpni
         gQwLMSDPdDp/zuCCkyGjB/au8DBD+19bRPzEcUm7xVRzjEMDqcOW+a3HKAwReZXTW5B5
         g53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IL5kwDSryJAVi6JEN0sFtKcKcm1GU6ESrLzLBduwMNM=;
        b=ldbHShj6woW/H4SiMBEwBhqERVAtWyL0mrg4Y2doD0XWSggXsAVvF90eViUEoHnM5H
         eNaxkjG0G53lSnBMdnC5DNWiVakQ4XsRSkeUupm/0f0Y71+w3JeC7z/yO/+LyY4v9WC9
         AWcacyPLlrOydZYudVUff2UAAFwGkmax7p77tVklaFyKsKXkhjxsjPJ/SXDLaDW3HAaO
         cxsbOR7L0rQriExINm/Av2xeCWQoSds8YeXFRoFj1tcGPKT449jtzba8C+VyGbXbj3xH
         1IyvjCZmZhiDMdvuqMDhGutHQQoGF7ml4yv6HqTEqqJhtPQ/i7fteJpdUXZOww8Bnu2J
         OdJg==
X-Gm-Message-State: AOAM532m0taKKgBB0sQG8avoZDFC5y+T+6L4yjTQBNGuOlWek01NtRPB
        PuqFCFQ9Jh6iJCvwtuGec28KhTr3Hw+z7fDXwUE=
X-Google-Smtp-Source: ABdhPJz+P0SCzJkREvgOevDYLFGIm89aZAHw2nkzz74pY0wJV3IvPIXGZ4B8riBSSCq3ajuhNXH/bePGm7XzX3gw8kg=
X-Received: by 2002:a05:6512:b0d:: with SMTP id w13mr1945800lfu.500.1616593063661;
 Wed, 24 Mar 2021 06:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5B_uHS_Z2LuMwHDmn9erORrsrNBMHMjkW-hW+pnfHZThQ@mail.gmail.com>
 <20210324132841.5841-1-oliver.staebler@bytesatwork.ch>
In-Reply-To: <20210324132841.5841-1-oliver.staebler@bytesatwork.ch>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 24 Mar 2021 10:37:32 -0300
Message-ID: <CAOMZO5CP8Hrqgyc8VEkNqam-PoSteZ0=RkWpgOwTbZWokb8r5g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mm/q: Fix pad control of SD1_DATA0
To:     =?UTF-8?Q?Oliver_St=C3=A4bler?= <oliver.staebler@bytesatwork.ch>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Wed, Mar 24, 2021 at 10:28 AM Oliver St=C3=A4bler
<oliver.staebler@bytesatwork.ch> wrote:
>
> Fix address of the pad control register
> (IOMUXC_SW_PAD_CTL_PAD_SD1_DATA0) for SD1_DATA0_GPIO2_IO2.  This seems
> to be a typo but it leads to an exception when pinctrl is applied due to
> wrong memory address access.
>
> Signed-off-by: Oliver St=C3=A4bler <oliver.staebler@bytesatwork.ch>

Thanks for the fix:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
