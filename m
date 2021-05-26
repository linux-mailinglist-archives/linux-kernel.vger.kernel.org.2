Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36D9391711
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbhEZMLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhEZML3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:11:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43327613D6;
        Wed, 26 May 2021 12:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622030998;
        bh=o437F/NDmnXSz60kGFxOTq/koslQcitDFaKgPYc4TEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZQ6J+KLOn8p++yxL2LiNkjpgGdk7Go0/iVyvLTTHOyciLMwZ2cJhzx+2+aTPKFMs
         1dmtWcUbipswXuRONoC08aA5oQ0URzcJrEkTooQVBedW9KBcJ13Q78jUktMojrF9pL
         FNVp0npKvJYL5Cws/aPvQRPkeGKCHg3l4gaYt8ne+qqsngSPxwlJvoNDVqPhs54pbg
         ZhEAjSRHIsE8wynYtuGoRekkp+CVNFQ3i2NPxWZNUZCH4XFrps6ElcDnyHL5PFMHh+
         XzPxK14Hs+NbBSarqFr72IauF3ARrtkJ3l7w7ngzq+SO4hcxxOpmWuwNVbRmf0sNOm
         ypjyPPv+zSHnA==
Date:   Wed, 26 May 2021 14:09:54 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     sfr@canb.auug.org.au, swboyd@chromium.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] module: fix build error when CONFIG_SYSFS is
 disabled
Message-ID: <YK46kiW1gHYAaK7a@p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de>
References: <20210525105049.34804-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210525105049.34804-1-cuibixuan@huawei.com>
X-OS:   Linux p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de
 5.12.0-2-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Bixuan Cui [25/05/21 18:50 +0800]:
>Fix build error when disable CONFIG_SYSFS:
>kernel/module.c:2805:8: error: implicit declaration of function ‘sect_empty’; did you mean ‘desc_empty’? [-Werror=implicit-function-declaration]
> 2805 |   if (!sect_empty(sechdr) && sechdr->sh_type == SHT_NOTE &&
>
>Fixes: 9ee6682aa528 ("module: add printk formats to add module build ID to stacktraces")

Hm, can't find this commit in the next-20210526 tree. Commit 7685f91fed25
("module: add printk formats to add module build ID to stacktraces")
seems to be the correct one.

>Reported-by: Hulk Robot <hulkci@huawei.com>
>Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
>Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Acked-by: Jessica Yu <jeyu@kernel.org>

