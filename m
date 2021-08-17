Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238583EE92E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhHQJIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:08:53 -0400
Received: from mail.ispras.ru ([83.149.199.84]:48460 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234843AbhHQJIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:08:51 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPSA id E0FBD40D3BFF;
        Tue, 17 Aug 2021 09:08:06 +0000 (UTC)
Subject: Re: [PATCH] mtd: rawnand: mxic: Enable and prepare clocks in probe
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
References: <20210812113800.12466-1-novikov@ispras.ru>
 <CAHp75VcgqZEHBTXpNApGfRkhgjpCvbgj+yxUZbbO+=0DOvZLQg@mail.gmail.com>
From:   Evgeny Novikov <novikov@ispras.ru>
Message-ID: <4e582d89-0ef2-a94a-250a-30aa0f2eceb2@ispras.ru>
Date:   Tue, 17 Aug 2021 12:08:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcgqZEHBTXpNApGfRkhgjpCvbgj+yxUZbbO+=0DOvZLQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 12.08.2021 15:13, Andy Shevchenko wrote:
>
>
> On Thursday, August 12, 2021, Evgeny Novikov <novikov@ispras.ru 
> <mailto:novikov@ispras.ru>> wrote:
>
>     It seems that mxic_nfc_probe() missed invocation of
>     mxic_nfc_clk_enable(). The patch fixed that. In addition, error
>     handling
>     was refined appropriately.
>
>
> NAK. Until you provide a deeper analysis, like how this works before 
> your change.
>
>
> Please, don’t blindly generate patches, this can even your bot do, 
> just think about each change and preferable test on the real hardware.
>
> The above is to all your lovely contributions.

I completely agree with you that testing and debugging on the real 
hardware is indispensable since this can help to reason about both found 
bugs and patches suggested. Nevertheless, there are several cases when 
this does not work. The most obvious one is lack of appropriate devices 
on the spot that is not an obstacle for static analysis.

My patches are based on results of static verification (software model 
checking). In a nutshell, this approach allows analyzing target programs 
more accurately in comparison with widely used static analysis tools. 
But this is not for free. Usually it needs much more computational 
resources to get something meaningful (in a general case the task is 
undecidable). Modern computer systems solve this issue partially. Worse 
is that thorough static analysis needs more or less complete and correct 
models of environments for target programs. For instance, for loadable 
kernel modules it is necessary to specify correct sequences of callback 
invocations, initialize their arguments at least to some extent and 
develop models of some vital functions like kzalloc(). Moreover, it is 
necessary to specify requirements if one wants to search for something 
special rather than NULL pointer dereferences. We were able to devote a 
relatively small part of our project to development of environment 
models and requirement specifications for verification of the Linux 
kernel. Also, we spent not so much time for application of our framework 
for open source device drivers. Nevertheless, this helped to find out 
quite a lot of bugs many of which are tricky enough. If you are 
interested in more details I can send you our last paper and presentation.

Most our bug reports were accepted by developers. Rarely they preferred 
to fix bugs according to their needs and vision, that is especially the 
case for considerable changes that do need appropriate hardware and 
testing. Just a few our bug reports were ignored or rejected. In the 
latter case developers often pointed out us what is wrong with our 
current understanding and models of the device driver environment or 
requirement specifications. We always welcome this feedback as it allows 
us to refine the stuff and, thus, to avoid false alarms and invalid 
patches. Some developers requested scripts used for finding reported 
issues, but it is not easy to add or refer them in patches like, say, 
for Coccinelle since there is a bunch of external files developed in 
different domain-specific languages as well as a huge verification 
framework, that nobody will include into the source tree of the Linux 
kernel.

Regarding your claim. We do not have an appropriate hardware. As usual 
this bug report was prepared on the base of static verification results 
purely. If you want to see on a particular artifact I based my decision 
on, I can share a link to a visualized violation witness provided by a 
verification tool. We have not any bots since used verification tools do 
not give any suggestions on the issue roots. Maybe in some cases it is 
possible to generate patches automatically on the base of these 
verification results like, say, Coccinelle does, but it is another big 
work. Of course, it is necessary to test the driver and confirm that 
there is an issue or reject the patch. As always the feedback is welcome.

If you are not gratified with my explanation it would be great if you 
and other developers will suggest any ideas how to enhance the process 
if you find this relevant.

Best regards,
Evgeny Novikov

>
>     Found by Linux Driver Verification project (linuxtesting.org
>     <http://linuxtesting.org>).
>
>     Signed-off-by: Evgeny Novikov <novikov@ispras.ru
>     <mailto:novikov@ispras.ru>>
>     Co-developed-by: Kirill Shilimanov <kirill.shilimanov@huawei.com
>     <mailto:kirill.shilimanov@huawei.com>>
>     Signed-off-by: Kirill Shilimanov <kirill.shilimanov@huawei.com
>     <mailto:kirill.shilimanov@huawei.com>>
>     ---
>      drivers/mtd/nand/raw/mxic_nand.c | 16 ++++++++++++----
>      1 file changed, 12 insertions(+), 4 deletions(-)
>
>     diff --git a/drivers/mtd/nand/raw/mxic_nand.c
>     b/drivers/mtd/nand/raw/mxic_nand.c
>     index da1070993994..37e75bf60ee5 100644
>     --- a/drivers/mtd/nand/raw/mxic_nand.c
>     +++ b/drivers/mtd/nand/raw/mxic_nand.c
>     @@ -509,9 +509,15 @@ static int mxic_nfc_probe(struct
>     platform_device *pdev)
>             if (IS_ERR(nfc->send_dly_clk))
>                     return PTR_ERR(nfc->send_dly_clk);
>
>     +       err = mxic_nfc_clk_enable(nfc);
>     +       if (err)
>     +               return err;
>     +
>             nfc->regs = devm_platform_ioremap_resource(pdev, 0);
>     -       if (IS_ERR(nfc->regs))
>     -               return PTR_ERR(nfc->regs);
>     +       if (IS_ERR(nfc->regs)) {
>     +               err = PTR_ERR(nfc->regs);
>     +               goto fail;
>     +       }
>
>             nand_chip = &nfc->chip;
>             mtd = nand_to_mtd(nand_chip);
>     @@ -527,8 +533,10 @@ static int mxic_nfc_probe(struct
>     platform_device *pdev)
>             nand_chip->controller = &nfc->controller;
>
>             irq = platform_get_irq(pdev, 0);
>     -       if (irq < 0)
>     -               return irq;
>     +       if (irq < 0) {
>     +               err = irq;
>     +               goto fail;
>     +       }
>
>             mxic_nfc_hw_init(nfc);
>
>     -- 
>     2.26.2
>
>
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
