Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68693E49A2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhHIQVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhHIQTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:19:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A5AC061796;
        Mon,  9 Aug 2021 09:19:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id c24so8365165lfi.11;
        Mon, 09 Aug 2021 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9VdH7ns3h5j/pkoJcdwYLPrHEhcNZabrfGVRGH7EGA=;
        b=aAsa1GsrKNIid2ukdTvB2onVx9ChYfIoWc+oMoD5C29aHmVYhbEtRDyNuZ/M2jmtYF
         n0h0A7uQwwCdELxuSJM9wc9w4NCDqdCzdvLCsWvLMD9yjVLDGPzGe+QQhQ1LWIKOAzdg
         jIuCoVhdXzs8kCIbVh85AYcJ5n0OKX5iLg0Rtj0Bh80gKYuBBkUxP3x6rziQOJtweF+c
         /+NxmL8xS/yd4jj+JvifBTV/Wtl+ZpsesMbBh10g9VMIt8uG/jLUxxqiP/YgUfunvvwc
         u6uMR67yhLB+mc2nL0mvjUmCuvrxzmQAWoHpkrCkmNAwzNASI5Xi3mUwtvDFf/eDdd/J
         +eUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9VdH7ns3h5j/pkoJcdwYLPrHEhcNZabrfGVRGH7EGA=;
        b=GtVfSNGcFLRAlsltEaQDWx/Cd5yqhsLCv0QsLLHo3GEArjpfBFG1ToeD/DxmJuR4A7
         A9vh+1FD6zMNLhA5EQR1seTXZGoDzA4u/vAib2bgZgaxzHNKl6CdM+jrd5YJs6DZgEb4
         gf5tcaBGWjff/WXonnB9bFMCb0ZS0RMc6Tz3LZ1l2/A7uW56PsMybjP6LcwbDBDk0Gjt
         /S+4+Q7bpIVcM1lInZhk4MNDEDkrD2EqmvYCFDPgt4rbkd89YUoFFapJLRiztYIpAO0q
         NCK0ZYj3gyrKbaixpQKEDEFPuRwQmbPY2JK6hDoTMr6NVfY5A0k1XEPWL6y5evpWHC74
         Qflg==
X-Gm-Message-State: AOAM5324QB50rEKj/Dz6WFscBYFEB2gBaMllO68CvrAloHHG33aOGgZA
        3S/nKg2uzXsz6GEqQEWyFi9ABI2vpiB56Zo7e7s=
X-Google-Smtp-Source: ABdhPJxCwqVyO3DLEGV8llT8YbwmG153gIXdgtT4ALWyc7DZWXzea0i1wx4SxIBin/adnb6Nch335/g50aswk5zEiN4=
X-Received: by 2002:a05:6512:39c6:: with SMTP id k6mr18099640lfu.549.1628525959073;
 Mon, 09 Aug 2021 09:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+jKREfXERKj7XB7U3Wh1g4STO2Dt0qnMkcPV5nXB3_bwg@mail.gmail.com>
 <8923f2b8-0be0-ffbf-70a4-c03c9a02d58a@suse.com>
In-Reply-To: <8923f2b8-0be0-ffbf-70a4-c03c9a02d58a@suse.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Mon, 9 Aug 2021 21:49:07 +0530
Message-ID: <CAHhAz+hYy6najVa4gt2zkAiipWPCL6X+KH=RFrHZfY1RH13QAw@mail.gmail.com>
Subject: Re: read() via USB bus
To:     Oliver Neukum <oneukum@suse.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 1:45 PM Oliver Neukum <oneukum@suse.com> wrote:
>
>
> On 09.08.21 09:58, Muni Sekhar wrote:
> > Hi all,
> >
> > PCIe memory mapped registers can be read via readb(), readw(), readl()
> > kernel API's. Similarly what are the kernel API to read the device
> > registers via USB bus
> >
>
> Hi,
>
> I am afraid this is based on a fundamental misunderstanding on how
> USB works. It is based on passing messages, not reading and writing
> registers.
>
> USB devices are primarily based on endpoints, not registers. A literal
> answer to your question would point you to the clear/set/get_feature
> standard requests of chapter 9 of the specification, but that really
> will not help you, as you are making assumption that fundamentally
> do not apply.
>
> I hope this list stays friendly to newcomers and we will answer
> specific questions, but at this point I must advise you to first
> read an introductory book.
Thank you, I will check it out.
>
>     HTH
>         Oliver
>
>


-- 
Thanks,
Sekhar
