Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75193E8777
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhHKBAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 21:00:07 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:37199
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S231423AbhHKBAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 21:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Message-ID:Subject:From:To:Cc:
        Date:In-Reply-To:Content-Type:User-Agent:MIME-Version:
        Content-Transfer-Encoding; bh=bkyTr8U9mDgH26ArdVJoULtROyWhuFWJsu
        f21BkcZDw=; b=dbVwKKMGPNg06LIxiY+qWAS3QOsq926JtQQVHit70fpesl/m3q
        zDD7lwxayURSKEa81YSPyxhUAm6YwkQ95aWmF0uuHRLK6pD7VL+f1GN4b88xxMjl
        N8Dwi+iUwYz7puHg70ij4KufnEg3Ln550fsDSpQsObfvcR8EWsRrm23t8=
Received: from [10.8.0.4] (unknown [222.29.156.242])
        by front02 (Coremail) with SMTP id 54FpogBHT+OxIBNh_6YuAg--.56139S2;
        Wed, 11 Aug 2021 08:58:26 +0800 (CST)
Message-ID: <2ddec0b8f77a275c758c7d5d2cc89bc7a0a5e380.camel@pku.edu.cn>
Subject: Re: [PATCH] x86/fault: Fix wrong signal when vsyscall fails with
 pkey
From:   Jiashuo Liang <liangjs@pku.edu.cn>
To:     dave.hansen@intel.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        liangjs@pku.edu.cn, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        x86@kernel.org
Date:   Wed, 11 Aug 2021 08:58:25 +0800
In-Reply-To: <15721c9c-3030-2e4e-8e34-9f18afe8d171@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: 54FpogBHT+OxIBNh_6YuAg--.56139S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYg7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCY02Avz4vE14v_twCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr
        1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
        AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjg18DUUUUU==
X-CM-SenderInfo: isqqijqrtqmio6sn3hxhgxhubq/1tbiAwERBVPy7sZO2gATsY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-07-29 at 07:02 -0700, Dave Hansen wrote:
> On 7/28/21 11:24 PM, Jiashuo Liang wrote:
>> I agree that using ARCH_DEFAULT_PKEY is better. I think I am supposed to
>> send a patch v2 for the update?
>
> Yes, please.

The patch v2 is here: https://lore.kernel.org/lkml/20210730030152.249106-1-liangjs@pku.edu.cn/
Would you please have a look?

