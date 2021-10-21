Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CF3435E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhJUKAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231334AbhJUKAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634810316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A9IiOedhyxVfcKD2UTU5hZ0UiHKLyWqMSwlLuzgje/4=;
        b=HWDKDN73yh4HlOF4aOhy4hmprq7ANdr+2a7PsVI1ZviS/AvubVojc9xBG0D9j2jDOFJFTd
        htGC1icl+BaptYt35hTw5a2B6JLecTTUz1nKzy2R0oKev7YGGDvcygdzmFl8W0U3k8Tuyq
        jdeflFpAeo3KoTtAIip7wJZ/t2ZtIKs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-D6eY1_UIPAWKpZzU6cqThA-1; Thu, 21 Oct 2021 05:58:34 -0400
X-MC-Unique: D6eY1_UIPAWKpZzU6cqThA-1
Received: by mail-pj1-f70.google.com with SMTP id rm3-20020a17090b3ec300b001a1806521bbso102363pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9IiOedhyxVfcKD2UTU5hZ0UiHKLyWqMSwlLuzgje/4=;
        b=GvpOFME7rpgqsLB16JYCGsCNOv7e45cp9vM7qrCzjg52hK3c7DzcNb7Wx/0VKohyjT
         rYGxY5ax6u3dsK/NmMWpqMO8EPD8uVMVmKo8P7wxFNmVPZdyy4dI2usWcByanruJpdzA
         nvSGlnfywxgQQ0UotIt2cMwD/FIDVfkF69JJph1+6F/YR2+WIph7LD9wqNA7IF6N5JYg
         rLMKhmxDyZpqG1S/kKSTLxUYaGzMBSh7iP3YHepnDJN8ZXZZlpk0wqnQrSd4n4+J0RI9
         RWjdCdm3eer/NJkIlb9xC6gY5XaINyQzYk3wW8hfRUofI0WoGSh0of6uXn10+u7+Y/gP
         3GFQ==
X-Gm-Message-State: AOAM530yqltFGhoi6RiRnMXv1TXQknxHNEapPpvsAYiWJ/6vFreMay77
        nvwuJ+1n2DRus6SoG4ykMzehUNFXzwDjx4fCGY2WERT0yPX2D6+B6xBPgRn3Aj7OYBVhjeh1OyK
        PCVAccTMMtiQRbBz+KsfwZLjGhFiDhgdWB0NmTMD3
X-Received: by 2002:a17:90a:6942:: with SMTP id j2mr1876812pjm.113.1634810313364;
        Thu, 21 Oct 2021 02:58:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeHjs8u7Xh8k+uFFs4rT+sd83fySQn4c03IVl6Virn+jwm8JqRdJ0oRPDj1R24JN7HvOsrhyNFjldXZM5Yd0E=
X-Received: by 2002:a17:90a:6942:: with SMTP id j2mr1876791pjm.113.1634810313112;
 Thu, 21 Oct 2021 02:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211021095107.116292-1-alistair@alistair23.me>
In-Reply-To: <20211021095107.116292-1-alistair@alistair23.me>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 21 Oct 2021 11:58:21 +0200
Message-ID: <CAO-hwJKXQsEU-i41EB5LyB3cSrFG9y+6WsQ8XuryL5AniCrM_Q@mail.gmail.com>
Subject: Re: [PATCH v12 1/3] HID: quirks: Allow inverting the absolute X/Y values
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 11:51 AM Alistair Francis
<alistair@alistair23.me> wrote:
>
> Add a HID_QUIRK_XY_INVERT quirk that can be used to invert the X/Y
> values.
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/hid/hid-input.c | 7 +++++++
>  include/linux/hid.h     | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 4b5ebeacd283..0a9634473940 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1328,6 +1328,13 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>
>         input = field->hidinput->input;
>
> +       if (*quirks & HID_QUIRK_XY_INVERT) {
> +               if (usage->type == EV_ABS &&
> +                       (usage->code == ABS_X || usage->code == ABS_Y)) {

I think I would prefer to have one quirk per axis if we go this route.

Cheers,
Benjamin

> +                       value = field->logical_maximum - value;
> +               }
> +       }
> +
>         if (usage->hat_min < usage->hat_max || usage->hat_dir) {
>                 int hat_dir = usage->hat_dir;
>                 if (!hat_dir)
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 9e067f937dbc..a6e91ee5b3de 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -349,6 +349,7 @@ struct hid_item {
>  /* BIT(9) reserved for backward compatibility, was NO_INIT_INPUT_REPORTS */
>  #define HID_QUIRK_ALWAYS_POLL                  BIT(10)
>  #define HID_QUIRK_INPUT_PER_APP                        BIT(11)
> +#define HID_QUIRK_XY_INVERT                    BIT(12)
>  #define HID_QUIRK_SKIP_OUTPUT_REPORTS          BIT(16)
>  #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID                BIT(17)
>  #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP BIT(18)
> --
> 2.31.1
>

