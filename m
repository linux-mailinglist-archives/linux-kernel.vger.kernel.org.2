Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA781346FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhCXDAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:00:17 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:16785 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhCXC76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:59:58 -0400
X-AuditID: 0a580157-47bff70000021a79-65-605aa424663e
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id B3.73.06777.424AA506; Wed, 24 Mar 2021 10:29:56 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 24 Mar
 2021 10:59:55 +0800
Date:   Wed, 24 Mar 2021 10:59:50 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     <qemu-devel@nongnu.org>
CC:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        <yaoaili@kingsoft.com>, <sunhao2@kingsoft.com>
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210324105950.714fd8a6@alex-virtual-machine>
In-Reply-To: <20210224103921.3dcf0b65@alex-virtual-machine>
References: <20210222180819.3998fe33@alex-virtual-machine>
        <20210222102206.GC29063@zn.tnic>
        <20210222192146.76ffec84@alex-virtual-machine>
        <20210222201723.0fcec589@alex-virtual-machine>
        <20210222122241.GA10880@zn.tnic>
        <20210222203549.0e54c26f@alex-virtual-machine>
        <20210222124550.GB10880@zn.tnic>
        <20210223102755.13cbdffd@alex-virtual-machine>
        <20210223094300.GA26060@zn.tnic>
        <20210223175640.5708c7ed@alex-virtual-machine>
        <20210223100538.GB26060@zn.tnic>
        <20210223192711.0b517745@alex-virtual-machine>
        <9232988079334ab8801cccec6557f9c3@intel.com>
        <20210224103921.3dcf0b65@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsXCFcGooKuyJCrBYN5iVYvPG/6xWUzbKG5x
        edccNotLBxYwWRzv3cFisXnTVGaLNxfusVj82PCY1YHD43trH4vH4j0vmTw2repk83h37hy7
        x5Nrm5k83u+7yubxeZOcx4mWL6wBHFFcNimpOZllqUX6dglcGfNub2UtmMJfcfP0f5YGxuvc
        XYycHBICJhIrd01gArGFBKYzSdzYq93FyAVkv2KUmHnzIRtIgkVAVeJx7wYWEJsNyN51bxYr
        iC0iIC3RP6edHaSBWaCDWWL9vqdARRwcwgKhEkumFYLU8ApYSbzc2A82h1PAWuLQkoeMEAve
        s0hc23oEbCi/gJhE75X/TBAX2Uu0bVnECNEsKHFy5hOwGmYBHYkTq44xQ9jyEtvfzmGGuFpR
        4vCSX+wQvUoSR7pnsEHYsRLL5r1incAoPAvJqFlIRs1CMmoBI/MqRpbi3HTDTYyQmAnfwTiv
        6aPeIUYmDsZDjBIczEoivC3hEQlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEedW0gVIC6Yklqdmp
        qQWpRTBZJg5OqQam5JKf/w7Ir9op8PfxxxTlnK1fFzy5amXneEj+nMjDd3WnQ1Zdv6Xf6Hf8
        CL/aLIF1cYHyOXKcfHtvBXw5b5kx34ohL7ZCfsoZpzDLK722cySbP0+7dmlq6MYd2/dOOuKj
        7MWrbLw+IGBWu2uPRUiunaHTBkNtVwu2k0YKQtlplz48W2zB03GgOH1FZN/sknunI7onPgl/
        fdIiMm/ey8kfuPTNO6v3nz9VWvHo7YLrk6ucuM8zbJhnwu7E/mDRxYVzm45u6c3UyznkPJul
        O2li9as0r1zNm7JJuVUTsp4sKV9xzoW1aWqIDONy1VXhF268Z/x3inGGnrapR7HBqctrfTqz
        71oVbxMP0HaaOElQiaU4I9FQi7moOBEAmVMp0ggDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 10:39:21 +0800
Aili Yao <yaoaili@kingsoft.com> wrote:

> On Tue, 23 Feb 2021 16:12:43 +0000
> "Luck, Tony" <tony.luck@intel.com> wrote:
> 
> > > What I think is qemu has not an easy to get the MCE signature from host or currently no methods for this
> > > So qemu treat all AR will be No RIPV, Do more is better than do less.    
> > 
> > RIPV would be important in the guest in the case where the guest can fix the problem that caused
> > the machine check and return to the failed instruction to continue.
> > 
> > I think the only case where this happens is a fault in a read-only page mapped from a file (typically
> > code page, but could be a data page). In this case memory-failure() unmaps the page with the posion
> > but Linux can recover by reading data from the file into a new page.
> > 
> > Other cases we send SIGBUS (so go to the signal handler instead of to the faulting instruction).
> > 
> > So it would be good if the state of RIPV could be added to the signal state sent to qemu. If that
> > isn't possible, then this full recovery case turns into another SIGBUS case.  
> 
> This KVM and VM case of failing recovery for SRAR is just one scenario I think,
> If Intel guarantee that when memory SRAR is triggered, RIPV will always be set, then it's the job of qemu to
> set the RIPV instead.
> Or if When SRAR is triggered with RIPV cleared, the same issue will be true for host.
> 
> And I think it's better for VM to know the real RIPV value, It need more work in qemu and kernel if possible.
> 
> Thanks
> Aili Yao

ADD this topic to qemu list, this is really one bad issue.

Issue report:
when VM receive one SRAR memory failure from host, it all has RIPV cleared, and then vm process it and trigger one panic!

Can any qemu maintainer fix this?

Suggestion:
qemu get the true value of RIPV from host, the inject it to VM accordingly.

Thanks
Aili Yao!
