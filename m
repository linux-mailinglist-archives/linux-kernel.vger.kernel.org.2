Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA7F3F3BAB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhHUR1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 13:27:08 -0400
Received: from mail.ispras.ru ([83.149.199.84]:44254 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229806AbhHUR1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 13:27:07 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPSA id 02ACC40A2BC7;
        Sat, 21 Aug 2021 17:26:26 +0000 (UTC)
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
 <4e582d89-0ef2-a94a-250a-30aa0f2eceb2@ispras.ru>
 <CAHp75VcVX21mpWmA_g+tOdJDGgkN45nz85YXyh3p-m91GS_HeQ@mail.gmail.com>
From:   Evgeny Novikov <novikov@ispras.ru>
Message-ID: <9b0e4eb3-7d18-f3ed-be7d-5ff48e86292f@ispras.ru>
Date:   Sat, 21 Aug 2021 20:26:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcVX21mpWmA_g+tOdJDGgkN45nz85YXyh3p-m91GS_HeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 17.08.2021 14:47, Andy Shevchenko wrote:
> On Tue, Aug 17, 2021 at 12:08 PM Evgeny Novikov <novikov@ispras.ru> wrote:
>> On 12.08.2021 15:13, Andy Shevchenko wrote:
>>> On Thursday, August 12, 2021, Evgeny Novikov <novikov@ispras.ru
>>> <mailto:novikov@ispras.ru>> wrote:
>>>
>>>      It seems that mxic_nfc_probe() missed invocation of
>>>      mxic_nfc_clk_enable(). The patch fixed that. In addition, error
>>>      handling
>>>      was refined appropriately.
>>>
>>> NAK. Until you provide a deeper analysis, like how this works before
>>> your change.
>>>
>>> Please, don’t blindly generate patches, this can even your bot do,
>>> just think about each change and preferable test on the real hardware.
>>>
>>> The above is to all your lovely contributions.
>> I completely agree with you that testing and debugging on the real
>> hardware is indispensable since this can help to reason about both found
>> bugs and patches suggested. Nevertheless, there are several cases when
>> this does not work. The most obvious one is lack of appropriate devices
>> on the spot that is not an obstacle for static analysis.
>>
>> My patches are based on results of static verification (software model
>> checking). In a nutshell, this approach allows analyzing target programs
>> more accurately in comparison with widely used static analysis tools.
>> But this is not for free. Usually it needs much more computational
>> resources to get something meaningful (in a general case the task is
>> undecidable). Modern computer systems solve this issue partially. Worse
>> is that thorough static analysis needs more or less complete and correct
>> models of environments for target programs. For instance, for loadable
>> kernel modules it is necessary to specify correct sequences of callback
>> invocations, initialize their arguments at least to some extent and
>> develop models of some vital functions like kzalloc(). Moreover, it is
>> necessary to specify requirements if one wants to search for something
>> special rather than NULL pointer dereferences. We were able to devote a
>> relatively small part of our project to development of environment
>> models and requirement specifications for verification of the Linux
>> kernel. Also, we spent not so much time for application of our framework
>> for open source device drivers. Nevertheless, this helped to find out
>> quite a lot of bugs many of which are tricky enough. If you are
>> interested in more details I can send you our last paper and presentation.
> It is good and thanks for your contribution!
>
>> Most our bug reports were accepted by developers. Rarely they preferred
>> to fix bugs according to their needs and vision, that is especially the
>> case for considerable changes that do need appropriate hardware and
>> testing. Just a few our bug reports were ignored or rejected.
> This ratio is not a point. I hope you learnt from the UMN case.
>
>> In the
>> latter case developers often pointed out us what is wrong with our
>> current understanding and models of the device driver environment or
>> requirement specifications. We always welcome this feedback as it allows
>> us to refine the stuff and, thus, to avoid false alarms and invalid
>> patches. Some developers requested scripts used for finding reported
>> issues, but it is not easy to add or refer them in patches like, say,
>> for Coccinelle since there is a bunch of external files developed in
>> different domain-specific languages as well as a huge verification
>> framework, that nobody will include into the source tree of the Linux
>> kernel.
>>
>> Regarding your claim. We do not have an appropriate hardware. As usual
>> this bug report was prepared on the base of static verification results
>> purely. If you want to see on a particular artifact I based my decision
>> on, I can share a link to a visualized violation witness provided by a
>> verification tool. We have not any bots since used verification tools do
>> not give any suggestions on the issue roots. Maybe in some cases it is
>> possible to generate patches automatically on the base of these
>> verification results like, say, Coccinelle does, but it is another big
>> work. Of course, it is necessary to test the driver and confirm that
>> there is an issue or reject the patch. As always the feedback is welcome.
> My point is that the type of patches you are sending even a bot may
> generate (for example, simple patches the LKP project generates along
> with reports). The problem with all teams that are working with static
> analysers against Linux kernel is that they so proud of their tools
> and trying to flood the mailing lists with quick and nice fixes, from
> which some are churn, some are simple bad, some are _bringing_
> regressions, and only some are good enough. The ratio seems to me like
> 1 to 4 at most. So, 75% patches are not needed and only are a burden
> on maintainers' shoulders.
Developers of static analysis tools need some acknowledgment. 
Application to the Linux kernel gives a great capability for that since 
it is a huge and vital open source project. Besides, it is unlikely that 
somebody will be able to develop any valuable QA tool without a numerous 
feedback from users (in case of this sort of tools users are developers 
of target projects). We always welcome any ideas and suggestions how to 
improve a quality of analysis.
> Good patch should have a good commit message [1]. The message should
> include an analysis to explain why the considered change is needed and
> what the problem it tries to solve. Neither of this I have seen in
> your patch. Also, you need to take into account the credits and tags
> that Linux kernel is using (Fixes, Suggested-by, Reported-by, etc) it
> will add a bit of unification. Also, while fixing problems these
> patches often miss the big picture, and contributors should think
> outside the box (this is a problem of 95% of such contributions, one
> example is your patch where I recommended completely rewriting the
> ->probe() approach). That said, I don't want to see the flood of
> patches with 75% miss ratio, I want to see maybe 5x, 10x less patches,
> but each of them is carefully thought through and _ideally_ be tested
> besides compilation.
We will try to follow your advices to a possible extent. I am not sure 
that this will be the case for thinking outside the box since often it 
requires a deep involvement into the development process. Moreover, it 
may be dangerous to make such big changes without having an appropriate 
experience or/and an ability to test them.
> And thank you for your work!
Thank you for your patience!

Best regards,
Evgeny Novikov
>> If you are not gratified with my explanation it would be great if you
>> and other developers will suggest any ideas how to enhance the process
>> if you find this relevant.
> [1]: https://chris.beams.io/posts/git-commit/
>
