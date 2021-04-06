Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5669354D42
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 09:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244134AbhDFHEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 03:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244127AbhDFHD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 03:03:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44222613B8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 07:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617692631;
        bh=II8YJ4JpSpwhgMcptjuIr56mrDAfmcCfLHzLMKpNCvA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ByyDvuwSdJXkM5eF8EtxUtzQTmqJOIOlpTzdi6IcHkuS4bAtCmElURf8u26OypzKL
         f93bglG4HOvZBBAUgJFenNmRoL5E2NfiqmIt213wFKP8o2b3HCz5fn7wcyLNCbjbCq
         Hx+8SMXzaWLMOahqKkS23d62nlNOnzJ+P6NxwdARxMEnu0gtps11uGV1dU5rvYb7uZ
         E2RPU+79YUPAjwaZoVdHhk/YGUp9nm3lSuvHTDtx2PIfoK/phI+Ljdw0PcRY/zBifr
         afP8KtaoMq1VtJaqBa5t9V0KHThxY7nJabE5uh3n/S52ofXemRATBUgFmw71R37aj5
         KbnAQurXDVNOA==
Received: by mail-ot1-f52.google.com with SMTP id s11-20020a056830124bb029021bb3524ebeso13756683otp.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 00:03:51 -0700 (PDT)
X-Gm-Message-State: AOAM5311PFaLIckX+fR7MdP4PXmex5KHLc1TPxIs6yUbKJuX4OZ+61Du
        1esi+LxzAAVII6g8chhizzWPyorrtvz48ITS5FY=
X-Google-Smtp-Source: ABdhPJxrTxtZeO0biblExtyWdMjqEFT3VrL3Bqkcwi8jDWJBxLPUQVcNeB2fB+TlKFgDVxmiGCNx/q61axFQ4CkBLHs=
X-Received: by 2002:a9d:758b:: with SMTP id s11mr25666929otk.305.1617692630538;
 Tue, 06 Apr 2021 00:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <YGpTTbWENcr1EejC@kali>
In-Reply-To: <YGpTTbWENcr1EejC@kali>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Apr 2021 09:03:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3-JYvNc36RSeaDVnr737MgabmrESQCL9K2kWqqAM2neg@mail.gmail.com>
Message-ID: <CAK8P3a3-JYvNc36RSeaDVnr737MgabmrESQCL9K2kWqqAM2neg@mail.gmail.com>
Subject: Re:
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     manish@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        gregkh <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 5, 2021 at 2:03 AM Mitali Borkar <mitaliborkar810@gmail.com> wrote:
>
> outreachy-kernel@googlegroups.com, mitaliborkar810@gmail.com
> Bcc:
> Subject: [PATCH] staging: qlge:remove else after break
> Reply-To:
>
> Fixed Warning:- else is not needed after break
> break terminates the loop if encountered. else is unnecessary and
> increases indenatation
>
> Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> ---
>  drivers/staging/qlge/qlge_mpi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/staging/qlge/qlge_mpi.c b/drivers/staging/qlge/qlge_mpi.c
> index 2630ebf50341..3a49f187203b 100644
> --- a/drivers/staging/qlge/qlge_mpi.c
> +++ b/drivers/staging/qlge/qlge_mpi.c
> @@ -935,13 +935,11 @@ static int qlge_idc_wait(struct qlge_adapter *qdev)
>                         netif_err(qdev, drv, qdev->ndev, "IDC Success.\n");
>                         status = 0;
>                         break;
> -               } else {
> -                       netif_err(qdev, drv, qdev->ndev,
> +               }       netif_err(qdev, drv, qdev->ndev,
>                                   "IDC: Invalid State 0x%.04x.\n",
>                                   mbcp->mbox_out[0]);
>                         status = -EIO;
>                         break;
> -               }
>         }

It looks like you got this one wrong in multiple ways:

- This is not an equivalent transformation, since the errror is now
  printed in the first part of the 'if()' block as well.

- The indentation is wrong now, with the netif_err() starting in the
  same line as the '}'.

- The description mentions a change in indentation, but you did not
   actually change it.

- The changelog text appears mangled.

        Arnd
