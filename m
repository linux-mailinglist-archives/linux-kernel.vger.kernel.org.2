Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B143E8684
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhHJXad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233570AbhHJXac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:30:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76C6960551;
        Tue, 10 Aug 2021 23:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628638209;
        bh=y3cWTqqjb1WsGKSlACTRwaVwEb56Zhd6VF470hJIM1g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pOsrZWHhre2TlMiHrkNqOgf5vclnE2Lcm/rvVBWryKYABEy5H6DQx7jaV9ohDqT3o
         gCM+tD/H9zwkwyL90PmNlf8EUMBnEqg8FKNyUHILaZFLWr+ECoDDVUwigYcsBCU85S
         OioOUaGGinQCnOA9RSNp0VHzditH43qXlqMwTNYFx6qApkO82YeLzKPDY1Ds0FCO0H
         bsFS3Eog2ww5boCV8iVaoPPwhBCpk3vA8HXmfxyyriIbTFEUkKT4SmdnLH+c6jlbqa
         Tv/oGkuUdFdvWKLcKMuembmBxL+cfehyLknY8JwWjyWKgY6WYtuxJHDqvg1+Omv4zv
         QJyPhgZQYUp8A==
Subject: Re: [PATCH] erofs: directly use wrapper erofs_page_is_managed() when
 shrinking
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
References: <20210810065450.1320-1-zbestahu@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <5d83c8be-b7d1-d359-61e0-04a4aed2febf@kernel.org>
Date:   Wed, 11 Aug 2021 07:30:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810065450.1320-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/10 14:54, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> We already have the wrapper function to identify managed page.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
