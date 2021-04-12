Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88A935D289
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 23:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbhDLVVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 17:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbhDLVVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 17:21:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59C1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 14:21:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so7856717pjv.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e1wU9Pp476KuP1Qo05s1erphsvUxkBpS9TJ9TBaDCrI=;
        b=mfutZUZ1Fgy+FfBdTgEu+i6Uf8HWKB5xTjyhttc/uO065QEj71pKIZMr/3Tik59odM
         82GEV/hMH8OTY8ODOrwt7R2Y0bvTXwS2S3A9tnawI+sYstpct5OuWoI3L4MqsxzxuKcF
         2Nln2a6jTnRZXoUeCaoYfFF3hAcUAF/YsQU3sp1DFYRgzSJJ36A8i8RpBsRAuqB3e4rb
         DNzy25mFq3FPHLiIVpQmk4xRcG2IoKUB9+LfZZKTu6bc6Z6t+JmSAIypwdagbBNOyyIf
         todzaO0T7T5em9tp++Tx5wVBoIoaBBxmvreZYnOyyGMluY6dlKD9vh5lhDv/pEw1Jrtn
         kW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e1wU9Pp476KuP1Qo05s1erphsvUxkBpS9TJ9TBaDCrI=;
        b=D5aADaXcrhlo2qfF588Idp75DWVEEinylHRkH0m0s5it8sbTwZFhnbZdBbeccMywQ8
         1m1XFuWQlEiCI9UCb2Y9K/lthMvtVIDysJ5mB6ylJYT0w53X3H0o40H0vLHSXHCTC2md
         TOKQf/GHvcjKY6b3zWqg6aJhRYtJERPvYH12Mh87fGJjq91KIoz3wx49fgCW4f5u2UCb
         NudevBjvmZE2bNn8WkruA+0evDgVZ82PlYixMSDNL6ahv1qPJoBRMhzj+rSNv0NLWRvt
         DfZXEYsyv/cbfqJjiZG0/Pd4FW7NI8O+pQPc7lG2v/aN286BOrD7dxc0Pu1ZucRTNMY2
         QxHg==
X-Gm-Message-State: AOAM533S4E5L0JnYbCWh2XDGgYawhjYtzz/iEBHfxQpNbCK8BBhPV7/3
        JQhbh6SHIOlB5QEAj+WWZBaJkVzxxI0RC3/xIN8=
X-Google-Smtp-Source: ABdhPJwDJRQV8mHz6Drp+0A4/+h+ALtybC+I+0SCdeoyYbBp7iRCIRe6vgpQ+Ccw1omw36a6PK5oCFEc9alSZXsUrms=
X-Received: by 2002:a17:902:bf92:b029:e6:bc0:25ac with SMTP id
 v18-20020a170902bf92b02900e60bc025acmr29172987pls.49.1618262491534; Mon, 12
 Apr 2021 14:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <1617086920-15952-1-git-send-email-fanghao11@huawei.com> <20210330072203.GA24255@leoy-ThinkPad-X240s>
In-Reply-To: <20210330072203.GA24255@leoy-ThinkPad-X240s>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 12 Apr 2021 16:21:20 -0500
Message-ID: <CABb+yY0OB+U0+nQF0qr7kywv=Ajmk-waczM=j3KZnotiomRtJg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: hisilicon: Use the correct HiSilicon copyright
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Hao Fang <fanghao11@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 2:22 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> On Tue, Mar 30, 2021 at 02:48:40PM +0800, Hao Fang wrote:
> > s/Hisilicon/HiSilicon/g.
> > It should use capital S, according to
> > https://www.hisilicon.com/en/terms-of-use.
> >
> > Signed-off-by: Hao Fang <fanghao11@huawei.com>
>
> Though the kernel has tons of "Hisilicon", for this patch:
>
How about one patch to convert all occurrences?

thanks.
