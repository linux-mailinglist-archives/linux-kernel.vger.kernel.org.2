Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730B945D78D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351513AbhKYJvy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 Nov 2021 04:51:54 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27295 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354185AbhKYJty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:49:54 -0500
Received: from dggeme709-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J0Cgy6Ct8zbj68;
        Thu, 25 Nov 2021 17:46:38 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggeme709-chm.china.huawei.com (10.1.199.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Thu, 25 Nov 2021 17:46:41 +0800
Received: from dggeme759-chm.china.huawei.com ([10.8.81.151]) by
 dggeme759-chm.china.huawei.com ([10.8.81.151]) with mapi id 15.01.2308.020;
 Thu, 25 Nov 2021 17:46:41 +0800
From:   weizhenliang <weizhenliang@huawei.com>
To:     Sean Anderson <seanga2@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Changhee Han <ch0.han@lge.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH v2 1/2] tools/vm/page_owner_sort.c: Sort by stacktrace
 before culling
Thread-Topic: [PATCH v2 1/2] tools/vm/page_owner_sort.c: Sort by stacktrace
 before culling
Thread-Index: Adfh4TSNBRWwucFZSraN+GUTNyvgCQ==
Date:   Thu, 25 Nov 2021 09:46:41 +0000
Message-ID: <22bad523dffb4681a201e6fedef7c50d@huawei.com>
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

On 2021/11/25 3:37, Sean Anderson <seanga2@gmail.com> wrote:

> static int compare_num(const void *p1, const void *p2) @@ -121,6 
>+122,7 @@ static void add_list(char *buf, int len)  
>list[list_size].page_num = get_page_num(buf);  
>memcpy(list[list_size].txt, buf, len);  list[list_size].txt[len] = 0;
>+ list[list_size].stacktrace = strchr(list[list_size].txt, '\n');

When read_block gets an empty line, buf is "\n", then the stacktrace is NULL

> list_size++;
> if (list_size % 1000 == 0) {
> printf("loaded %d\r", list_size);
>@@ -199,7 +201,7 @@ int main(int argc, char **argv)
> 
> printf("sorting ....\n");
> 
>- qsort(list, list_size, sizeof(list[0]), compare_txt);
>+ qsort(list, list_size, sizeof(list[0]), compare_stacktrace);
> 
> list2 = malloc(sizeof(*list) * list_size);  if (!list2) { @@ -211,7 
>+213,7 @@ int main(int argc, char **argv)
> 
> for (i = count = 0; i < list_size; i++) {  if (count == 0 ||
>- strcmp(list2[count-1].txt, list[i].txt) != 0) {
>+ strcmp(list2[count-1].stacktrace, list[i].stacktrace) != 0) {

And when stacktrace is NULL, a segmentation fault will be triggered here.

> list2[count++] = list[i];
> } else {
> list2[count-1].num += list[i].num;

1. Maybe you can check whether the ret of read_block is 0 before add_list,
or whether the len of buf is 0 in add_list
2. Is it necessary to check stacktrace==NULL before use ?

Wei.
