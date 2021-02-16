Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1893B31CEA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhBPRG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhBPRGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:06:20 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66001C06174A;
        Tue, 16 Feb 2021 09:05:40 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 15193A75;
        Tue, 16 Feb 2021 17:05:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 15193A75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1613495140; bh=YPle+G1Lk2amVuY3xUnjqm5Dh/EowY5kPGq9W01HOXk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OCHs/0XnSrIwSF6VfOhzoq0JlCiz9xFLc9mFsJKj43NhqNIyUjUuiTRxpcJiqwPHW
         J1IhEVE0zZIySrzdLGWlrTCNSab8yFiUBNreFoo0Zc2ck6BCXTR/ljrYu9GoaHymLj
         CXUawLlB2xFQWfclcvX0TnRPqxR9f6JVUpZq+sfJEaLSxhj6SbUKyDXZ0TwGImdUVT
         jkg9cfl3vq0DfGf4cnjuqruTdLwi+pQfUpLJX+WbWPgECj1Za5c68FiIJXih7Dj1F8
         iL+L64tayUO65Z9EdcxozvnCaBcY62AJPo9BqniXLwm65AmvbHu0FcblbH4JhWKW/5
         HafEy2vyHb/lA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: anonymous enums in kernel doc
In-Reply-To: <CAHp75Vc0SwC=WxUOiokUik1G4uPE6bHfX_F_ckgp-eEJaVuWhA@mail.gmail.com>
References: <CAHp75VfpnGEZcnrQLFYaFQ-HuxTmPw5OnewKmRGfXQf__ztjww@mail.gmail.com>
 <87r1lgx8fo.fsf@meer.lwn.net>
 <CAHp75Vc0SwC=WxUOiokUik1G4uPE6bHfX_F_ckgp-eEJaVuWhA@mail.gmail.com>
Date:   Tue, 16 Feb 2021 10:05:39 -0700
Message-ID: <87mtw4x7rw.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Tue, Feb 16, 2021 at 6:51 PM Jonathan Corbet <corbet@lwn.net> wrote:
>>
>> > Mauro, can you do some test cases in your workflow against anonymous
>> > enum in ernel doc, please?
>> >
>> > They are broken again, please fix the script!
>> >
>> > drivers/pinctrl/intel/pinctrl-intel.c:204: warning: wrong kernel-doc
>> > identifier on line:
>> > * enum - Locking variants of the pad configuration
>> >
>> > Above is simply a wrong statement.
>>
>> The real problem, perhaps, is that there seems to be little point in
>> adding kerneldoc comments for anonymous enums; where are you going to
>> use that documentation?
>
> I had been explicitly told during review (IIRC by maintainers) to make
> it such, while the initial version was exactly like you are thinking
> of. So, I'm not the right person to be asked :-)
>
>>  The error message could perhaps be changed to
>> say that; meanwhile, perhaps this one could be fixed with an action like
>> s%/**%/*% ?
>
> See above. I think regression comes from the kernel doc script,
> earlier it was okay. That said, the author of kernel doc changes has
> to submit a patch to amend the driver and maintainers will review it.

kerneldoc now warns about various incorrect things that it used to just
silently pass over.  There is no regression here, just a new diagnostic
to point out something that was never going to work right.  Unless you
have a good idea for what kerneldoc should do with a block like that?

(An alternative fix, of course, would be to give the enum a name so it
can actually be used for type checking.)

Thanks,

jon
