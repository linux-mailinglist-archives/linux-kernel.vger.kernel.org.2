Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F8C43B7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbhJZQzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbhJZQzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:55:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87C7C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:53:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d13so17942122wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DM+aJPjsd48FUeJElqQHCbFgsOMymWLw+lsiNqSlzXg=;
        b=WJX7nKNlKxTAaJ1K5jyrLkCetXEeMs36mDlugrjFC97UEg9FEHzPJTBavQBb70HNMV
         AFkH5K1juVFYViscnCu/1CTEnL/WR8nxZhcBmVXn2N7rBRQh8FrgV7siPVVf0oHaHiec
         /5vNHxf6bvxq6dBIPSqpRuLqPQARibnsfOQsWVAyVVNO2NwcBH9gtfyY2b1M7N2Y55xQ
         UXCLTxaH0tmkv5Mj7Viw0Dp2YBgy/lQ+b30P5QUnLZYjy2fF/u4s6OaOrdwjnN3H7Z+x
         AVpph8NVC00eG1Cx4jUbLfxpQOvnlHVd7a8QKW4IRJJMTeq7G6+vwbAkVj0Y8A/InNNT
         DATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DM+aJPjsd48FUeJElqQHCbFgsOMymWLw+lsiNqSlzXg=;
        b=1tztM/Ui0GLvz0V7f9pqR3Rg2z41+5IKYTid4d0Ruk5Y2/gYH4YoeEasIfQYCconev
         kJDZJPz4KOpapZ3YLatlMtU5aYMM3WUrpBYDiqOhAoL4HWoObpR+rBOehDuGkn/avMTf
         JoVULYs858cOE7CkwV1oBljQZQwvjJXsa7qGqG8aDfmEOdvI+WfnwOwWNSTm0pj+5rJD
         /Pl4Q5defcRbCGrRb7Ct7KoigzAXFRczbMmFErpdrbIfRc8Fs4CRkcqz0dmfxiz1pvGM
         uE8OOPxRG/QIdHOdIlQfn8aCBhpjVRfmh+ekp12C4CvnF5MDpeo+t93sHjaHYb4L4tCL
         QXfw==
X-Gm-Message-State: AOAM532j6lLL1yDw6+zYSvUvwYJ4/ndHi30SQx+S4/tB6rZq1wtWe1Ut
        rRxIemSlUpEe2+cItrcWPSY8iSW9IVofuRtMPPw=
X-Google-Smtp-Source: ABdhPJyv6ySr3f13pX6/rGh854q2f2e9oKVNMojw5SdliRIWOoFzd/ZKJto0acTyBgFOYHKPuhpm0VnEbXNTqB4MmcU=
X-Received: by 2002:a5d:64c8:: with SMTP id f8mr33527882wri.398.1635267190450;
 Tue, 26 Oct 2021 09:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <1635204907-412-1-git-send-email-quic_abhinavk@quicinc.com>
In-Reply-To: <1635204907-412-1-git-send-email-quic_abhinavk@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 26 Oct 2021 09:58:01 -0700
Message-ID: <CAF6AEGvZRuhRXnMzcMyo8DvPw6ASkLyPOaAE8ufW6du37Y7Q4g@mail.gmail.com>
Subject: Re: MAINTAINERS: update designated reviewer entry for MSM DRM driver
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, nganji@codeaurora.org,
        aravindh@codeaurora.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 4:35 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Adding myself as a designated reviewer to assist with the
> code reviews for the changes coming into MSM DRM.
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Acked-by: Rob Clark <robdclark@gmail.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b33791..503112d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5938,6 +5938,7 @@ M:        Sean Paul <sean@poorly.run>
>  L:     linux-arm-msm@vger.kernel.org
>  L:     dri-devel@lists.freedesktop.org
>  L:     freedreno@lists.freedesktop.org
> +R:     Abhinav Kumar <quic_abhinavk@quicinc.com>
>  S:     Maintained
>  T:     git https://gitlab.freedesktop.org/drm/msm.git
>  F:     Documentation/devicetree/bindings/display/msm/
> --
> 2.7.4
>
