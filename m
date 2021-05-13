Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E01C37F3F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhEMIWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhEMIWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:22:35 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17328C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:21:26 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j10so37419429lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1/k0C0U/4PbCo991QeF2hoImjtMAGcUEqpPrZUi0VU=;
        b=jvrERVq6t/rzqVFu5XXz1l714GDGaw+rZ2nZkXdo5ZA4kxNgtgacNNYTqgBq7ljbPt
         ZQzQrX1xchRvSyhS+xX5bX5e8o7ab0h1+adzpkLXYEF+bHLaoI+EAiKAvganCkziUM6g
         YF3zBMriWEJL1Py4KmP7dyRYufrukQ14QIzk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1/k0C0U/4PbCo991QeF2hoImjtMAGcUEqpPrZUi0VU=;
        b=VSkQn1zpjKA2cP33WzBes/e5ag84fiB7jkT1pk32nZme2Hz1E/9mCbTUxL/yht3XvU
         qCAj3dJ5W0HOJQmqNWoRcLpGe/dYzggotGwQZ5SxePG9/y7nTYbAW8gdtVG8fnzLSUC/
         d0gd+G6SrxYJoSM9WsUup9ZSvkwtbNT3W/k7eyq0DsBgny01qhJHhSvDWVX8Mnhpgakv
         eRvl+5kkYx85SnEw6Qo98L3SZED55O4SNZe/5dnvfYnxwTHIWA+c+OQbDYl7sBehJI7X
         Jkgi1N0zaVZXi6B4GNaW/22G0HMIeTpUyBhGOMXjTM6ngDBnsIXy5cv3m9wKGaTdPIbW
         68ZQ==
X-Gm-Message-State: AOAM532CJU0+AAxJYG8nUIHJlDG8cvqClrOSX8U1El1BIGdt9Y1dEQfa
        wfR4n6Mb8+/xjgHKIEh/+Z/QwvpwnQb5wg==
X-Google-Smtp-Source: ABdhPJx2l2Pw4QUL7yNhQDN6DNz852NFvCEX+JFfq75LFIFXlwWhTsf8t+lve5bilV4KG1kzdUtp5g==
X-Received: by 2002:a19:674d:: with SMTP id e13mr28674292lfj.652.1620894084353;
        Thu, 13 May 2021 01:21:24 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id q34sm358661lje.56.2021.05.13.01.21.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 01:21:23 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id c3so37446969lfs.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:21:23 -0700 (PDT)
X-Received: by 2002:a19:c10:: with SMTP id 16mr24165709lfm.332.1620894082924;
 Thu, 13 May 2021 01:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210427111526.1772293-1-acourbot@chromium.org> <976d420c-b4fc-bc23-c398-9b3a7ab4ffc9@collabora.com>
In-Reply-To: <976d420c-b4fc-bc23-c398-9b3a7ab4ffc9@collabora.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 13 May 2021 17:21:11 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVcnei2OLFYG-2YyqZrY8JvA-CJN6SUv=vGRmOZ2Af47g@mail.gmail.com>
Message-ID: <CAPBb6MVcnei2OLFYG-2YyqZrY8JvA-CJN6SUv=vGRmOZ2Af47g@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] media: mtk-vcodec: support for MT8183 decoder
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

On Thu, Apr 29, 2021 at 9:07 PM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
> Hi,
>
> On 27.04.21 13:15, Alexandre Courbot wrote:
> > This series adds support for the stateless API into mtk-vcodec, by first
> > separating the stateful ops into their own source file, and introducing
> > a new set of ops suitable for stateless decoding. As such, support for
> > stateful decoders should remain completely unaffected.
> >
> > This series has been tested with both MT8183 and MT8173. Decoding was
> > working for both chips, and in the case of MT8173 no regression has been
> > noticed.
>
> I am trying to test the decoder with this patchset using v4l2-ctl on mt8173.
>
> I am trying to decode an h264 file into V4L2_PIX_FMT_MT21C format.
> I am not able to do it. It seems that the driver expects each buffer to start
> with a nal starting code, and the v4l2-ctl command just read the files into
> buffers without any parsing.
>
> Can you share the command and the files you used for testing?

I have been using the Chromium test suite (aka
video_decode_accelerator_tests). I had doubts after reading your email
but I tested the series again using this tool and confirmed it was
working.

Unfortunately this test is not easy to build, but maybe if you have a
Chromium environment ready you can run it. mtk-vcodec does expect the
input buffers to be split by NAL units (as per the spec [1] IIUC), so
that would explain why v4l2-ctl failed (I assume that it also fails
without this series?).

Maybe ffmpeg can also be used to exercice this driver with properly
split NAL units, but I am not familiar with its use with V4L2. I'm
also not sure it would be happy about the MT21C format that the driver
outputs, or that it could pick the MDP to convert it to something
readable...

Cheers,
Alex.

[1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/pixfmt-compressed.html#compressed-formats
