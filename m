Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A402D357892
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 01:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhDGXdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 19:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDGXdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 19:33:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD4C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 16:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=MpRbqVH11WDrjLdwbclElTPVzrqxrO57EVIBD5YvChw=; b=nffNf62G6/CX8WGvEysy5Kk7AO
        MwShDBcnxiZ3H4csUaoGs3vFs74SpF+UU6I7wuj7WqiWBbtZijYHLi2nsbzxZkkV2OCUTbgLt+dwk
        7ua/4n1won2dLpQC9m0YW2vV0rl0pdZ2gWMBpjmCa4G3xuB98P6kJDZVE3J3fSGda9qUKboV1PcK1
        zEz8JHeKTV8Hol8DtpDeQjZYLXrqoet3if8ViF2yCyQQjBHt51NZAvHDdaRgJGpkIsSSLVeXugFhs
        7NZWIZFW/FCNpDZg5DzvCvGw98IvA2qgUgNo8u4WIgNQ6+Emcn39kCKraBmlgNmK8N96T226+mB4o
        /NQDxgaA==;
Received: from [2602:306:c5a2:a380:9e7b:efff:fe40:2b26]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUHeW-00FGPa-8Q; Wed, 07 Apr 2021 23:32:10 +0000
Subject: Re: [PATCH] sound:ppc: fix spelling typo of values
To:     caizhichao <tomstomsczc@163.com>, perex@perex.cz, tiwai@suse.com
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, caizhichao <caizhichao@yulong.com>
References: <20210323085543.741-1-tomstomsczc@163.com>
From:   Geoff Levand <geoff@infradead.org>
Message-ID: <89c4f3e6-437c-6562-1ab8-5b253c9038fa@infradead.org>
Date:   Wed, 7 Apr 2021 16:32:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210323085543.741-1-tomstomsczc@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 1:55 AM, caizhichao wrote:
> From: caizhichao <caizhichao@yulong.com>
> 
> vaules -> values
> 
> Signed-off-by: caizhichao <caizhichao@yulong.com>
> ---
>  sound/ppc/snd_ps3_reg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Seems fine. Thanks for your contribution.

Acked-by: Geoff Levand <geoff@infradead.org>

