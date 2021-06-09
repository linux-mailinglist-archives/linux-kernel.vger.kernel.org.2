Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEA13A09A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 03:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhFIBvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 21:51:48 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3910 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhFIBvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 21:51:47 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G092J3t9dz6wsf;
        Wed,  9 Jun 2021 09:46:48 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 09:49:52 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 09:49:50 +0800
Subject: Re: [PATCH 1/1] audit: remove trailing spaces and tabs
To:     Richard Guy Briggs <rgb@redhat.com>
CC:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-audit <linux-audit@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210608075437.13120-1-thunder.leizhen@huawei.com>
 <20210608151744.GD2268484@madcap2.tricolour.ca>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <8f3615c5-db21-4642-8b38-459974747ec2@huawei.com>
Date:   Wed, 9 Jun 2021 09:49:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210608151744.GD2268484@madcap2.tricolour.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/8 23:17, Richard Guy Briggs wrote:
> On 2021-06-08 15:54, Zhen Lei wrote:
>> Run the following command to find and remove the trailing spaces and tabs:
>>
>> sed -r -i 's/[ \t]+$//' kernel/audit*
> 
> The api header include/uapi/linux/audit.h should probably be included.

OK, I will included it in v2.

> 
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  kernel/audit.h   | 2 +-
>>  kernel/auditsc.c | 8 ++++----
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/audit.h b/kernel/audit.h
>> index 1522e100fd17..cab3e2652dab 100644
>> --- a/kernel/audit.h
>> +++ b/kernel/audit.h
>> @@ -1,5 +1,5 @@
>>  /* SPDX-License-Identifier: GPL-2.0-or-later */
>> -/* audit -- definition of audit_context structure and supporting types 
>> +/* audit -- definition of audit_context structure and supporting types
>>   *
>>   * Copyright 2003-2004 Red Hat, Inc.
>>   * Copyright 2005 Hewlett-Packard Development Company, L.P.
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index 0a9a1569f1ea..679a43fd342a 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -343,13 +343,13 @@ static int audit_compare_uid(kuid_t uid,
>>  {
>>  	struct audit_names *n;
>>  	int rc;
>> - 
>> +
>>  	if (name) {
>>  		rc = audit_uid_comparator(uid, f->op, name->uid);
>>  		if (rc)
>>  			return rc;
>>  	}
>> - 
>> +
>>  	if (ctx) {
>>  		list_for_each_entry(n, &ctx->names_list, list) {
>>  			rc = audit_uid_comparator(uid, f->op, n->uid);
>> @@ -367,13 +367,13 @@ static int audit_compare_gid(kgid_t gid,
>>  {
>>  	struct audit_names *n;
>>  	int rc;
>> - 
>> +
>>  	if (name) {
>>  		rc = audit_gid_comparator(gid, f->op, name->gid);
>>  		if (rc)
>>  			return rc;
>>  	}
>> - 
>> +
>>  	if (ctx) {
>>  		list_for_each_entry(n, &ctx->names_list, list) {
>>  			rc = audit_gid_comparator(gid, f->op, n->gid);
>> -- 
>> 2.25.1
> 
> - RGB
> 
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635
> 
> 
> .
> 

