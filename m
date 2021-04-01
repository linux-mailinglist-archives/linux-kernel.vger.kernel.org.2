Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA01351924
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhDARtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbhDARjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:39:37 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB7FC0610D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 05:33:06 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id x207so1626709oif.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 05:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bYBBXqXjqIEWJW+a8G61y+9V36oyZ8bqWDrWT4tmnlc=;
        b=Kg+n6DGxQjSdU4ERhysXZ45Lu56R/0K+pTJJpe7815cK0Mtt660ipOl4qwNPU4lcta
         D4Txr9k1sgImDF7ualRrC8EbqCfmkPSUJ77tRSvAVuybaC8ZFEyy/R1YoD9KeMWsD5Pf
         Va4I7+ZprD3HxQ38wydSNIyjUhtkGpZ5tMGHOAbBD7QkXTT1ml+30AJ7lVEouAAqkuFO
         cUZ/MWeqUnCB3VRNPawpvLBIaN7SP5j/o/91ArNzAYd9WNfyw8mb+LXdkN10bEkAsJH0
         Ypu6ls2y57tvLHQLdxKEXAQlfFU+8Q7KGg2Faf68A348V3OfZOfapnu9I3ShOmnGCslj
         RloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bYBBXqXjqIEWJW+a8G61y+9V36oyZ8bqWDrWT4tmnlc=;
        b=OPBRhTqbLGvFfk/wAUf/ubmTi5fgy7mhYvrvyVQXdquzxyyuBzfRr09LtRtDOC5yAS
         UHctUChiHMeDQDRXIx1Oo0mmPww2tbnWWNxiPHDB8MBEELlNzcpb1F7q3zN+Ma/fxQ2W
         ciH6cz6INnDeDZtWgOrBNQ0xEDD/5zti+aLAihMu9wU1BtL1ASXR24iPsRBB76WQHCdW
         D9VxDN4YYOhwoQfiLvHSYIqBPGGOR/LHWE3Bzm6fuomi67koiiT1Bkc5ZFzRxC14aJd/
         vZ7CBb8aBlKXONba4/l2GgS5/iJXpqZLuR7/r9t6z4Zg27na7W91ljWg3eHSRzxKF1c6
         kuWw==
X-Gm-Message-State: AOAM531UpSFNoZHgoJt0PpEtTl2nR6R6Ajuh0kiMSOpDgN/kIZJZTRvx
        4GrcHZJJtLySyO98/vIx8aexqP8BnUZe9iRSpjo/zg==
X-Google-Smtp-Source: ABdhPJywnxWEEjMlE4aBIUeotkDIUC9+UKYA0hL+/WDzMmkmPSd5/pgY/hKusGxY9ewHKyLtBan5czoqJBH63756PxY=
X-Received: by 2002:aca:7c4:: with SMTP id 187mr5765643oih.47.1617280385522;
 Thu, 01 Apr 2021 05:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210330082208.GA965793@jade> <161727243793.583633.7984995735453542553.b4-ty@arndb.de>
In-Reply-To: <161727243793.583633.7984995735453542553.b4-ty@arndb.de>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 1 Apr 2021 14:32:54 +0200
Message-ID: <CAHUa44Fdvhj2ca4O+CxD94YZ6BtzNut9HMn3FxDshh_vgHVwDA@mail.gmail.com>
Subject: Re: [GIT PULL] OP-TEE tracepoints fix for v5.13
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SoC Team <soc@kernel.org>, arm-soc <arm@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 12:23 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> On Tue, 30 Mar 2021 10:22:08 +0200, Jens Wiklander wrote:
> > The previous pull request for OP-TEE tracepoints introduced a build
> > error when building whithout O=..., apparently many regression builds
> > uses that option.
> >
> > Please pull this small fix for the build error.
> >
> > Thanks,
> > Jens
> >
> > [...]
>
> You asked for this to be merged for 5.13, but as the change is clearly correct
> and required as a build fix, I added it as a fix for 5.12 instead, hope that's
> ok.
>
> Merged into arm/fixes, thanks!
>
> merge commit: 3e530f89d72dd1ab31e20d6f8567e357b928705c

OK. Please note that this pulls in 0101947dbcc3 ("tee: optee: add
invoke_fn tracepoints") (the commit just before actually) which I
believe was queued for v5.13.

Cheers,
Jens
