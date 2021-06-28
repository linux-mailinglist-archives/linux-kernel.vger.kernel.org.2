Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718F83B56F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhF1BuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:50:22 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:8359 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhF1BuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:50:21 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GCr3z4ZHNz73NZ;
        Mon, 28 Jun 2021 09:43:43 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 09:47:54 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 28 Jun 2021 09:47:53 +0800
Subject: Re: [linux-next] rootfs: rootflags take effect when mount rootfs
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <viro@zeniv.linux.org.uk>, <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>
References: <20210626011655.351057-1-chenweilong@huawei.com>
 <YNhW/XQlZxfJR9Us@kroah.com>
From:   chenweilong <chenweilong@huawei.com>
Message-ID: <929b30c6-9d5e-0e57-c2a0-5c166b32dc10@huawei.com>
Date:   Mon, 28 Jun 2021 09:47:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <YNhW/XQlZxfJR9Us@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/27 18:46, Greg KH wrote:
> On Sat, Jun 26, 2021 at 09:16:55AM +0800, Weilong Chen wrote:
>> The kernel root filesystem may use the rootflags parameters
>> when mount, especially for tmpfs, to setup a variety of features.
>>
>> For example:
>> 1. Add 'rootflags=huge=always' to boot args.
>> 2. When the OS bootup:
>> rootfs on / type rootfs (..., huge=always)
>> Then we can get the hugepage performance improvement of tmpfs.
>>
>> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
>> ---
>>  fs/namespace.c       | 5 +++--
>>  include/linux/init.h | 2 +-
>>  init/do_mounts.c     | 4 +++-
>>  3 files changed, 7 insertions(+), 4 deletions(-)
> No documentation update for this new user/kernel api you added?

There is already relevant documents (Documentation/admin-guide/kernel-parameters.txt)

description:

    rootflags=      [KNL] Set root filesystem mount option string

This patch make it work for tmpfs.

> .


