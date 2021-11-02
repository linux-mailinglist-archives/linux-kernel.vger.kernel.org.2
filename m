Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B65443198
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 16:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhKBP2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 11:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbhKBP15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 11:27:57 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA886C061205
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 08:25:18 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v64so47509969ybi.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qLijg/S82bS3/HvXfcEbQA7NnYkfmPHzDFi0qly52oA=;
        b=vZ0VJ7sQVsWs1GLsM0cEbgyzdSLsh/wMW68M/vjW5aClxGW+QkeqiNPej3xPxKluLH
         A8gOxkYCJ4azsH4BqSNWn890gNT6/f6dvOwgzPRbpP6yOqHtwWKDfFGSUnWEdyda260B
         qq0KIeEKddiO1U6MfPQXs09t1SZzBsnsiXM8HmnqsTVDG7Fc5fIyB8m0u0vkZ7++VnPw
         UJ9hmI42NgU2ehS55LwaudwqH70VC2GeBVqzAVaDkKjekxEvmAWzMQZ1naRfCoxqqTYP
         PzhbCSrv718Et2NuTCFVLRBaVX7mx6WrbxROHRsCXJVgYJOIKEbhDGvrTmUDJl/t95Xh
         EhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qLijg/S82bS3/HvXfcEbQA7NnYkfmPHzDFi0qly52oA=;
        b=E7afpXWcDyAvDcnayh5kPjxwIJ6a0u689y7fo+vcFTfJZMNOFfTwyit34i4L8btcX7
         tZyw7wTxkfOS/TU4xGgDXjQrrtf8eYb6+pqwq7n4fuUEiwTFS3isNpFaq+fyNlxyuZFX
         i9Qv5LhHyHJDmuppuKdWsShpUFg75exmp+TRZnVbWYIHmvDgTgXaETfxSdeq8MyNNXLX
         Ozoa3Gh1xP4mxqYu1Np7JfgFDRiVE/YiYKzhk1ZZj6bPH7HR5sw+nGbLt8NA1NBju4lr
         /wZEhbZII1ux4126dWsMX9nYG1E/sKrzYP+ZYtYpTT8u2nakOzJC/rVF2/wmqjEk0XPg
         eqkA==
X-Gm-Message-State: AOAM532gwu8joKBwvpJATGm63J1fYuYglETebXJx/bTxUdqGjB8UTvoV
        wjgGjICDIJMydFe7WMT5rigxDnnDU5Bub0u7wOCCIw==
X-Google-Smtp-Source: ABdhPJxMIpc4IC//gL0hAJWKLAamwC+q3ERjbNS5k6JCw/XaKSf82AytaPJ1GnEjS35DsGjzKGApUZ/Ql6Y4M95c7GM=
X-Received: by 2002:a5b:d50:: with SMTP id f16mr28779011ybr.350.1635866718051;
 Tue, 02 Nov 2021 08:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <6725b3093d47459fa438825fb187970f@man.com>
In-Reply-To: <6725b3093d47459fa438825fb187970f@man.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 2 Nov 2021 16:25:05 +0100
Message-ID: <CAKfTPtAKpMj15dHO1MC=dH_XJQe1Os24k93N2jDZ=kgg3O7K7A@mail.gmail.com>
Subject: Re: kernel/scheduler: The Linux scheduler doesn't scale to more than
 8 cores?
To:     "Morotti, Romain (London)" <romain.morotti@man.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

On Tue, 2 Nov 2021 at 14:23, Morotti, Romain (London)
<Romain.Morotti@man.com> wrote:
>
> Hello,
>
>
>
> Apologies if it's the wrong place, this is my first time trying to submit=
 a bug/email to the kernel.
>
>
>
> I was doing some tuning on compute grids and that got me looking into the=
 scheduler.
>
>
>
> There are few sysctl settings to adjust how long processes can be schedul=
ed. (sched_latency_ns, sched_min_granularity_ns, etc...)
>
> They are set to few milliseconds by default and adjusted automatically wi=
th the number of cores.
>
>
>
> doc: <value> ms * (1 + ilog(ncpus)), units: nanoseconds)
>
>
>
> Problem: The scaling doesn't scale as intended, it's capped to only detec=
t 8 CPUs at most.
>
>
>
>
>
> In this function get_update_sysctl_factor().
>
> https://github.com/torvalds/linux/blob/8cb1ae19bfae92def42c985417cd6e894d=
daa047/kernel/sched/fair.c#L174
>
>
>
> static unsigned int get_update_sysctl_factor(void)
>
> {
>
>                 unsigned int cpus =3D min_t(unsigned int, num_online_cpus=
(), 8);
>
>                 unsigned int factor;
>
>     [...]
>
>                                 case SCHED_TUNABLESCALING_LOG:
>
>                                 default:
>
>                                                 factor =3D 1 + ilog2(cpus=
);
>
>                                                 break;}
>
>
>
>
>
>
>
> From the first line, the CPU count is capped to 8.
>
> Thus the scheduler scaling won't be more than a factor of 4, no matter ho=
w many CPUs there are. (1+log2(8))
>
> There's also a linear scaling option, that is similarly capped to 8 times=
, because 8 CPUs.

That's a good point and I never realized this limitation in the scaling fac=
tor.

Peter mentioned that there were interactivity problems with large
scale factors at the time it was added. But the scheduler has changed
since and it would be interesting to run benchmarks on more recent
platforms with larger factor

>
>
>
>
>
> Looking up the history. That code goes back to November 2011 from this co=
mmit, shipped with kernel v3.3
>
> https://github.com/torvalds/linux/commit/029632fbb7b7c9d85063cc9eb470de6c=
54873df3
>
> https://github.com/torvalds/linux/blob/029632fbb7b7c9d85063cc9eb470de6c54=
873df3/kernel/sched_fair.c#L122
>
>
>
> That was a fairly large patch that added and moved code around. That=E2=
=80=99s not the original source.
>
> Looking further, I found these commits around December 2009 to make the s=
cheduler more configurable, shipped with kernel v2.6.33
>
> https://github.com/torvalds/linux/commit/1983a922a1bc843806b9a36cf3a370b2=
42783140
>
> https://github.com/torvalds/linux/blob/1983a922a1bc843806b9a36cf3a370b242=
783140/kernel/sched.c#L7035
>
>
>
> I think the ultimate origin is this commit from December 2009:
>
> https://github.com/torvalds/linux/commit/0bcdcf28c979869f44e05121b96ff2cf=
b05bd8e6
>
> ---   unsigned int factor =3D 1 + ilog2(num_online_cpus());
>
> +++   unsigned int cpus =3D min(num_online_cpus(), 8U);
>
> +++   unsigned int factor =3D 1 + ilog2(cpus);
>
>
>
>
>
> Circa 2009, a 8+ cores CPU was about the best money could buy (perhaps mo=
re on multi-socket servers if you've got the budget).
>
> Servers have had tens of cores for a long time now. For reference, the la=
test x64 CPUs have up to 64 cores (128 threads) https://en.wikipedia.org/wi=
ki/Epyc .
>
>
>
> My guess is that the limit was hardcoded to reflect the hardware availabl=
e at the time, and it's been forgotten ever since.
>
> The doc was written much later and it's simply incorrect. Didn't notice t=
he limit? https://github.com/torvalds/linux/commit/2b4d5b2582deffb77b3b4b48=
a59cd36e9e1e14d9
>
>
>
> I think this may need adjustment to reflect current hardware? And the doc=
 should be corrected?
>
>
>
>
>
> Regards.
>
>
>
>
>
>
>
> This email has been sent by a member of the Man group (=E2=80=9CMan=E2=80=
=9D). Man's parent company, Man Group plc, is registered in Jersey (company=
 number 127570) with its registered office at 22 Grenville Street, St Helie=
r, Jersey, JE4 8PX. The contents of this email are for the named addressee(=
s) only. It contains information which may be confidential and privileged. =
If you are not the intended recipient, please notify the sender immediately=
, destroy this email and any attachments and do not otherwise disclose or u=
se them. Email transmission is not a secure method of communication and Man=
 cannot accept responsibility for the completeness or accuracy of this emai=
l or any attachments. Whilst Man makes every effort to keep its network fre=
e from viruses, it does not accept responsibility for any computer virus wh=
ich might be transferred by way of this email or any attachments. This emai=
l does not constitute a request, offer, recommendation or solicitation of a=
ny kind to buy, subscribe, sell or redeem any investment instruments or to =
perform other such transactions of any kind. Man reserves the right to moni=
tor, record and retain all electronic and telephone communications through =
its network in accordance with applicable laws and regulations.
>
> During the course of our business relationship with you, we may process y=
our personal data, including through the monitoring of electronic communica=
tions. We will only process your personal data to the extent permitted by l=
aws and regulations; for the purposes of ensuring compliance with our legal=
 and regulatory obligations and internal policies; and for managing client =
relationships. For further information please see our Privacy Notice: https=
://www.man.com/privacy-policy
