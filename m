Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B203949E7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 04:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhE2CDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 22:03:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2083 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhE2CDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 22:03:09 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FsPn32QPKzWpKJ;
        Sat, 29 May 2021 09:56:55 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 10:01:32 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 29 May
 2021 10:01:32 +0800
Subject: Re: [PATCH 1/1] tracing: fix spelling mistakes
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210525062047.8951-1-thunder.leizhen@huawei.com>
 <20210525062047.8951-2-thunder.leizhen@huawei.com>
 <20210528211314.5dba632a@oasis.local.home>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <93006372-8482-84af-52c0-1d6e7f66e187@huawei.com>
Date:   Sat, 29 May 2021 10:01:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210528211314.5dba632a@oasis.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/29 9:13, Steven Rostedt wrote:
> On Tue, 25 May 2021 14:20:47 +0800
> Zhen Lei <thunder.leizhen@huawei.com> wrote:
> 
>> Fix some spelling mistakes in comments:
>> wont ==> won't
> 
> I prefer not to fix that spelling. I sometimes purposely leave off
> single quotes. It's no that big of a deal, and doesn't deserve the
> churn.

Yes, all people can get it right by their wits. "Wont" doesn't affect
their reading speed. But most people might think it's best to add the
missing single quote.

The minority obeys the majority?

In addition, "wont" is an independent word. See：
https://www.grammarly.com/blog/wont-vs-wont/
Wont is usually used as a noun meaning “a type of behavior specific to a person,” or “a habit.”

> 
> -- Steve
> 
> .
> 

