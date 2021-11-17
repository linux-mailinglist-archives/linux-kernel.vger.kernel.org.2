Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4F24550A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 23:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbhKQWlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 17:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241381AbhKQWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 17:41:22 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57318C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 14:38:23 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id h23so4423635ila.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 14:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++yK/fefOCnm5/0BEaS3pGjqkSD2xStfuHUGZISxXZo=;
        b=PwDl7vqqUSkJvq7T+MXFYsdBvi3ghKL9+p2yzxKB11sb3Q0OskN6YGorN6NlN4j3Vb
         /D5btlCUAkuaxJvxF/qjZwFTgpKYwm4r7W3FWOY2+Zf2cQL4YOnHIS98IIGwv5OgNm+N
         Fwu5WtCjHanUdDjGxGUbQCXXpmFGVQ6KxCBYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++yK/fefOCnm5/0BEaS3pGjqkSD2xStfuHUGZISxXZo=;
        b=3r4DCrCllaJULViHQhp4Tt+1nlPZvN1+LoLGOLlLViWidxfzNfPE9fjrx4m7qR+nuy
         rVKahTiCJ/RyYdW4D+lUrksPcHUM73M957w3jUIz4A63d+XikLUape3tLqiJvO/t2zW3
         jn2CRZFiRG8CJtKM6A4wBZfEedBvmhGR2VfrAS+vTBKYR5m7WnoAmaHFS0ebZiE/XC78
         ihJP9Q2/AgulEc1Vndcr5LMVXrhb8gEpN8qdWzW6jI1o5TwsDj+vdx7wRDCS2qUnxDCn
         gGUBV5z6q3TlHQZdJdlc9HkWtq/gL88C7/2hphGLr87Qco9nZbO2Rz3gECfoZ4QTf7hX
         uq6w==
X-Gm-Message-State: AOAM530iC+zFKXxwME4e5ca7JTSMEQ0r4K7RVaA0b49c2s0PmsO7Guc1
        vdk7f7jq07scIeadGlCE6uXIuSjj3eLaFw==
X-Google-Smtp-Source: ABdhPJwbpoASgn3lQQCJcQBiFI6pCW4blUQwQyoZip53TC1wO7COj+HC9+r429a74u0izXcOGyTRWg==
X-Received: by 2002:a92:c08d:: with SMTP id h13mr12565764ile.60.1637188702709;
        Wed, 17 Nov 2021 14:38:22 -0800 (PST)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id m3sm684558ilg.59.2021.11.17.14.38.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 14:38:22 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id w22so5434574ioa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 14:38:22 -0800 (PST)
X-Received: by 2002:a6b:440f:: with SMTP id r15mr13770158ioa.128.1637188701810;
 Wed, 17 Nov 2021 14:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20211117133110.2682631-1-vkoul@kernel.org>
In-Reply-To: <20211117133110.2682631-1-vkoul@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Nov 2021 14:38:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UQ+NteFBV0reov4nadZioBPsvuDdgd1gE0Pt+ojwevVQ@mail.gmail.com>
Message-ID: <CAD=FV=UQ+NteFBV0reov4nadZioBPsvuDdgd1gE0Pt+ojwevVQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] spi: qcom: geni: remove unused defines
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 17, 2021 at 5:31 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> Commit b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
> added GPI support but also added unused defines, so remove them
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
