Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5A33F8C98
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 19:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243135AbhHZRAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 13:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbhHZRAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:00:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C579C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 09:59:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso7367123wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qnQKMtCrpxtD4U6aslleaR7YtsFiPfp2usl//RcNAcU=;
        b=EadKsHtvrcU131xZgzMiSYw6FjuaMEuHOm/hq9bWSmScHbENdNds8jqP3fApIjykZW
         BAoVYRzrSmHko2nzeg1AamqiHWPctdMy547Tf5MlI7GDibYqJR12vHZoOJer/jLWwGTI
         CtLSYqFxkwcx9nHYrknQSswOzb0FXilXEJDKr/aQHQKebj0+7GbD9O7AfwalJJbsL+Jk
         GcHK/5Wsh01LvVACprLcBZj8UTr0ti7cMHRgG/+FGQyvdtFbF9bkVQ0dNCiGKAYD1e+4
         wijc+yMCobosUr556uTNz4eXD9oeM44x1e5TcLuc5pHytOnquNSjydwX5CcleKATSBu7
         u7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qnQKMtCrpxtD4U6aslleaR7YtsFiPfp2usl//RcNAcU=;
        b=mNUXK1oXKI6KqBIGtYN82Dg8/OCe6D19BTgxlSaImUmEZdkZT9lBrGZV0/VkoCr5yt
         HYbx14JdmiDF0tpUxKJr2QHOcFZMXbwyJElqJV/aJvTg3d6JC6TL26oXVS4Kl7vFiTq3
         gz/fVxYKi1oxsV/IBRVIJg2vjLQ5w6y/lg5ZezDuASljFFsIxxKDeI7lBc7Twqsv5xje
         W5mtjX/TaY+BbBx1eJcqQ+lh5CrsDhYERWMaINryRVplWujcqEQKHwHE8uFoitQXHxB2
         GW35QMeNaEe1KxWaF7G7aIvRPoNRL4wFGUC95XlLm5zNUukZTBYvM284WbSW63mRw7jg
         j6YA==
X-Gm-Message-State: AOAM531MuR3rEldlGIpszIgiGaCHhfxFjZjgDcuMmk3erssKvCBn0cO8
        HSHRjB3xHc6SKr2RMC+ImE3YmQ==
X-Google-Smtp-Source: ABdhPJwPgeuBh6v9VCnH1N8xiLxNFkZx/GLFIh0UmWj+okTfsy42zvtTHybKYkq3vqXOwd2e/cXQ3Q==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr4746792wmc.42.1629997197947;
        Thu, 26 Aug 2021 09:59:57 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id t5sm2552698wra.95.2021.08.26.09.59.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Aug 2021 09:59:57 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 0/4] optimize the bfq queue idle judgment
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210806020826.1407257-1-yukuai3@huawei.com>
Date:   Thu, 26 Aug 2021 18:59:55 +0200
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A983576-4EE3-441A-8515-14A819A94B8B@linaro.org>
References: <20210806020826.1407257-1-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 6 ago 2021, alle ore 04:08, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> Chagnes in V2:
> - as suggested by Paolo, add support to track if root_group have any
> pending requests, and use that to handle the situation when only one
> group is activated while root group doesn't have any pending requests.
> - modify commit message in patch 2
>=20

Hi,
sorry for my delay.  I've just finished reviewing your new patches.
As I already said, I like the improvement you are making.  Now the way
you make it also seems effective to me.  I still have a design
concern.  You will find it in my detailed comments on your patches.

Thanks
Paolo

> Yu Kuai (4):
>  block, bfq: add support to track if root_group have any pending
>    requests
>  block, bfq: do not idle if only one cgroup is activated
>  block, bfq: add support to record request size information
>  block, bfq: consider request size in bfq_asymmetric_scenario()
>=20
> block/bfq-iosched.c | 69 ++++++++++++++++++++++++++++++++++++++-------
> block/bfq-iosched.h | 29 +++++++++++++++++--
> block/bfq-wf2q.c    | 37 +++++++++++++++---------
> 3 files changed, 110 insertions(+), 25 deletions(-)
>=20
> --=20
> 2.31.1
>=20

