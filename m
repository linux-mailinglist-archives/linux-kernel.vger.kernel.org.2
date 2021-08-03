Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9FD3DF52F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 21:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbhHCTOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 15:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbhHCTOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:14:33 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB13C0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 12:14:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq29so333611lfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o0KpkzuHgK9GvKRz84YUwSFRZoVYeFdlCPtHyXWJQI4=;
        b=IhVvc2zO0gVenINJka9gU+HwzPs2chpbN81UxmimQd2DrzkYTxm58GZq29MO5pPrqO
         /b1z92x2EQLw7KwxaepO60QJxHJfmkD4ODPtUrnthsHL/gv5/gwORNIwMCzIzM2rwLd3
         +qRbm3O2pt1vJ1vzGeoeZp0BBj/Jr5gZVANa0nWwTlgd59plD4greZN1+qurDjT46QhC
         NKNFR5yWdCfqPq2mJNpvb5Gj+DC2QnwuGUswMZ5efFinEjjCF7xUnkz/A+PNvqBlEMOz
         IWE0sQoSSqjUMHW3BCXee39qartNBPLd7H+v6iSMe6sFtM7ZVaCK+PBx1DrGYIdXb98F
         eFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0KpkzuHgK9GvKRz84YUwSFRZoVYeFdlCPtHyXWJQI4=;
        b=qUTITHSCn1cGIYlFn3i/7GZ8d8m5YYvcw5AYSFcsk7R6AT6akPRWobEZll7NsLi0dy
         RZfPKb6WQunUBBosKiFbkbGeqoTcSkHHG34a98SRGrvhiSlIRtb9Q9bN4tLQM/expZd8
         pCfvarifYG0N66hyR5ABRdB9kawXXfYohTqxWvnrfmUzCjhzzOUJlyDzbJYvYavinaiY
         SjoQLsEl6U1fRX4yWo12kca6aaHd2rv0HWBt2nodAACtuWLlkGpsFx0ZZqZhN6Afxbd8
         xOZBm7dtwZzFArdNXDQxzD7fpm51dO8urPsR2zzY1I7N5qMWn5559mgZBtMkBzgHFPBh
         7GKg==
X-Gm-Message-State: AOAM531bMzzMrttzQ1K9LqcxxKrJ0S62uopO+G8Pu1qctjcAGyOTvt7I
        XIOeaHx0yy6INFc7Du36FBriT9ARAW+Qag8BTI5XZQ==
X-Google-Smtp-Source: ABdhPJxhNGyqsLT6k8Bxnxe0BQDXXGxD/VmjU/Ju+m5Ftr+9Ql55KKi1LMJz+or4Ekd3G8wphgKajB3wLeYYk6dLDuc=
X-Received: by 2002:ac2:5d4a:: with SMTP id w10mr17773309lfd.529.1628018058868;
 Tue, 03 Aug 2021 12:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210803150904.80119-1-colin.king@canonical.com>
In-Reply-To: <20210803150904.80119-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 3 Aug 2021 21:14:07 +0200
Message-ID: <CACRpkdZ5u-C8uH2pCr1689v_ndyzqevDDksXvtPYv=FfD=x_xg@mail.gmail.com>
Subject: Re: [PATCH][next] brcmfmac: firmware: Fix uninitialized variable ret
To:     Colin King <colin.king@canonical.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev <netdev@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 5:09 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the variable ret is uninitialized and is only set if
> the pointer alt_path is non-null. Fix this by ininitializing ret
> to zero.
>
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Nice catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
