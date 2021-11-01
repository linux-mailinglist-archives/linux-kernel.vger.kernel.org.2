Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987DF441C7F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhKAOVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232174AbhKAOVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635776346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=grnEDNR+DhcQw8Yy4DrErkca3Qi7jQ/4xAssJ+EIqu0=;
        b=iMrTURznvbua5jdOVZfRjG5dK7dNO6HG3emLYRi0bscbq6z2No9804dI8GJWNCr3r6FbUw
        eNhRe22j6I5FSLmoCpIOrbpoM3Z+vWNDXbbcBrjhAhm5GaFzZGFcUUBRhloVb3tuqIEAPm
        TXNGk38D5ahM8T1zFmmWGfYFOWlXyjw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-B_jB1YEFPm2vnzPDOKVOog-1; Mon, 01 Nov 2021 10:19:04 -0400
X-MC-Unique: B_jB1YEFPm2vnzPDOKVOog-1
Received: by mail-yb1-f199.google.com with SMTP id t24-20020a252d18000000b005c225ae9e16so8143367ybt.15
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 07:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grnEDNR+DhcQw8Yy4DrErkca3Qi7jQ/4xAssJ+EIqu0=;
        b=bH/1dZkzSieCTFEWYTfv1TwCXj8hkP2d0KfLvaBpqGKuDq67Z9D7nASV7YlFc1NPhs
         XczP2h745oIRGKIi03sby8GRYsh6S+Blkb+Ihxu+t1V+qWy3EOtDFwstESZU6w+cX4ai
         1nzDGMCVwrvrp7OYDf9eQvMcbVYJK467owMPVcHXz81oBVoZ8T+lalvKp32q/nXLKT9n
         qQpymKHhhlTIAiW6R7TQ5VNhqrrBAFqMVpeHQc8rAVDG/dEZoeERpFODmoSriryfQDI/
         Z55vp4XHCAqE2bNcTg35zzPnXVlz5Zz0xlmv9Pz3JvqJqd1CZi1K8CUvX9nmhlzJAEKb
         eo/g==
X-Gm-Message-State: AOAM531y4eofa7W23YpxtIFuoyPdPhX4tfDk78EZhay1mrWC20izNUSv
        NCPSZAVLm0h23wwSjdIZUY8358lNq2MTI6Up89VxmE85IUKUevIaa9jj3Fj99eifi7b8UWie/pd
        xzOz9FeQJgngbgSN5E5e55My19D0o1CDmMPsgjtJu
X-Received: by 2002:a25:8b90:: with SMTP id j16mr32930284ybl.210.1635776344394;
        Mon, 01 Nov 2021 07:19:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrV8UpfpZC0DvRRXKkp6XeEMkMtvN2gjHGneF97Z4WSzDAEg0KfICJKWzvGacEgOXgwfCH2pd1HYDLs94DeM0=
X-Received: by 2002:a25:8b90:: with SMTP id j16mr32930261ybl.210.1635776344239;
 Mon, 01 Nov 2021 07:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211029215516.801593-1-cmirabil@redhat.com> <CANiq72=cp+LTQhGMMmtWHLAk+AE81HOVB+2f06kQ9DXtBz+NyA@mail.gmail.com>
In-Reply-To: <CANiq72=cp+LTQhGMMmtWHLAk+AE81HOVB+2f06kQ9DXtBz+NyA@mail.gmail.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Mon, 1 Nov 2021 10:18:48 -0400
Message-ID: <CAL1p7m6ernt3fHMkLRePEWo5aqfb_6N+upt4a9GQPdzSrrpUHQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Raspberry Pi Sense HAT driver
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org,
        Fedora RPi <fedora-rpi@googlegroups.com>,
        Mwesigwa Guma <mguma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the suggestion, we weren't sure what the right "Xxx-by:"
was for this circumstance so we will use this in subsequent patchsets.

Best,
Joel Savitz

Best,
Joel Savitz


On Sun, Oct 31, 2021 at 12:39 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Oct 29, 2021 at 11:58 PM Charles Mirabile <cmirabil@redhat.com> wrote:
> >
> > Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> > Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
>
> Please note that you need to write `Co-developed-by: ...` (see
> `Documentation/process/submitting-patches.rst`); otherwise, it looks
> as if this was sent through several layers.
>
> Cheers,
> Miguel
>

