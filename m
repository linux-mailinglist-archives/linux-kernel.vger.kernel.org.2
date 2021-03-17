Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7E833E8D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCQFOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhCQFOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:14:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AFBC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 22:14:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id l3so302827pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 22:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=CNdGMKqM0pQjbLelZc2KiS3A+5IeroB8GexfPgW33zQ=;
        b=TmZoZANKCbUzvYSCuu4tjz9Bzddgny2LMOa5H1sRP7Wxx8uuhohlb1a3hXvBAENyX0
         aShFNO/ASaCOGZKhT2ctrEYhV6n0w1tz0UuzmGHCAeQWGniBI4Dk0XBmgE/nSQBLOGb/
         Gi8iO+FW+nLrvrRc6GOdOpz9+cmY7uf76EFxZARRAUFnK7VNINsnXpwfA7A1RS5nVTgF
         7rrTASfr/QpecMXavnF1HagwNhvCCIc05BgJh4C0aOPykHIa6VDQbbgKPnw2Q3irDstp
         gaUpUUO22k3edr6SMaVENWAip9dylik5QOWuComOHrM3LR4omDvpBuRgUjmEPAhAqWRR
         x/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=CNdGMKqM0pQjbLelZc2KiS3A+5IeroB8GexfPgW33zQ=;
        b=fjTi+eQcwSS6mhpdfrBkpCwYY9Ar2ZOHV2cwIMx1ByLblEFSrtbqaBFo/AMKJdgx7N
         srQli8sD46tOqs64mlPsoLo3EyCEleKeSMEy65nhBo1m4jH9Cn4fuxT7DZtGNkBfP+3S
         XXUNg4Tfxr6OpXdLi+TBLPm+4BJGp2mXhReisXw5k9I5LTiVEeF//bAxPUa/O/R3JI6+
         VSnNr/VoyVi/tat5KyRVdkNQZ1LytoOK+5wGyCDrpnv1KYyc5burQ+DhOpbIMxOS4fQH
         DQnFZv1QOESwEHnNhciz8zJWe3DxZFO6rTK0Q2aaB2jGjhFqW9ED6WW+o/0OJVYGm+eV
         wLSw==
X-Gm-Message-State: AOAM530Hp/xOy1dV4+n+J4Csam4rGzvHfzZzx8fVvxdqntM0LfRtom7d
        msn92Jfebl0I3wJpD3th6g5UEA==
X-Google-Smtp-Source: ABdhPJx25sOT3lNg8mxIzP8z3booUHLSdwDwXkB5viC5Gl5IpBe7X1pW34ymCnnaL1K9kU0v6sIZfQ==
X-Received: by 2002:aa7:908c:0:b029:209:aacd:d8b with SMTP id i12-20020aa7908c0000b0290209aacd0d8bmr2748693pfa.74.1615958056674;
        Tue, 16 Mar 2021 22:14:16 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 14sm18249938pfo.141.2021.03.16.22.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 22:14:15 -0700 (PDT)
Date:   Tue, 16 Mar 2021 22:14:15 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Mar 2021 22:14:14 PDT (-0700)
Subject:     Re: [PATCH] riscv: Fix spelling mistake "initialisation" -> "initialization
In-Reply-To: <20210316093054.GA1081018@LEGION>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        musamaanjum@gmail.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     musamaanjum@gmail.com
Message-ID: <mhng-884ba68c-f5f0-4808-869a-611720dec5ee@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 02:30:54 PDT (-0700), musamaanjum@gmail.com wrote:
> There is a spelling mistake in a comment. Fix it.
>
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
>  arch/riscv/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index ea028d9e0d24..1ec014067855 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * SMP initialisation and IPI support
> + * SMP initialization and IPI support
>   * Based on arch/arm64/kernel/smp.c
>   *
>   * Copyright (C) 2012 ARM Ltd.

The internet seems to suggest that both of these are words and that they mean
the same thing.
