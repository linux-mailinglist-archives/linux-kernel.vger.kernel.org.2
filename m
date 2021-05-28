Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168D8394277
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbhE1MX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbhE1MXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:23:43 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D507C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:22:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id v8so5024156lft.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bk0m802/txIOgvae+cWm9NwKB9iJgroWnhYgWbXTbHM=;
        b=uZYX5efiBfbqe9deNaH8OSrHaPyp/3zfNu9Xu2VJyxF0/fpbpv5mTcm5J1PCZ2WNXA
         xgEtO1D5Y4vr/baSHwg2wH6MMMxTI09Crk1Kfyoog/xeT9s7LCCPdwsjlI0+mTXWtDDj
         DxAMoMq/sLPorhV/iQpqyPBftTSyyHYQ9eikfnGWlIpZGu/bX7Ur+NajtX0jqUZKcvIV
         hVA4DAOLPErhRHtdHySckDOqq7Cj0A+eaNF6an66PZL53v2bDnggC3VYtgTKPlkB+RJN
         jab8kcoiLU/SHTLx54CbM5J+CCd8eHTkdG2fOO8vPAI0MeruE6JpIMwk7ctYg9ylaTLD
         cr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bk0m802/txIOgvae+cWm9NwKB9iJgroWnhYgWbXTbHM=;
        b=hTRHdlnbeDtjHSO789z2G7NpTjCiS0aPsS3fTxvhyogTkQnkYP+c85dx/Zm3OoGk28
         5CZatKca5WVUPISKJ99bOF/oaiQB37A5ZCTu/gXZzy16DPZyuQCGSgUp5rCy4Z0YNiIm
         QxNhiP8NUUM+EK8n+W99pP2EdQez/vgo7BIkU9k/nomXTFEarUSECb7M833mzK4HPRv3
         3xClqegZ2a5ZuzeJi7nH1lzb0v0BDw3ZkadIUk2nEdbnsCd1HK8pAhdkwO86xbFQQN1g
         KSpIIo99OvFjGmfBbS1+r+1FSf7yIAI95mkJ65X+Yfp1K5AmDLoOCK4Z4wm3KzJafiHE
         1SRA==
X-Gm-Message-State: AOAM530g67N2947iLCqOwNwKP8eZ5s4Cth68U9lxGWrsxGiQ4c1Wy264
        kVLpZDFYSnuIWJzQwB0BsJ9l/fU4DRHNpIi2kciXfg==
X-Google-Smtp-Source: ABdhPJxH0GojF39Uo7jtHHtmhJg71ZvFQdGsMIkprWcD0s3bUzRGVAEEYNkmzi9DuTv7Bn62PffErdbjEsr/x6gmN8Y=
X-Received: by 2002:a19:f616:: with SMTP id x22mr5580039lfe.291.1622204526543;
 Fri, 28 May 2021 05:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210518120633.GW12395@shell.armlinux.org.uk> <E1lmZSw-0005TI-0s@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1lmZSw-0005TI-0s@rmk-PC.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 14:21:55 +0200
Message-ID: <CACRpkdaDmZqseri1DsV=XEF5eJLzSjZPdtA4_743UfWrvxiKwg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] ARM: change vmalloc_min to vmalloc_start
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Yanfei Xu <yanfei.xu@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hailong liu <carver4lio@163.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 12:11 PM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:

> Change the current vmalloc_min, which is supposed to be the lowest
> address of vmalloc space including the VMALLOC_OFFSET, to vmalloc_start
> which does not include VMALLOC_OFFSET.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
