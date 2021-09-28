Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223AD41B121
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbhI1Nux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241026AbhI1Nur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:50:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37811C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:49:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id e15so93132700lfr.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKhQNZjOIfjJSyht2FLszmL1D3tP60bcjgnElckVMHw=;
        b=SWEdIIJwb6X69/Lam+uJXQ6A4Xb8I8sL8BhXeM3sLLTYm81aA3aB2/BC6+HJbIZ9Np
         WiUtxZii+TvQXkeuNHoLpp/YKiZcjUc3Lma1kF6etJ6fJulA7H1Qa8WOsMnSi5VDacoL
         /39tpHlEqw4oO0o7g3FG9oLdkaCQxKO7AbQCK6zgWE6ybQxqsB6INHnMLtSrMMXN31zB
         o9o+clLvDMIS1yiRptqNduVYmZRDoTw+nqRIl1EoKZ08skFyuzAttaoiGBoDTpD6lePa
         LrrE5kHQR/1R/mXEYc1KOigNq/loDqFZHEnIbM6jnTX4khW1moblBvMKPX9ySC7ZbAnH
         lx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKhQNZjOIfjJSyht2FLszmL1D3tP60bcjgnElckVMHw=;
        b=MlklczTH9yZ+Vrxxtzl9bLykeqlYRyRMdiiPxPrMj2iK2lcXV3BYRGziYNig8QVnLO
         Tgvs0XtRd+NQittMgLa41qWizaUYsArRf+eSMIuFTt7zc4QrPFAY/yL4U4TS9GNCFpIw
         XSSxFdpiQuUmMF4mtVDclGCjpL04vYMLDN9eb3uX9yyJElOuppAVBEEtK5ZVyIOXXaQH
         LKO+Tfj/58xIZeV0aRjNhu4XFbJS2SNpim2u8+ea0EFLuLj145Mf7zTzJcOQoBE/Ve9I
         I3rpdFKtqqV7cIMekrXFsNMzNip9k9trEELCnS6LhD5LDE1b5v2rpc7DESc6vnF8b/hU
         EieA==
X-Gm-Message-State: AOAM532WsaGzG73EFlHfcClVlI9R3LiwU3uqqR9/akc4Oy98b8B/bHGg
        00ZYOYAYAEFsAKMCKc0sDvgl8281YJqibELa0sYBMQ==
X-Google-Smtp-Source: ABdhPJwA3IKyzL3cWJqddBcnon0fBZlmLO9AeCStzXybEnOG68cSahyOUvLzXIRJ0IEALndQdr8Jff18s9lyLDEQzT0=
X-Received: by 2002:a05:6512:e82:: with SMTP id bi2mr5737173lfb.95.1632836938527;
 Tue, 28 Sep 2021 06:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210928014156.1491-1-caihuoqing@baidu.com> <20210928014156.1491-3-caihuoqing@baidu.com>
In-Reply-To: <20210928014156.1491-3-caihuoqing@baidu.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Sep 2021 15:48:47 +0200
Message-ID: <CACRpkdZMZ2LNP37h=6bkVAsFGNLBnUsZ1AuDtKzuzgq-op7csg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: light: gp2ap002: Make use of the helper
 function dev_err_probe()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 3:42 AM Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
