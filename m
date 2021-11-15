Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D4C450193
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbhKOJos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhKOJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:44:45 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562C7C061766
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 01:41:49 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w1so69193749edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 01:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYqbeZ2mpQmpuB6ksQc8ohOCYowaIxnorZPGKiryA0c=;
        b=JdMnykfVIKiiMfL2VFgEJRbHZB7MfwD71DqvHpdzQbO4tmxNago+L3p/1h7ESjNjyu
         oxO3rtK9kRAb2z/eOpuFUIiMi43U4dSeXoNKMy3cgMKNfn3ZVa86cGUixekGfuUCLsxm
         /7nMCOBspoDbYJ3JgGZL15HZc7ypC4LNbKMnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYqbeZ2mpQmpuB6ksQc8ohOCYowaIxnorZPGKiryA0c=;
        b=yGMT67KmWeqzVEAIQjIzoyHv4MT7BKds42kxrV4h6QHzlLPqS8L4/h2soxQt8f9NTJ
         4ZHQOwcJVLcWrt4qU9CeYcF+qenniBi6JU3OJ+kqbUoY5x+bPDBH0I3XrcftHGRPJtsO
         IJlyykAnAecKd981D91eqYdH50bDBKiSxvFvG6cpadbG/WEELmOX6QG6s1PFXmcx+yvM
         /YqSmnsq3V+/n6MbcJwF8g7VOv3xFrwm9vdQx89btKeHDZ50vS0vGZlPKMXQ7Am5UDqr
         zTnaaAZGDej2S5Pwr32B592yoQjGarJca5ii0zvxjOOmB6TuCrpUfdtvO+MK0xohSISq
         UvaQ==
X-Gm-Message-State: AOAM531tco/JnK5i9PxiZRO5x2RxsIZLY6r2gNXjVx+MBTdoDBKS8WaI
        xcQdcYjRtpXJ7SQNlxY50GnpRuV3EA0kZ/qFS+mVmQ==
X-Google-Smtp-Source: ABdhPJxLrlF28FgYkomzR4UH3SqUDvOokPN1DVYuV1rM6mujj1DJG9mFRIRGyNDhu/4m275cebUKYM4RiMCcXsJPkpM=
X-Received: by 2002:aa7:c719:: with SMTP id i25mr16210158edq.157.1636969307866;
 Mon, 15 Nov 2021 01:41:47 -0800 (PST)
MIME-Version: 1.0
References: <47ed717c3070a1d0f53e7b4c768a4fd11caf365d.1636707421.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <47ed717c3070a1d0f53e7b4c768a4fd11caf365d.1636707421.git.christophe.jaillet@wanadoo.fr>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Mon, 15 Nov 2021 15:11:36 +0530
Message-ID: <CA+sbYW3WNJNWSNL84XgZ+PPSbR+_S93HV1u0CGS+3uNTpDp-WQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bnxt_re: Scan the whole bitmap when checking if
 "disabling RCFW with pending cmd-bit"
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Eddie Wai <eddie.wai@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 2:36 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> The 'cmdq->cmdq_bitmap' bitmap is 'rcfw->cmdq_depth' bits long.
> The size stored in 'cmdq->bmap_size' is the size of the bitmap in bytes.
>
> Remove this erroneous 'bmap_size' and use 'rcfw->cmdq_depth' directly in
> 'bnxt_qplib_disable_rcfw_channel()'. Otherwise some error messages may
> be missing.
>
> Other uses of 'cmdq_bitmap' already take into account 'rcfw->cmdq_depth'
> directly.
>
> Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
