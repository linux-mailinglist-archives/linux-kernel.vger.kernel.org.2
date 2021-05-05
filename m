Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E715B373F3A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 18:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhEEQIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 12:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbhEEQIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:08:40 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E0C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 09:07:43 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id a2so1989687qkh.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fIiJfW9zZM/AzeFGOLYj4IPsxMiQz+BDB9ZjjXfBkQg=;
        b=eiPygUvDSy+tt7Q68C4IwCtPn3u3etglOU2Lj3/XPV2WCLKTiYUDg7KUMBcCfFl9IG
         aQqjjmrQajgC3PPVD7KyMJ9r2lgUlsZOGUj7R2QBwet72Rl4O4JQZbh7HdWS9JzTa7Hx
         gs0EircnFraMMBg4grZST1Kk2o0lV0JQO0LMwzoFqd9fhjro6hp1WbC8k89wb/GpH7B3
         0OFh72FgwpJWrKgKa1qgFsYPunm9Un9i4T/+478/CS30+46afps/0ZIskp5qvsMvw+2Y
         qUBgM0eR43ghQ11+GbHJl2Yqr9ewCZTDXzpgdLDEv40MXoM6s9XB8I/a38oT+gaQ9Ss3
         OMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIiJfW9zZM/AzeFGOLYj4IPsxMiQz+BDB9ZjjXfBkQg=;
        b=D14gJeDGUDla29yohmcwqpjl0l1JoCkB4dOJSD0BoMVwMBs89I8N5s7mWM9ljYj3dg
         PXQCCYbmZ0LA2Wg8SouvdO7OnnB4v8OObtAkyRUGb/N4Z+Bi7h9FUh8Fr1/wKtFiehEi
         RLfyv5xikV8Irb64HMqZv0AD1dem1xflWH7kd5QEbmHv253R4PWK70Hfqc3pEETBDHe/
         pvm4MWoVJ7heedxmBK7aY+IgIHNg6dDQaJ/Po01XennmH4Oxln+w7B//XExNO1MQZPRu
         x/aTAGT4crqm1u41l5Zosp9PlNqjVFbCJcjEDRAwgK9NFATWtrVzsHEG5tQFcd9oYJPz
         Os4Q==
X-Gm-Message-State: AOAM530Y61R9rek7GmZRYK2h2DjqrvH5KU/1E8y7lLYw5+fX6pcYfeDm
        g4QaHl27nl822wEcthrDDNDkEGS7/DwjbSlqeBNLNA==
X-Google-Smtp-Source: ABdhPJx3Vz8XUjrWDlXiIUh/Sh4atHIziC30URMIPubkhKz+5T3UAZ0DDID19/ktekugrogcEAwFldQ15Ey/0DQ5z+w=
X-Received: by 2002:a05:620a:1036:: with SMTP id a22mr18710509qkk.186.1620230862131;
 Wed, 05 May 2021 09:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210429103751.v1.1.Ic231ad3cfa66df90373578777cf7cdc7f0e8f2ae@changeid>
In-Reply-To: <20210429103751.v1.1.Ic231ad3cfa66df90373578777cf7cdc7f0e8f2ae@changeid>
From:   Yu Liu <yudiliu@google.com>
Date:   Wed, 5 May 2021 09:07:06 -0700
Message-ID: <CAHC-ybzmwCSbYXRAvUEih6C+H7obkD64OS72QXaOfS_MPOpDDQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Add a new MGMT error code for 0x3E HCI error
To:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping for attention.

On Thu, Apr 29, 2021 at 10:38 AM Yu Liu <yudiliu@google.com> wrote:
>
> This is to enable us to retry the pairing in the user space if this
> failure is encountered
>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> Signed-off-by: Yu Liu <yudiliu@google.com>
> ---
>
> Changes in v1:
> - Initial change
>
>  include/net/bluetooth/mgmt.h | 1 +
>  net/bluetooth/mgmt.c         | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index a03c62b1dc2f..78b94577a7d8 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -45,6 +45,7 @@
>  #define MGMT_STATUS_RFKILLED           0x12
>  #define MGMT_STATUS_ALREADY_PAIRED     0x13
>  #define MGMT_STATUS_PERMISSION_DENIED  0x14
> +#define MGMT_STATUS_CONNECT_NOT_ESTD   0x15
>
>  struct mgmt_hdr {
>         __le16  opcode;
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index b44e19c69c44..9e44c04d4212 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -271,7 +271,7 @@ static const u8 mgmt_status_table[] = {
>         MGMT_STATUS_INVALID_PARAMS,     /* Unsuitable Connection Interval */
>         MGMT_STATUS_TIMEOUT,            /* Directed Advertising Timeout */
>         MGMT_STATUS_AUTH_FAILED,        /* Terminated Due to MIC Failure */
> -       MGMT_STATUS_CONNECT_FAILED,     /* Connection Establishment Failed */
> +       MGMT_STATUS_CONNECT_NOT_ESTD,   /* Connection Establishment Failed */
>         MGMT_STATUS_CONNECT_FAILED,     /* MAC Connection Failed */
>  };
>
> --
> 2.31.1.527.g47e6f16901-goog
>
