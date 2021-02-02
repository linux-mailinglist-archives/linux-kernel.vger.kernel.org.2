Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70F030CB9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbhBBTbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbhBBT3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:29:01 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEC0C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 11:28:20 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h12so29627838lfp.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 11:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppyhT04tHHxwR+mDoskGjB2AeZvItaZVawlIMQ7teiI=;
        b=YhfiDsLHO9V0DeZnZYcMh6zo7TDWvINCnh/217UqSekFvJWrtQ5YLN8hCGSfhAzBDP
         Qw0Xb/Y/LtU36ClS1Hrhhgblx6by+p9v9OTKKC7ROMcNM2CkB5SB5zIWWNu6sYW9aE2V
         6pj3E1ZR6SCIoAM8CPy1VKd1gxHUYuqNB0JTajGIC+28yin5fL1Xl2Cr7F0aCrbvsFFn
         Fs7+CbaiGIvbbAM5PO3mwnClg7zeYBJ6MfnNoSk7abrdV1f+jCAiqTq842z0cBhXlWcW
         N6WRpLfIm1mO4nlcnueNtjeNgjBgt3Rem9ASNmR4/6/B0uppd6qIB9NfaB2tB9hAlS3A
         o6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppyhT04tHHxwR+mDoskGjB2AeZvItaZVawlIMQ7teiI=;
        b=dJiy7JtdSjTJAOf386OhvXwChpH/nNWaZY3oIoJrjDZAexP/0d4gj+NC+DMHlXQVi3
         Og0fMX9l2rtxyzyjbAeXRGGYPDbd1Hd+/SbI9r61tMgar3r856gXga715h2tLreYJcDf
         /giz3jySUKz17dpmQBc+BjA8wKrWrrk8lWWxqTlutEcgzeTrACKvngRCJ6ln0LrKLNpD
         QtZOS65KQB1iAeY879teA4RYPTUeMg2B99F6XeAZ8vo5rVEp1SdsA/oQRfkNUTzcJ/gz
         i6aLRZ6L+GJxKWhieEtdGl3P8BQcw912e0X8XYzmigCNZa7M93q2GSGOA4qPku3Pxbf0
         Td1w==
X-Gm-Message-State: AOAM532Mn5Rj/2+y3jDQPSrhUemtvH1biyL6+2Fx/9tRJe5dtj7mlgnA
        TvfRDzIyur5Pbk4vp+gvaR07tE6wrLRLdadeuvCVOA==
X-Google-Smtp-Source: ABdhPJxE2IM/VAXC9rSTVwJm52slElSr+ueiKZce9TAly0m3+poBzWJkFqodfcU0T7cxjYvosSqoAaPrWwAzcJpUfr8=
X-Received: by 2002:a19:600e:: with SMTP id u14mr11571338lfb.465.1612294098520;
 Tue, 02 Feb 2021 11:28:18 -0800 (PST)
MIME-Version: 1.0
References: <1611930410-25747-1-git-send-email-srinivas.neeli@xilinx.com> <1611930410-25747-5-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1611930410-25747-5-git-send-email-srinivas.neeli@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Feb 2021 20:28:07 +0100
Message-ID: <CACRpkdZvpmgWPMxM-e64MY4a4zym2ySVB49k16NhuNhe3BtrYA@mail.gmail.com>
Subject: Re: [PATCH V5 4/5] gpio: gpio-xilinx: Add support for suspend and resume
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 3:27 PM Srinivas Neeli
<srinivas.neeli@xilinx.com> wrote:

> Add support for suspend and resume, pm runtime suspend and resume.
> Added free and request calls.
>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---
> Changes in V5:

This v5 version looks really nice!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
