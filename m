Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412D73507A5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 21:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhCaTvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 15:51:45 -0400
Received: from ms.lwn.net ([45.79.88.28]:48292 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235995AbhCaTvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 15:51:19 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1D1199B1;
        Wed, 31 Mar 2021 19:51:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1D1199B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1617220275; bh=EEHjSy38eDkmBHhG9hxDYKTsPRe7jW1nMUaESQgRSZ4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fUGiKxNLoWOp9UgcEzIj2nD17PVe/e5M1wKm1NO/65qhkBtSsnSCOSttgx0hCtlax
         uiZqOiAFjz6RxkZdXBgp+Sf376WP3boJ4oxRPYSTn8fHN/4XrbRm8IPi4/3Le36uTU
         QKFDjOhOtc8lZ95U286rbce6XWiKDyIKSfRLg/B3sRkkt2ge8CPyAAyJ3qryiRpYRv
         LHXZzykKfixxlvFakMoo/rBtRWC6ECIgslWeE9HOc5c7jbOOtuEFB939L2wlEeTsfH
         xEJ84PVovuJ+8BSjOXuUrIy2MCvCgQOh4ONH6fdIsK/luWJUCA7FhNNql//WAym8G/
         45RQ3DmZ2mZ3Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     He Ying <heying24@huawei.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, ruscur@russell.cc,
        oohall@gmail.com, heying24@huawei.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: powerpc: Fix misspellings and grammar errors
In-Reply-To: <20210326100853.173586-1-heying24@huawei.com>
References: <20210326100853.173586-1-heying24@huawei.com>
Date:   Wed, 31 Mar 2021 13:51:14 -0600
Message-ID: <878s63ksp9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

He Ying <heying24@huawei.com> writes:

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: He Ying <heying24@huawei.com>
> ---
>  Documentation/powerpc/booting.rst                | 2 +-
>  Documentation/powerpc/dawr-power9.rst            | 2 +-
>  Documentation/powerpc/eeh-pci-error-recovery.rst | 2 +-
>  Documentation/powerpc/elfnote.rst                | 2 +-
>  Documentation/powerpc/firmware-assisted-dump.rst | 2 +-
>  Documentation/powerpc/kaslr-booke32.rst          | 2 +-
>  Documentation/powerpc/mpc52xx.rst                | 2 +-
>  Documentation/powerpc/papr_hcalls.rst            | 4 ++--
>  Documentation/powerpc/transactional_memory.rst   | 4 ++--
>  9 files changed, 11 insertions(+), 11 deletions(-)

Applied, thanks.

jon
