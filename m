Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7FA408742
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbhIMIou convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Sep 2021 04:44:50 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15406 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbhIMIos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:44:48 -0400
Received: from dggeme711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H7Kf71YMxzR5KW;
        Mon, 13 Sep 2021 16:39:27 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggeme711-chm.china.huawei.com (10.1.199.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 13 Sep 2021 16:43:31 +0800
Received: from dggeme759-chm.china.huawei.com ([10.8.81.151]) by
 dggeme759-chm.china.huawei.com ([10.8.81.151]) with mapi id 15.01.2308.008;
 Mon, 13 Sep 2021 16:43:31 +0800
From:   weizhenliang <weizhenliang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "tangbin@cmss.chinamobile.com" <tangbin@cmss.chinamobile.com>,
        "zhangshengju@cmss.chinamobile.com" 
        <zhangshengju@cmss.chinamobile.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nixiaoming <nixiaoming@huawei.com>,
        "Xiaoqian (xiaoqian, RTOS FAE)" <xiaoqian9@huawei.com>
Subject: Re: [PATCH] tools/vm/page_owner_sort.c: count and sort by mem
Thread-Topic: [PATCH] tools/vm/page_owner_sort.c: count and sort by mem
Thread-Index: Adeod/kkYLMXa0wOSGS/zRUUIILS7Q==
Date:   Mon, 13 Sep 2021 08:43:31 +0000
Message-ID: <fb610c72d1324f1bb41c24cae4374411@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.101.97]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2021 Christian wrote:

>On Fri, 10 Sep 2021 11:03:43 +0800 Zhenliang Wei <weizhenliang@huawei.com> wrote:
>
>> When viewing page owner information, we may be more concerned about 
>> the total memory than the number of stack occurrences. Therefore, the 
>> following adjustments are made:
>> 1. Added the statistics on the total number of pages.
>> 2. Added the optional parameter "-m" to configure the program to sort by
>>    memory (total pages).
>> 
>
>Why does it add regexp matching to add_list()?  Presumably this is some enhancement to the user interface which I cannot see documented in the changelog or the code comments,
>
>Can we please add/maintain a full description of the user interface in, I guess, Documentation/vm/page_owner.rst?

Thanks for reviewing, I did omit the documentation part, I will improve git msg and page_owner.rst later.

The general output of page_owner is as follows:

		Page allocated via order XXX, ...
		PFN XXX ...
		 // Detailed stack

		Page allocated via order XXX, ...
		PFN XXX ...
		 // Detailed stack

The original page_owner_sort tool ignores PFN rows, puts the remaining rows in buf, counts the times of buf, and finally sorts them according to the times.
General output:

		XXX times:
		Page allocated via order XXX, ...
		 // Detailed stack

Now, we use regexp to extract the page order value from the buf, and count the total pages for the buf.
General output:

		XXX times, XXX pages:
		Page allocated via order XXX, ...
		 // Detailed stack

By default, it is still sorted by the times of buf;
If we want to sort by the pages nums of buf, use the new -m parameter.

>> @@ -59,12 +65,50 @@ static int compare_num(const void *p1, const void *p2)
>>  	return l2->num - l1->num;
>>  }
>>  
>> +static int compare_page_num(const void *p1, const void *p2) {
>> +	const struct block_list *l1 = p1, *l2 = p2;
>> +
>> +	return l2->page_num - l1->page_num;
>> +}
>> +
>> +static int get_page_num(char *buf)
>> +{
>> +	int err, val_len, order_val;
>> +	char order_str[4] = {0};
>> +	char *endptr;
>> +	regmatch_t pmatch[2];
>> +
>> +	err = regexec(&order_pattern, buf, 2, pmatch, REG_NOTBOL);
>> +	if (err != 0 || pmatch[1].rm_so == -1) {
>> +		printf("no order pattern in %s\n", buf);
>
>Shouldn't error messages normally be directed to stderr?  We aren't very consistent about this but it was the accepted thing to do 20-30 years ago, lol.

On this point, it does not affect the use of the tool. Personally, I prefer to retain the original coding style of the tool. Is this ok? lol

>> +		return 0;
>> +	}
>> +	val_len = pmatch[1].rm_eo - pmatch[1].rm_so;
>> +	if (val_len > 2) /* max_order should not exceed 2 digits */
>> +		goto wrong_order;
>> +
>> +	memcpy(order_str, buf + pmatch[1].rm_so, val_len);
>> +
>> +	errno = 0;
>> +	order_val = strtol(order_str, &endptr, 10);
>> +	if (errno != 0 || endptr == order_str || *endptr != '\0')
>> +		goto wrong_order;
>> +
>> +	return 1 << order_val;
>> +
>> +wrong_order:
>> +	printf("wrong order in follow buf:\n%s\n", buf);
>> +	return 0;
>> +}
>> +
>>  static void add_list(char *buf, int len)  {
>>  	if (list_size != 0 &&
>>  	    len == list[list_size-1].len &&
>>  	    memcmp(buf, list[list_size-1].txt, len) == 0) {
>>  		list[list_size-1].num++;
>> +		list[list_size-1].page_num += get_page_num(buf);
>>  		return;
>>  	}
>>  	if (list_size == max_size) {
>> @@ -74,6 +118,7 @@ static void add_list(char *buf, int len)
>>  	list[list_size].txt = malloc(len+1);
>>  	list[list_size].len = len;
>>  	list[list_size].num = 1;
>> +	list[list_size].page_num = get_page_num(buf);
>>  	memcpy(list[list_size].txt, buf, len);
>>  	list[list_size].txt[len] = 0;
>>  	list_size++;
>> @@ -85,6 +130,13 @@ static void add_list(char *buf, int len)
>>  
>>  #define BUF_SIZE	(128 * 1024)
>>  
>> +static void usage(void)
>> +{
>> +	printf("Usage: ./page_owner_sort [-m] <input> <output>\n"
>> +		"-m	Sort by total memory. If not set this option, sort by times\n"
>
>s/If not set this option/If this option is unset/

Okay, thank you, I will adjust the Usage description later

And any other suggestions about the patch?

Wei.
