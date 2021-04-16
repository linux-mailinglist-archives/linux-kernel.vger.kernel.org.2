Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9893362164
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244260AbhDPNrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244237AbhDPNra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:47:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CABC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 06:47:06 -0700 (PDT)
Received: from [IPv6:2a02:810a:880:f54:c1fa:1310:49b:e88e] (unknown [IPv6:2a02:810a:880:f54:c1fa:1310:49b:e88e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9AFF61F41957;
        Fri, 16 Apr 2021 14:47:04 +0100 (BST)
Subject: Re: [PATCH] iommu/mediatek: always enable the clk on resume
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, will@kernel.org, yong.wu@mediatek.com,
        kernel@collabora.com, dafna3@gmail.com,
        enric.balletbo@collabora.com
References: <20210408122842.29009-1-dafna.hirschfeld@collabora.com>
 <YHhA4u7zat3vtJfD@8bytes.org>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <3c1f184f-e666-5198-e89e-c3774917c6d4@collabora.com>
Date:   Fri, 16 Apr 2021 15:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YHhA4u7zat3vtJfD@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I sent v2, removing the word 'comment' from the 'Fixes' tag
after a problem report from Stephen Rothwell,
could you replace v1 with v2?

Thanks,
Dafna

On 15.04.21 15:34, Joerg Roedel wrote:
> On Thu, Apr 08, 2021 at 02:28:42PM +0200, Dafna Hirschfeld wrote:
>>   drivers/iommu/mtk_iommu.c | 19 ++++++++-----------
>>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> Applied, thanks.
> 
