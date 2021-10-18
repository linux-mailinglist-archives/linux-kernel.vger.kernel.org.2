Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC09430E24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 05:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhJRDZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 23:25:29 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:25163 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhJRDZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 23:25:27 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HXhx75Fr1z1DHgh;
        Mon, 18 Oct 2021 11:21:31 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 11:23:15 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 11:23:14 +0800
To:     <tom.zanussi@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Subject: [QUESTION] Performance deterioration caused by commit
 85f726a35e504418
Message-ID: <992d3b1c-70db-5cc7-8400-39caa5d502d5@huawei.com>
Date:   Mon, 18 Oct 2021 11:23:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom and Steven,

commit 85f726a35e504418 use strncpy instead of memcpy when copying comm,
on ARM64 machine, this commit causes performance degradation.

I test the number of instructions executed by invoking the 
trace_sched_switch function once on an arm64 machine:
1. Use memcpy, the number of instructions executed is 850.
2. Use strncpy, the number of instructions executed 1100.
That is, use strncpy is almost 250 more instructions than memcpy.

Has the impact on performance been considered in this commit? :)
What is the impact of revert the patch?

Kind regards,
Jihong
