Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E51374FFA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhEFHV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:21:57 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:24434 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhEFHVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:21:54 -0400
X-AuditID: 0a580157-bebff70000027901-14-609398d7daa5
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 5E.BA.30977.7D893906; Thu,  6 May 2021 15:20:55 +0800 (HKT)
Received: from alex-virtual-machine (10.88.1.103) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 6 May 2021
 15:20:54 +0800
Date:   Thu, 6 May 2021 15:20:48 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <yaoaili126@gmail.com>
Subject: Re: [PATCH] Revert "mm/gup: check page posion status for coredump."
Message-ID: <20210506152048.2baefb05@alex-virtual-machine>
In-Reply-To: <YJOUmh+HcDXBdyuS@dhcp22.suse.cz>
References: <20210505135407.31590-1-mhocko@kernel.org>
        <20210506134750.17d2f6eb@alex-virtual-machine>
        <YJOUmh+HcDXBdyuS@dhcp22.suse.cz>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.1.103]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXCFcHor3t9xuQEgwkzhCzmrF/DZvF1/S9m
        i8u75rBZ3Fvzn9Xifp+DxbPWqywObB47Z91l99j0aRK7x4kZv1k83u+7yuaxfstVFo/Pm+QC
        2KK4bFJSczLLUov07RK4Mj5sbGAsuCFQMePoSqYGxjbeLkZODgkBE4nVX/qZuhi5OIQEpjNJ
        TGr9wA7hPGOUWHF/DxtIFYuAisSNy3dYQGw2AVWJXfdmsYLYIgJKEl2bd7KBNDALrGKUOPf8
        C1hCWMBHYnbvOnYQm1fASqJp93cmEJtTQE/i1d19UOu6GSUWN08C28AvICbRe+U/UIID6CZ7
        icfrFSF6BSVOznwCtphZQEfixKpjzBC2vMT2t3PAbCEBRYnDS36xQ7wjL3H393RGCDtWounA
        LbYJjMKzkIyahWTULCSjFjAyr2JkKc5NN9zECImG8B2M85o+6h1iZOJgPMQowcGsJMJbsLY/
        QYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvlYKuBCGB9MSS1OzU1ILUIpgsEwenVAMTr9N15o7m
        X4uCvRI3GRwT3LiQaao7a+aZ+b/47uU9PNk7+fNviSnc5XmvFcTTbnfOOyYpbB2Ue+pT+hwW
        p1M1LYLn7tavbJ6kHevX1XD8acoGg6eVu40/SC9OWykZVnr9uYIDo3iZ8+H/3hf+/Gfd+dvg
        uta35p//Djm6ce1Z8G3Jqnm/G16rzuDQt7z/XXBWgvGWtM2srU46LSIzQzX27M8/+rT8T5/+
        gu0Wxwz2bp3cUWk1+wrj9HSLPQLCs6VmlFWEc0XcPOvhdcY06bLcK6GjeSu6jgq3NjaWPbns
        V+/M678nxnj9OoH7Uyr4l5asu3/xwLeA4gMcyvLPa2s+7BFdu5NX25pH+NweNu55SizFGYmG
        WsxFxYkAimq/2PUCAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 09:02:50 +0200
Michal Hocko <mhocko@suse.com> wrote:

> On Thu 06-05-21 13:47:50, Aili Yao wrote:
> > On Wed, 5 May 2021 15:54:07 +0200
> > Michal Hocko <mhocko@kernel.org> wrote:
> >   
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > While reviewing http://lkml.kernel.org/r/20210429122519.15183-4-david@redhat.com
> > > I have crossed d3378e86d182 ("mm/gup: check page posion status for
> > > coredump.") and noticed that this patch is broken in two ways. First it
> > > doesn't really prevent hwpoison pages from being dumped because hwpoison
> > > pages can be marked asynchornously at any time after the check.  
> > 
> > I rethink this:
> > There are two cases for this coredump panic issue.
> > One is the scenario that the hwpoison flag is set correctly, and the previous patch
> > will make it recoverable and avoid panic.
> > 
> > Another is the hwpoison flag not valid in the check, maybe race condition. I don't think
> > this case is worth and reliazable to be covered. As the SRAR can happen freshly in the dump
> > process and thus can't be detected.
> > 
> > And the previous patch doesn't make the Another case worse and unacceptable. just as it can't be
> > covered.
> > 
> > So here is the patch:
> > For most case in this topic, the patch will work. For the case hwpoison flag not valid, it will
> > fallback to the original process before this patch --- just panic.   
> 
> Please propose a new fix which a) doesn't leak a page reference b)
> evaluates how realistic is the scenario 

Got this, Thanks, I will dig into it and try to fix the leak. And There will be more comments on the
scenario that the issue will be triggered.

> c) explain why any other gup
> user doesn't really need to care - or in other words is the gup layer
> really suitable for this issue?

For SIGBUS coredump case, we will call the gup module for dump pages. For normal hwposion case, the gup module
will check the pte entry for hwpoison case, ans this issue is for another case for hwpoison. Maybe it's easy to
fix this issue in gup module.

Thanks!
Aili Yao

