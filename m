Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0E83F3BBE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 19:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhHURao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 13:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhHURan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 13:30:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A1BC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:30:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h1so3471464pjs.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ogRJWET2r0ZEOHnVOELtmeC7ZrMSpFkdcuNji551as=;
        b=aUYENPN6rgHJHIRtDP5SuOnqohDKnGFcuyLASbIkSAy3azEHLpSODmRch5t/Cq2IfS
         PvxMEbzkDP7oR66bsaFh5CILC0rew2lj6omiRKv837tANzBXyDDQFHKUsYsfMlgh0Bjf
         vEm42pmLu6/UOEKcE5DUUuz+2uMtBUt4ljsYBuw8J53FGJcHy1qGgoa2qswkb7r90uiX
         fY98svuX56unTOCQ8sLc0naH3XYLoV+tmIHQJWNswyqpe+tUuOYvyNBG6Ozq7rwFqAAv
         c2LyKQ2tzzBdTcIIVlbPEZt/xYebsME/t+0/8pcgMlHvilxbYtpB3OMHopshP3debja0
         5qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ogRJWET2r0ZEOHnVOELtmeC7ZrMSpFkdcuNji551as=;
        b=VCeC6ZzgnajLYxKaLgTXJdvUZFFThNm1PmTC4koEIh7Cp0WkfcFlQ/ugszU9SmQ2lG
         niFS3Q0Yz+fBxTE1ZGyOIDbJPBsqV2SBYZFjPyqpqJLyrDzn95KInhf7DN+/6EGqbyF0
         CXCODELPni7pv6kPY2VZRGc0i6+jEqgRldjfcBXFokGWyY0C0QlX7xD3WZK3JEzJwiNy
         a1bqK9WQe125aq2uZGUkEC4Ruc70bUPZ7iypQWDPGI1oZaCGg2R8zolLeR+Rn8J+EIeJ
         t/mEUZ/bBaSsH0s5k5e5CrBxOF4nwRPC878iiqrVDZFgiF4O8hNuYp6h0+axIc99lxvi
         H1Sg==
X-Gm-Message-State: AOAM533qXzOCKHVMUM3T5OPtn12MzP6s24ubF3fxWx7LCPJ5v1azIAgW
        PvDIPh2Y6TrdtQDR/lmeh/jkXIhvNjVSLAWGfgr8Jw==
X-Google-Smtp-Source: ABdhPJxmh0gJTtCE/GD6VPl0t7VdpfwTluLfuU4t+pukNp5dVZFizZlMmaw6KVYm5WpxKg09hYQoiAWuu6sOZj3lN6E=
X-Received: by 2002:a17:902:f704:b029:11a:cdee:490 with SMTP id
 h4-20020a170902f704b029011acdee0490mr21501619plo.37.1629567003980; Sat, 21
 Aug 2021 10:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210821164859.4351-1-martin@kaiser.cx> <20210821164859.4351-9-martin@kaiser.cx>
In-Reply-To: <20210821164859.4351-9-martin@kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 21 Aug 2021 18:29:53 +0100
Message-ID: <CAA=Fs0nq2hHCY=kpeYCVX8-D9abnPqi5d0E0fe98kn77bbL1kw@mail.gmail.com>
Subject: Re: [PATCH 09/10] staging: r8188eu: remove unused members of struct _io_ops
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2021 at 17:50, Martin Kaiser <martin@kaiser.cx> wrote:
>
> Remove function pointers which are not used by the r8188eu driver.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/include/rtw_io.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
> index f1b3074fa075..4b41c7b03972 100644
> --- a/drivers/staging/r8188eu/include/rtw_io.h
> +++ b/drivers/staging/r8188eu/include/rtw_io.h
> @@ -100,13 +100,10 @@ struct _io_ops {
>                           u8 *pmem);
>         void (*_write_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
>                            u8 *pmem);
> -       void (*_sync_irp_protocol_rw)(struct io_queue *pio_q);
> -       u32 (*_read_interrupt)(struct intf_hdl *pintfhdl, u32 addr);
>         u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
>                           u8 *pmem);
>         u32 (*_write_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
>                            u8 *pmem);
> -       u32 (*_write_scsi)(struct intf_hdl *pintfhdl,u32 cnt, u8 *pmem);
>         void (*_read_port_cancel)(struct intf_hdl *pintfhdl);
>         void (*_write_port_cancel)(struct intf_hdl *pintfhdl);
>  };
> --
> 2.20.1
>

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
