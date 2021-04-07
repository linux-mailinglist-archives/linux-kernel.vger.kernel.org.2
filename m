Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D42B356826
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350183AbhDGJfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:35:53 -0400
Received: from m34-101.88.com ([104.250.34.101]:3793 "EHLO 88.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231294AbhDGJfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=U+dpdTGIkI10tnxL+rOqMbALU09LbePW1V0eV
        cbBuLM=; b=MeqNQxDRg+dQ6Y0t9ipzIMDVEQa5DH5PmTreSQOwQAgh473dsQq/7
        hNrex+biEIeT97QlCL8Ez06OSmWou52LBB418iotfR5C1WjS+wpqRaurn9+ID2US
        hp02SFOkKplVIeTTqYSn5GtjYr9gUZOR/DGtlWkECQO7M8NNL1WXGI=
Received: from bobwxc.top (unknown [120.238.248.129])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgDnWdC2fG1gnXxQAA--.49205S2;
        Wed, 07 Apr 2021 17:34:48 +0800 (CST)
Date:   Wed, 7 Apr 2021 17:34:45 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harry Wei <harryxiyou@gmail.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/19] docs: replace transation references for
 reporting-bugs.rst
Message-ID: <20210407093445.GB2492@bobwxc.top>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
 <65d1983fb625b5dd38d05f5c75a592e61992a4e0.1617783062.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65d1983fb625b5dd38d05f5c75a592e61992a4e0.1617783062.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: LCKnCgDnWdC2fG1gnXxQAA--.49205S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF43Jw1fWw13tw4ktF1UJrb_yoW7JFWkpF
        ykKrZ7K3W7KFy5Gw1xGr4Iqa12kayxua1fGFWkJwn5WFn8AFWktrsFqr90gFZ3XryFyFyU
        ZFZ5KryYyr12yrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyGb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcx
        kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWx
        Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1U
        Jr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUjzwZ7UUUUU==
X-Originating-IP: [120.238.248.129]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 10:20:56AM +0200, Mauro Carvalho Chehab wrote:
> Changeset d2ce285378b0 ("docs: make reporting-issues.rst official and delete reporting-bugs.rst")
> dropped reporting-bugs.rst, in favor of reporting-issues.rst, but
> translations still need to be updated, in order to point to the
> new file.
> 
> Fixes: d2ce285378b0 ("docs: make reporting-issues.rst official and delete reporting-bugs.rst")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/translations/it_IT/process/howto.rst            | 2 +-
>  Documentation/translations/ja_JP/howto.rst                    | 2 +-
>  Documentation/translations/zh_CN/SecurityBugs                 | 2 +-
>  .../translations/zh_CN/admin-guide/reporting-issues.rst       | 4 ++--
>  Documentation/translations/zh_CN/process/howto.rst            | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
> 
[...]

Hi Mauro,

Thanks to help us!

For zh translation:

> diff --git a/Documentation/translations/zh_CN/SecurityBugs b/Documentation/translations/zh_CN/SecurityBugs

This file is very old, may be removed soon.
No need to edit it.

> index 2d0fffd122ce..980199d88eca 100644
> --- a/Documentation/translations/zh_CN/SecurityBugs
> +++ b/Documentation/translations/zh_CN/SecurityBugs
> @@ -31,7 +31,7 @@ linux内核安全团队可以通过email<security@kernel.org>来联系。这是
>  一组独立的安全工作人员，可以帮助改善漏洞报告并且公布和取消一个修复。安
>  全团队有可能会从部分的维护者那里引进额外的帮助来了解并且修复安全漏洞。
>  当遇到任何漏洞，所能提供的信息越多就越能诊断和修复。如果你不清楚什么
> -是有帮助的信息，那就请重温一下admin-guide/reporting-bugs.rst文件中的概述过程。任
> +是有帮助的信息，那就请重温一下admin-guide/reporting-issues.rst文件中的概述过程。任
>  何攻击性的代码都是非常有用的，未经报告者的同意不会被取消，除非它已经
>  被公布于众。
>  
> diff --git a/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst b/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst

The link here could not be simply replaced, the means is wrong.
I will sync reporting-issues.rst with new verison in future.

> index 2805c1a03cd5..72c8e2db88c0 100644
> --- a/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst
> @@ -19,7 +19,7 @@
>  
>  .. important::
>  
> -   本文档将取代“Documentation/admin-guide/reporting-bugs.rst”。主要的工作
> +   本文档将取代“Documentation/admin-guide/reporting-issues.rst”。主要的工作
>     已经完成，你可以自由地按照其指示来向Linux内核开发者报告问题。但请留意，
>     下面的文字还需要一些润色和校审。现阶段它被合并到Linux内核源代码中，以使
>     这个过程更容易，并增加文本的可见性。
> @@ -726,7 +726,7 @@ tar 存档包。
>  .. note::
>  
>     FIXME: 本节文字暂时是占位符，与目前
> -   “Documentation/admin-guide/reporting-bugs.rst”中的旧文字非常相似。它和它
> +   “Documentation/admin-guide/reporting-issues.rst”中的旧文字非常相似。它和它
>     所引用的文档已经过时，因此需要重新审视。因此，请将此说明视为一个求助：如
>     果你熟悉这个主题，请写几行适合这里的文字。或者只需向本文件的主要作者（见
>     导言）大致概述一下当前的情况，因为他们也许能写出一些东西来。
> diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst

This change is ok.

> index ee3dee476d57..c87cd529d769 100644
> --- a/Documentation/translations/zh_CN/process/howto.rst
> +++ b/Documentation/translations/zh_CN/process/howto.rst
> @@ -280,7 +280,7 @@ bugzilla.kernel.org是Linux内核开发者们用来跟踪内核Bug的网站。
>  
>  	http://test.kernel.org/bugzilla/faq.html
>  
> -内核源码主目录中的:ref:`admin-guide/reporting-bugs.rst <reportingbugs>`
> +内核源码主目录中的:ref:`admin-guide/reporting-issues.rst <reportingbugs>`
>  文件里有一个很好的模板。它指导用户如何报告可能的内核bug以及需要提供哪些信息
>  来帮助内核开发者们找到问题的根源。
>  
> -- 
> 2.30.2

Thanks!

Wu X.C.

