Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36023770B9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 10:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhEHIsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 04:48:00 -0400
Received: from m32-153.88.com ([43.250.32.153]:19073 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230129AbhEHIsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 04:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=h3OFUOuA8+n+jaPT6okhGKXPY7/eXNUsIvJvd
        SizbAU=; b=W6wER3Qzy+AfABKaHaI+WD+Dic6dlIQ/xAt84opLKnxtMJvK/KYy1
        nEJHpWZ4KuhxWUDvaA4mO203mfLLl2y3w+UCac+l6aK7+TzRmW/jVqRBbHfrFPZp
        II5yXFfKTfp9e+1u9SS8SQ5Fpcy1LL6cC6UkPE9bp3P85ti7CZAa8g=
Received: from bobwxc.top (unknown [120.238.248.9])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgAXZlj9T5Zg9JokAA--.27828S2;
        Sat, 08 May 2021 16:46:55 +0800 (CST)
Date:   Sat, 8 May 2021 16:46:53 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] docs/zh_CN: Remove obsolete translation file
Message-ID: <20210508084653.GA10159@bobwxc.top>
References: <20210508030741.82655-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210508030741.82655-1-wanjiabing@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: GiKnCgAXZlj9T5Zg9JokAA--.27828S2
X-Coremail-Antispam: 1UD129KBjvdXoWrJrWUXF17JFW5Kr1DAFWfAFb_yoWxWrXEva
        4kJF40yF4UAryrGa1xCFs5AF1q93y0g34kGrs8t3yUA39rAwsxWwnrXwsYvFyfXF4akr45
        CFZ7Ca4UGr97WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbnkYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E
        87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcx
        kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWx
        Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l42
        xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0zR_Oz3U
        UUUU=
X-Originating-IP: [120.238.248.9]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 11:07:33AM +0800, Wan Jiabing wrote:
> This translation file was replaced by 
>    Documentation/translations/zh_CN/admin-guide/security-bugs.rst
> which was created in commit 2d153571003b ("docs/zh_CN: Add
> zh_CN/admin-guide/security-bugs.rst").
> This is a translation left over from history. Remove it.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Acked-by: Wu XiangCheng <bobwxc@email.cn>

> ---
>  Documentation/translations/zh_CN/SecurityBugs | 50 -------------------
>  1 file changed, 50 deletions(-)
>  delete mode 100644 Documentation/translations/zh_CN/SecurityBugs
> 

