Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE433EC41A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 19:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbhHNRXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 13:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238690AbhHNRXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 13:23:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA52C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:22:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w14so19997431pjh.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cj3brR7/gBmdZFywr+8Ggozpje7JHKDRwC1PgsV8mJA=;
        b=GqhHLlJmqw12wvkn0UJ/QoTElJtmFzwFMo0xTTgqQTlSlTWGYf0uQVyd5mlfXnzTz/
         epRzJ4XXvPVgVEgWba/nno+gnkTX0eEM8vms6v92iLD0T8/GojxVPOp2cFxXAMxzBw92
         aIHDkv8QQXyn+eh6GLeofqLcG89QBEY0cuUomgphY144DGbBjCaj0fnKx8PzctJ9oSZY
         WGLZo5xiIJeCfJtruvetrnbCvkbQAjYew/dPichw/R3ZSGa8VHr7fs7hPMNl1k9VIWwc
         RJJ3tDQpIOC7ZupSjb7MGOG8ZC60+U7Psyw7x+5l70HiG4uIY7OrtFvmms9kmru8RiA4
         eRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cj3brR7/gBmdZFywr+8Ggozpje7JHKDRwC1PgsV8mJA=;
        b=O92RcXVacsdjnzVokqn7AfhTn3S1Vusy96L5eLpkmNxDLuwx016ZAI+WE19+Znm5R4
         f8g7njBrV2/FnFx0kQno0DQhhIeBrLh65MPmMF5XpTB18NlcE6m+78VZ7Kr+xoBSi9yM
         5+Ld8+gnd76OmBWqjWhacdyZTFHVL33UYAaiqq2WJ4QZUE0lYy1/eQij3c1ZKtSj3v7n
         +J04osgGRnbOeiWjNU3xCD/+xK1UlkflU9jtmPc0t5nv1NihQPHNAI5/8DmEt/EqqXeD
         ZHtDgrEqLD4Dy5rhiZ1iP9KLK+pJ83iaF4iXTjXTzLogE0FIpheOXuLnqM82HlP/479a
         jGiw==
X-Gm-Message-State: AOAM5336ZWSg5CSNN1zZo2givGIl9al3uNov0PdX/sIaOYYhabU6RnDg
        mHfhg7BJj7QSmsBCCiZpjEr20dJvFRKfmP68qjqQUg==
X-Google-Smtp-Source: ABdhPJxbf3pmQsG8AgZuA9FcoS3029YBFQL8bd3yFDPJ2qyt5ncnYj6PI92zQdiVpMS7euZ1iU5CWU79QKBj63x/mAw=
X-Received: by 2002:a63:aa43:: with SMTP id x3mr7683855pgo.208.1628961751198;
 Sat, 14 Aug 2021 10:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210814160804.11634-1-fmdefrancesco@gmail.com>
In-Reply-To: <20210814160804.11634-1-fmdefrancesco@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 14 Aug 2021 18:22:20 +0100
Message-ID: <CAA=Fs0nR+Jh-1V1DdsZB9pMpeLRRwbQNh2X9UMMabh-vAubvqw@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: os_dep: Remove defined but not used variables
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Aug 2021 at 17:08, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> Remove defined but not used const variables. Issues detected by GCC
> running with -Wunused-const-variable option enabled.
>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 21 --------------------
>  1 file changed, 21 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 38ee41f9d2ba..d9fdd83218dc 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -84,11 +84,6 @@ static u32 rtw_rates[] = {1000000, 2000000, 5500000, 11000000,
>         6000000, 9000000, 12000000, 18000000, 24000000, 36000000,
>         48000000, 54000000};
>
> -static const char * const iw_operation_mode[] = {
> -       "Auto", "Ad-Hoc", "Managed",  "Master", "Repeater",
> -       "Secondary", "Monitor"
> -};
> -
>  void indicate_wx_scan_complete_event(struct adapter *padapter)
>  {
>         union iwreq_data wrqu;
> @@ -6666,19 +6661,3 @@ struct iw_handler_def rtw_handlers_def = {
>         .num_private_args = sizeof(rtw_private_args) / sizeof(struct iw_priv_args),
>         .get_wireless_stats = rtw_get_wireless_stats,
>  };
> -
> -/*  copy from net/wireless/wext.c start */
> -/* ---------------------------------------------------------------- */
> -/*
> - * Calculate size of private arguments
> - */
> -static const char iw_priv_type_size[] = {
> -       0,                            /* IW_PRIV_TYPE_NONE */
> -       1,                            /* IW_PRIV_TYPE_BYTE */
> -       1,                            /* IW_PRIV_TYPE_CHAR */
> -       0,                            /* Not defined */
> -       sizeof(__u32),            /* IW_PRIV_TYPE_INT */
> -       sizeof(struct iw_freq),  /* IW_PRIV_TYPE_FLOAT */
> -       sizeof(struct sockaddr),        /* IW_PRIV_TYPE_ADDR */
> -       0,                            /* Not defined */
> -};
> --
> 2.32.0
>

Thanks Fabio.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
