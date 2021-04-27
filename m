Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F3536CB50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbhD0Svw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0Svu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:51:50 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B127C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 11:51:07 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a13so15548158ljp.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gog+9Z3fXL22LIPFv7bH+SyHlsPgqAEYM+x0G4DVbUk=;
        b=TBvf0xKSwntfNBf0ki5A6F9saMvDAtYZZ//h/FcOHpAKhLhUpTEAOvReK/Cbk24D4q
         NWWhfSMe/wdjbcrKD2FBkm/Qms/xqia+kjBpuwsyhyjxGsxghMacVDusDEVpsXCXUlYw
         adeYxpvYfc1bVbPoJhJwwWKxU6HZupYPUPcDEDdz6NlPw0z+CykZJtCZS8tg36fQZRJm
         9pQT5vnhbINDuNub+jC6HXwE6tY030Mu4031/lKOlmIB9kdbHrJXUz1Q+EjPPfcDoKkf
         y7n2xIZn1urvoUh+y5c+F+zJkvkwBTs2dNF59WTkfJSzgHk1qI3mblHUn+JM7XfLXl8F
         uE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gog+9Z3fXL22LIPFv7bH+SyHlsPgqAEYM+x0G4DVbUk=;
        b=jckFl8WgvrmG/wZqUvLgnDnQeWOAl6fl8acPjKN2z9yzq47a7O9bEIS4YC7aWMJp7I
         SUhGHhV2XsWWfTjw+zhm8zIM207cpMEZD3zQzEmpDiaPCNB0AP+jsigWe6HaU7C9DFSw
         7sxbkwmCZmkw4e97SsB2pP35tLJjAsRMDDC7M40bnjrEkZRi6ebroBXAP8mVlu1FTyvk
         5/PGiF/qwHy4EJXXPKd+5ynrO1gE6PWNFVG7vrxyaMPB6kX9DOiENdyPhkrLICYhnEPA
         9xJwTZJejHCl9/RTUF+l023HHtHhEaH80F4eM0M0np5Vww7Id6Zi/G3GYFU29AFl3PcY
         3NXQ==
X-Gm-Message-State: AOAM533yJPj9zdm0LxORmIYA3WUVtvSqnM9tXFYpnqy01w14NSLBUm1a
        UanMFTG5osIbgDhJzLsq6xqgW2JqW56fZnNLuiw7eA==
X-Google-Smtp-Source: ABdhPJwxKbevoemvyWBbaarG/ohvblLCHTsJTfbV7w0ScGJyTAY/d62rNZGVzSX4cFx25v8OxTCyeZHL45vTV5iZzcA=
X-Received: by 2002:a2e:6c12:: with SMTP id h18mr12473028ljc.116.1619549465409;
 Tue, 27 Apr 2021 11:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <1619345553-29781-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1619345553-29781-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Apr 2021 11:50:53 -0700
Message-ID: <CAKwvOdkXxyyLSTAaMsyeJ3jxCeAGY=9DxLZNX4DcvF=fmkx7mg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: q6dsp: q6afe: remove unneeded dead-store initialization
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, srinivas.kandagatla@linaro.org,
        bgoswami@codeaurora.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 3:12 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Variables 'wait' and 'port_id' are being initialized, however the
> values are never read and updated later on, hence the redundant
> initializations can be removed.
>
> Cleans up clang warnings:
> sound/soc/qcom/qdsp6/q6afe.c:933:21: warning: Value stored to 'wait'
> during its initialization is never read
> sound/soc/qcom/qdsp6/q6afe.c:1186:6: warning: Value stored to 'port_id'
> during its initialization is never read
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks for the patch, but it looks like this has already been fixed in:
https://lore.kernel.org/alsa-devel/20210218222916.89809-5-pierre-louis.bossart@linux.intel.com/


> ---
>  sound/soc/qcom/qdsp6/q6afe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
> index cad1cd1..442bf27 100644
> --- a/sound/soc/qcom/qdsp6/q6afe.c
> +++ b/sound/soc/qcom/qdsp6/q6afe.c
> @@ -930,7 +930,7 @@ int q6afe_get_port_id(int index)
>  static int afe_apr_send_pkt(struct q6afe *afe, struct apr_pkt *pkt,
>                             struct q6afe_port *port, uint32_t rsp_opcode)
>  {
> -       wait_queue_head_t *wait = &port->wait;
> +       wait_queue_head_t *wait;
>         struct aprv2_ibasic_rsp_result_t *result;
>         int ret;
>
> @@ -1183,7 +1183,7 @@ int q6afe_port_stop(struct q6afe_port *port)
>         struct afe_port_cmd_device_stop *stop;
>         struct q6afe *afe = port->afe;
>         struct apr_pkt *pkt;
> -       int port_id = port->id;
> +       int port_id;
>         int ret = 0;
>         int index, pkt_size;
>         void *p;
> --
> 1.8.3.1
>


-- 
Thanks,
~Nick Desaulniers
