Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F95F37645D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 13:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhEGLPE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 May 2021 07:15:04 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:24564 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhEGLPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 07:15:02 -0400
X-AuditID: 0a580157-bebff70000027901-e6-609520f9e94f
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 05.AE.30977.9F025906; Fri,  7 May 2021 19:14:01 +0800 (HKT)
Received: from alex-virtual-machine (10.88.1.103) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 7 May 2021
 19:14:00 +0800
Date:   Fri, 7 May 2021 19:14:00 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, Jue Wang <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <yaoaili126@gmail.com>
Subject: Re: [PATCH v3 0/3] mm,hwpoison: fix sending SIGBUS for Action
 Required MCE
Message-ID: <20210507191400.6258dee6@alex-virtual-machine>
In-Reply-To: <20210507052422.GB2158342@hori.linux.bs1.fc.nec.co.jp>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
        <d09f178272df4c82b8c090ba79d222b5@intel.com>
        <87ba79daaba1416589b203118be096cb@intel.com>
        <20210507052422.GB2158342@hori.linux.bs1.fc.nec.co.jp>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.88.1.103]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsXCFcHor/tTYWqCQdtHCYs569ewWXze8I/N
        4uv6X8wWN2+ZWFzeNYfN4t6a/6wW53etZbVYNe8Os8XFxgOMFmemFVm8uXCPxeJZ61UWBx6P
        7619LB47Z91l91iwqdRj8Z6XTB6bVnWyeWz6NInd48SM3yweL65uZPF4v+8qm8fm09UenzfJ
        BXBHcdmkpOZklqUW6dslcGWs/7yKrWAtW8XuFffZGxi7WLsYOTkkBEwk5l67ytbFyMUhJDCd
        SeL9wndMEM4zRon+ra9YQKpYBFQkTlybzQhiswmoSuy6NwusW0QgSWLx7K9gDcwCW5klPm+6
        zwySEBYIlTj76ylYA6+AlcSRczvAGjgFnCXubH0Gte4qo8SatSvAEvwCYhK9V/4DTeIAusle
        4vF6RYheQYmTM5+AHcEsoCnRuv03O4StLbFs4WuwXUICihKHl/xih3hHXuLu7+mMEHasRNOB
        W2wTGIVnIRk1C8moWUhGLWBkXsXIUpybbriJERJ14TsY5zV91DvEyMTBeIhRgoNZSYT39KLJ
        CUK8KYmVValF+fFFpTmpxYcYpTlYlMR5G2cCpQTSE0tSs1NTC1KLYLJMHJxSDUymswX1lYW1
        mZ8tKDqy4ufZzsmcljr7FmQeXurfWjHdZ+l1lYqlmn57F855c5xpmR6zmXfW2UjePpdpDLdq
        VdsuT9O+cbZ4auC1JXued+1ntemoWKrrlH97q76E6c4uoa3n03cvkbhlvj1Mn8/kvYV4V4O+
        kF5mc8qdWYteP3rsLZIpVHm/zZ3Zc3vc6rfbj+yOEQ03W39j1d93m74HfhT7der7xqr5nVqZ
        M79/sGDoY1vzcz/b2hXcXZo7zayD9rBmXDpkxai396C0YvJTjbj0ysW3/21LK315vfrogvZv
        CcrLGV5oOK/2Kt2T+ejppPjjTA7lullTxCxSnxon7VY4sWuBrJ7/7muhpm5ntjEpsRRnJBpq
        MRcVJwIA6+vuZCkDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2021 05:24:22 +0000
HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:

> On Fri, May 07, 2021 at 03:37:07AM +0000, Luck, Tony wrote:
> > >> I updated the series based on previous feedbacks/discussions.  
> > >
> > > Tested-by: Tony Luck <tony.luck@intel.com>  
> > 
> > Maybe this series should get a "Cc: stable" tag too?  
> 
> The second patch (I squashed 2/3 and 3/3 into one in v4) is a little
> too large (more than 100 lines of change), which doesn't meet stable rule.
> But the first patch looks suitable to me for stable.

Before cc:stable, would you please do one stress test first?
It failed in my server, but I didn't dig into it, maybe the fail is meaningless.
Just a small suggestion.

Thanks!
Aili Yao
