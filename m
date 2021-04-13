Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059E135E8BD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 00:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347047AbhDMWFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 18:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244945AbhDMWEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:04:52 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D88C061574;
        Tue, 13 Apr 2021 15:04:30 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id l131so13501640oih.0;
        Tue, 13 Apr 2021 15:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BcnYnq+N4uwq3rpVGjNwNyLl9v3yA5MibMCbAIE9Wo8=;
        b=YTUKHAbfr0yghnmFvbEHM85abC0EuoOUvchIIN4NRlmlxg6pGi92dFs3hOfrHBGzc+
         9jiLDyf1zHZtVKKF+Yrj7tBDxHa4kdC9kDBWsg+54vcFiSHIV0D5JhqbQC+bsa/+omKD
         Ee/5suqNFM9FmNkeDOdYg8EAzCGDjUkAc6C63d+D6Yj8u1VFo/g/hJVbMfCn8iVd1JS8
         +FxiGKwXBUBvDzZUB5dyGeXpWrg4OKzZMVxurzreTEA00yLw8aS3PydoSf0nRhpHuPpO
         dMKBLhqkwnVyDYnsICzKQwtFsSWG6sRVf+jUfT3MT0A1Fl7bad5UYNaiWmTl/DQpVn3h
         /B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BcnYnq+N4uwq3rpVGjNwNyLl9v3yA5MibMCbAIE9Wo8=;
        b=AIG1eiJoz0niRS0PsualVDOM/qW4I6JQcYzKbgMAOEmEgAKykPP9nFzSr9RelwbJLQ
         eBEWSOBV7W0SdcUj/AkmdV3vmyVWTeDgsq/YhoQCMqxUMDBfl7kfhDUfJUfbNOeaejVU
         Ec9NKNGez8tn+/LG1vyVV0jKwdfIJxNjRFgDZVyaL6ABYBq7acz0hpQlc+yZY1TK5ZFp
         dMpMVHeF3eJKjjKkrmSeSmo13hy9T62zlYjgPfTMqKWCos0qyiJlMOjFIbLLJPUCvb4E
         IyG1RiIbtkfB40bFUzeq+o99Uicsflyug31BdQtASKpjZYcb/7wO+Wx7Svz9SQZZIBC3
         DlJg==
X-Gm-Message-State: AOAM530cVoTywZ+MImUjDJCWIcPlKTXHVhduHtZ57fVDkaoPvv/gTD3R
        0yxlOlUHNZD5vx1VDI9JIVGSmCsRWPgTY34z8BY=
X-Google-Smtp-Source: ABdhPJxMLX1+M0fUfSSy17zs75AhlQvNWzhMAK+QvYTsoF4TKANnFU5rUIpstMkzbLtyrAJxwtj7Lk8A84apXVXTi1o=
X-Received: by 2002:a05:6808:10c5:: with SMTP id s5mr1592655ois.58.1618351470082;
 Tue, 13 Apr 2021 15:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210413101812.323079-1-josephsih@chromium.org>
In-Reply-To: <20210413101812.323079-1-josephsih@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 13 Apr 2021 15:04:19 -0700
Message-ID: <CABBYNZK7a0XMmhrRBg=6ByuaOD0yq8gSkg87VG3=U2RKfX9FGA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: btusb: support link statistics
 telemetry events
To:     Joseph Hwang <josephsih@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Joseph Hwang <josephsih@google.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Kiran K <kiran.k@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joseph,

On Tue, Apr 13, 2021 at 3:18 AM Joseph Hwang <josephsih@chromium.org> wrote:
>
> From: Chethan T N <chethan.tumkur.narayan@intel.com>
>
> This patch supports the link statistics telemetry events for
> Intel controllers
>
> To avoid the overhead, this debug feature is disabled by default.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> ---
>
> Changes in v3:
> - fix the long line in the commit message
>
> Changes in v2:
> - take care of intel_newgen as well as intel_new
> - fix the long lines in mgmt.c
>
>  drivers/bluetooth/btintel.c | 20 +++++++++++++++++++-
>  drivers/bluetooth/btusb.c   | 18 ------------------
>  2 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index e44b6993cf91..de1dbdc01e5a 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1248,8 +1248,10 @@ EXPORT_SYMBOL_GPL(btintel_read_debug_features);
>  int btintel_set_debug_features(struct hci_dev *hdev,
>                                const struct intel_debug_features *features)
>  {
> -       u8 mask[11] = { 0x0a, 0x92, 0x02, 0x07, 0x00, 0x00, 0x00, 0x00,
> +       u8 mask[11] = { 0x0a, 0x92, 0x02, 0x7f, 0x00, 0x00, 0x00, 0x00,
>                         0x00, 0x00, 0x00 };
> +       u8 period[5] = { 0x04, 0x91, 0x02, 0x01, 0x00 };
> +       u8 trace_enable = 0x02;
>         struct sk_buff *skb;

Looks like I commented on the wrong version, anyway the comments I
made on v2 also apply here.

>         if (!features)
> @@ -1266,8 +1268,24 @@ int btintel_set_debug_features(struct hci_dev *hdev,
>                            PTR_ERR(skb));
>                 return PTR_ERR(skb);
>         }
> +       kfree_skb(skb);
> +
> +       skb = __hci_cmd_sync(hdev, 0xfc8b, 5, period, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_err(hdev, "Setting periodicity for link statistics traces failed (%ld)",
> +                          PTR_ERR(skb));
> +               return PTR_ERR(skb);
> +       }
> +       kfree_skb(skb);
>
> +       skb = __hci_cmd_sync(hdev, 0xfca1, 1, &trace_enable, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_err(hdev, "Enable tracing of link statistics events failed (%ld)",
> +                          PTR_ERR(skb));
> +               return PTR_ERR(skb);
> +       }
>         kfree_skb(skb);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(btintel_set_debug_features);
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 192cb8c191bc..f29946f15f59 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2811,7 +2811,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>         u32 boot_param;
>         char ddcname[64];
>         int err;
> -       struct intel_debug_features features;
>
>         BT_DBG("%s", hdev->name);
>
> @@ -2865,14 +2864,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>                 btintel_load_ddc_config(hdev, ddcname);
>         }
>
> -       /* Read the Intel supported features and if new exception formats
> -        * supported, need to load the additional DDC config to enable.
> -        */
> -       btintel_read_debug_features(hdev, &features);
> -
> -       /* Set DDC mask for available debug features */
> -       btintel_set_debug_features(hdev, &features);
> -
>         /* Read the Intel version information after loading the FW  */
>         err = btintel_read_version(hdev, &ver);
>         if (err)
> @@ -2911,7 +2902,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
>         u32 boot_param;
>         char ddcname[64];
>         int err;
> -       struct intel_debug_features features;
>         struct intel_version_tlv version;
>
>         bt_dev_dbg(hdev, "");
> @@ -2961,14 +2951,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
>          */
>         btintel_load_ddc_config(hdev, ddcname);
>
> -       /* Read the Intel supported features and if new exception formats
> -        * supported, need to load the additional DDC config to enable.
> -        */
> -       btintel_read_debug_features(hdev, &features);
> -
> -       /* Set DDC mask for available debug features */
> -       btintel_set_debug_features(hdev, &features);
> -
>         /* Read the Intel version information after loading the FW  */
>         err = btintel_read_version_tlv(hdev, &version);
>         if (err)
> --
> 2.31.1.295.g9ea45b61b8-goog
>


-- 
Luiz Augusto von Dentz
