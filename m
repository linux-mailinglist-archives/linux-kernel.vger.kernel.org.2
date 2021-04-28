Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726F036E1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhD1XHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 19:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhD1XHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 19:07:18 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D25C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 16:06:31 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 190so8754155qkl.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zh7OlMvW3DerlpqnUGmUulKmpWmcH2OBnD2WoZd3s2E=;
        b=YmSZOiKx330MTi6OgPxfVQAMQcngQCx0VixjfYfa8oimpEQdKQgtVXk/+sdhYuWHBk
         INJua3d8nJs4sB3DuURU4LOBXXJvRHtnO9z2pzNUOsZJqxJ/lu/MSd8Zk7zaJlk6X+3b
         wV1t6QWmPYLQjSAqEZt/q6B+HAPDWWap6PV+FVd7Z7vMjm/zlLW6fC30urIy9Ixi1Zow
         C+B1TJrtu6N0ov6PxdLuPTBDL8VD0zEtoFnb74RMkjl9oi1MKgNdiBJgV1HNSjGVv/Fl
         L/AR4xnQA6V3mj7Yb0eu1tgO/5mcDwYATZi63am5SCwGLOOEX5cnBhXezwGWRTelTvHJ
         begg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zh7OlMvW3DerlpqnUGmUulKmpWmcH2OBnD2WoZd3s2E=;
        b=Ljuo9sdLxpCyqkQXY/QQkBRRXpo0NSSlAH6+LFfz0+Pf8mGy2wV4CCjgbl9Iojqok2
         XXUMZCU7LHO+ALkQUc1i+jFdd8TC4aMYykdnVrBTbIM9HcokUDbim7mNbH5ApKt/KWhM
         O95IfFFOiXlUweSDYjLkbOIjSNbLOZOUnOcC+XZ2pm4TlXvI047t/bYv1IKFJt6thW59
         Bmex4tKRDGqhlz0Jk2uOKa7faYqqH1voaxjhHJrp5XbKq3hmKaY/vy0SYNyQv/nLVm6L
         PXMHuxlm5p56SeI1LHgxSgF+73qhkCt2fAI01s5hvvv2bobqUbNSKvkSBkGFq8aDv16X
         agMA==
X-Gm-Message-State: AOAM532DsbXE5KRyyf6lSARLsXnp1S8jlLmg5bxNTODt+R6buotEvTTo
        nJdkFIzvdj4zev2jprOH21roni9XTXP4S5D2hf12iQ==
X-Google-Smtp-Source: ABdhPJyP5Rq2TRUvGNCzXQ1TVtatDBGYjPsbD4BIYz1E9VvNk25ly9hWjYmcb76DZ6leGHtwS5fr3IhvvwXH1Fuxrjw=
X-Received: by 2002:a05:620a:70e:: with SMTP id 14mr31567987qkc.278.1619651190787;
 Wed, 28 Apr 2021 16:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210419165323.v1.1.I9f9e8bcc849d91c1bb588a5181317c3e2ad48461@changeid>
In-Reply-To: <20210419165323.v1.1.I9f9e8bcc849d91c1bb588a5181317c3e2ad48461@changeid>
From:   Yu Liu <yudiliu@google.com>
Date:   Wed, 28 Apr 2021 16:05:54 -0700
Message-ID: <CAHC-ybzmnE9ja1ianmLMyMvPq6Kkt1U8caiO+cGKtVc4cy1kLQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Fix the HCI to MGMT status conversion table
To:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping for attention, thanks.


On Mon, Apr 19, 2021 at 4:53 PM Yu Liu <yudiliu@google.com> wrote:
>
> 0x2B, 0x31 and 0x33 are reserved for future use but were not present in
> the HCI to MGMT conversion table, this caused the conversion to be
> incorrect for the HCI status code greater than 0x2A.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Yu Liu <yudiliu@google.com>
> ---
>
> Changes in v1:
> - Initial change
>
>  net/bluetooth/mgmt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 40f75b8e1416..b44e19c69c44 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -252,12 +252,15 @@ static const u8 mgmt_status_table[] = {
>         MGMT_STATUS_TIMEOUT,            /* Instant Passed */
>         MGMT_STATUS_NOT_SUPPORTED,      /* Pairing Not Supported */
>         MGMT_STATUS_FAILED,             /* Transaction Collision */
> +       MGMT_STATUS_FAILED,             /* Reserved for future use */
>         MGMT_STATUS_INVALID_PARAMS,     /* Unacceptable Parameter */
>         MGMT_STATUS_REJECTED,           /* QoS Rejected */
>         MGMT_STATUS_NOT_SUPPORTED,      /* Classification Not Supported */
>         MGMT_STATUS_REJECTED,           /* Insufficient Security */
>         MGMT_STATUS_INVALID_PARAMS,     /* Parameter Out Of Range */
> +       MGMT_STATUS_FAILED,             /* Reserved for future use */
>         MGMT_STATUS_BUSY,               /* Role Switch Pending */
> +       MGMT_STATUS_FAILED,             /* Reserved for future use */
>         MGMT_STATUS_FAILED,             /* Slot Violation */
>         MGMT_STATUS_FAILED,             /* Role Switch Failed */
>         MGMT_STATUS_INVALID_PARAMS,     /* EIR Too Large */
> --
> 2.31.1.368.gbe11c130af-goog
>
