Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB588321FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhBVTFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbhBVTD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:03:28 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0423C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 11:02:47 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id j19so7357092lfr.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 11:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7tjb/ULPTs0YK9djuSw4jI/piZzj9Be22oeBt6d4gY=;
        b=mrY2NByHHyaff5bYeda64M/VoEosJ32rOPg4tTipSJbWFIY8bKAiJGN3qURfIutpyz
         cKHTAdFT3H9fWNcQWE2vXUst95QbVQs61PEsUdkOp7sG0fP2gxNN5ic1tPrEInT/BFCC
         DdjFE6QkIVos4s3D0CwyGIsOIS7R2loRI6I3YgmoFTLjfYtMpCnkAXXeYXEvbzQfP7xh
         hZL+lMLgfhKTczJIeW/5/P43e8Jte8+AMEoZg7Zk7fIwbSVfeWZMzJi5nYZSyuhx6wB3
         pa+VbIe1bTeAVIh3SXAnnnoSQJbpwwYw9zj6co1Uc5gfn4SJlHujHmfF00kn4ZC+/sb3
         ikuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7tjb/ULPTs0YK9djuSw4jI/piZzj9Be22oeBt6d4gY=;
        b=loqJn2fnwL+KT6wX7OMGoJPTft8j2yUwH0U2lyq1+VLRjAPL9PBBaVpbK6iyRwDgoZ
         gA14UmSOhVK3Ibpw6lvNk+JVbGIjFurRdOGTq2ml5v3zFRbTDXTATjHP64Z79v5n/i2G
         3U/TGx8bOeQmLFDhDQB9D1J/J/kUZCumSkN6Zq790FJCu6Q2sYiZ6KxNgG3p4vDdytP5
         VfnZeSNLUMDqnEhEdecZfgvTF9lDE1l6+Q98g4EIgXRSIiooqxOqnCS9OHTyidY4B4xT
         ek6dXx0RFCRNXkwYUFiEm31lo/myXmfDy/QXOML/tb70+KBIziptTMMvalscnZQkkF7M
         c4pg==
X-Gm-Message-State: AOAM5329yuo3QmdMRHHTVdTplSZt9or2oJ86iHBIlW80843lVJqU8513
        wOE2BWv6ohNk0UYEJUeZs2TRBX2953nQJyDvdV8sag==
X-Google-Smtp-Source: ABdhPJwWmG0JYv8DqkeX3ykU/s7MQAhAyFGkaW2VRAIk/PCpiPtFsdg9zr2j2BvY54a5YWmtKdCLcROd3JJyfCfLpf4=
X-Received: by 2002:ac2:515c:: with SMTP id q28mr5267546lfd.297.1614020566033;
 Mon, 22 Feb 2021 11:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20210211194258.4137998-1-nathan@kernel.org>
In-Reply-To: <20210211194258.4137998-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Feb 2021 11:02:34 -0800
Message-ID: <CAKwvOdkJfJ+LDspz04tsjd=55LxF5rgTOAXt0cPxTyCCUBqgBw@mail.gmail.com>
Subject: Re: [PATCH] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
To:     Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>, qemu-devel@nongnu.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Did this happen to get picked up already? EOM

On Thu, Feb 11, 2021 at 11:43 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> fw_cfg_showrev() is called by an indirect call in kobj_attr_show(),
> which violates clang's CFI checking because fw_cfg_showrev()'s second
> parameter is 'struct attribute', whereas the ->show() member of 'struct
> kobj_structure' expects the second parameter to be of type 'struct
> kobj_attribute'.
>
> $ cat /sys/firmware/qemu_fw_cfg/rev
> 3
>
> $ dmesg | grep "CFI failure"
> [   26.016832] CFI failure (target: fw_cfg_showrev+0x0/0x8):
>
> Fix this by converting fw_cfg_rev_attr to 'struct kobj_attribute' where
> this would have been caught automatically by the incompatible pointer
> types compiler warning. Update fw_cfg_showrev() accordingly.
>
> Fixes: 75f3e8e47f38 ("firmware: introduce sysfs driver for QEMU's fw_cfg device")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1299
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/firmware/qemu_fw_cfg.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 0078260fbabe..172c751a4f6c 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -299,15 +299,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
>         return 0;
>  }
>
> -static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
> +static ssize_t fw_cfg_showrev(struct kobject *k, struct kobj_attribute *a,
> +                             char *buf)
>  {
>         return sprintf(buf, "%u\n", fw_cfg_rev);
>  }
>
> -static const struct {
> -       struct attribute attr;
> -       ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
> -} fw_cfg_rev_attr = {
> +static const struct kobj_attribute fw_cfg_rev_attr = {
>         .attr = { .name = "rev", .mode = S_IRUSR },
>         .show = fw_cfg_showrev,
>  };
>
> base-commit: 92bf22614b21a2706f4993b278017e437f7785b3
> --
> 2.30.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210211194258.4137998-1-nathan%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
