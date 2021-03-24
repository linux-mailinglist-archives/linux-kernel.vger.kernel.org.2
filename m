Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA8E347227
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhCXHMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbhCXHMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:12:17 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3465EC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:12:17 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id r8so20493813ilo.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=wtPwCRqQ8DPy9FuKHe/XAab8ekCGoek7d/MJtDY4qNk=;
        b=sF5oy0TCFrN6GbnafaPoynvj46/ukx7ac8iVs2cJJS0ILW5xLBu5WYxnCAOcPZben0
         YBkvHnpR7AC11d3WXl1miZ/yY6TOIpOfZh7Z9nKCBRRBIQqHFPEjomZVnNJ/HprAbnm3
         oKO3ApGtNyF6Mvjtg848Q7kfT3+4NNMu+3yFmPPn4Bs0esS7ivgBpbfeyC3lOxRQeHvP
         CbHxavB4Uk0oz+CnlIxemHGLT4h+Mi5c/kiHa45XI+va6jcQO03UOOfLgxL+f3tXy8Bo
         jTfla3fWn3FedEDBamEwyvtE59ciK26jIbjdw4I577/8sdGu2PH+P//undkiqpRgLYIE
         33UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=wtPwCRqQ8DPy9FuKHe/XAab8ekCGoek7d/MJtDY4qNk=;
        b=aMnDTADqXhSSDZTz/cdgbpq9WpZULlrWinfUXN0ovb+seXRULWVrbl5G7OSzmESoGL
         XBeorsiJTD2SMFdCCIZi6EYn/EW6njZXkMV49gdR+E1k44Bb7S+SwtJMq4KxrFoDGQ54
         k+keRJCl0e0yz5hkidE7pTcHjImXDW1O1Qli9xOzuj2J6QXOfKQz0nXb3ganXu1PtGRv
         BVJcFMfZGxDPsBSKg7F7GieNjXgv/NRfYscoUMN+ih+skacJmF+3oWs/MpWgPySbZhAH
         1ZQpJoulxSk7BMBkRqIkus3/wgi9TQ0EIDDlM8BB7Zo5K51x0kgu1PgaLa8yl1Ley6sJ
         T/Mg==
X-Gm-Message-State: AOAM531qcBmZQuXPIomKAsF7qL8KRM/eaRn9UB76phMR8YTDx5aBtXjV
        EONGAdaTN/hDcUNTCHYJcrMDU1b+fSlqniZnu7ARZQ==
X-Received: by 2002:a05:6e02:156e:: with SMTP id k14mt1479077ilu.200.1616569936401;
 Wed, 24 Mar 2021 00:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210308171049.3962577-1-gmouse@google.com>
In-Reply-To: <20210308171049.3962577-1-gmouse@google.com>
From:   Anton Kachalov <gmouse@google.com>
Date:   Wed, 24 Mar 2021 08:12:05 +0100
Message-ID: <CADVsX8_e9GNeceV-op5HwbxEnzUG_68izC11K=g46YWvCZE2Ag@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: nuvoton: Fix flash layout
Cc:     devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gently ping

On Mon, 8 Mar 2021 at 18:11, <gmouse@google.com> wrote:
>
> From: "Anton D. Kachalov" <gmouse@google.com>
>
> This change follows OpenBMC partitions' naming layout.
>
> Signed-off-by: Anton D. Kachalov <gmouse@google.com>
> ---
>  arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 38 +++++++----------------
>  1 file changed, 11 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> index 9f13d08f5804..55c5a89592d7 100644
> --- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> +++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> @@ -78,8 +78,8 @@ partitions@80000000 {
>                         compatible = "fixed-partitions";
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> -                       bbuboot1@0 {
> -                               label = "bb-uboot-1";
> +                       u-boot@0 {
> +                               label = "u-boot";
>                                 reg = <0x0000000 0x80000>;
>                                 read-only;
>                                 };
> @@ -88,38 +88,22 @@ bbuboot2@80000 {
>                                 reg = <0x0080000 0x80000>;
>                                 read-only;
>                                 };
> -                       envparam@100000 {
> -                               label = "env-param";
> +                       u-boot-env@100000 {
> +                               label = "u-boot-env";
>                                 reg = <0x0100000 0x40000>;
>                                 read-only;
>                                 };
> -                       spare@140000 {
> -                               label = "spare";
> -                               reg = <0x0140000 0xC0000>;
> -                               };
>                         kernel@200000 {
>                                 label = "kernel";
> -                               reg = <0x0200000 0x400000>;
> -                               };
> -                       rootfs@600000 {
> -                               label = "rootfs";
> -                               reg = <0x0600000 0x700000>;
> -                               };
> -                       spare1@D00000 {
> -                               label = "spare1";
> -                               reg = <0x0D00000 0x200000>;
> -                               };
> -                       spare2@0F00000 {
> -                               label = "spare2";
> -                               reg = <0x0F00000 0x200000>;
> +                               reg = <0x0200000 0x580000>;
>                                 };
> -                       spare3@1100000 {
> -                               label = "spare3";
> -                               reg = <0x1100000 0x200000>;
> +                       rofs@780000 {
> +                               label = "rofs";
> +                               reg = <0x0780000 0x1680000>;
>                                 };
> -                       spare4@1300000 {
> -                               label = "spare4";
> -                               reg = <0x1300000 0x0>;
> +                       rwfs@1e00000 {
> +                               label = "rwfs";
> +                               reg = <0x1e00000 0x200000>;
>                         };
>                 };
>         };
> --
> 2.30.1.766.gb4fecdf3b7-goog
>
