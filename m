Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1930934FBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhCaIl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:41:27 -0400
Received: from m34-101.88.com ([104.250.34.101]:29677 "EHLO 88.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232984AbhCaIlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:41:11 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Mar 2021 04:41:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=cGMIpLGopqNGNJ8RtjhCfqrGOBvIa0fV5k9lD
        6TjwrA=; b=c6bRa0dptnvgjHRsMjv0sucfkdazNFjgxm6bnDyAi/st5tSqVLnoP
        hX4c+OHUS76pY4yOT/Kc6yZ0dml95THMexBeB31vLQm7DXaYc84rMRbXh2LER5Gc
        07QXLqhhFYTDQUfhwM7BYNqIk/IgXynog0O6qv3w6H8c+8F9YXsUnk=
Received: from mipc (unknown [120.238.248.129])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgDnWdDhM2RgVdpDAA--.21247S2;
        Wed, 31 Mar 2021 16:33:39 +0800 (CST)
Date:   Wed, 31 Mar 2021 16:33:37 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alex Shi <alexs@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/4] docs: make reporting-issues.rst official and
 delete reporting-bugs.rst
Message-ID: <20210331083337.GA5287@mipc>
References: <cover.1617113469.git.linux@leemhuis.info>
 <49c674c2d304d87e6259063580fda05267e8c348.1617113469.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49c674c2d304d87e6259063580fda05267e8c348.1617113469.git.linux@leemhuis.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: LCKnCgDnWdDhM2RgVdpDAA--.21247S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zry3WFW7ArWDZrWxtrW5Wrg_yoW8Zr13p3
        WDKrZ2q3ZxJFn0kr1xGr12qw12va4xuayrJr48Xw1rCrs8CF1ktrWqvr90vas3ury8tFWU
        XF4Fgr90yr1jyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyvb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4U
        Jr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2
        xKxwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWxJr1U
        JwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUeOTmDUUUUU==
X-Originating-IP: [120.238.248.129]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Alex Shi's new email <alexs@kernel.org>

On Tue, Mar 30, 2021 at 04:13:04PM +0200, Thorsten Leemhuis wrote:
> Removing Documentation/admin-guide/reporting-bugs.rst will break links
> in some of the translations. I was unsure if simply changing them to
> Documentation/admin-guide/reporting-issue.rst was wise, so I didn't
> touch anything for now and CCed the maintainers for the Chinese and
> Italian translation. I couldn't find one for the Japanse translation.
> 
> Please advice. For completeness, this are the places where things will
> break afaics:
> 
> $ grep -ri 'reporting-bugs.rst' Documentation/
> Documentation/translations/zh_CN/SecurityBugs:是有帮助的信息，那就请重温一下admin-guide/reporting-bugs.rst文件中的概述过程。任
> Documentation/translations/zh_CN/process/howto.rst:内核源码主目录中的:ref:`admin-guide/reporting-bugs.rst <reportingbugs>`
> Documentation/translations/zh_CN/admin-guide/reporting-issues.rst:   本文档将取代“Documentation/admin-guide/reporting-bugs.rst”。主要的工作
> Documentation/translations/zh_CN/admin-guide/reporting-issues.rst:   “Documentation/admin-guide/reporting-bugs.rst”中的旧文字非常相似。它和它

Yeah, as Greg said, we will solve that after you patches be merged in next
tree. Since I have translate the zh reporting-issues.rst in the next tree,
will correct the link when I sync it with your new version. May cause 
Warning for some days, but don't worry about it.

Wu X.C.

> Documentation/translations/it_IT/process/howto.rst:Il file admin-guide/reporting-bugs.rst nella cartella principale del kernel
> Documentation/translations/ja_JP/howto.rst:admin-guide/reporting-bugs.rstはカーネルバグらしいものについてどうレポー
> 
> Ciao, Thorsten

