Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E8336F140
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhD2Ure (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhD2Urd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:47:33 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD9CC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 13:46:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c22so16528051edn.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WgLKTfF2m6aFVph8YVoLnHUhUC3a+ICHx4fOWtLtkUY=;
        b=AhpGWuJY5why2oF/WmjGuw+62ZG3SETxkECzhYzChL6cWPmcLWlI1Skyr/iUzPxBCt
         DlCYYXSXAaDD2/n6HCgNrWeINejQDiANCBkjLQFlFG4TqzN4+ZARWcvTB+04eZRIYBVD
         80iHKrJZtHO1h6I8n21Qszp7BTWLr1evfopov7HDXdES7E6ooitwxkUixhHqHxKFg0ma
         bBP0vJaVlj7JYgIkgaFJv7wyEdR8taftme4jHBoTn2hEdwPIIl8tiPfKKDrw6ojjyzW8
         v0aCu06tL3gt7jPcEkWFRIENSt5/O3nHToMKUHnD99FLPE0hbYS+QSiXdhYXIsbcLEu3
         pYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WgLKTfF2m6aFVph8YVoLnHUhUC3a+ICHx4fOWtLtkUY=;
        b=nFm8GrkoP4+voqCdYu8aN9xHX8ItYrv/gEqzWtlWeWQEQv0TCPygZc6yp4RAhKTCYa
         TKTeiZgbBXk4f4CvAM1w0DdpvOSR2sWDzPMflxv8QBaAD7RK438fA0idxBqaEfwDOPug
         e9ve8C81Lw9R4gQbyu4D0bDvW/ktm+yTmMmicbh7s/FfKqHcTZvqAy6DtG2v2hsuWG5e
         mgatnyIh0F27OG31IuwAqjHkLJl+mVljpY8KFNX+WrH83yNmxwXJs8b88bIuai3bmT5O
         fdlMIJqpf/MIuOzCwI5Oa34vAsopvbZJLU/6+VpOPrTG46wJHg/ZQS/fyd+qrsYvaxr7
         EYuw==
X-Gm-Message-State: AOAM5317ynvySntAqzcIXCKRgcxgdDjVpBQk5nkjE8ZRi9dx5uKagk7o
        b5kNMt+0PJb/MaVeKYmzyYmfFfVaHCApRkqGjm4=
X-Google-Smtp-Source: ABdhPJwlHXvuI11WdJAA7XjJIqO9h0ktT1pkTTPYMdjmtZZ8L+mVogYy1p7mq+TRRFwUzzanEYOFqQR/TrDFTsyoh0c=
X-Received: by 2002:aa7:c957:: with SMTP id h23mr1745712edt.301.1619729202396;
 Thu, 29 Apr 2021 13:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210429083823.59546-1-jbrunet@baylibre.com>
In-Reply-To: <20210429083823.59546-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 29 Apr 2021 22:46:31 +0200
Message-ID: <CAFBinCBdzeApU0Ai5i91ed9Ra6CB4pThuCHHwaPbFm9FDhq=3A@mail.gmail.com>
Subject: Re: [PATCH RESEND] arm64: meson: select COMMON_CLK
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 10:39 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> This fix the recent removal of clock drivers selection.
> While it is not necessary to select the clock drivers themselves, we need
> to select a proper implementation of the clock API, which for the meson, is
> CCF
>
> Fixes: ba66a25536dd ("arm64: meson: ship only the necessary clock controllers")
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

note to self: ARCH_MULTIPLATFORM for the 32-bit SoCs also selects this
