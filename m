Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3974E4254FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbhJGOGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 10:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241383AbhJGOGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:06:07 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1777AC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 07:04:14 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id b67so2739205vkb.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 07:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OkzY67jn2IfmDfjsCLMtxI3P4gcNu0/qXtTRvkyvntY=;
        b=ArTpgcfjCsitaA/Zjyyr6iu/FFQHU/glq9hbIpJOzXcOz1rkabu8myg1CqeUXiRKaB
         BamjwFmURRphxQBpmDdk24t8wcp4ZMUOIADJPiY+WEw1HSxB6Io2MfEmZ1tf9xfXd5rr
         Ppw4WIoSdskspwdReI/KoqJ2b+xcp9H0VQjQihfpLjaYOWPhIOjWmm3yK4vm1j/u0Ufi
         ySf9CHKKHF5hwiSi2aT8id5g7wQDr7H3n4Z6n43zO7W7QPVB+RtidT2FmVjxRRLWEYJy
         O8Eg/YmHHIVjg8fiVsQfrir+19Wkv+EDNVOaID6s2UpSnBShi3kss8EfjEknnN7xtnIX
         0RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OkzY67jn2IfmDfjsCLMtxI3P4gcNu0/qXtTRvkyvntY=;
        b=flz+BraaS28D5HEZCL6NA9cF30XGwmcjFF0Tof/1XZgsQolH/f803AKo9Zx9LAYMUI
         FczeoZblh5yAVWGgEml/BDhx5nyiGiuJW9VcPy0mE1RL3DzbDbzMfaMNKhx6QL/fGV2k
         le8NU0RNdzxGUeSd+cMD3JnNWuElaUvJzxNZ+4qHxGF+GM+VslsoIKgkkhc3O0P5h9Qe
         dHOgVJ3FMwFpVJJ33Za8HcUDhHo/yQAimiaWWqUM1LkobANlhtKK6glhuJ9tD3zBr3xl
         /mqqw+K8JmFJN3Jdvw0oon+u0d03PmKG24aYMUfwOUwszXAeYgAhijHKPGPewtUMRd/N
         7Zbw==
X-Gm-Message-State: AOAM531o9BG9AKnbbNUC+4/LKaEcIxAxlAPvk/AKDDORIw92UIfpYi+v
        8wkz6e8zJIvtbd+1xtTxng4ROAquX46IuU2fJphuzg==
X-Google-Smtp-Source: ABdhPJyOMnSuUsgRJsfSQGm4B8Hm41x4PZMO6QYGegNV3M7Jvqk3zNyiTirS0kDO38cuPnrcXiB242PtKxy4qMtA3OI=
X-Received: by 2002:a1f:a1d3:: with SMTP id k202mr3677759vke.24.1633615453230;
 Thu, 07 Oct 2021 07:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211007135635.2717-1-semen.protsenko@linaro.org>
In-Reply-To: <20211007135635.2717-1-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 7 Oct 2021 17:04:01 +0300
Message-ID: <CAPLW+4=20VZU2uh47XbL92_DTzbCwiwDYeeni7SexMBjMX19VQ@mail.gmail.com>
Subject: Re: [PATCH v3] clk: Add clk_set_parent debugfs node
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 at 16:56, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Useful for testing mux clocks. One can write the index of the parent to
> set into clk_parent node, starting from 0. Example
>
>     # cd /sys/kernel/debug/clk/mout_peri_bus
>     # cat clk_possible_parrents
>       dout_shared0_div4 dout_shared1_div4
>     # cat clk_parent
>       dout_shared0_div4
>     # echo 1 > clk_parent
>     # cat clk_parent
>       dout_shared1_div4
>
> One needs to define CLOCK_ALLOW_WRITE_DEBUGFS in drivers/clk/clk.c in
> order to use this feature.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> --

Bummer... Now the title is obviously wrong. Will send v4 soon.

> Changes in v3:
>   - Removed unwanted changes added by mistake
>
> Changes in v2:
>   - Merged write() function into existing 'clk_parent' file
>   - Removed 'if (val >= core->num_parents)' check
>   - Removed incorrect usage of IS_ERR_OR_NULL()
>
>  drivers/clk/clk.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 806c55f0991b..f57e33efda9b 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3224,6 +3224,46 @@ static int current_parent_show(struct seq_file *s, void *data)
>  }
>  DEFINE_SHOW_ATTRIBUTE(current_parent);
>
> +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> +static ssize_t current_parent_write(struct file *file, const char __user *ubuf,
> +                                   size_t count, loff_t *ppos)
> +{
> +       struct seq_file *s = file->private_data;
> +       struct clk_core *core = s->private;
> +       struct clk_core *parent;
> +       char buf[4] = { 0 };
> +       u8 idx;
> +       int err;
> +
> +       if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +               return -EFAULT;
> +
> +       err = kstrtou8(buf, 0, &idx);
> +       if (err)
> +               return err;
> +
> +       parent = clk_core_get_parent_by_index(core, idx);
> +       if (!parent)
> +               return -ENOENT;
> +
> +       clk_prepare_lock();
> +       err = clk_core_set_parent_nolock(core, parent);
> +       clk_prepare_unlock();
> +       if (err)
> +               return err;
> +
> +       return count;
> +}
> +
> +static const struct file_operations current_parent_rw_fops = {
> +       .open           = current_parent_open,
> +       .write          = current_parent_write,
> +       .read           = seq_read,
> +       .llseek         = seq_lseek,
> +       .release        = single_release,
> +};
> +#endif
> +
>  static int clk_duty_cycle_show(struct seq_file *s, void *data)
>  {
>         struct clk_core *core = s->private;
> @@ -3291,9 +3331,20 @@ static void clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
>                             &clk_prepare_enable_fops);
>  #endif
>
> -       if (core->num_parents > 0)
> +       if (core->num_parents > 0) {
> +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> +               if (core->num_parents > 1) {
> +                       debugfs_create_file("clk_parent", 0644, root, core,
> +                                           &current_parent_rw_fops);
> +               } else {
> +                       debugfs_create_file("clk_parent", 0444, root, core,
> +                                           &current_parent_fops);
> +               }
> +#else
>                 debugfs_create_file("clk_parent", 0444, root, core,
>                                     &current_parent_fops);
> +#endif
> +       }
>
>         if (core->num_parents > 1)
>                 debugfs_create_file("clk_possible_parents", 0444, root, core,
> --
> 2.30.2
>
