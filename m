Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA92632A9A3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581125AbhCBSjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351445AbhCBPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:48:31 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BCCC06178B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:47:14 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u4so32018806lfs.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGserAI4CaONV3YDRH9VObSYZ9RyY9qBNLrU2ZPzRMI=;
        b=XixrPLxA622gkekOtBSy3NUK8rxlTCfj3FOEsjnztBOLX96YbLMIkbhS8VGIBJVW1C
         gYgWg0bVZdOqgk9i4Xvy+DpbBteXWQ3wWuKcZ8oRk0IfpbarywXFhoYMEqLfDyG/j6PR
         Pi16OxvYd/VprqXOK8fAtnR6WjuOkFMOyaOI5SG4Rxup9A1h4j2BEe9ceT2fM/UREJ19
         dk8BzI8VmiBJMVy8iQkamQFidOpFynZmpP4FENnI4QGHHEsGbiofGs81LGp5i2asNCMH
         hrglY3pYQJk4vwY/rl+9fTaNpXfX/No0PV59pZ5rwtcymDIS33443TWiC0U42AlOanrg
         fIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGserAI4CaONV3YDRH9VObSYZ9RyY9qBNLrU2ZPzRMI=;
        b=kI7p00ztXZ08ShQA8c8OIhMMicBcpnxBikr1Tu5LoIZjjy2QT1IpLbgwCt+gC8uXtE
         9gRlwDaKPuEOWBhk0tUI7o7bhfQiON4PSd/sFiSz3IpBJhYoaRB5ajiE3nCnqqqdxbOm
         e+k7bUlq06OtTQq1eKEFdUKARc7TWVGH9+Z3VUmzGA1SgvZiiMv8VMYLTT1BNdYEg9ZV
         1N5NhBfX5hbNH7PNBaCTgcwDTI/Nmu34dMAM9MxpVoDT5WlECezFPd55H9O30jPQ9aCV
         bhjd9NBkAh1Xjug4KC60mZBDkC2TxziPswyNHd5YCekvLV8PPlyD7MHpMRv7wd1ZjC8z
         HAXg==
X-Gm-Message-State: AOAM530j0eAPPDAUmm5wSiJdieq7A7uXl/tKRCVltiozhZgsEI+6tJNQ
        BoPDAhq45+HgaIwDE6XvjewcsW6Ff6fNbCC59+tyxA==
X-Google-Smtp-Source: ABdhPJxC7pe3lG8qzOnmQGLeFblxStCWivQprRprE1ANOpe2gx6tgJV3PqzoKvuOWkvmdELHE7FPYtFGBfA0shSkCww=
X-Received: by 2002:a19:4c08:: with SMTP id z8mr12085900lfa.157.1614700033169;
 Tue, 02 Mar 2021 07:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20210227092152.GC2087@kadam>
In-Reply-To: <20210227092152.GC2087@kadam>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 16:47:01 +0100
Message-ID: <CACRpkdbWtBA-ptCF7prizoP1D9cshWgpt8r4CGRRfxwcXiX61g@mail.gmail.com>
Subject: Re: drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:458 lpi_config_set()
 error: uninitialized symbol 'strength'.
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kbuild@lists.01.org, kbuild test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 10:22 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> New smatch warnings:
> drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:458 lpi_config_set() error: uninitialized symbol 'strength'.
>
> Old smatch warnings:
> drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:457 lpi_config_set() error: uninitialized symbol 'pullup'.

I don't think these are real problems, but maybe there is some way to explicitly
express that so that smatch knows as well?

Yours,
Linus Walleij
