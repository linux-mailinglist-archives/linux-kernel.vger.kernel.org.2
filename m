Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D256E3A1C79
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 20:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhFISG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 14:06:26 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:37880 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhFISGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:06:25 -0400
Received: by mail-lj1-f179.google.com with SMTP id e2so1003159ljk.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9YdZryUHOFemXxBmnNMasEA3KQSlyNFX0TrYWhkRb9M=;
        b=q9uZT40smGEUmu6fsQpa5IX0SX0yBPHtqnMFDQeDkJ7+TJ4vcrokwpf0lC7Q8u4RL+
         omhGlvMxvtWt0b2GqUHkOTLG6etOzSDwiBzzCWn2STduWotJ9aTjXT+KFBTZ74FptSyp
         B8FmhaA9lPmEskCR2DQ+oRXDS0/7iDWCDpFt2N4oFr8MshrVKj6DaNVmbfxuUdo32X1c
         +2BdAJxVTA0g2tt6GPh3e6eoWkLZ9UU7byX5ZGeD4H33dJ8iYSGtkOuQCGv4PP/a3UGI
         OSpeKIkK+iGznuvaGygkjJDtbRtVmd2EuS8j++SGUAGc8CtjnNTV4WyA3SoC5LGjNzFY
         YVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YdZryUHOFemXxBmnNMasEA3KQSlyNFX0TrYWhkRb9M=;
        b=AeXOpSsX3mQRVnLDim1bYbZy16Mq8xW6Dzk8uBWkX9oajMbDqcC/+xYITak6i1pMzW
         fifRkk7mRqYZS5XEDSBs2AheCFI4tnJJWY91AR4HaAqEWcJtinm1rLDep4PQ3ICu4zyA
         b+M6h84GMmRDcTgb5wy50DvXr8xCenXbhkDQ3EZC9O53gu6YcOKAR3lNSGJ3z4oFJ+6e
         NbhX9BJK7pmdvKCw/bIy3IVPiMdim1TWjlZQlQj0kkzz5GsjNEgApnyhwsyHk1B1INpD
         k5GL1RRMMiwPmfCYXz8chsTH2tg31m2Cj1nHSoHN7zeB+hJYvpWhD8BC+Zwd6iynJuW4
         fESg==
X-Gm-Message-State: AOAM5331lSRAjs0lMwEPXetmRug3TmPPZy7FiMBYMSl0H9xOVGcFBVmu
        5JABgJNYb5Gpz8vyzz4dD0vB1mcrZVDhx/ap8B1x3A==
X-Google-Smtp-Source: ABdhPJzUqOVP1jg0cBhoTP0lwiwl3Dn1H25jFPgICK1fPJaqQM4zMD1hXfiJPJyG+VE/mxH/lPjZjQUhroKjsN7ARV0=
X-Received: by 2002:a05:651c:1111:: with SMTP id d17mr837367ljo.116.1623261807735;
 Wed, 09 Jun 2021 11:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <1623222893-123227-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1623222893-123227-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Jun 2021 11:03:16 -0700
Message-ID: <CAKwvOdn0WP53-qNLH8ce7R5meudaXbnvxyAn58p_NOzZhxMGCQ@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: xilinx: dpdma: fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     hyun.kwon@xilinx.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nathan Chancellor <nathan@kernel.org>,
        dmaengine@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 12:15 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix function name in xilinx/xilinx_dpdma.c comment to remove
> a warning found by kernel-doc.
>
> drivers/dma/xilinx/xilinx_dpdma.c:935: warning: expecting prototype for
> xilinx_dpdma_chan_no_ostand(). Prototype was for
> xilinx_dpdma_chan_notify_no_ostand() instead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

I'm ok with leaving my reviewed by on _this_ patch because it's so simple but...

In general, when sending a follow up version of a patch, it's _not_ ok
to add a reviewed by tag when a reviewer has not explicitly responded
with "Reviewed-by: ...".  That provides a false sense that a patch has
been thoroughly reviewed.  Responding to a patch does not constitute a
"Reviewed-by:" tag.

And I might be fine with _this_ patch, but that says nothing about
Nathan, whom you've also falsely attributed a reviewed by tag here.

For such a trivial patch, it's not a big deal, but in the future
please do not do that again.  It's ok to send v2, v3, etc, but wait
for reviewers to explicitly state such reviewed by tag. The maintainer
will collect those responses (and can be done so in an automated
fashion via a tool like b4 (https://pypi.org/project/b4/)) when
applying patches.

> ---
>
> Change in v2:
> --replaced s/clang(make W=1 LLVM=1)/kernel-doc/ in commit.
> https://lore.kernel.org/patchwork/patch/1442639/
>
>  drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index 70b29bd..0c8739a 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -915,7 +915,7 @@ static u32 xilinx_dpdma_chan_ostand(struct xilinx_dpdma_chan *chan)
>  }
>
>  /**
> - * xilinx_dpdma_chan_no_ostand - Notify no outstanding transaction event
> + * xilinx_dpdma_chan_notify_no_ostand - Notify no outstanding transaction event
>   * @chan: DPDMA channel
>   *
>   * Notify waiters for no outstanding event, so waiters can stop the channel
> --
> 1.8.3.1
>


-- 
Thanks,
~Nick Desaulniers
