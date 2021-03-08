Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A63330CE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhCHL7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:59:34 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13867 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhCHL7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:59:19 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DvGzq293bz7dmG;
        Mon,  8 Mar 2021 19:57:27 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Mon, 8 Mar 2021
 19:59:08 +0800
Subject: Re: [PATCH] sched/topology: Fix a typo in pr_err()
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
References: <1615195496-13980-1-git-send-email-yangyicong@hisilicon.com>
 <YEYLSdUdNmIE/quo@hirez.programming.kicks-ass.net>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <f6b1d07c-9ef2-3288-be8a-326503bd4e82@hisilicon.com>
Date:   Mon, 8 Mar 2021 19:59:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YEYLSdUdNmIE/quo@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/8 19:32, Peter Zijlstra wrote:
> On Mon, Mar 08, 2021 at 05:24:56PM +0800, Yicong Yang wrote:
>> Fix a typo 'borken' to 'broken' in pr_err().
> 
> It was not a typo..
> 

got it already. terribly sorry to bother and please ignore this.

> .
> 

