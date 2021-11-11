Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B2E44DB8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 19:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhKKS0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 13:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhKKS0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 13:26:13 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7191C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 10:23:23 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso10127405otg.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 10:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7ZNzHH3aITCjNcGHNzHisUUYbiJGzkSNsCnNbeBhS8=;
        b=EOEBrF1H7JDGijAd7i3c/0rF52elvRBGSRif5o2ADDVOVN3rT4Y1CPndrfmURpFMbV
         fn3Z7edOE925wcgEYnN3HkW67maRAcjQHnpTsmVLXCjyVYcaPilEJPAdHO+e/SFxExns
         oYt5oCVszuCtxcju3iyceTgRzKvWgC8OcWrPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7ZNzHH3aITCjNcGHNzHisUUYbiJGzkSNsCnNbeBhS8=;
        b=fu3mPJmYBIFYByg3uUk1CQGn41EoL0deBB1ZEYfStQYym+Jznd/LpzjJ5CV0MBS6s/
         Drn84MthRiQCuz3uHxzvwtkpkThB7lfUE0wNxzZJ+J8aCS7AGOyuvPOgMZ1M1JDW0lds
         EVj6DLM0isOHk2rWKjfJj1hm8VsWRvFhTvyOOxDoImER6LZsCAAHpZxG1c/OBY4jbyiV
         OTb3i3sev2BkbLNXmEXfbqlCpodgU9JIzikG0UXdX1OhURi5xXU7FL9yn5Jl3Zqzca+E
         c/aNAxPq9ObtJWZbFfj63VO6jYoeywz77fqjWgp3ZJhnpYYbAJZCSnyubx99B1PBdLLu
         U6WQ==
X-Gm-Message-State: AOAM533fr3xXwven9q0EolYee03v1mP2kAfjNUMSYRyQV5XYxzgIOQlK
        cqhQjrYFzhYj24hJ2EJd1U7sRiIQp/GgqQ==
X-Google-Smtp-Source: ABdhPJxPG5Q8bcutTZO6UdnNsDyPDYGLtwOoBjumGnLNA7aAkpOsoT3RGo4BP3Jbi04DqYgc/0pY8g==
X-Received: by 2002:a9d:62c5:: with SMTP id z5mr7693851otk.166.1636655002737;
        Thu, 11 Nov 2021 10:23:22 -0800 (PST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id q63sm795026oia.55.2021.11.11.10.23.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 10:23:21 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so10145673otj.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 10:23:21 -0800 (PST)
X-Received: by 2002:a9d:5185:: with SMTP id y5mr7328544otg.110.1636655000514;
 Thu, 11 Nov 2021 10:23:20 -0800 (PST)
MIME-Version: 1.0
References: <20211108200058.v2.1.Ide934b992a0b54085a6be469d3687963a245dba9@changeid>
In-Reply-To: <20211108200058.v2.1.Ide934b992a0b54085a6be469d3687963a245dba9@changeid>
From:   Jesse Melhuish <melhuishj@chromium.org>
Date:   Thu, 11 Nov 2021 12:23:10 -0600
X-Gmail-Original-Message-ID: <CACGnfjS5OOWsdBQNpmJ7DFWTYkH0vYDmVeW71xY0h3LsNut1Mw@mail.gmail.com>
Message-ID: <CACGnfjS5OOWsdBQNpmJ7DFWTYkH0vYDmVeW71xY0h3LsNut1Mw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Don't initialize msft/aosp when using user channel
To:     Jesse Melhuish <melhuishj@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinging. LMK if something is wrong or missing here. Thanks!

On Mon, Nov 8, 2021 at 2:01 PM Jesse Melhuish <melhuishj@chromium.org> wrote:
>
> A race condition is triggered when usermode control is given to
> userspace before the kernel's MSFT query responds, resulting in an
> unexpected response to userspace's reset command.
>
> Issue can be observed in btmon:
> < HCI Command: Vendor (0x3f|0x001e) plen 2                    #3 [hci0]
>         05 01                                            ..
> @ USER Open: bt_stack_manage (privileged) version 2.22  {0x0002} [hci0]
> < HCI Command: Reset (0x03|0x0003) plen 0                     #4 [hci0]
> > HCI Event: Command Complete (0x0e) plen 5                   #5 [hci0]
>       Vendor (0x3f|0x001e) ncmd 1
>         Status: Command Disallowed (0x0c)
>         05                                               .
> > HCI Event: Command Complete (0x0e) plen 4                   #6 [hci0]
>       Reset (0x03|0x0003) ncmd 2
>         Status: Success (0x00)
>
> Signed-off-by: Jesse Melhuish <melhuishj@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> ---
>
> Changes in v2:
> - Moved guard to the new home for this code.
>
>  net/bluetooth/hci_sync.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index b794605dc882..5f1f59ac1813 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3887,8 +3887,10 @@ int hci_dev_open_sync(struct hci_dev *hdev)
>             hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) && hdev->set_diag)
>                 ret = hdev->set_diag(hdev, true);
>
> -       msft_do_open(hdev);
> -       aosp_do_open(hdev);
> +       if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> +               msft_do_open(hdev);
> +               aosp_do_open(hdev);
> +       }
>
>         clear_bit(HCI_INIT, &hdev->flags);
>
> --
> 2.31.0
>
