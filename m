Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652113F59E0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbhHXIco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbhHXIcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:32:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF567C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:31:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f10so12233105wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtst-co-kr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TnEE4WDBdrIjf8ZQY8z7Cx3+EY+yZnYOwZyLdfohe2w=;
        b=ocizO4608zniyP1ZKKqG5IHcL9X9zmsnp8VqCc4DrPyhk/PPWIKoz6Gl6it9+OCSxj
         e+5qLeVCMpLlCEAMZweirc4LKy3tn1Gck/+mSs/0nSzIEfUhI3vqpBZK/SyPg6P/kl8p
         UUBoMBTohQajVzz6XjEnrJdFTyz1XGjLDY+kSm/+xuR8JVWsW7SW3Zc+nRag6bR7t4SG
         WAly/o5y1ZmYjBEw3pVpcibIy/hFrP+2xXVpfOEPX7aOMX5aq2Uv+T+rYxQ3Erk9y7BU
         B1OTjA7oHUibJDkFkAmTRvu4bqZ3xvqnf8ISeMuaoeShv4QAG+zJAMG33UBBN+22PZ4F
         owrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TnEE4WDBdrIjf8ZQY8z7Cx3+EY+yZnYOwZyLdfohe2w=;
        b=IGmqhxMCLmxaUTK/NY4cwvUhn4XyHAcUoORiTgD7DBRltkGKZrD3ToAwsP7v1D31dE
         izw79D7rpQk/MnZ0oR90wsiy3k1w/e3OLNNRDAdETUCl2gINPwhaXU8ulgwfecmnSinw
         98BgMYmVtX8P4qUy4Rcomxb30QYIXC+avDf2NCwM27V07hy/5At8pWsm1HpKgR9OqLqL
         7AJQJCGueuz0+ZF55XqjNFVL0JA3Hcehyug8LA4jrePh410CRvudw3QhyGDSyv+kVxJI
         U/UwOtFuNFJWnQhUKk4q7vdDJc/Rbn0JVGrjWHcYZJUBw0tXgNcV/mkKse1aFKpUiz23
         7M5A==
X-Gm-Message-State: AOAM531MYPDs9KTt2D3R3E2/fS3AxAMM2RvbZfuhwFL9QZTw5xrNWNzU
        Mpt6XZH7Vp8F72nRGyDRYkJ8VpYz0LQgsjjBvT9zeg==
X-Google-Smtp-Source: ABdhPJwRpkVUDRptqamQvbig52Q5aC/Ir1MxA3ZnC2ZKSP1LiqvIiwZhiWNTaaH7+8DUXlUMjJj81NrTZze04xlB1CM=
X-Received: by 2002:a7b:c316:: with SMTP id k22mr2900561wmj.56.1629793915785;
 Tue, 24 Aug 2021 01:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210817064353.GA669425@ubuntu>
In-Reply-To: <20210817064353.GA669425@ubuntu>
From:   Jeaho Hwang <jhhwang@rtst.co.kr>
Date:   Tue, 24 Aug 2021 17:31:44 +0900
Message-ID: <CAJk_X9gbnx5edLmxKUfZYyDMQYKeotO3undgQygmp1skn2HjSQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: chipidea: add loop timeout for hw_ep_set_halt()
To:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux team <team-linux@rtst.co.kr>,
        =?UTF-8?B?67OA66y06rSRKEJ5ZW9uIE1vbyBLd2FuZykv7J6Q64+Z7ZmU7JewKUF1dG9tYXRpb24gUGxhdGZvcm0=?=
         =?UTF-8?B?7Jew6rWs7YyA?= <mkbyeon@lselectric.co.kr>,
        =?UTF-8?B?7LWc6riw7ZmNKENob2kgS2kgSG9uZykv7J6Q64+Z7ZmU7JewKUF1dG9tYXRpb24gUGxhdGZvcm3sl7A=?=
         =?UTF-8?B?6rWs7YyA?= <khchoib@lselectric.co.kr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021=EB=85=84 8=EC=9B=94 17=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:44, J=
eaho Hwang <jhhwang@rtst.co.kr>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> If ctrl EP priming is failed (very rare case in standard linux),
> hw_ep_set_halt goes infinite loop. waiting 100 times was enough
> for zynq7000.
>

Hi Peter.
I found from zynq7000 TRM that the hardware clears Stall bit if a
setup packet is received on a control endpoint.
I think hw_ep_set_halt goes infinite loop since:

1. hw_ep_prime for control EP which is called from
isr_tr_complete_handler -> isr_setup_status_phase is failed due to a
setup packet received.
2. in isr_tr_complete_handler it tries to call _ep_set_halt if either
isr_tr_complete_low or isr_setup_status_phase returns error.
3. Since the control EP got a setup packet, HW resets TXS bit just as
the driver sets inside hw_ep_set_halt so it goes infinite loop.

Does it make sense? If it is right, we shouldn't call _ep_set_halt if
the err is -EAGAIN, which could be returned ONLY due to the setup
packet issue described above.
And the loop timeout is not required anymore.

Can I ask your opinion on this, Peter and USB experts?

Thanks.

> Signed-off-by: Jeaho Hwang <jhhwang@rtst.co.kr>
>
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index 8834ca613721..d73fadb18f32 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -209,6 +209,9 @@ static int hw_ep_prime(struct ci_hdrc *ci, int num, i=
nt dir, int is_ctrl)
>         return 0;
>  }
>
> +/* enough for zynq7000 evaluation board */
> +#define HW_EP_SET_HALT_COUNT_MAX 100
> +
>  /**
>   * hw_ep_set_halt: configures ep halt & resets data toggle after clear (=
execute
>   *                 without interruption)
> @@ -221,6 +224,7 @@ static int hw_ep_prime(struct ci_hdrc *ci, int num, i=
nt dir, int is_ctrl)
>   */
>  static int hw_ep_set_halt(struct ci_hdrc *ci, int num, int dir, int valu=
e)
>  {
> +       int count =3D HW_EP_SET_HALT_COUNT_MAX;
>         if (value !=3D 0 && value !=3D 1)
>                 return -EINVAL;
>
> @@ -232,9 +236,9 @@ static int hw_ep_set_halt(struct ci_hdrc *ci, int num=
, int dir, int value)
>                 /* data toggle - reserved for EP0 but it's in ESS */
>                 hw_write(ci, reg, mask_xs|mask_xr,
>                           value ? mask_xs : mask_xr);
> -       } while (value !=3D hw_ep_get_halt(ci, num, dir));
> +       } while (value !=3D hw_ep_get_halt(ci, num, dir) && --count > 0);
>
> -       return 0;
> +       return count ? 0 : -EAGAIN;
>  }
>
>  /**
> --
> 2.25.1
>
