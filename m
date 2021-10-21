Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA64435CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhJUIXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhJUIXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:23:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0807C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:21:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w19so2177923edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hiUEvAk0D+Wzqjvqk+6FpLdxlRGHN8XahFm7bhkPck=;
        b=UsGpUysSmE0IX+iOcdYqPhwYRsS5qwrxwZb/H0tqdrKEiUZ/VuZ9GKWGaSrFHItYFG
         OYGP2LK9FUnAViP2sDpbmmEZFHg2JqHU+mAOIlnafuwSSK+RyRgCKG6m+mu6jpsS4nyZ
         E8ubjdLbqhGqmqqlZzLqA+WZjGmWQLRrtFRc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hiUEvAk0D+Wzqjvqk+6FpLdxlRGHN8XahFm7bhkPck=;
        b=M1fKIVqz99BCubHuy1C/wfZ1yZ+RAIvUZr1snBkgwsCf+YmbXE/iDVqEdJ1TD0Uvu6
         436iZKtlzOkpnmaL7078AF6N58nwt68rD0Mb4nYVR0Ek91CHCHfAahcEdA8Vczp8kQlD
         q8RQ3cr/WBj26soBQ9ozA0qxzV19dm7Ulvp3j1i1hh+AkbWOBZbb6YxVAm8TqfePrnR5
         kz6O43MTUXWsbBZLFeOHVhedDBdPFO0nEnz2JX/HCIefKf9sGaYC0GZvfrcf1Ea03BP7
         ZokircyFvQpSvriHVfzf3dUfTpfD3UJaU15RmdgdNgoEXHUIqZKYeM2jeSTqwsCkEQV3
         4HpA==
X-Gm-Message-State: AOAM530RZ1nj/aWtulMat+/aENOv9FfJgHFC+EBsXsOaJVDazZ1qGFjX
        r6pYVTFjP84xUD+SaO0f+tiFOnV0QxeD/A==
X-Google-Smtp-Source: ABdhPJxd8Grg1pg3or3V6o/vQ259VGn+6L6AQDLTWPmXfzZhNN0PylaEY/KIJHC800w22uMM45UP5g==
X-Received: by 2002:aa7:c394:: with SMTP id k20mr5996417edq.286.1634804489910;
        Thu, 21 Oct 2021 01:21:29 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id k23sm2377743edv.22.2021.10.21.01.21.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 01:21:29 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id g25so508007wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:21:28 -0700 (PDT)
X-Received: by 2002:adf:a51e:: with SMTP id i30mr5620040wrb.206.1634804488220;
 Thu, 21 Oct 2021 01:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211018091427.88468-1-acourbot@chromium.org>
In-Reply-To: <20211018091427.88468-1-acourbot@chromium.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 21 Oct 2021 17:21:16 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A_yoZPUw26Cza8KLh9VdgtbxWK9rezSbj4keJZt249NQ@mail.gmail.com>
Message-ID: <CAAFQd5A_yoZPUw26Cza8KLh9VdgtbxWK9rezSbj4keJZt249NQ@mail.gmail.com>
Subject: Re: [PATCH] media: docs: dev-decoder: add restrictions about CAPTURE buffers
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 6:14 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> CAPTURE buffers might be read by the hardware after they are dequeued,
> which goes against the general idea that userspace has full control over
> dequeued buffers. Explain why and document the restrictions that this
> implies for userspace.
>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  .../userspace-api/media/v4l/dev-decoder.rst     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/Documentation/userspace-api/media/v4l/dev-decoder.rst b/Documentation/userspace-api/media/v4l/dev-decoder.rst
> index 5b9b83feeceb..3cf2b496f2d0 100644
> --- a/Documentation/userspace-api/media/v4l/dev-decoder.rst
> +++ b/Documentation/userspace-api/media/v4l/dev-decoder.rst
> @@ -752,6 +752,23 @@ available to dequeue. Specifically:
>       buffers are out-of-order compared to the ``OUTPUT`` buffers): ``CAPTURE``
>       timestamps will not retain the order of ``OUTPUT`` timestamps.
>
> +.. note::
> +
> +   The backing memory of ``CAPTURE`` buffers that are used as reference frames
> +   by the stream may be read by the hardware even after they are dequeued.
> +   Consequently, the client should avoid writing into this memory while the
> +   ``CAPTURE`` queue is streaming. Failure to observe this may result in
> +   corruption of decoded frames.
> +
> +   Similarly, when using a memory type other than ``V4L2_MEMORY_MMAP``, the
> +   client should make sure that each ``CAPTURE`` buffer is always queued with
> +   the same backing memory for as long as the ``CAPTURE`` queue is streaming.
> +   The reason for this is that V4L2 buffer indices can be used by drivers to
> +   identify frames. Thus, if the backing memory of a reference frame is
> +   submitted under a different buffer ID, the driver may misidentify it and
> +   decode a new frame into it while it is still in use, resulting in corruption
> +   of the following frames.
> +
>  During the decoding, the decoder may initiate one of the special sequences, as
>  listed below. The sequences will result in the decoder returning all the
>  ``CAPTURE`` buffers that originated from all the ``OUTPUT`` buffers processed
> --
> 2.33.0.1079.g6e70778dc9-goog
>

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
