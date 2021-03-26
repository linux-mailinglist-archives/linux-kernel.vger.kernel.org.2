Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579C934A27E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhCZHYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhCZHYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:24:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF79461A45;
        Fri, 26 Mar 2021 07:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616743456;
        bh=lX/80uGLe0JABuz9/Sat3RiOhg6CKPQU9KB49SC6miw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d23ZYfGT5UX9TzKMtS6DUY2KYWYQAJMujFbiJ+qpW44CTZArzt0Qz5DcAYAIeWp08
         TqY98yTzlwp+zV4+jShzCmLFvPnGVHd/BUoL20dzgVBLucz/eV/soaxYDBXeUfhpCm
         vkOktUzatMBKtDtOu+zNse9tfjMGYiFKUDnRJPrnl98fSMbEYSfMnby3jtnU2/adho
         tdXpKxHQawaVpVNPYMo/Jaj417myX58FUCm+cg4qEgLn4FA2XVL07ziFGvwEDK9kij
         hKpJSI7+6V0VwWpdIH2M+ZouvR6+oq+xBr+0B7kWRPUx2G2oBO5SxodAtVAKu72XV+
         eP8XT8GSi3Q+Q==
Subject: Re: [PATCH v2] drm/omap: dsi: Add missing IRQF_ONESHOT
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1616492093-68237-1-git-send-email-yang.lee@linux.alibaba.com>
 <20210323111539.5wi3ldwfvxvzmio7@earth.universe>
From:   Tomi Valkeinen <tomba@kernel.org>
Message-ID: <84621ac3-a4b6-cd95-1c7a-00cb971f23c7@kernel.org>
Date:   Fri, 26 Mar 2021 09:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210323111539.5wi3ldwfvxvzmio7@earth.universe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 13:15, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Mar 23, 2021 at 05:34:53PM +0800, Yang Li wrote:
>> fixed the following coccicheck:
>> ./drivers/gpu/drm/omapdrm/dss/dsi.c:4329:7-27: ERROR: Threaded IRQ with
>> no primary handler requested without IRQF_ONESHOT
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>> ---
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> Also maybe add this, so that it is properly backported. OTOH old code did
> not have IRQF_ONESHOT either.
> 
> Fixes: 4c1b935fea54 ("drm/omap: dsi: move TE GPIO handling into core")

Thanks, I have applied this.

  Tomi
