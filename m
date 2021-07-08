Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5CE3BF8C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhGHLT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:19:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50930 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhGHLT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:19:58 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625743035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NcpsbVMpIl7rwujvGTZxy9jB4Ph0ZDxg+aiwErH2oWs=;
        b=AJcSXUwqSB8MZcqc8T6juuyshncxwjo0+jIlwJ4Npc0DIAxf8aKgtLLBKP2I0HNFgq/HSz
        mUpthfjbwy8zksYt09xRyp1bE/g8K7VY2opN47Scp7135vcdQGJD5ST0K+YDFy6Sejdbek
        EsAXQZbuwSNOKd6UigJQay7iv5u/OApr/PV3wqOxCgtt/SM3WuICNHqCi1Y0qnOuLHnJC9
        ze70dyP6sFHN9jxynV717d6JItIL85ImBvTsL5aCgn57TZ9t+7d+lXjjlj3vM1Ul3xv/px
        pPiHOWva5/6FuWeqY7Dprm4SED7hwUBGjX/a9Yy/jmo38Xln9x9SUhH/6WBgDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625743035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NcpsbVMpIl7rwujvGTZxy9jB4Ph0ZDxg+aiwErH2oWs=;
        b=VH5MlYMZqy1lDOFWqOJ+eWAVctvO7vcuUeef4LYRuey/UtQuFVEy6cYQE9pRrxzLvrCmUD
        FxUfPiz5tmK3I5Bg==
To:     Linux <zhaoyan.liao@linux.alibaba.com>
Cc:     mingo@redhat.com, hpa@zytor.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        songmuchun@bytedance.com, likunkun@bytedance.com,
        guancheng.rjk@alibaba-inc.com, duanxiongchun@bytedance.com,
        wenan.mao@linux.alibaba.com
Subject: Re: [PATCH] use 64bit timer for hpet
In-Reply-To: <8A96C0F7-FBE4-4B23-8565-E814401BF927@linux.alibaba.com>
References: <1625213625-25745-1-git-send-email-zhaoyan.liao@linux.alibaba.com> <875yxmqw2s.ffs@nanos.tec.linutronix.de> <8A96C0F7-FBE4-4B23-8565-E814401BF927@linux.alibaba.com>
Date:   Thu, 08 Jul 2021 13:17:14 +0200
Message-ID: <87o8bdoy11.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liao!

On Thu, Jul 08 2021 at 11:11, Linux wrote:
>> 2021=E5=B9=B47=E6=9C=887=E6=97=A5 =E4=B8=8B=E5=8D=886:04=EF=BC=8CThomas =
Gleixner <tglx@linutronix.de> =E5=86=99=E9=81=93=EF=BC=9A
>> Seriously? The wrap-around time for 32bit HPET @24MHz is ~3 minutes.
>
> In some cases, our system will be very busy, and the timeout of 3 minutes=
=20
> is not an exaggeration. Then, the system considers that the tsc clock is=
=20
> inaccurate and switches the tsc clock to the hpet clock, which brings=20
> greater performance overhead.

Sorry, keeping the softirq from running for 3 minutes is simply out of
spec. If the sysadmin decides to do so, then he can keep the pieces.

>> Aside of that the reason why the kernel does not support 64bit HPET is
>> that there are HPETs which advertise 64bit support, but the
>> implementation is buggy.
>
> Can you tell me what is the buggy with the 64-bit hpet clock?

I forgot the details, but when I tried moving HPET to 64bit it did not
work on one of my machines due to an erratum and other people reported
similar issues on different CPUs/chipsets.

TBH, I'm not interested at all to chase down these buggy implementations
and have yet another pile of quirks.

> In my opinion, it is unreasonable to use a lower-bit width clock to
> calibrate a higher-bit width clock, and the hardware already supports
> the higher-bit width.

There is nothing unreasonable with that, really:

   1) This is not about calibration. It's a sanity check to catch
      broken TSC implementations.

      Aside of that it _IS_ very reasonable for calibration. We even
      calibrate TSC via the PIT if we can't get the frequency from
      the firmware.

   2) Expecting that the softirq runs within 3 minutes is very
      reasonable.

   3) On modern machines this is usually not longer necessary. If you
      are confident that the TSC on your system is stable then you
      can disable the watchdog via the kernel command line.

      There is also effort underway to come up with reasonable
      conditions to avoid the watchdog on those CPUs in the first place.

   4) For any system which actually has to use HPET the 64bit HPET is
      overhead. HPET access is slow enough already.

   5) 32bit HPET has to be supported as well and just claiming that a
      64bit access on 32bit HPET does not matter is just wishful
      thinking. Aside of breaking 32bit kernels along the way which
      is just a NONO.
=20=20=20=20=20=20
#4 and #5 were the main reason why I gave up on it - aside of the
discovery that there are broken implementations out there.

So no, there is really no compelling reason to support 64bit HPETs.

Thanks,

        tglx
---
P.S: Please trim your replies.
