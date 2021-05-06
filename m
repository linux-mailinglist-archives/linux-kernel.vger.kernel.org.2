Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED7A374F02
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 07:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhEFFtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 01:49:00 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:3129 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229622AbhEFFs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 01:48:57 -0400
X-AuditID: 0a580155-c6bff700000401e3-1b-6093830d3bcd
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 3A.8B.00483.D0383906; Thu,  6 May 2021 13:47:57 +0800 (HKT)
Received: from alex-virtual-machine (10.88.1.103) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 6 May 2021
 13:47:56 +0800
Date:   Thu, 6 May 2021 13:47:50 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, <yaoaili126@gmail.com>
Subject: Re: [PATCH] Revert "mm/gup: check page posion status for coredump."
Message-ID: <20210506134750.17d2f6eb@alex-virtual-machine>
In-Reply-To: <20210505135407.31590-1-mhocko@kernel.org>
References: <20210505135407.31590-1-mhocko@kernel.org>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.1.103]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXCFcHor8vbPDnBYGq/hsWc9WvYLL6u/8Vs
        cXnXHDaLe2v+s1q8/raM2eJ+n4PFs9arLA7sHjtn3WX32LSqk81j06dJ7B4nZvxm8Xi/7yqb
        x/otV1k8Pm+SC2CP4rJJSc3JLEst0rdL4MrYfGAWe8ExroqvB1eyNTDu4uhi5OSQEDCReLb1
        HHMXIxeHkMB0Jok9V5oYIZxnjBLz2yeygVSxCKhIXD88lxXEZhNQldh1bxaYLQIUX993hx2k
        gVngDKPExXmbmUASwgI+ErN717GD2LwCVhLLl10Di3MKmEv8aZ0CtIEDaIOZRPeDaJAwv4CY
        RO+V/0wgYQkBe4nH6xUhOgUlTs58wgJiMwvoSJxYdYwZwpaX2P52DpgtJKAocXjJL3aIZ+Ql
        7v6ezghhx0o0HbjFNoFReBaSUbOQjJqFZNQCRuZVjCzFuelGmxgh0RG6g3FG00e9Q4xMHIyH
        GCU4mJVEeAvW9icI8aYkVlalFuXHF5XmpBYfYpTmYFES52Uv7EoQEkhPLEnNTk0tSC2CyTJx
        cEo1MHm0Nuv1FtyqT/ug2mbJ22Tl2L7TVkN7wmWxBV/9ovP8rJZqRr7+dOMlr2fWsU2mVqKx
        5gKhB0/t/nn9jOaDF+tur+lln/7OKCXl9Qr3y7MfTnkSEG6kcynz4PapdYeV8qaKRhkc/rfl
        dKPey/aCy8utd4h4PHysPt36qWjP5jhVFfsI1dN1h7e8fPjHbP8Hi4debjuOdF/bf1lxsaKk
        4cWnO3oSO7P+XShpPBK1qWxrfEeDo0Xa1acNJ7/ESzbuPuN/c1bYvt3cQYXdh1rctHy12JaF
        /K8/URguYH9V4RnX+1mzP9a09CXXufx2TVUp1pTftXuJeqlA8MczLdZPVpcoLbXa1cB25eX6
        iPbNYUosxRmJhlrMRcWJAH3/FZf9AgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 May 2021 15:54:07 +0200
Michal Hocko <mhocko@kernel.org> wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> While reviewing http://lkml.kernel.org/r/20210429122519.15183-4-david@redhat.com
> I have crossed d3378e86d182 ("mm/gup: check page posion status for
> coredump.") and noticed that this patch is broken in two ways. First it
> doesn't really prevent hwpoison pages from being dumped because hwpoison
> pages can be marked asynchornously at any time after the check.

I rethink this:
There are two cases for this coredump panic issue.
One is the scenario that the hwpoison flag is set correctly, and the previous patch
will make it recoverable and avoid panic.

Another is the hwpoison flag not valid in the check, maybe race condition. I don't think
this case is worth and reliazable to be covered. As the SRAR can happen freshly in the dump
process and thus can't be detected.

And the previous patch doesn't make the Another case worse and unacceptable. just as it can't be
covered.

So here is the patch:
For most case in this topic, the patch will work. For the case hwpoison flag not valid, it will
fallback to the original process before this patch --- just panic. 

And i don't think we need to consider the minor case as you have said the posion can happen any time.

Thanks!
Aili Yao




