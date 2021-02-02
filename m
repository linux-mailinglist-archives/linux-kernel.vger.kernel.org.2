Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB75230C946
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbhBBSO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbhBBSLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:11:13 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5496C061793
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=7DYkva/bTpl9W1P3QcVm3lnW/O6szR6PkUt261/VRgI=; b=bxDYixQiBL37HFgc53gq0M0d6V
        qw1vKdclZ4Qe8hgOtjLJj+tXeK7XAmzXEFi5V3chX8pWGT8oWuRij6t65UD+L3Enp2Uxo80LFbRmj
        tHRrPlvPgBpb38sSGYi55GJ4+Cs9C6bsbD4Bx5kSiuvT/PMF+WsPTcyv1hn3y9leGPi6sL6PVNKkQ
        RShAdgFoGdE5tdjNm8FGmMHUXmWKdSQnIIm9DRXRV4pxvX3UTclNObFs5Gdg92MNiE3B78DueFueB
        L7qhSj9hQMHVoexplLmrPz2a0cZDcPbA9uaWlovmZ503mR0TThneQNgJqJXOgxB3YhZRfbvBaDL0d
        5NBHHb+g==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l708D-0003Mi-Ge; Tue, 02 Feb 2021 18:10:29 +0000
Subject: Re: [PATCH] arch: powerpc: kernel: Fix the spelling mismach to
 mismatch in head.44x.S
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        akpm@linux-foundation.org, rppt@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210202093746.5198-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e50d1c19-9d38-b15e-6b58-905315af7d4c@infradead.org>
Date:   Tue, 2 Feb 2021 10:10:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210202093746.5198-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 1:37 AM, Bhaskar Chowdhury wrote:
> 
> s/mismach/mismatch/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/powerpc/kernel/head_44x.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

-- 
~Randy

