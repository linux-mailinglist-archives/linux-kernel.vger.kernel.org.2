Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FCF36CBA0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbhD0T3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:29:19 -0400
Received: from www62.your-server.de ([213.133.104.62]:42478 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbhD0T3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:29:17 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lbTNo-0002Ha-5A; Tue, 27 Apr 2021 21:28:32 +0200
Received: from [85.7.101.30] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lbTNo-0000l2-0p; Tue, 27 Apr 2021 21:28:32 +0200
Subject: Re: [PATCH 066/190] Revert "bpf: Remove unnecessary assertion on
 fp_old"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-67-gregkh@linuxfoundation.org>
 <YIhQsRZ9LgZKlkPw@kroah.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <56b8a42d-261e-1fc0-f572-8c3c1a98701d@iogearbox.net>
Date:   Tue, 27 Apr 2021 21:28:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <YIhQsRZ9LgZKlkPw@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26153/Tue Apr 27 13:09:27 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/21 7:58 PM, Greg Kroah-Hartman wrote:
> On Wed, Apr 21, 2021 at 02:59:01PM +0200, Greg Kroah-Hartman wrote:
[...]
>>   kernel/bpf/core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 75244ecb2389..da29211ea5d8 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -230,6 +230,8 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
>>   	struct bpf_prog *fp;
>>   	u32 pages;
>>   
>> +	BUG_ON(fp_old == NULL);
>> +
>>   	size = round_up(size, PAGE_SIZE);
>>   	pages = size / PAGE_SIZE;
>>   	if (pages <= fp_old->pages)
> 
> The original commit here is correct, I'll drop this revert.

Ok, sounds good to me, thanks! (If there would ever be an incorrect fp_old with NULL, then at
latest we crash in fp_old->pages anyway, so the BUG_ON() was not needed.)

> thanks,
> 
> greg k-h
> 

