Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DE03567C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhDGJMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:12:19 -0400
Received: from m32-153.88.com ([43.250.32.153]:40509 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234354AbhDGJMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=2kr3mKZwv+18nDhZjEPYMzz8yFydV9XsOtTeg
        04x4Ps=; b=UHyuNuI4Mw/0Xob+9ExC34LIQZ6R1BEnWBFDcITFLwJtjCnmg00VA
        7MdZNwy0Nh0fZAUoIXoV7pdUAXv2D8omrVI62lgn5GyLtHWfJmazSeiS8kk9mAFq
        BVrJItRRoUn2x4B9sDs+Lw+UVVGA4ZRzb2kwn4ujzfQfAhY6barw18=
Received: from bobwxc.top (unknown [120.238.248.129])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgBn8iJbd21g2F5hAA--.30094S2;
        Wed, 07 Apr 2021 17:11:57 +0800 (CST)
Date:   Wed, 7 Apr 2021 17:11:55 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Harry Wei <harryxiyou@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/19] docs: translations/zh_CN: fix a typo at
 8.Conclusion.rst
Message-ID: <20210407091155.GA1793@bobwxc.top>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
 <87442e7f284d063b6e552080b4ed7ca891c4895c.1617783062.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87442e7f284d063b6e552080b4ed7ca891c4895c.1617783062.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: GiKnCgBn8iJbd21g2F5hAA--.30094S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWDGrW7uF1DtFykWrWfZrb_yoW8Wr47pF
        92gr97K3WxK3WYkryxGr4xGrW8JF1xGa97KrW2q3W3XFnYkw47tr9xtr9xWF9aq34Fka4U
        Xr48tFyYgr42krJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgSb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2
        z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcx
        kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWx
        Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc2xSY4AK67AK6r4fMxAIw2
        8IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
        CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IUUpVbPUUUUU==
X-Originating-IP: [120.238.248.129]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 10:20:57AM +0200, Mauro Carvalho Chehab wrote:
> transaltions -> translations
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks!

Acked-by: Wu XiangCheng <bobwxc@email.cn>

> ---
>  Documentation/translations/zh_CN/process/8.Conclusion.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/zh_CN/process/8.Conclusion.rst b/Documentation/translations/zh_CN/process/8.Conclusion.rst
> index 71c3e30efc6f..4707f0101964 100644
> --- a/Documentation/translations/zh_CN/process/8.Conclusion.rst
> +++ b/Documentation/translations/zh_CN/process/8.Conclusion.rst
> @@ -19,7 +19,7 @@
>  :ref:`Documentation/translations/zh_CN/process/howto.rst <cn_process_howto>`
>  文件是一个重要的起点；
>  :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
> -和 :ref:`Documentation/transaltions/zh_CN/process/submitting-drivers.rst <cn_submittingdrivers>`
> +和 :ref:`Documentation/translations/zh_CN/process/submitting-drivers.rst <cn_submittingdrivers>`
>  也是所有内核开发人员都应该阅读的内容。许多内部内核API都是使用kerneldoc机制
>  记录的；“make htmldocs”或“make pdfdocs”可用于以HTML或PDF格式生成这些文档
>  （尽管某些发行版提供的tex版本会遇到内部限制，无法正确处理文档）。
> -- 
> 2.30.2

