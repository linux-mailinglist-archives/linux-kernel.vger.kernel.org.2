Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDAC3601B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhDOFkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:40:47 -0400
Received: from [43.250.32.171] ([43.250.32.171]:13764 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S230204AbhDOFkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=KvftrG5Lhi1GCGuoRVYKNQEyYty8Kzz1Wdzom
        p/vDD4=; b=S5hFYQolkCCfs1nHoOdOZXKwlirk5PCTD0DdUVaKS3GU91O5Pntt6
        WLne41UtfDLfBYKDfMr1oeGZC42v8XlmqNaRA9pRzmNl+VVDAaPjBE+57/bMreFB
        g1uz7JIRTJ6sR6cY5tA9EMHD70YgfZegto5dRjCDjT2Y8pfSB6PDBk=
Received: from bobwxc.top (unknown [120.238.248.129])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgAXi9Gu0XdghZddAA--.16668S2;
        Thu, 15 Apr 2021 13:40:00 +0800 (CST)
Date:   Thu, 15 Apr 2021 13:39:58 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc:     Alex Shi <alexs@kernel.org>, Bernard Zhao <bernard@vivo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        YanTeng Si <sterlingteng@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v5] docs/zh_CN:
 add translations in zh_CN/dev-tools/gcov
Message-ID: <20210415053958.GB26262@bobwxc.top>
References: <20210414082316.15160-1-bernard@vivo.com>
 <20210414132127.GA13306@bobwxc.top>
 <e26cc66e2a2745f994eb8ede9a783563@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e26cc66e2a2745f994eb8ede9a783563@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: LCKnCgAXi9Gu0XdghZddAA--.16668S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFy5uw1UuFyUXFWrZr4fKrg_yoW5Ww4xpF
        4DKFWfK3Wxury3CFW2gF1UAFyUAas7Ww4DKryIq3s0qrWqvr4Fyr17tryjgr9rWr48Za45
        Za18WFyj93s0kFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyGb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0x
        vYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_
        Cr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkIecxEwVAFwVW8WwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F4U
        Jr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUUO6pPUUUUU==
X-Originating-IP: [120.238.248.129]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 04:01:55AM +0000, Zengtao (B) wrote:
> > -----邮件原件-----
> > 发件人: Wu XiangCheng [mailto:bobwxc@email.cn]
> > 发送时间: 2021年4月14日 21:21
> > 收件人: Alex Shi <alexs@kernel.org>; Bernard Zhao <bernard@vivo.com>
> > 抄送: Jonathan Corbet <corbet@lwn.net>; YanTeng Si
> > <sterlingteng@gmail.com>; Nathan Chancellor <nathan@kernel.org>; Nick
> > Desaulniers <ndesaulniers@google.com>; linux-doc@vger.kernel.org;
> > linux-kernel@vger.kernel.org; clang-built-linux@googlegroups.com
> > 主题: [PATCH v5] docs/zh_CN: add translations in zh_CN/dev-tools/gcov
> > 
> > From: Bernard Zhao <bernard@vivo.com>
> > 
> > Add new zh translations
> > * zh_CN/dev-tools/gcov.rst
> > * zh_CN/dev-tools/index.rst
> > and link them to zh_CN/index.rst
> > 
> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
> > Reviewed-by: Wu XiangCheng <bobwxc@email.cn>
> > Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
> > ---
> > base: linux-next
> > commit 269dd42f4776 ("docs/zh_CN: add riscv to zh_CN index")
> > 
> > Changes since V4:
> > * modified some words under Alex Shi's advices
> > 
> > Changes since V3:
> > * update to newest linux-next
> > * fix ``
> > * fix tags
> > * fix list indent
> > 
> > Changes since V2:
> > * fix some inaccurate translation
> > 
> > Changes since V1:
> > * add index.rst in dev-tools and link to to zh_CN/index.rst
> > * fix some inaccurate translation
> > 
> >  .../translations/zh_CN/dev-tools/gcov.rst     | 265 ++++++++++++++++++
> >  .../translations/zh_CN/dev-tools/index.rst    |  35 +++
> >  Documentation/translations/zh_CN/index.rst    |   1 +
> >  3 files changed, 301 insertions(+)
> >  create mode 100644 Documentation/translations/zh_CN/dev-tools/gcov.rst
> >  create mode 100644 Documentation/translations/zh_CN/dev-tools/index.rst
> > 
> > diff --git a/Documentation/translations/zh_CN/dev-tools/gcov.rst
> > b/Documentation/translations/zh_CN/dev-tools/gcov.rst
> > new file mode 100644
> > index 000000000000..7515b488bc4e
> > --- /dev/null
> > +++ b/Documentation/translations/zh_CN/dev-tools/gcov.rst
> > @@ -0,0 +1,265 @@
> > +.. include:: ../disclaimer-zh_CN.rst
> > +
> > +:Original: Documentation/dev-tools/gcov.rst
> > +:Translator: 赵军奎 Bernard Zhao <bernard@vivo.com>
> > +
> > +在Linux内核里使用gcov做代码覆盖率检查
> > +=====================================
> > +
> > +gcov是linux中已经集成的一个分析模块，该模块在内核中对GCC的代码
> > 覆盖率统
> 
> Gcov is a tool/function, misleading for " gcov是linux中已经集成的一个分析
> 模块"
> 
> I 'd suggest:
> "Linux内核中已经集成一个特性支持gcov功能，该特性让用户可以使用gcov
>  工具对内核代码覆盖率进行统计"
> 
> Thanks.

Have rewrited it.

Thanks
Wu

