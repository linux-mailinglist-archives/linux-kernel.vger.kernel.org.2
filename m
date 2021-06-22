Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524463AFB26
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 04:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhFVCmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 22:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhFVCmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:42:45 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4BCC061574;
        Mon, 21 Jun 2021 19:40:29 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z22so27932781ljh.8;
        Mon, 21 Jun 2021 19:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8WjX4cnHEYgo+3vdxIdw+5bVRyOPIY5mBYw6H82eb8=;
        b=Mpcpbltx1iFJKINdMHpkVw7066ThgQ06/5vFObBvg7h3S0PL3Srp+IE7Br9m98k1SJ
         ZqDo+dEkcLjfL7FkK8Wn52U3QwsAXDfyOeFniEiWQPF1BuVKtLf2aIsrJXqkiLgxdWC6
         zf9vryWqWM6QiNqnIE3nvp9xObWKGu8AguaorfJVr+hP3e972SNzTPlyT7gRsPmgNvVS
         KjFyfzkB84vOsuTFXAsua3odvruEcsN2HUjZpdgAiom/tLaDEMbjOCC+KVZ+hfPARtky
         dvsEGfAqFCPJO0cIaLoQFpAd5u6fHkYla/vLQZnE9WUrRcGset52dFERO04bIQkjIE+v
         e5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8WjX4cnHEYgo+3vdxIdw+5bVRyOPIY5mBYw6H82eb8=;
        b=VT5yLCKzgGJR/CWNLc7L8mrBVgY94auotoKnJfCvbPggZPSL9BrgEXL0jrmhezF1QK
         9cFkoG7FZJ11sPBWYBm9nXLcsVnDH5arfkm3pw+BxA0KZyAQ/0iYqOT/jBkRQlZR027c
         x2BB2B2zoN6JpJRSTKPCU6Ykxh4PNRrcPh2I4hj+OwDazLDVOJQhL8tlWu3Xc0dxlnU5
         pK3Nro7UovZ5wfiHo/oIHM/0n3pPVOjDUJo4B3XCLQOdDsWmAyPG5Tk8WPltPLu9smUr
         a3q11tLKCBwnuvLfSZ6WZTnjz6FDRPRbR7KuMi2rscE1JDGVNMDOpvBp0KsdkUegxlxn
         JuFw==
X-Gm-Message-State: AOAM533TQUO6b/xWrtW5nFIs9fVFJts9oPO4NyVNZj5Fnq3KBOYxtq/n
        hYNe6wmWoDDiZcmat2V4dPRpYOhkZW6CG/0MssE=
X-Google-Smtp-Source: ABdhPJySx3U18ns7T15pcuPKCF6pSzDGUr8BT5xrxXYEcg6Ga9upcgyuejaj9zI8ljAitWa/d/r5sLcgqZ00nsmp8P0=
X-Received: by 2002:a2e:a234:: with SMTP id i20mr1103486ljm.272.1624329627435;
 Mon, 21 Jun 2021 19:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210621214446.1406159-1-keescook@chromium.org>
In-Reply-To: <20210621214446.1406159-1-keescook@chromium.org>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 21 Jun 2021 21:40:16 -0500
Message-ID: <CAH2r5msjg34KP4OxSwJTHmwawkFBW1k6-EUb4G_Ac4anC9TOgA@mail.gmail.com>
Subject: Re: [PATCH] cifs: Avoid field over-reading memcpy()
To:     Kees Cook <keescook@chromium.org>
Cc:     Steve French <stfrench@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Mon, Jun 21, 2021 at 4:45 PM Kees Cook <keescook@chromium.org> wrote:
>
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally reading across neighboring fields.
>
> Instead of using memcpy to read across multiple struct members, just
> perform per-member assignments as already done for other members.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/cifs/smb2pdu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 31784e3fa96f..962826dc3316 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -2892,7 +2892,10 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
>  #endif /* CIFS_DEBUG2 */
>
>         if (buf) {
> -               memcpy(buf, &rsp->CreationTime, 32);
> +               buf->CreationTime = rsp->CreationTime;
> +               buf->LastAccessTime = rsp->LastAccessTime;
> +               buf->LastWriteTime = rsp->LastWriteTime;
> +               buf->ChangeTime = rsp->ChangeTime;
>                 buf->AllocationSize = rsp->AllocationSize;
>                 buf->EndOfFile = rsp->EndofFile;
>                 buf->Attributes = rsp->FileAttributes;
> --
> 2.30.2
>


-- 
Thanks,

Steve
