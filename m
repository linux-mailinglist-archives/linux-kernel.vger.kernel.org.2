Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F763ADC36
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 03:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhFTBGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 21:06:37 -0400
Received: from m32-153.88.com ([43.250.32.153]:41107 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229591AbhFTBGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 21:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=3L+11Y54fap4t1XJrl3PTGlhsHNfsYnWhh6Ya
        liW8kw=; b=bOqJopVfpZI/YgF7cXt5hT5NFhiC6EwcZ/4iykQiMmPVetiyY9yW6
        V8kzCImtyOkwpYBplJc1TgvyE21uAYtLXhNdcXbvfvvWDPqMo3j/duwkAowlve8E
        o0GEFf8lgStOmWpHbZFuqniu7hbXxwhAejB4PwlntUcRW8DJOFcx4k=
Received: from [0.0.0.0] (unknown [113.251.9.208])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgAH3vwSlM5gG3MfAA--.16262S3;
        Sun, 20 Jun 2021 09:04:21 +0800 (CST)
Subject: Re: [PATCH] docs/zh_CN: add a missing space character
From:   Hu Haowen <src.res@email.cn>
To:     alexs@kernel.org, corbet@lwn.net
Cc:     bobwxc@email.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210619162238.12665-1-src.res@email.cn>
Message-ID: <7fb04fbd-34e6-5e0c-47e9-09382550a7ec@email.cn>
Date:   Sun, 20 Jun 2021 09:04:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210619162238.12665-1-src.res@email.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: GiKnCgAH3vwSlM5gG3MfAA--.16262S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF47GF45KFy8AryfZF4UCFg_yoW8Xw43pF
        WIgr97K3WxCw15u3yxGr409FWfGFyxuay7GFnFy34DWrn8Cw1vqrZrKr909F93WryxZayk
        ZF10kFy3Gry2vFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07
        AlzVAYIcxG8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx2
        6F4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
        AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUshSdDUUUU
X-Originating-IP: [113.251.9.208]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/20 上午12:22, Hu Haowen 写道:
> "LinusTorvalds" is not pretty. Replace it with "Linus Torvalds".
>
> Signed-off-by: Hu Haowen <src.res@email.cn>
> ---
>   Documentation/translations/zh_CN/process/2.Process.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


Sorry, this patch didn't fix up all of this kind of issues. Please go
to patch v2 I would send later.

Thx,
Hu Haowen


> diff --git a/Documentation/translations/zh_CN/process/2.Process.rst b/Documentation/translations/zh_CN/process/2.Process.rst
> index 229629e305ca..0e69737e9889 100644
> --- a/Documentation/translations/zh_CN/process/2.Process.rst
> +++ b/Documentation/translations/zh_CN/process/2.Process.rst
> @@ -47,7 +47,7 @@
>   （顺便说一句，值得注意的是，合并窗口期间集成的更改并不是凭空产生的；它们是经
>   提前收集、测试和分级的。稍后将详细描述该过程的工作方式。）
>   
> -合并窗口持续大约两周。在这段时间结束时，LinusTorvalds将声明窗口已关闭，并
> +合并窗口持续大约两周。在这段时间结束时，Linus Torvalds将声明窗口已关闭，并
>   释放第一个“rc”内核。例如，对于目标为5.6的内核，在合并窗口结束时发生的释放
>   将被称为5.6-rc1。-rc1 版本是一个信号，表示合并新特性的时间已经过去，稳定下一
>   个内核的时间已经到来。

