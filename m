Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711F833751E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhCKOI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbhCKOIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:08:35 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DD3C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:08:35 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y20so3691783iot.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nvUep30MhS7eKX27VJOtU3nQKdMk30KOK/OCrCoZ3t8=;
        b=iUwZzjiNt5FbTsrpQQYi9Sa27joiQf4AYrgmqr6yNh6GLi+vD1Cz59etVUsWY+Afjr
         mfKbkMgE7qWWpmNoBcjrGeU8N1Eq9j0oceKxcn1zEtme/NrzarFsv5HPP2T/39Lk2OaL
         n2/dTiPaH7hmqcH/2M9GkdaasZiujt5kGIJJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nvUep30MhS7eKX27VJOtU3nQKdMk30KOK/OCrCoZ3t8=;
        b=nt5s/X+lIJ4jWOwGtH0+ap2s0hQJK8QDRy8BeF+6GboXAFQOTMKN31RS8v97VmVtvw
         4YVc9TcVFe44j2MgmMuoJB3JZ/+2xNl6BFumQ4Gp4IVDs/iFbRq0f/kUXkB/p1TlT/kK
         9+Ej8V1p7QXjAs0k2lwSs3ig8I01Syu90TeCAhgBwT5oRXRflJYsvEUm299wRUHrEBNq
         W3aiQ0z3eixPq43RwS1CYbQWSNVlgbsWqVLk+Dz31M+gMGLXpQLwlMQNrzU/XLpp1Hby
         0l1HTprkMl/SC/0OQNFH2Fgz6hnIC8WVgGxxgd0k/1AjC6uyzNYEL67190jUagQaNCTo
         e2oQ==
X-Gm-Message-State: AOAM533yBPxGH6Mus0dcRRlxwR7EV8HnI3AM/tOmGJuFTxBLY0NXNtFD
        zzvaMKXRQuGAzfbTjqYGocaHrWBhKsC3CjIw
X-Google-Smtp-Source: ABdhPJySVhiT/KOBRew1cS6X+iVD+XiYXOnH1VcAqTTtlFnfZ+/rNkrsVIDwUFmwxMBH96oAvKYsKQ==
X-Received: by 2002:a6b:ec14:: with SMTP id c20mr6505590ioh.122.1615471714749;
        Thu, 11 Mar 2021 06:08:34 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id c9sm1413725ili.34.2021.03.11.06.08.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 06:08:34 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id z13so22006434iox.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:08:33 -0800 (PST)
X-Received: by 2002:a6b:e80a:: with SMTP id f10mr6395854ioh.51.1615471713397;
 Thu, 11 Mar 2021 06:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20210311122040.1264410-1-ribalda@chromium.org> <20210311122040.1264410-5-ribalda@chromium.org>
In-Reply-To: <20210311122040.1264410-5-ribalda@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 11 Mar 2021 15:08:22 +0100
X-Gmail-Original-Message-ID: <CANiDSCtw2q7UxMoZSMeE545WCxMs-WSHR2xbjG+xWL9CaBE3Aw@mail.gmail.com>
Message-ID: <CANiDSCtw2q7UxMoZSMeE545WCxMs-WSHR2xbjG+xWL9CaBE3Aw@mail.gmail.com>
Subject: Re: [PATCH 03/10] media: uvcvideo: Return -EIO for control errors
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed in the IRC with Hans

We need to specify in the commit message that this is most likely due
to hw error.

On Thu, Mar 11, 2021 at 1:20 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Fixes v4l2-compliance:
>
> Control ioctls (Input 0):
>                 fail: v4l2-test-controls.cpp(448): s_ctrl returned an error (22)
>         test VIDIOC_G/S_CTRL: FAIL
>                 fail: v4l2-test-controls.cpp(698): s_ext_ctrls returned an error (22)
>         test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index f2f565281e63..5442e9be1c55 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -113,7 +113,7 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
>         case 6: /* Invalid control */
>         case 7: /* Invalid Request */
>         case 8: /* Invalid value within range */
> -               return -EINVAL;
> +               return -EIO;
>         default: /* reserved or unknown */
>                 break;
>         }
> --
> 2.31.0.rc2.261.g7f71774620-goog
>


-- 
Ricardo Ribalda
