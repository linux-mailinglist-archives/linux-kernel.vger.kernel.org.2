Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F5D3A8405
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhFOPdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhFOPdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:33:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F078CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 08:31:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 131so25695651ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pOcokHjn8C6eblfhNNWJ0wrgW2SVamVUGfojc7gGQjs=;
        b=swmvymsrhJ6L048X3+XStYbzujdk7jR5zt2V1M6/pTVdtObYp5LnqwfzCx0r99kO9W
         GY8NcGhwl/Gls7Sley676uGrVfa/yr87iknIs1gWqu07YJuYwqMaYDiHux/ZSdU6yM6y
         OGNrH26KrRzG9ftfskymNsZEV+ZJWfANr6n3SIvVfj0Ph23S6VZW4TS51eOzWsy9hloj
         ca3jKzYyMCAOofS3qUExqKEmH0QR80s4UeAQ4ZmCN38Q0AIt0lQy2hdhyATSkIUY1P6P
         AMvB1Uebqcl1hku3Dp4w3ZX9RCa8ksLeU57xBCQm3UBz/M3hJCQnJWGZWn5YoKXh+Xc8
         uiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pOcokHjn8C6eblfhNNWJ0wrgW2SVamVUGfojc7gGQjs=;
        b=kFIJwn2SqqjsGyb3x4HQhWeKfjKu2pcdzkwuRh1jDOuGpygIYP2exmRRbGnn61Iv+J
         o5SGrPpCLYD3hRzZa9o9vc8CBV2/p6mV8ZIs085Ner4rxl6HH68RieMgrVf6flUQ1OzA
         KU231cS+y5Ular/LU2uE4XP00jJKazISdY2MA6iXhe6uRhyTqenLXYyhyhYja/9TC6dv
         iPMTaS79ZcQ0ej3coOHV56DH1xVHr6fSfif5PTii+NiBNScoj0jxqicG8Gtj0IVesrdG
         ZjJSmzriWK9XJf4mCJC981eHVxKY+EQjv+h0NKqeSIrifIUjjDwMfpBtHYN6E+tUcY9b
         ZP4A==
X-Gm-Message-State: AOAM532Ca/cerp6P4JaenAIzn/xkm4utjf4U0k2I3dUGcd1boWyg+PJ4
        /nqcUIQJSf2PPDoXyHPBUox+jrEbUPUBI4Ii
X-Google-Smtp-Source: ABdhPJzfs0hjW6mrhnb0kSABzAozuBYwYUHvShyjT8JHAxKkozmbsrKr+yWYDxG5gwqAVxtNPmE/VQ==
X-Received: by 2002:a2e:9855:: with SMTP id e21mr152492ljj.295.1623771107330;
        Tue, 15 Jun 2021 08:31:47 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id z8sm1056119lfd.217.2021.06.15.08.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 08:31:46 -0700 (PDT)
Date:   Tue, 15 Jun 2021 08:28:40 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, SoC Team <soc@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        Mohammed Billoo <mohammed.billoo@gmail.com>
Subject: Re: [GIT PULL] ARM: mstar for v5.14 v2
Message-ID: <20210615152840.GD11724@lx2k>
References: <CAFr9PXnBb7OmOAMumDodC+0usWqRT-RXwC+YUHZ2Y43Xe_uTQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXnBb7OmOAMumDodC+0usWqRT-RXwC+YUHZ2Y43Xe_uTQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 02:39:59AM +0900, Daniel Palmer wrote:
> Hi Arnd, Olof,
> 
> Here is a fixed version of the PR with my s-o-b for Romain's patch.
> 
> Content is as before:
> 
> - Romain has stepped up to clean up some of the ~300 patch backlog for
> MStar and he added support for earlyprintk in the process.
> - In an effort to do things properly I've moved work on the MStar
> stuff from my personal github account to one for this project. So
> people can find it I've added a link in MAINTAINERS.
> 
> The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:
> 
>  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)
> 
> are available in the Git repository at:
> 
>  https://github.com/linux-chenxing/linux.git tags/mstar-5.14-v2
> 
> for you to fetch changes up to eb5e7693630c6039d040e428840be82b7e3a8614:
> 
>  MAINTAINERS: ARM/MStar/Sigmastar SoCs: Add a link to the MStar tree
> (2021-06-13 02:12:18 +0900)
> 
> ----------------------------------------------------------------
> Daniel Palmer (1):
>      MAINTAINERS: ARM/MStar/Sigmastar SoCs: Add a link to the MStar tree
> 
> Romain Perier (1):
>      ARM: debug: add UART early console support for MSTAR SoCs
> 
> MAINTAINERS            |  1 +
> arch/arm/Kconfig.debug | 11 +++++++++++

Hi,

This time it seems like you based your branch on 5.14-rc5, which is a newer -rc
than what we have the rest of our trees on. The general rule of thumb is to
base it on the oldest meaningful rc for the release (rc1 or rc2, most of the
time). We normally base our tree on rc2 or so, in this case I went forward to
rc3 earlier.

(Maybe you had the same base last time around, and I missed it -- my tooling
failed out on the S-o-b checking before I noticed)

To avoid another roundtrip here, I'll apply the two patches directly, but
please keep it in mind in the future, especially once you have more material
for a cycle.


-Olof
