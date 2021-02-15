Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF51331B66B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 10:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhBOJ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 04:27:39 -0500
Received: from foss.arm.com ([217.140.110.172]:33848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230191AbhBOJ1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 04:27:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3410431B;
        Mon, 15 Feb 2021 01:26:37 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B13EC3F40C;
        Mon, 15 Feb 2021 01:26:34 -0800 (PST)
Subject: Re: [PATCH V3 11/14] coresight: sink: Add TRBE driver
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-12-git-send-email-anshuman.khandual@arm.com>
 <20210211190024.GD2186000@xps15>
 <be83fd32-e552-ac06-6ee5-3bf22c6daab2@arm.com>
 <20210212165734.GA2692426@xps15>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c9e564a5-2f35-e311-98d1-f0d864091b51@arm.com>
Date:   Mon, 15 Feb 2021 14:56:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210212165734.GA2692426@xps15>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/21 10:27 PM, Mathieu Poirier wrote:
> [...]
> 
>>>
>>>
>>>> +	if (nr_pages < 2)
>>>> +		return NULL;
>>>> +
>>>> +	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, trbe_alloc_node(event));
>>>> +	if (IS_ERR(buf))
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +
>>>> +	pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
>>>> +	if (IS_ERR(pglist)) {
>>>> +		kfree(buf);
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < nr_pages; i++)
>>>> +		pglist[i] = virt_to_page(pages[i]);
>>>> +
>>>> +	buf->trbe_base = (unsigned long) vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
>>>> +	if (IS_ERR((void *)buf->trbe_base)) {
>>>
>>> Why not simply make buf->trbe_base a void * instead of having to do all this
>>
>> There are many arithmetic and comparison operations involving trbe_base
>> element. Hence it might be better to keep it as unsigned long, also to
>> keeps it consistent with other pointers i.e trbe_write, trbe_limit.
> 
> That is a fair point.  Please add a comment to explain your design choice and
> make sure the sparse checker is happy with all of it.

Added a comment.

> 
>>
>> Snippet from $cat drivers/hwtracing/coresight/coresight-trbe.c | grep "trbe_base"
>> There are just two places type casting trbe_base back to (void *).
>>
>> 	memset((void *)buf->trbe_base + head, ETE_IGNORE_PACKET, len);
>> 	return buf->trbe_base + offset;
>> 	WARN_ON(buf->trbe_write < buf->trbe_base);
>> 	set_trbe_base_pointer(buf->trbe_base);
>> 	buf->trbe_base = (unsigned long)vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
>> 	if (IS_ERR((void *)buf->trbe_base)) {
>> 		return ERR_PTR(buf->trbe_base);
>> 	buf->trbe_limit = buf->trbe_base + nr_pages * PAGE_SIZE;
>> 	buf->trbe_write = buf->trbe_base;
>> 	vunmap((void *)buf->trbe_base);
>> 	base = get_trbe_base_pointer();
>> 	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
>> 	if (buf->trbe_limit == buf->trbe_base) {
>> 	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
>> 	if (buf->trbe_limit == buf->trbe_base) {
>> 	offset = get_trbe_limit_pointer() - get_trbe_base_pointer();
>> 	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
>> 	if (buf->trbe_limit == buf->trbe_base) {
>> 	WARN_ON(buf->trbe_base != get_trbe_base_pointer());
>> 		if (get_trbe_write_pointer() == get_trbe_base_pointer())
>>   
>>> casting?  And IS_ERR() doesn't work with vmap().
>>
>> Sure, will drop IS_ERR() here.
>>
> 
> [...]
> 
> 
>>>
>>>> +
>>>> +static ssize_t dbm_show(struct device *dev, struct device_attribute *attr, char *buf)
>>>> +{
>>>> +	struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
>>>> +
>>>> +	return sprintf(buf, "%d\n", cpudata->trbe_dbm);
>>>> +}
>>>> +static DEVICE_ATTR_RO(dbm);
>>>
>>> What does "dbm" stand for?  Looking at the documentation for TRBIDR_EL1.F, I
>>> don't see what "dbm" relates to.
>>
>> I made it up to refer TRBIDR_EL1.F as "Dirty (and Access Flag) Bit Management".
>> Could change it as "afdbm" to be more specific or if it is preferred.
>>
> 
> I don't see "afdbm" being a better solution - why not simply "flag"?

Replaced all reference for "dbm" with "flag".
