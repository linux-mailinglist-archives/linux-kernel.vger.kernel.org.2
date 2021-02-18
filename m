Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442C931EF26
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhBRTCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:02:38 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:33798 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbhBRRXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:23:14 -0500
Received: by mail-ot1-f52.google.com with SMTP id b16so2573937otq.1;
        Thu, 18 Feb 2021 09:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NX6EDg3WVwyAV5L0N2YCyGTGVewn44yzxxRjVeIot1Q=;
        b=qGpUndmKQE00QbO/h/ebGD7GoDZo/vP0E5JpYx00VGk5ukPQxMcKPKyZN8RPs8OM1y
         krdsmxsuUYwIOYpRsTeC+BBjvmCxuBHId75GhE+MjCyJzNhUfEfMBMgiByEQ9GREUTeG
         J5+TyFuZl5m/vc4+A8BvvIhWCaYAOiSeC2RXSlC2p/mKn7ikJ2Zo6qen8aTZ8W0VGjq6
         A2mTYVWWxYX8F4zbN2cMVxzigY90L1ApEoBxxNjcnVjzkvCdjEg9kyAB/Oz6ADfJ37+Z
         ucXHL1GIKJIvRMkW2R45kDi9zEw5ePiEDfy24cKc8kpv0xvSiWPtD0K++PnV1iHZ+Xyb
         bOPw==
X-Gm-Message-State: AOAM530vY0Wq44ZhdRx3ECwtvrQ4N6JdH3x5ky6x/zbdkhtpr7mDTSJ+
        egr+ZDiU8Yq8qoQaM67jZDyyVlpWEev1j5eY9uY=
X-Google-Smtp-Source: ABdhPJyL0mcRakFrgJhNrkU9sn6cSFUrR5BucNkiLUT4O9W9lDN6NNlc6aJ2wuf3wy7Wz49hLOKbNxVpTznj1Oz4O68=
X-Received: by 2002:a9d:a2d:: with SMTP id 42mr3773337otg.321.1613668953665;
 Thu, 18 Feb 2021 09:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20210217195136.195789-1-colin.king@canonical.com>
In-Reply-To: <20210217195136.195789-1-colin.king@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Feb 2021 18:22:22 +0100
Message-ID: <CAJZ5v0gOcLu1=Vn5uqRix=JXy2ucHZVDtiPcbMsaSYgrgf7pxg@mail.gmail.com>
Subject: Re: [PATCH] drivers/base/cpu: remove redundant initialization of
 variable retval
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 8:51 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable retval is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/base/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 8f1d6569564c..2e834cd315d8 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -409,7 +409,7 @@ __cpu_device_create(struct device *parent, void *drvdata,
>                     const char *fmt, va_list args)
>  {
>         struct device *dev = NULL;
> -       int retval = -ENODEV;

Might as well init it to -ENOMEM and drop the assignment below.

> +       int retval;
>
>         dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>         if (!dev) {
> --
