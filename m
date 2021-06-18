Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CB23AC91D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 12:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhFRKuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 06:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhFRKuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 06:50:11 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5CEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 03:48:01 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id t22so1616168uar.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ya8vwRrjecoObdlsOLUUJ30LnN+duoFw+J3OVPTRUF0=;
        b=o+GYjCGtWRIKz5X/yZwey8VX/VwQ1kNglvJ6anIhHFnbVoy6y8IpFZD/CmvxKvsnu4
         7fMIqEGs7akx2UkVIENbeLCEqT4QWrzBe+XQy31HwEYJ8FPSziNwkx/TnSvXVMp6xlNi
         3ByIgcP+aeWT3O/Mrb1RKmpjGldYTpc5uWg3xcdFzUwnkKeo0xd5IOl/TY+UuyRHOfPx
         EkF0aKbwd7yRuNbV31tin3sDSdqgLv3S5B2uVnRccij9U9yroymYETDVM2hfxRl/E63T
         MajJD7t3SNctRf3Z9QsSKWg9/endK9nKrPNaeNEyLZdvaJixCkdKyod7EsT+imw8fXf/
         cvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ya8vwRrjecoObdlsOLUUJ30LnN+duoFw+J3OVPTRUF0=;
        b=KdhdqDZ3liWxRnBsbx4Y/tLLz9DnkJ+BGXkOOTT2sy8HZGCv7+PB/U+xqTvBGufAjd
         x3pgklSWQgEzotdE0EGsBuc2AVYTxs76NEYLrCW9jBIdEUmcYHDxjxNDDaDagtqenFeq
         wVWHudyip8WIbgDlADCqzyGY9KTOeWXPtlsRNP5HTqBLdn7YnVzJu3TJD2U0mNKwtE4x
         Qj6eUE7Kyc6QK6IZq6s6IB7Zt7blIiGfD7t6zTWYeYs6RkMbj8Dj+xrjGnd3um9BxgRf
         7yg/kkyO2/fRf/69GOT4s5S/iAwsvEicwLsuOFz8CSJAivoeycePdNvPN77y96d4Zl8/
         4ntw==
X-Gm-Message-State: AOAM533os8ltUwfa+8Pxs4bEi9aADiJNwEP41GVMfzDDNjQFlGqzIx0H
        v0AQVFxHppgg67qLTNkD/peoYTQvVuG4virWo/ALSQ==
X-Google-Smtp-Source: ABdhPJzvdhXNK9nCo8mGufnqn1+1JRV4UhLNlnvq8xDijarv//1iFSjLa091BJv6MUg9sL9GbqqXUruK5kjlEG7d/7w=
X-Received: by 2002:ab0:d8f:: with SMTP id i15mr11175274uak.104.1624013280934;
 Fri, 18 Jun 2021 03:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <LO2P265MB26880B222999818677722528C4369@LO2P265MB2688.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB26809CC8BCD8A0289697CBBDC40D9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB26809CC8BCD8A0289697CBBDC40D9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Jun 2021 12:47:24 +0200
Message-ID: <CAPDyKFr6bfcG+_3f+8ZYFFsuTA9reJ4Ykntxt=yh16-Z_6vxAg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: ioctl: Poll for TRAN if possible
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 at 12:00, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> >Poll for TRAN state if the ioctl command will eventually return to TRAN
> >
> >The ioctl submitted command should not be considered completed until
> >the card has returned back to TRAN state. Waiting just for the card
> >to no longer signal busy is not enough as they might remain in a
> >non-busy PROG state for a while after the command.
> >Further commands requiring TRAN will fail then.
> >It should not be the responsibility of the user to check if their comman=
d
> >has completed until sending the next via ioctl,
> >instead the check should be made here.
> >So now, in doubt, wait for TRAN except for the few commands that will
> >never return to TRAN state.
>
> So apart from the fact that I missed a couple of non-TRAN returning MMC
> commands, which I will add in v2, are there any other thoughts about this
> patch? It would change the behavior of the ioctl interface, but I think i=
t is
> the only way to prevent race conditions here.

I need some more time to review, but feel free to post a v2, I can
look at that instead.

Kind regards
Uffe

>
> Best Regards,
> Christian
>
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
