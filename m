Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E3D3BB693
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 07:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhGEFH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 01:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhGEFH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 01:07:26 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D24C061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 22:04:49 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p24so22951408ljj.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 22:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzm0nWj/aTYJHOKXonLiG7z2GGnZubrdTmRQ0xRi/ZI=;
        b=A7xlaSndZwByNH1ngHi12Wy4wDajC6l1MlhCftDjaKo5zes9hg+ZZImW9ll3V2hBiX
         Y+iX+Fq9yigCH+771Lca7wXR92k0ABqkWePAkW9suWUo0E2GTeeqMYOeX9v5NysFKOnq
         nAJp8E0T7iCgoGRwvXnArWptJ45g9Uibv9rCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzm0nWj/aTYJHOKXonLiG7z2GGnZubrdTmRQ0xRi/ZI=;
        b=T7GSz9T+YZfYDBjX9i9nZhJPLu8bFyS1J4/UX21xOc3IePmkLhz1G8ug+C52ZMfEN7
         /KdpyLHIeqm1JAcX2XNNY5BuFbl1J4O4Rm8THjI/rUzJ43rrUdx4LBbYosWiaBg9HnzP
         JJZ3vKMXjWO0dFaeso0VKm+85N1He41XqtnvmMi+jDxafvla9JGJidlG3j09mm9ZR+Qp
         40sVsTZiz1pbz8JVeOm5feyAQn/YaJ/rjkMHopR6VCLGxEj4XxLSbyjlMslHeeqT/oTg
         pqCDcd5LrPTVvjny0x3rss7dI9lI2QaWod+Q5vRlqvcvqZvEbtKAVwd+fNnLBHSULQGA
         LQRQ==
X-Gm-Message-State: AOAM531m5pYdGBq0jjuYK9QX8AB+bCAp510xEwLyp7UE0jUN10cuh7aY
        Jv8iREvxT46i8qIcaQG246F8onfdC4gDQA==
X-Google-Smtp-Source: ABdhPJzBAI64Ui4pHiyw0dVQ2fWIX+pX1qJ1rKUJpj/FhZDH6V+78tD4sPA0Hh54B7/gUqaxqRq9Mg==
X-Received: by 2002:a2e:9e04:: with SMTP id e4mr9557609ljk.431.1625461487911;
        Sun, 04 Jul 2021 22:04:47 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id d5sm970730lfs.1.2021.07.04.22.04.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 22:04:47 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id bq39so17564222lfb.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 22:04:47 -0700 (PDT)
X-Received: by 2002:a19:5e16:: with SMTP id s22mr9437459lfb.614.1625461486444;
 Sun, 04 Jul 2021 22:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143011.1175546-1-acourbot@chromium.org>
 <20210519143011.1175546-6-acourbot@chromium.org> <9b37044d-f909-9169-3d22-fa6c5f788822@collabora.com>
In-Reply-To: <9b37044d-f909-9169-3d22-fa6c5f788822@collabora.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 5 Jul 2021 14:04:35 +0900
X-Gmail-Original-Message-ID: <CAPBb6MV35sJ-LY8w-nhpnndRHtJXapSN63xFzUiAbYQFLvm1dQ@mail.gmail.com>
Message-ID: <CAPBb6MV35sJ-LY8w-nhpnndRHtJXapSN63xFzUiAbYQFLvm1dQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] media: mtk-vcodec: venc: support START and STOP commands
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna, sorry for (again) taking so long to come back to this! >_<

On Fri, May 28, 2021 at 4:03 PM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
> Hi,
>
> I applied this patchset and tested the stateful encoder on debian with the command:
>
> [gst-master] root@debian:~/gst-build# gst-launch-1.0 filesrc location=images/jelly-800-640.YU12 ! rawvideoparse width=800 height=640 format=i420 ! videoconvert ! v4l2h264enc ! h264parse ! mp4mux ! filesink location=jelly-800-640.mp4
>
> I get:
>
> Setting pipeline[   79.703879] [MTK_V4L2] level=0 fops_vcodec_open(),190: encoder capability 10000000
>   to PAUSED ...
> Pipeline is PREROLLING ...
> Redistribute latency...
> [   80.621076] mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to full flush
> [   80.631232] mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to full flush
> [   80.640878] mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to full flush
> [   80.650766] mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to full flush
> [   80.660430] mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to full flush
> [   80.670194] mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to full flush
> [   80.680967] mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to full flush
> [   80.691376] mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to full flush
> [   80.701718] mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to full flush
> [   80.712106] mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to full flush
> [   80.722272] [MTK_V4L2] level=0 mtk_venc_set_param(),371: fmt 0x3, P/L 0/0, w/h 800/640, buf 800/640, fps/bps 25/4000000, gop 0, i_period 0
> Pipeline is PREROLLED ...
> Setting pipeline to PLAYING ...
> New clock: GstSystemClock
> [   81.918747] [MTK_V4L2][ERROR] mtk_vcodec_wait_for_done_ctx:32: [3] ctx->type=1, cmd=1, wait_event_interruptible_timeout time=1000ms out 0 0!
> [   81.931392] [MTK_VCODEC][ERROR][3]: h264_encode_frame() irq_status=0 failed
> [   81.938470] [MTK_V4L2][ERROR] mtk_venc_worker:1219: venc_if_encode failed=-5
> [   82.974746] [MTK_V4L2][ERROR] mtk_vcodec_wait_for_done_ctx:32: [3] ctx->type=1, cmd=1, wait_event_interruptible_timeout time=1000ms out 0 0!
> [   82.987392] [MTK_VCODEC][ERROR][3]: h264_encode_frame() irq_status=0 failed
> [   82.994471] [MTK_V4L2][ERROR] mtk_venc_worker:1219: venc_if_encode failed=-5
> [  104.163977] cros-ec-dev cros-ec-dev.2.auto: Some logs may have been dropped...
> 0:00:00.4 / 99:99:99.
> 0:00:00.4 / 99:99:99.
> 0:00:00.4 / 99:99:99.
> 0:00:00.4 / 99:99:99.
> 0:00:00.4 / 99:99:99.
> 0:00:00.4 / 99:99:99.
> 0:00:00.4 / 99:99:99.
> 0:00:00.4 / 99:99:99.
> 0:00:00.4 / 99:99:99.
> 0:00:00.4 / 99:99:99.
> ^Chandling interrupt.
>
> And then the streaming hangs. The same error happens without this patchset, but without
> this patchset the statful encoder does not support V4L2_ENC_CMD_STOP/START needed by the spec.
> I am not sure what cause the error and wether those mtk-iommu erros has to do with that. The issue
> could also come from the mtk-vpu used by the encoder.
> Do you have any idea where this can come from?

Mmm, this looks like the firmware is unhappy about something and
hangs. I wonder if the IOMMU messages above could not be linked to
that, I remember seeing similar problems when the buffers were not
properly synced on the device side.

I'll try and see if I can deploy gstreamer on the old MT8173
Chromebook I am using to see if I have more success here, but no
guarantee I can test in the same conditions as you unfortunately. :/

The MTK folks are the most qualified to look into this issue though.
Yunfei, do you have any idea about why this is happening?
