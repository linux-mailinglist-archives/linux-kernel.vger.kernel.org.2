Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D1536BF08
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 07:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhD0F4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 01:56:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:60501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhD0F4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 01:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619502876;
        bh=4SozHBhMS5Q8Rjl3HiUYSX1YMImtT3zCoY8k6axU3iM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ECNROBuCdUH/MSwQlGMNlObOQEafMHP7tGoJgY3Aho+Zsq9AzMnKz+NFLOeORGatx
         dCiZW1S6wpi9HYROFcgmI9UCx2XdWCjid+nuDe9XFotjQJBtvLIzU67nmWdPgkBC+c
         6PvX7BCIFWu1/+udYDU43thxn2RTAWN/jMV/WrLk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.83]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7KU-1llgoL4AH4-00Ba33; Tue, 27
 Apr 2021 07:54:36 +0200
Message-ID: <3fe7113cc87ac89077b55ca55bda2b99729f13c8.camel@gmx.de>
Subject: Re: [PATCH] sched/fair: don't use waker's cpu if the waker of sync
 wake-up is interrupt
From:   Mike Galbraith <efault@gmx.de>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>
Cc:     "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "xieyongjia (A)" <xieyongjia1@huawei.com>
Date:   Tue, 27 Apr 2021 07:54:32 +0200
In-Reply-To: <d057eb13ec4e4643b314dd1652ffa9d4@hisilicon.com>
References: <20210427023758.4048-1-song.bao.hua@hisilicon.com>
         <9a6cadd9b65068b52c95adc44119bd09c6a4f9d7.camel@gmx.de>
         <d057eb13ec4e4643b314dd1652ffa9d4@hisilicon.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VGkbZIHqRz2YuSWjg2sJQ4r3WPhkq+LeT9fZwooJyCuvehLif6G
 cW0g4T5gMpqWhN1hw29A5ogOBhZkjUX2lo+VKpo48gD1AGoCbbQ7jhrf8qRWYMI8E8zWtz2
 Oe2ia1DGrJsHL2VsC6dIAIZYkz3wLaZqCW5zzwzgBzvAd29GoKiPVIAxfspbUg+Fw2KPqNJ
 sDKVPgRI9RR7LK8U9t/Wg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2/fobH0T9/c=:ii2hab9nNDI0n1MjFDiepJ
 7gDuCQYhVP7+jc7rpTprjR8UXwtN5mlANMDN+7dIWli4Z6XapT91m32KpKxxt8G+DbKjgtbkw
 RBsIECTenGuwGuTZo1yJa4cn3r/J/3Pl7pW1oQ9N8IhS/IqK6M962kYTOLG5ViOmaUrVWjX3S
 FDKt+HREzVlqBtB6qgr+y66GNH9jogJWPiaxo3aBtAOhKWb7r9WvDzjU/81o5XUQ5RBKBjwZs
 aMcUV2FsdC9msYVJGhBk21iAlPjvpUVvUWgEewYq1JD1xIJvZKNlWWKD0U3+Bs3PNUONa/Mhh
 5mbLIpIYxwwEEZjTQN6LJONaSTRCRQAnw7WPbnHsLkR+8JhAfMgyfxfLF4Tz45yYqrtQCdzA4
 FCM7i/9flTk7IReaKnTIBkfCK+fAgoCPiRqLfw05IRobEClC3MNxlQ/A10dXGK8b+K73z78ch
 gUGemYJz5GGXRMgcRVdeRB/IKnGVQBmHzG8Ob1UZnCXSK8IiN07Lo3MvZiqlxzP1xytDMI9+c
 OSDlvY143giwKsTxKV+oppuqI5Vqgrt5Hbuqofw5bFvgSDbPhB9+Xgm9wrCifwTXrdWMBZQLv
 hvPRzWIImgx43gcVUE8a4nBeadL8z5pPQEkb1/IC9U3C2VFxj0zE6jO00Y5kv0Gb17g8xXfV/
 YY2Sr5wxjw7lnUuXrF2JGDPMDyjw77qQ5f3pOHCUQVJz3dXXqxN/4bFpAseX4qv/CkFRENOha
 j/9acOz3tw3bGs98FJw5+aO7f04baD8aOnEpjLMsCdLp23c7rWuhloJvOsGyC1nFP45gink8O
 09XRq+UTPYdRCnsa5VGG2TYZ24Zj1CQV/Acb03Ph+IbHVOzUTS2ZWhkbYcxhHgK8bkM6/bYsD
 byLqm0KNEq/LJOBAkM+amEW63exyVpS7YyHAxfKikN52KwkUuN8UUTY35p3BLKpjXKUYhwRH8
 h/HAJhDduaZiIBRczw+pE+aqNvxMk9WtZnk3ImNbRVVcOZjWT/2tY2PbRwJE0ZTvTBqeOLVNm
 6lmwCnidDVg0btuiPXiVxlTPRgeddCoL6LLeFPEKviY3E68AAEq6gTW2weL3J0DSNfx8WpH1B
 0UBUe5aIiTCEVrkpSU02/VqfY5+k9HWiDw3fOD2GcEkvNtQNuLsX4KWd4O0NwC4a38MsSgQkv
 Q1C9HkZAGQaihsJy2OV91RKZAX+ODCFnvNAnEq1jnnp61xP3JyjTxlQdRvI/2/c57tAw0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-04-27 at 04:44 +0000, Song Bao Hua (Barry Song) wrote:
>
>
> I agree sync hint might have been overused by other kernel subsystem.
> But this patch will at least fix a case: sync waker is interrupt,
> in this case, the existing task has nothing to do with waker and wakee,
> so this case should be excluded from wake_affine_idle().

I long ago tried filtering interrupt wakeups, and met some surprises.
Wakeup twiddling always managing to end up being a rob Peter to pay
Paul operation despite our best efforts, here's hoping that your pile
of stolen cycles is small enough to escape performance bot notice :)

	-Mike

