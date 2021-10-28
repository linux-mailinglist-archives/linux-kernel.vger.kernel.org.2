Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7DB43F1D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 23:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhJ1VgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 17:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhJ1VgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 17:36:19 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013C4C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 14:33:52 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id z126so10237912oiz.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 14:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ojtgT//7p7t10p7AJbgEBlvuMnFN3DnPO87emGYBPlo=;
        b=dOBpw4p+OyNuZ2q2pbtiHIDy0of27aYm+errnGezomSb4EzF587zcp3XyKPZKn0xUD
         spwGOEA/IRD4CkdZDRXcy2HiRDXyRPqihqHl9xr053n57sKFpi/ezlFFjKsWqjvvifdV
         vOOacmOsQTpGvspg1qEgiSjw7oNKit2slbMHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ojtgT//7p7t10p7AJbgEBlvuMnFN3DnPO87emGYBPlo=;
        b=X6unznvsrkHQtsZtNq4TmY+sYL9xOECQ6/pFOmtLFMx5rW9dORPCqcYRAoA9ZQis43
         cybXnnTR2odv6LTbadOcuHNs1oixS6Xh456yif9ekx/qAlXOmC9U4S//x9cmzFChy5Y8
         Yp5EHjYVOF0N06Mkcr3B/DgvSjAIZQ2O9ugn8IJkZRgerEnIS48Sdg4gelcOcQCckuvw
         ZP+y27MiZYXKXtzkHW2yap5L551rwPWL2O4qe0KUJwTqvWDjI/gDTCD1hitUAtLlresd
         2lIs9wl+hVt4OtoBfia8CyQWjcuQp8Wwzt+ic88igDO5CmN+N2PlXIGzvZjLvXXV9Ye3
         tP7w==
X-Gm-Message-State: AOAM5334GHkK3SeFHnBjBN54v8vhGLI4IpEintknB6gLlzHwVw0OK4k8
        WdEA7J7EzMXpEgTMouC/n9k0c2XK+iYj6w==
X-Google-Smtp-Source: ABdhPJzOi2GemcdQUTVA7iMvH3y4IrHw8pi8BmOZK+Pwta3eIG6ooR5n67fFf0IUGiEHWSDRiy5Hog==
X-Received: by 2002:a05:6808:643:: with SMTP id z3mr5041893oih.156.1635456831108;
        Thu, 28 Oct 2021 14:33:51 -0700 (PDT)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id s124sm546589ooa.25.2021.10.28.14.33.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 14:33:50 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id s23-20020a056830125700b00553e2ca2dccso5704613otp.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 14:33:50 -0700 (PDT)
X-Received: by 2002:a05:6830:4009:: with SMTP id h9mr5296087ots.186.1635456439298;
 Thu, 28 Oct 2021 14:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211028073729.24408-1-verdre@v0yd.nl>
In-Reply-To: <20211028073729.24408-1-verdre@v0yd.nl>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 28 Oct 2021 14:27:06 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOrad3b=b8+vwuF6m3+ZcigVaoJySpDXXZOnC3O8CJBSw@mail.gmail.com>
Message-ID: <CA+ASDXOrad3b=b8+vwuF6m3+ZcigVaoJySpDXXZOnC3O8CJBSw@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: Add quirk to disable deep sleep with certain
 hardware revision
To:     =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 12:37 AM Jonas Dre=C3=9Fler <verdre@v0yd.nl> wrote:
>
> The 88W8897 PCIe+USB card in the hardware revision 20 apparently has a
> hardware issue where the card wakes up from deep sleep randomly and very
> often, somewhat depending on the card activity, maybe the hardware has a
> floating wakeup pin or something.

What makes you think it's associated with the particular "hardware
revision 20"? Have you used multiple revisions on the same platform
and found that only certain ones fail in this way? Otherwise, your
theory in the last part of your sentence sounds like a platform issue,
where you might do a DMI match instead.

> --- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
> @@ -708,6 +708,22 @@ static int mwifiex_ret_ver_ext(struct mwifiex_privat=
e *priv,
>  {
>         struct host_cmd_ds_version_ext *ver_ext =3D &resp->params.verext;
>
> +       if (test_and_clear_bit(MWIFIEX_IS_REQUESTING_FW_VEREXT, &priv->ad=
apter->work_flags)) {
> +               if (strncmp(ver_ext->version_str, "ChipRev:20, BB:9b(10.0=
0), RF:40(21)", 128) =3D=3D 0) {

Rather than memorize the 128-size array here, maybe use
sizeof(ver_ext->version_str) ?

Brian
