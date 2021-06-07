Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B610F39DE4B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhFGOEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhFGOEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:04:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 353F06109F;
        Mon,  7 Jun 2021 14:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623074533;
        bh=KYCIX3pLUm0gdVK2rnWH38u1p5z/G1DqTnBuzw91XJE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YFkR9SRasvWrfzUy9bmgDtrzo2DAYABeVhY8StSMDHPFXK9V7Sf3jYo/XZ7603cii
         CeAjDHRrJyciOPN/WBUitHr486qPo6ZkeG3afLXQh2t8Da6pvYlbLPidhyCpDUCJGA
         AGrltOiMXT+PIcV4PIK+PNn9l+WsL2rOVU2zj/HH4McMR36B/BvhGSe1E67X3pmhaB
         njKyUR6wUA8gCBpoKdThSwjmjmCsr/YL0L41JhxD0uF1mD+wcDU9rQ6kCLA0xQqXwv
         nwzcqUSbGGQhI7B0uGzLxCPA91SM4SzkXyr6haErB/6Xl/VTRuNyWB9rAsiMyYGFFQ
         qL9PYJby/abfg==
Subject: Re: [PATCH] erofs: clean up file headers & footers
To:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210602160634.10757-1-xiang@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <b06f2b88-98ca-6714-4959-a1430254f2bd@kernel.org>
Date:   Mon, 7 Jun 2021 22:02:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210602160634.10757-1-xiang@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/3 0:06, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
>   - Remove my outdated misleading email address;
> 
>   - Get rid of all unnecessary trailing newline by accident.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
