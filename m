Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17805376485
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 13:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhEGLeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 07:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhEGLeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 07:34:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8ACC861460
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 11:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620387182;
        bh=uNOfVzEP5k+ZkjaxaopCUbI+LBtfgX0jgTDBxgbMZIk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NA2/7hZJVyQOs+U8s/021UqsKuFDYZZ35Gg3rmPQ+tWC+HHc7rmegwUYTU2CrkvL4
         J8AMvePUs4GN66OyseIAKNwi0o+cSdRlrzuk9qnAEThTjkQMK5v+1RF/HqgzkkWj9c
         iMuhyyZVzEImbw8hONek9Hmg/79l9wLDySIOU7HHZ1LTxpC056p6pfT4QV8+m4k3Zk
         rJg5ltcuQLacZsOiZ8ZdWLJ2wGPkPVZ+FmUhA6Wdtgt4e7zQZz5TCDCXBJhtbmFT9q
         OIExW0djgV5wDNSY2zPwMia8r/IAhDfCxqc8/6K1DWI6L7WeT61piSctmitovWeMzh
         b3MZOC1RLwcuA==
Received: by mail-ed1-f53.google.com with SMTP id b17so9862768ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 04:33:02 -0700 (PDT)
X-Gm-Message-State: AOAM533yCfd5+KJwonJAVtrbMZVtLnvDcUYRn6vRFR3czz5X1aC0hBy3
        GLwjePymFtT6ezMP0SJei2ERImLKMQ0eufCK260=
X-Google-Smtp-Source: ABdhPJwrPN2pFFy6x22M3aSDyIoUGE9If+JHQH/L/g3SPKcSgjmXUcaD0tImisJyflVWf+RtmEbyTYaR5rUYqQYtD68=
X-Received: by 2002:a05:6402:2714:: with SMTP id y20mr10696552edd.348.1620387181113;
 Fri, 07 May 2021 04:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <1595606355-1329-1-git-send-email-richard.gong@linux.intel.com>
In-Reply-To: <1595606355-1329-1-git-send-email-richard.gong@linux.intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 7 May 2021 07:32:47 -0400
X-Gmail-Original-Message-ID: <CAJKOXPcwW3ZPpiJzoDWXtVbwJW4Ys_VLFPUMRzJ7aNnJ00OvVw@mail.gmail.com>
Message-ID: <CAJKOXPcwW3ZPpiJzoDWXtVbwJW4Ys_VLFPUMRzJ7aNnJ00OvVw@mail.gmail.com>
Subject: Re: [RESEND PATCHv1] MAINTAINERS: altera: change maintainer for
 Altera drivers
To:     richard.gong@linux.intel.com
Cc:     mchehab+huawei@kernel.org, davem@davemloft.net, robh@kernel.org,
        gregkh@linuxfoundation.org, thor.thayer@linux.intel.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 at 11:49, <richard.gong@linux.intel.com> wrote:
>
> From: Richard Gong <richard.gong@intel.com>
>
> Thor is moving to a new position and I will take over the maintainership.
> Add myself as maintainer for 3 Altera drivers below:
> 1. Altera I2C driver
> 2. Altera System Manager driver
> 3. Altera System Resource driver
>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b4a43a9..d87a307 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -750,7 +750,7 @@ R:  Pali Roh=C3=A1r <pali@kernel.org>
>  F:     drivers/input/mouse/alps.*
>
>  ALTERA I2C CONTROLLER DRIVER
> -M:     Thor Thayer <thor.thayer@linux.intel.com>
> +M:     Richard Gong <richard.gong@linux.intel.com>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/i2c/i2c-altera.txt
>  F:     drivers/i2c/busses/i2c-altera.c
> @@ -767,13 +767,13 @@ S:        Maintained
>  F:     drivers/gpio/gpio-altera.c

Hi Richard,

The entry in maintainers is still wrong and emails to Thor bounce. If
you are willing to maintain the driver, please resend it with proper
Cc (as Rob pointed). If not, also please let us know so we will remove
the stale Maintainers entry.

Best regards,
Krzysztof
