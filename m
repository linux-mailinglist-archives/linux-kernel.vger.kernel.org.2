Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0613B3595C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhDIGth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:49:37 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:53780 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231540AbhDIGt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:49:28 -0400
X-AuditID: 0a580157-4f324a80000551c1-3a-606ff8e6ca10
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id EA.2C.20929.6E8FF606; Fri,  9 Apr 2021 14:49:10 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 9 Apr 2021
 14:49:10 +0800
Date:   Fri, 9 Apr 2021 14:49:09 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andy Lutomirski <luto@kernel.org>,
        "HORIGUCHI NAOYA( =?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>, <yaoaili@kingsoft.com>
Subject: Re: [RFC 0/4] Fix machine check recovery for copy_from_user
Message-ID: <20210409144909.3488db39@alex-virtual-machine>
In-Reply-To: <595ed0ac4fbb470ca9cfd256aaf1810e@intel.com>
References: <20210326000235.370514-1-tony.luck@intel.com>
        <20210408101335.28fd3692@alex-virtual-machine>
        <595ed0ac4fbb470ca9cfd256aaf1810e@intel.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsXCFcHor/vsR36Cwf7FGhaXd81hc2D0+LxJ
        LoAxissmJTUnsyy1SN8ugSuj7/dStoK5HBUHd0k1MO5g62Lk5JAQMJF4seUWSxcjF4eQwHQm
        iZ3/ljFCOC8ZJc78ucXaxcjBwSKgIrHjGQtIA5uAqsSue7NYQWwRATWJS4sfMIPUMws0Mkkc
        +vwULCEs4CLxoWku2AZeASuJm6tuMIHYnAKWEk+XdIDVCAnMZJRYcFQExOYXEJPovfKfCWSX
        hIC9xOP1ihCtghInZz4B28ssoCNxYtUxZghbXmL72znMEGMUJQ4v+cUO8YySxJHuGVCPxUo0
        HbjFNoFReBaSUbOQjJqFZNQCRuZVjCzFuemGmxghQRq+g3Fe00e9Q4xMHIyHGCU4mJVEeJub
        8xOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8y7+kpcgJJCeWJKanZpakFoEk2Xi4JRqYCp6UV5y
        e+HSLR6xCiJL9p3weMaWKbrcY8oPsdZryjICPer61y/XGq7hXJi1qdklZoqb43XBqLOZfIfn
        R6zRnh28MbV4yypObs0lMfeWNa64NmHanS+qzetv7glw1wn9UqIpwO5xtH/nTBX+Nwf1vPbt
        j371Pm3+DDGjrXv2+O15K3U6963H1QWspzb2/79YPd8kOKD8bnNRQs6M7f7FLFvC813FHJs/
        TFbR0LxtIWQZv7p7/2KGLWH9Ne5le4S115ZK9CvF35BxvB5q+zvso80VX967Nac1dif6mr/k
        qf/6+NyWBXUHO8UXnZZ3dDO24GuqaK8se7Uxy6FgGbeYwrIPRU2mBqfcFR8t2/GzXImlOCPR
        UIu5qDgRAIidVQfBAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 14:39:09 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> > I have one scenario, may you take into account:
> >
> > If one copyin case occurs, write() returned by your patch, the user process may
> > check the return values, for errors, it may exit the process, then the error page
> > will be freed, and then the page maybe alloced to other process or to kernel itself,
> > then code will initialize it and this will trigger one SRAO, if it's used by kernel,
> > we may do nothing for this, and kernel may still touch it, and lead to one panic.  
> 
> In this case kill_me_never() calls memory_failure() with flags == 0. I think (hope!)
> that means that it will unmap the page from the task, but will not send a signal.
> 
> When the task exits the PTE for this page has the swap/poison signature, so the
> page is not freed for re-use.
> 
> -Tony

Oh, Yes, Sorry for my rudeness and error-understandings, I just happen to can't control my emotions and get confused for some other things.

Thanks!
Aili Yao
