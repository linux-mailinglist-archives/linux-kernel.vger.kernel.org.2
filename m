Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9523D85FC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 05:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhG1DBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 23:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhG1DBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 23:01:54 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEC5C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 20:01:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GZJNC510kz9sWX;
        Wed, 28 Jul 2021 13:01:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1627441308;
        bh=zX1C16qqqIJJgzlwuK/90tstge6Gxyn/4mQmQ1LVDK4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gzWyRti+29ip505uVfvV3iKdJR9oW88gLdQmfEQMurAc7Vij6o+50EO/i/s+D70ov
         6mPGKFbNgRkkwkRIGemoT2w4anpwTT4QbbQRZ/RCMAOw7voFbjh2kDPGSOMSA6zW2o
         2I/6G36aLnx5j1rLE/uBE3wt+QbkyBMDLJMxuefV+4CxiUJzonQUPrMBEXrBSh3JdC
         P/YSqa6IgV9tfXI/DFOsG/+GrGSvKqmFWZrde4FL6jeo53a+HO6BimsVXi1OimpjJR
         OGeQvraiW1mqbuXoTPK/Cx+7Tw13xWbLwiLog64ukvgek0DTdluDlKThLyX6zT+RQp
         HtzrrXPi/YiMg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: Re: [PATCH] powerpc/xmon: use ARRAY_SIZE
In-Reply-To: <20210725150107.27865-1-wangborong@cdjrlc.com>
References: <20210725150107.27865-1-wangborong@cdjrlc.com>
Date:   Wed, 28 Jul 2021 13:01:44 +1000
Message-ID: <87bl6n16qv.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Wang <wangborong@cdjrlc.com> writes:
> The ARRAY_SIZE is the macro definition of sizeof(a)/sizeof(a[0]) and
> it is more compact and formal to get a array size.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/powerpc/xmon/ppc-opc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

This code is copied from binutils, please don't change it unnecessarily.

cheers
