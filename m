Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4A73CF2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 05:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346889AbhGTC5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 22:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346938AbhGTCyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 22:54:50 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696BAC061768
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:35:28 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id l5so22521002iok.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46s+twwjNv2sIPRbtw2A5bIDmISsKXnSTnGDLXGIZ0E=;
        b=O7/9wAbSVU1X2NPTi8SQJBRiExLOOIzoQwML7nz2eyMX0iaMTG1iubRKpBfJXNStNO
         u7PZE+c6iRaq1TxMI/x8I18vNdOPyZZYzbEEa5lcue5KS4mSSV0gp7pMWqf/SnmrG+7k
         CBabDT8vj+PC+p9opMnJNVQVGfCpTVoH0TfyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46s+twwjNv2sIPRbtw2A5bIDmISsKXnSTnGDLXGIZ0E=;
        b=Qv0HVkn2WB7xs35nmLuYFYYF/+Roc0TUMHulAItouflvszsGOMEEuKJE6oNkViJsmx
         Q6g7M17hPVpwLvfZ2vDOztXmbw/G0afekIMzUUtRzqtN93qvIDUVL3BSVMBr4eZPjUuO
         QA83Eh80t4WCw8KwgdonUmVDOVTrBR6MmyVqs0G/85HLgGd1uwpGa/gP9EBOq+FtD6kw
         +BihIDB2sx6Bdvv/9VGudKHCMUKBW20hDqRTHMo7d88Q4OPVXStNrnM8G43OYvwsTzSr
         vQQdZ3zpNzuwx/AoqooCito9I1M7thNugoLa05Cnz9elfc5yX9K/kQZlYoN5NfVqIh/I
         MKbw==
X-Gm-Message-State: AOAM533K1Ow2o+pg3sAzQx36yyq0DJjbblSCpUoNxvuPlGCaH2LjtI/u
        RMxocJ8PEqw7OIn12CqytE5wzIaZmHqpaQ==
X-Google-Smtp-Source: ABdhPJzMOrPMh7mfGyEsi5sgGRdwZZXperYqwFLzjXXcha205iTW0LlMxV1oxoKCfjuQ/k+7CFZijQ==
X-Received: by 2002:a05:6638:3a4:: with SMTP id z4mr24581435jap.65.1626752127604;
        Mon, 19 Jul 2021 20:35:27 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id c7sm10317926ile.69.2021.07.19.20.35.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 20:35:26 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id w1so17944423ilg.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:35:26 -0700 (PDT)
X-Received: by 2002:a92:dc4f:: with SMTP id x15mr19263827ilq.64.1626752125837;
 Mon, 19 Jul 2021 20:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210719123054.6844-1-will@kernel.org> <20210719123054.6844-2-will@kernel.org>
In-Reply-To: <20210719123054.6844-2-will@kernel.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 20 Jul 2021 11:35:14 +0800
X-Gmail-Original-Message-ID: <CALiNf29az7Y3t8OfDKRoNkhEzh4qcD-BDRX1rP-ZhfzwXAROsA@mail.gmail.com>
Message-ID: <CALiNf29az7Y3t8OfDKRoNkhEzh4qcD-BDRX1rP-ZhfzwXAROsA@mail.gmail.com>
Subject: Re: [PATCH 1/5] of: Return success from of_dma_set_restricted_buffer()
 when !OF_ADDRESS
To:     Will Deacon <will@kernel.org>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 8:31 PM Will Deacon <will@kernel.org> wrote:
>
> When CONFIG_OF_ADDRESS=n, of_dma_set_restricted_buffer() returns -ENODEV
> and breaks the boot for sparc[64] machines. Return 0 instead, since the
> function is essentially a glorified NOP in this configuration.
>
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Claire Chang <tientzu@chromium.org>

> Link: https://lore.kernel.org/r/20210702030807.GA2685166@roeck-us.net
> Fixes: fec9b625095f ("of: Add plumbing for restricted DMA pool")
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/of/of_private.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 376462798f7e..f557bd22b0cf 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -173,7 +173,8 @@ static inline int of_dma_get_range(struct device_node *np,
>  static inline int of_dma_set_restricted_buffer(struct device *dev,
>                                                struct device_node *np)
>  {
> -       return -ENODEV;
> +       /* Do nothing, successfully. */
> +       return 0;
>  }
>  #endif
>
> --
> 2.32.0.402.g57bb445576-goog
>
