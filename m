Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5924395540
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 08:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhEaGLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 02:11:37 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3298 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhEaGL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 02:11:26 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FtlBS3Rggz1BGpV;
        Mon, 31 May 2021 14:05:04 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 14:09:41 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 14:09:40 +0800
Subject: Re: [PATCH -next v2] cifsd: check return value of
 ksmbd_vfs_getcasexattr() correctly
To:     Hyunchul Lee <hyc.lee@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        linux-cifsd-devel <linux-cifsd-devel@lists.sourceforge.net>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        Steve French <sfrench@samba.org>
References: <20210531030550.1708816-1-yangyingliang@huawei.com>
 <CANFS6bbZysgZ2Wv7_FqmeBC0e34h5uiBLFdeiDvOxHFd2XGTSg@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <0d4edde6-f8e8-5100-5c06-54ff2e0a7378@huawei.com>
Date:   Mon, 31 May 2021 14:09:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CANFS6bbZysgZ2Wv7_FqmeBC0e34h5uiBLFdeiDvOxHFd2XGTSg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/31 13:38, Hyunchul Lee wrote:
> 2021년 5월 31일 (월) 오후 12:01, Yang Yingliang <yangyingliang@huawei.com>님이 작성:
>> If ksmbd_vfs_getcasexattr() returns -ENOMEM, stream_buf is NULL,
>> it will cause null-ptr-deref when using it to copy memory. So we
>> need check the return value of ksmbd_vfs_getcasexattr() by comparing
>> with 0.
>>
>> Fixes: f44158485826 ("cifsd: add file operations")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>> v2:
>>    Handle the case ksmbd_vfs_getcasexattr() returns 0.
>> ---
>>   fs/cifsd/vfs.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/cifsd/vfs.c b/fs/cifsd/vfs.c
>> index 97d5584ec870..2a9cc0bc7726 100644
>> --- a/fs/cifsd/vfs.c
>> +++ b/fs/cifsd/vfs.c
>> @@ -274,7 +274,6 @@ static int ksmbd_vfs_stream_read(struct ksmbd_file *fp, char *buf, loff_t *pos,
>>   {
>>          ssize_t v_len;
>>          char *stream_buf = NULL;
>> -       int err;
>>
>>          ksmbd_debug(VFS, "read stream data pos : %llu, count : %zd\n",
>>                      *pos, count);
>> @@ -283,10 +282,9 @@ static int ksmbd_vfs_stream_read(struct ksmbd_file *fp, char *buf, loff_t *pos,
>>                                         fp->stream.name,
>>                                         fp->stream.size,
>>                                         &stream_buf);
>> -       if (v_len == -ENOENT) {
>> +       if ((int)v_len <= 0) {
>>                  ksmbd_err("not found stream in xattr : %zd\n", v_len);
>> -               err = -ENOENT;
>> -               return err;
>> +               return v_len == 0 ? -ENOENT : (int)v_len;
> How about making ksmbd_vfs_getcasexattr return -ENONENT instead of
> returning 0 to
> remove duplicate error handling code?
Yes, I think it's ok, I will send a v3 later.

Thanks,
Yang
>
> Thanks,
> Hyunchul
>
>>          }
>>
>>          memcpy(buf, &stream_buf[*pos], count);
>> @@ -415,9 +413,9 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
>>                                         fp->stream.name,
>>                                         fp->stream.size,
>>                                         &stream_buf);
>> -       if (v_len == -ENOENT) {
>> +       if ((int)v_len <= 0) {
>>                  ksmbd_err("not found stream in xattr : %zd\n", v_len);
>> -               err = -ENOENT;
>> +               err = v_len == 0 ? -ENOENT : (int)v_len;
>>                  goto out;
>>          }
>>
>> --
>> 2.25.1
>>
> .
