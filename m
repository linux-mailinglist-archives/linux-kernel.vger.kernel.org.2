Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028AA35EB1A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343679AbhDNCtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239489AbhDNCte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:49:34 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F641C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:49:14 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id j12so1964779ils.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfXneJvz0C/vmR/s1WVupLiCXqI05TupW72jk8dT3HE=;
        b=f6G9Sp2yd9j4jRVXOkFWmU7cr+lF7b3NV6UjUSuCqtz7BfPT90JINGVDjaFXSKu/UA
         1SnSQwsYAlfc/9uivJFQGbBP/6v6qKbSLkY8zLf1I7Jc2AZgZ6Lzn6IDZkNctyNSS42g
         NEA7cxhAi/Jkbfv/SSUfombNU8ETTvAR5gkjEEj+QhYC4FFHDOwd9g/fWO0ksCsQqlXm
         tKKiNe24tqQMMSwntpN/AyMYHhlokCzXAZopTOuNDndzBWUOhTuzQbd5ny7xHmuxs6PP
         aJXkcsESndH72wvLLfwf8et6HEV/9noPo5vak8G5Ir+Ow/G3R0dgQGXb/gcxyLkQrvcJ
         yHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfXneJvz0C/vmR/s1WVupLiCXqI05TupW72jk8dT3HE=;
        b=kTbEDRZ+BJfde/AJZEFgBlSyIlgM7DJxh9kihwrf1ZRysJlxdnpvwg/7D3Yg4Dv5Ke
         jwTbyBOooE7b5KkbReJGvo+cIHKSaBHwTnjJy+RuBwEgUVTXdiULfpSCtyZU+jCoaqal
         gF0s2r2aLAQekanuaiNra9sDZ7HTgx8R5bgSwG2L+LYCfL4g8Qu6Y77/mWDGpbLCYxXy
         1mQ3k86IQnjA1vb0Dl3XJo7FdDwaJkJocPoyh+JQmRibJwXYad/dH32pz8nmwqarKsxf
         yf2hJePTS2RmWmg2CiyjoKZksmi12lBRDvDshjYHNiVVj0f83YDSZ4F/ypOB/Ngtjjoc
         gSjA==
X-Gm-Message-State: AOAM531xD3twssKBorR7mJ7PRrhvwUsrzOLZYGrysVJv0k8MW9yjqY7/
        mpRi9uJklCBkctxmb9+KNpqsRzinXZTjbe72OcaY5Q==
X-Google-Smtp-Source: ABdhPJxFD7Q/IMG2eTERE4O/KZZY/5mUsYQxRoL/NriGRRYzYgNutozWqMQir7c2qWV4N5KOe/4jZFxHMBGhL6B57MI=
X-Received: by 2002:a05:6e02:2197:: with SMTP id j23mr2481295ila.269.1618368553440;
 Tue, 13 Apr 2021 19:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com>
 <YHXRWoVIYLL4rYG9@kroah.com>
In-Reply-To: <YHXRWoVIYLL4rYG9@kroah.com>
From:   Lorenzo Colitti <lorenzo@google.com>
Date:   Wed, 14 Apr 2021 11:49:01 +0900
Message-ID: <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com>
Subject: Re: [PATCH] hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com, Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 2:14 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> To give context, the commit is now 46eb1701c046 ("hrtimer: Update
> softirq_expires_next correctly after __hrtimer_get_next_event()") and is
> attached below.
>
> The f_ncm.c driver is doing a lot of calls to hrtimer_start() with mode
> HRTIMER_MODE_REL_SOFT for I think every packet it gets.  If that should
> not be happening, we can easily fix it but I guess no one has actually
> had fast USB devices that noticed this until now :)

AIUI the purpose of this timer is to support packet aggregation. USB
transfers are relatively expensive/high latency. 6 Gbps is 500k
1500-byte packets per second, or one every 2us. So f_ncm buffers as
many packets as will fit into 16k (usually, 10 1500-byte packets), and
only initiates a USB transfer when those packets have arrived. That
ends up doing only one transfer every 20us. It sets a 300us timer to
ensure that if the 10 packets haven't arrived, it still sends out
whatever it has when the timer fires. The timer is set/updated on
every packet buffered by ncm.

Is this somehow much more expensive in 5.10.24 than it was before?
Even if this driver is somehow "holding it wrong", might there not be
other workloads that have a similar problem? What about regressions on
those workloads?
