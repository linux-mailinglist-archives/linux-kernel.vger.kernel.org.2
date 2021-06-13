Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5823A58E9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhFMODF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 10:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231755AbhFMODD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 10:03:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8BEC6128B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623592862;
        bh=0GuJ8MA8YvAb5LFEu1wccuQD+B/n8HPSEdt3rIsJcas=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o+51Gt//Duy1u56s/dk9eBSqfx7WwhWuvnaaLdrcMaG3LmeZrVtGkRkI0C4u7F+xe
         MxBf0MbTrfv0YH/G6frmBvYzEuaW6sMJahhiCIvqmWnkPBI768dvBpziGRFpQSGnJQ
         Kw7IJpvWeimsERuU/hgc07usgvl1rNQG03BeR0t6imRpYE4d960nqdYjJPaCOl9t6f
         YZyIUp/KPawWcIo6YortJ8GsP/C6ZZ7N4JC6L+MCWK34JxuTCNX+HDy0cm9zJZYQpV
         IF4eKBEJiwc1AqZkcKAiObyK0Xr18kE6SKRBUxzlTr07ucdXnGiyumBZKLXih4B07+
         /5bcHZKbI8W2w==
Received: by mail-pj1-f51.google.com with SMTP id k22-20020a17090aef16b0290163512accedso9238373pjz.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 07:01:02 -0700 (PDT)
X-Gm-Message-State: AOAM530SwtF3OnaEnsOElI58ovMf3yLOKDFbJxznjo+Nn8ZGuA9N1Bp2
        4cuMht6sn5g0X74nBNwo5QPkIe2qBVjMaNi3Uzc=
X-Google-Smtp-Source: ABdhPJyFOyiJWkaOurdmvQmKHDKj6R/+QYd0Y/yarti/BChQroTPj0Zm9Ag2edUHztcoSXwOu7UmDfTXDUlbEeJ5BU4=
X-Received: by 2002:a17:902:d4c8:b029:102:715b:e3a5 with SMTP id
 o8-20020a170902d4c8b0290102715be3a5mr12622809plg.83.1623592862495; Sun, 13
 Jun 2021 07:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210611093626.579176-1-yangyingliang@huawei.com> <20210611093626.579176-10-yangyingliang@huawei.com>
In-Reply-To: <20210611093626.579176-10-yangyingliang@huawei.com>
From:   Timur Tabi <timur@kernel.org>
Date:   Sun, 13 Jun 2021 09:00:25 -0500
X-Gmail-Original-Message-ID: <CAOZdJXUn9FgdhiPAqbxMrz4tSeqQ_S+L9jkpg48NxCo5Fz7PXQ@mail.gmail.com>
Message-ID: <CAOZdJXUn9FgdhiPAqbxMrz4tSeqQ_S+L9jkpg48NxCo5Fz7PXQ@mail.gmail.com>
Subject: Re: [PATCH -next 9/9] ASoC: fsl_xcvr: check return value after
 calling platform_get_resource_byname()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        PowerPC Mailing List <linuxppc-dev@lists.ozlabs.org>,
        alsa-devel mailing list <alsa-devel@alsa-project.org>,
        timur@kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 4:32 AM Yang Yingliang <yangyingliang@huawei.com> wrote:

>         rx_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rxfifo");
>         tx_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "txfifo");
> +       if (!rx_res || !tx_res) {
> +               dev_err(dev, "Invalid resource\n");
> +               return -EINVAL;
> +       }

If platform_get_resource_byname() returns an error, it's probably
because the name cannot be found.  So I think this error message is
more accurate:

"could not find rxfifo or txfifo resource"
