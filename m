Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D358536BE47
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 06:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhD0EXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 00:23:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:49095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhD0EXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 00:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619497294;
        bh=tqGdOlbrvgz19za+DA/w9fT3Idaa+cLj8GXnvjV+vHk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Y4LhBsTGJl6Jx9FRhYIu3nmgEvWaPdY9w/KFXDQg+QWbA333AsBGkjxXW1+yCfNCU
         6orUUCrNQmsp3fMrSp/Mzw++tcdsYAgpVnkBg4dSCKqI5Y4JHF6Ew7sLAcMXO6adn+
         zGNGmoIlZ6ASl60txKNCKeQRkuPaj1jvnQNUfSHY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.83]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoNC-1lmoky0SJi-00EvHJ; Tue, 27
 Apr 2021 06:21:34 +0200
Message-ID: <9a6cadd9b65068b52c95adc44119bd09c6a4f9d7.camel@gmx.de>
Subject: Re: [PATCH] sched/fair: don't use waker's cpu if the waker of sync
 wake-up is interrupt
From:   Mike Galbraith <efault@gmx.de>
To:     Barry Song <song.bao.hua@hisilicon.com>,
        vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Cc:     valentin.schneider@arm.com, juri.lelli@redhat.com,
        bristot@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, xuwei5@huawei.com,
        prime.zeng@hisilicon.com, guodong.xu@linaro.org,
        yangyicong@huawei.com, liguozhu@hisilicon.com,
        linuxarm@openeuler.org, wanghuiqiang@huawei.com,
        Yongjia Xie <xieyongjia1@huawei.com>
Date:   Tue, 27 Apr 2021 06:21:30 +0200
In-Reply-To: <20210427023758.4048-1-song.bao.hua@hisilicon.com>
References: <20210427023758.4048-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GT5C45vjqknDI0jIuFfcQGBLPfaRlrN1I73phzMmqLTx7D2uvLO
 4d0NLb4NnQjL6GoWSDNlSD/bhjZhtX+H8A5+hB9G+bPCIQfTOG2d1AL+ZknfdXcbyCU+UAp
 8KhSr9Rg1Finfy3zyE7TZiZG4orHngIGcD83hniSVinVzL95xDfZD3he+HsCcVjwBLb7tKh
 /+LiA+cOknpD1ef/wowHg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EG6UD9xcXDY=:5HGeXspvBRXTcwwSRvKGxj
 /WX6OqS9CkMLE29l3rDSlPYOM84xrgOKlKbDwsjf+S8NU8uM4Nz66sr5PWV9dPJI4dS2+yFV6
 aFHzztOcQAut9C1ZBDTBD/3qYt1BGgeKPprgTPnk8ujPz+KCA0pttehmGeqKmjzCytHWQYRms
 Andra/JX4JuBa7JNtHrJXMzHncWUcTM8EeEerPQqX62/7fQoD+OssjuUnAM/1C58GJneSS9MO
 MOiFAjkGxQELkEtpgmQvrb1KQUiiZ/zZMT4MaAW6/xzn9VecCaHL0Cx98oFaz7uIKzzXt/9GK
 NsJ1IrrA7Dl1Ut9tX+AD9llSXOeJdywFlhT7CRYUQh5HkmELOCqYuMGRNikhi69PDZH4Ux2+c
 hdabWgv54pBjO6uqzxNcR/qrJxA4bzzhTiLUFAa68rykMd3qV284viw2EJsiRXlipjAIyI1ww
 D+zHv1wDyCoUowxpqPuPd6uGkbHnxzzEYaGZxza7r0h2PwYvZgnFya7YpokHdV1YOLBPiXLl0
 ftm5n1EgD2oLUCkXzK0YND/yFqFTPCwie7MGni4yc9NfqO2PbHPPqYQK/PnyRj3aWiwpMVzLO
 Z6z/MzSFiLfsc0+p2ZbQ+XxwYO5dKeBxaJKTh7OrvTZ/N/v8VYZVAJImk1WSsEoZaVTPBXDtd
 4t9vxLJODMTzQFsMz9+qdIZOB85QOeCzyEiMxm5R3pZ/3lmD6gXBcRMhLmWLNy/aOhyhCV0Yr
 2MjGGugDiQoHYzzoGZhvEWGLXitEfe7gI7BGXV/WGbzizsazZzMT2s5y9PdqQ5h6kUC8+A3ej
 UkN/nJdh+qzQ58VjBhls90kNQM09WYT1yVQGuZ+pPk2vaIA3jtOdYyNcepY7Xjc0d4lQ1umsE
 WqPy4VA9BCeg3HkTja7etRYBelS92EdOndTRjBPafWU9HFO+Yc7UTNDph9mEnpfTHMBq0sELY
 IQx/a2pjhXCGGeOwDDGJjP0GXnGopuKF3l2RlacR2E9uxHSKq7+9WQ9Tzp+R8s/1uDR/TkxTD
 hp1prBSQyeOuv0KpXO4EArAHoijoghY8t6lOdJ2V/LTAyQZC8ojXlLsSY1+o8jchOaZXsk8gE
 EqS1uUZRelgzT6n2KbXYkszpuJpB6+geU77mcVh3dPeNvSIQYT0VabmjuxfSLnhVBsVQnrexH
 6u/iTOodr+yFZlxf0b9fZCExWqlSANv+wp/28ijT7HEKot681N2p+p/WY299qDU9FVzIc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-04-27 at 14:37 +1200, Barry Song wrote:
>
> To fix this issue, this patch checks the waker of sync wake-up is a task
> but not an interrupt. In this case, the waker will schedule out and give
> CPU to wakee.

That rash "the waker will schedule out" assumption, ie this really
really is a synchronous wakeup, may be true in your particular case,
but the sync hint is so overused as to be fairly meaningless. We've
squabbled with it repeatedly over the years because of that.  It really
should either become more of a communication of intent than it
currently is, or just go away.

I'd argue for go away, simply because there is no way for the kernel to
know that there isn't more work directly behind any particular wakeup.

Take a pipe, does shoving some bits through a pipe mean you have no
further use of your CPU?  IFF you're doing nothing but playing ping-
pong, sure it does, but how many real proggies have zero overlap among
its threads of execution?  The mere notion of threaded apps having no
overlap *to be converted to throughput* is dainbramaged, which should
be the death knell of the sync wakeup hint.  Threaded apps can't do
stuff like, oh, networking, which uses the sync hint heavily, without
at least to some extent defeating the purpose of threading if we were
to take the hint seriously.  Heck, just look at the beauty (gak) of
wake_wide().  It was born specifically to combat the pure-evil side of
the sync wakeup hint.

Bah, 'nuff "Danger Will Robinson, that thing will *eat you*!!" ;-)

	-Mike

