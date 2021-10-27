Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEED143C173
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 06:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhJ0E2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 00:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230455AbhJ0E23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 00:28:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D4636109E;
        Wed, 27 Oct 2021 04:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635308764;
        bh=W6FMTI2VwUiwDEPf2lg4qjV7hDXEBWma0uo+TjtD/TA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ju+eaB8MDCIW6dFF1lewvAl3MLkwdYqpsQToGXqAoce7iU4OJlTxXse8Cw7CvLS0O
         s1eByC/ap9dH5t2H4brMhk+GqaSwB/tnVzRHV3hPnBiHHrJ4MYx7naQpvWzG2qCSOv
         vvCzHPCGySXaNMXqWitPZ5bTsI9Au/PeiSJhSN6Guzb9UGSoRaAUU9UcSdHFQR+5gj
         9TP2dp9s5K+6OcxdSsFtp1ks9sZlFDnvUaE5cBQQfEUqjLPwcAhUA8uHCKFq56mm6B
         /Pouo/edi8ZIVnXL936pQi6ZRPscD+65DS2MrsPzWHHZaBI6Sc53uDQrqx+YlXhLbq
         aZk+fgQVRLtpQ==
Message-ID: <3be80c98-f637-c5a5-929f-1ddc1994c7bc@kernel.org>
Date:   Wed, 27 Oct 2021 12:26:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v2] f2fs: compress: disallow disabling compress on
 non-empty compressed file
Content-Language: en-US
To:     Hyeong-Jun Kim <hj514.kim@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <CGME20211027041606epcas1p237acb5e258066f2298f3fee162baffe4@epcas1p2.samsung.com>
 <20211027041600.115847-1-hj514.kim@samsung.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211027041600.115847-1-hj514.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/27 12:16, Hyeong-Jun Kim wrote:
> Compresse file and normal file has differ in i_addr addressing,
> specifically addrs per inode/block. So, we will face data loss, if we
> disable the compression flag on non-empty files. Therefore we should
> disallow not only enabling but disabling the compression flag on
> non-empty files.
> 
> ---
> v2:
>   - check F2FS_HAS_BLOCKS() instead of i_size
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Hyeong-Jun Kim <hj514.kim@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
