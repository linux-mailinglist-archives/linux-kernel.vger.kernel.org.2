Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2035BAE3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhDLHhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhDLHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:37:22 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CA3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:37:05 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id d12so12517874oiw.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ObdGU65M/fnAKtrmSC1hHUrnCEDTl7tLsUN7Hou/Kx4=;
        b=yN8W8ckWqJqQfldppJ47OT5b2E4pKRK0BLlhP9fLIJ6osYzKw34KRwccZexV0QgwM1
         GArPGikPnzqoRDfbCWlOcQggDwnVl4LBSoOae+jeLMQxWicJ5rRR9vlyv0F60liBnF4o
         s7FR16D6Enp+X5ouGsncFZhsLMx1FB7+9nTaf8H5K7I6aZFTdQJKvFgk6mqSU8LFTh0G
         a1XJeCH8+CZnkDvnL8FLWwMi9Gw9Mu58Iq0iQYkmRBRk6EwH3eIPaLUSkZd7xhP8cRam
         JzTbPreggEOCYI90uhDidgzHErm83HptfmSHtI/CsSLaP2KhDZk+Wl7WccZq4Vfj3Dkx
         IA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ObdGU65M/fnAKtrmSC1hHUrnCEDTl7tLsUN7Hou/Kx4=;
        b=V88MHxAYwWNquAEsXsRTxSX4uzCKU8+oNWZE4z+rfjgoK6paGSQiX2u1OOWbdZNYrN
         6K5XaC9dg1j5tzfJ0z2iKTAVcNDOaKonTltwIFTHV1UDAtj1sA2GpIxIqs0lh/CNWBhb
         cmkJ+bs8P09gg+ZHaz6QD/X/F8FybFEhWvfMU8yDk9QkThMjcJUeNgSKvMhJvWt1eZBu
         v+VxHr5VmTqZQMvmjgI90RiEkaNJdwfoop2KbAluLa2I9tNH9DvajYoxI+fGgCFnNs0r
         fdLpYw7FuYjIMWzI4/RqDKnbgNgrVDY2Hki6VYH9MCgdqeFGuCQAdRfFZOM3DoyE6Kca
         okvw==
X-Gm-Message-State: AOAM5333nL71Lu04mPTU6EDWDNRQf13iCvmlyPHOu6ZKTLIwJfAyBtZd
        sbk5kp2pREB2K/OOuM9tmMJib7+V0a1uD0SQkRqQ9g==
X-Google-Smtp-Source: ABdhPJwqZrl08pY1ljWFD6WA4HQ/JP26Wif5Q1ip3Uj1c2U/7+WmBGT8kDRPDfOC8cS7cVYteDGgL3e/yDFAvH8Nfzo=
X-Received: by 2002:aca:7c4:: with SMTP id 187mr18620213oih.47.1618213024537;
 Mon, 12 Apr 2021 00:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <3150feb19421ca6b15202c853215f8b40fe35567.1617615067.git.Rijo-john.Thomas@amd.com>
In-Reply-To: <3150feb19421ca6b15202c853215f8b40fe35567.1617615067.git.Rijo-john.Thomas@amd.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 12 Apr 2021 09:36:53 +0200
Message-ID: <CAHUa44Gga=k3indU8FC3X5xE=6RnKEDNeZBDWeJzm47-Spm0QA@mail.gmail.com>
Subject: Re: [PATCH v2] tee: amdtee: unload TA only when its refcount becomes 0
To:     Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Mythri Pandeshwara krishna <mythri.pandeshwarakrishna@amd.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 5, 2021 at 11:43 AM Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>
> Same Trusted Application (TA) can be loaded in multiple TEE contexts.
>
> If it is a single instance TA, the TA should not get unloaded from AMD
> Secure Processor, while it is still in use in another TEE context.
>
> Therefore reference count TA and unload it when the count becomes zero.
>
> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> ---
> v2:
>  * Unload TA if get_ta_refcount() fails
>
>  drivers/tee/amdtee/amdtee_private.h | 13 ++++
>  drivers/tee/amdtee/call.c           | 94 ++++++++++++++++++++++++++---
>  drivers/tee/amdtee/core.c           | 15 +++--
>  3 files changed, 106 insertions(+), 16 deletions(-)

Looks good to me. Please address Dan's comment.

Cheers,
Jens
