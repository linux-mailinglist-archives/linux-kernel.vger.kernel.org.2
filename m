Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAA836BF2F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 08:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhD0GRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 02:17:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:41849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhD0GRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619504152;
        bh=u1ARI6kSbqbn1fj+7+S8J9NDu+ocFwkSKh14BgPhcPI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Ufu48wiXEYF47UYDgrEwb1QHYIjHeYGJHWVUV6ePQafh7Tj75rXuUiIG7SoVQCCJF
         Bh0n+OmUUC7pjexANfJxIa3m4L5dp4wrBrGXbFWEE5tbuPV57boytj5u3a0BtjSD12
         Whowwj1QBzCvayQLLqieHUJIXMtqACEAojnQgK3w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.83]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6qv-1lGUSS3yix-00pfLh; Tue, 27
 Apr 2021 08:15:52 +0200
Message-ID: <b16c49d6c870594e770dd3eea9f7aea41faf14f6.camel@gmx.de>
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
Date:   Tue, 27 Apr 2021 08:15:48 +0200
In-Reply-To: <6c91195a6de9423abc78e8f85efc2780@hisilicon.com>
References: <20210427023758.4048-1-song.bao.hua@hisilicon.com>
         <9a6cadd9b65068b52c95adc44119bd09c6a4f9d7.camel@gmx.de>
         <d057eb13ec4e4643b314dd1652ffa9d4@hisilicon.com>
         <3fe7113cc87ac89077b55ca55bda2b99729f13c8.camel@gmx.de>
         <6c91195a6de9423abc78e8f85efc2780@hisilicon.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y8XDyx0Ntg6TO6pYiuJHzLN0KtDRnm6QvWBEZd1pz5SZOrNT2hA
 L6ChYwBS+0p8LD7oWjunZddHwCZMVENOgLJ0RlOEiLxIy3Y0d9P9gCPC4Bm7YkepXMfryca
 kuSiIQ8AIRXpY1/S0naCtE0HOWJzIIHIU6bzhqU2lXSAk1ngZ3R0BX8LRlKQ5SxKuhO/rV5
 cCygV/OpYLZrL11e1xoFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H6L0mAn/A7U=:fe+tgPQxK59mJOgblkqIHO
 x+HWHd323ShjqRixVm8JYr7MaPG71VxUCpf9+vkSfSLHVxzfOC2u64T43T1ipjcCQwoIzrgAL
 vYjrF6Birg56tgFqPN54aYfwrBC9IxfSI/yBHNoW9E6xeE/nfnYknqEimyH3TJGBhD9TseB8F
 6y9uyvL7KRpuUQHDkHMZhZB+EWTvtKyr5WHyyEiNqkd82B0kDXajQuW7IVJ3JTNFe16K+moZX
 iTljBDfr37PByVK1KMzr3jiI1xyurtsyuwsEQvJ4znBzV3rfYD1cFHC7UvM+bWHA8/IrjSlpx
 r5SuAmBcaMyagdEz6KGXlHnnj64hKd7GWkEREoC5mKeUzek0dzokr2LPPE7ykrb1sCT8aAYvN
 Z3XQj7QTWaTPGK1VXutQPEKJzNeEwO0+qjwD8tKEd7Gfs8r9S2eRPQLAoIQPwJ5RJ4WsGz0XS
 GKZDqwfRsLWto5UN9YT4Jpn/YFt/RK0nSGowaTP3iiHvIOgBFNK89VE9Z8cbQ7Nj4PYPmM9Uu
 +8NuqS7BGxRQ95UITVaDKK5mSO8S1gHtqO0C4erUUaVR1Wx3xNrSXEbUPYmm5DAScBY2u6Af4
 icuUGFgtXmHxXmt7hSmrBa6/WSnSKGucf4INvS/2v62KaH4PaTsUF3aOiS2HMtwXjlwqD57Lq
 z87eUOeF7Vsl3+wwx7aL05MDHvzudjRx3vubgXqALXUayYtXsXgPuyDYfc0Su/y8C9JzmEKGg
 tTxLxdqQvHYfuq5uxhsqtzjGB5pKh04V2D47qSfpL0IiHAVZQovuHnsRS9HCB5VSm2CkLLtEu
 UUDulTUpjwZxTabTDiwema3vzCLGipmRbZzbAlnmTJbOs+NngTSEgX9ly8Di/9Th8K6yTFIhu
 VexDlN0zg/NomjEXiPtgBXpckWoMcgzFSOm24i8wZP4q6BadvkWH8CrPwTsBvWH0Pcq/H/ZsR
 xJ5h3RUovNzEty2t433GQLX6AQ4fLmdn6vRtz0kau80fVjbRDVRjb5YwopY33hZUzG4FKyxy7
 nQpTBHMK5MpH4Q22GNYuG7KI30+oad0DvCbU3Cv80lIz6b8YQKym0zxwi5t8I7GSodp8uJ3UU
 6zDq9iR1xY2v55DXNr3RcbvW8w/EJtc8ZK/uIF5vhkoaHchH1Tyxz8hlTDVkeesdCs3TCw5it
 P2I3Mg87Rv562YyimV2iGXT5lLHOEaJGMtFqVb2xE5dxtLEFMH+FGMePFUf2bxzuRf+JM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-04-27 at 06:05 +0000, Song Bao Hua (Barry Song) wrote:
>
> Would you like to share the link you did before to filter interrupt
> wakeups?

Can't, failed experiments go only to my Bitmaster-9000 patch shredder
to avoid needing a snow plow to get to near my box.  Besides, it was
long ago in a much changed code base.

	-Mike

