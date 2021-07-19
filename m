Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C603CD178
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhGSJUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 05:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhGSJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 05:20:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B026C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:05:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id jx7-20020a17090b46c7b02901757deaf2c8so11799495pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dj2Pkj4697WEBKUdTIRcLnCnShjS53dNXfzQ6fBbXxk=;
        b=bs1xjmd4PHfTEyV3tlkBGLYlk6CUL15nfckKPruC9/iyNosMEuf3lCLLZw7UL/Temd
         P0QJzpXI17S0giZ8in4sM9pgBI12j5Y0aFV4AY7Kcz2T9Jj0atqgkyAZ9cntrMsXL9ph
         VLcwYQINfCjWUvLOonL1E5MsjA750sMABlRcGaHlCNqJjcPy2OkRo/MHPz2ORykqHcV5
         GbLjuDGi8qUXZIcuyXa0OqoROj0apbwTaEfYfnCL+SNOISHR6be9StFfsZo1g4fDlCIL
         Eu/3/yitq2OvHSxWi2oJN7albQbWKkUWGvr2rT7nF32hRo2Rh2vULpLk+Y7571A+tLu2
         XnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dj2Pkj4697WEBKUdTIRcLnCnShjS53dNXfzQ6fBbXxk=;
        b=Ino5GRNejHv/zhNUsybdt6Epka90JqB0yTudLJytGN0CoWI3QttrwD7JU5qdtmfHKz
         3h8l7HS/eAdVqUrpkddRilqLYylkGl9FUQNWZ28KCGjwx3+z5TsR9o7rq5AHhPXVrSP9
         fA92LgNGZ1P0b6iu7WIlaOyZ85TTJkDn2wTiD1IfGshh0SG7fHBf4UZWgP4ITOAdtWpk
         r81KWpoXldy6qIoo1aOp39gURsnOzVyIC+MSQTO0YxvL/hx+pYPaZhWwxIpkGw/Mc/wB
         iWBcF2ApwT8F/t+Zs6Vc2T6aEl38y0fawaYrFTMMh7sKjJW/FTFATfd3oCqBrxecobEi
         c43g==
X-Gm-Message-State: AOAM530NTH8TUiZwJ/RnitzPhiR3vhtZqbFNfMv4/TK3atPzHQRahkAB
        ANW63r5SZL9kj0RL/ZO1i8lf5CqzJ5Fz13k8Zz7IIQ==
X-Google-Smtp-Source: ABdhPJzaMXi3IhhHEWBwxgh2vvHsDCsAz6748LplsxwtZeNJ/QXxYLWdd/F+4L3nGf/wyoJ4iQhUD0BZowJRAYcaWVw=
X-Received: by 2002:a17:90a:5892:: with SMTP id j18mr24424949pji.18.1626688889508;
 Mon, 19 Jul 2021 03:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210714211805.22350-1-richard.laing@alliedtelesis.co.nz>
In-Reply-To: <20210714211805.22350-1-richard.laing@alliedtelesis.co.nz>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 19 Jul 2021 12:11:26 +0200
Message-ID: <CAMZdPi-1E5pieVwt_XFF-+PML-cX05nM=PdD0pApD_ym5k_uMQ@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: pci-generic: configurable network interface MRU
To:     richard.laing@alliedtelesis.co.nz
Cc:     David Miller <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Wed, 14 Jul 2021 at 23:18, <richard.laing@alliedtelesis.co.nz> wrote:
>
> From: Richard Laing <richard.laing@alliedtelesis.co.nz>
>
> The MRU value used by the MHI MBIM network interface affects
> the throughput performance of the interface. Different modem
> models use different default MRU sizes based on their bandwidth
> capabilities. Large values generally result in higher throughput
> for larger packet sizes.


For my interest do you have some numbers here highlighting improvement?

> In addition if the MRU used by the MHI device is larger than that
> specified in the MHI net device the data is fragmented and needs
> to be re-assembled which generates a (single) warning message about
> the fragmented packets. Setting the MRU on both ends avoids the
> extra processing to re-assemble the packets.


Re-assembly is quite free since it's about chaining buffers (no copy
or re-alloc).

>
>
> This patch allows the documented MRU for a modem to be automatically
> set as the MHI net device MRU avoiding fragmentation and improving
> throughput performance.


I would be interested in some numbers (throughput, CPU usage...) since
I've not been able to test that at very high throughput for MBIM. The
default MRU has been set so that MHI packets fit into 4K pages, for
faster allocation. As you said, that causes more MHI transfers but
there is Interrupt Coalescing at hardware level, which mitigates
overhead.

Regards,
Loic
