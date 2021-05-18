Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E131386FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 04:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346218AbhERCjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 22:39:24 -0400
Received: from mail.loongson.cn ([114.242.206.163]:44646 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230228AbhERCjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 22:39:24 -0400
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX+6LKKNggaYYAA--.20019S3;
        Tue, 18 May 2021 10:38:04 +0800 (CST)
Subject: Re: [PATCH] checkpatch: add help info if no filenames are given
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <1621301101-10650-1-git-send-email-yangtiezhu@loongson.cn>
 <b09f7f17f07cf960c26ddb522558e3ab5187ba83.camel@perches.com>
Cc:     linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f6291875-ee94-eb2c-785c-080b383b6e03@loongson.cn>
Date:   Tue, 18 May 2021 10:38:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <b09f7f17f07cf960c26ddb522558e3ab5187ba83.camel@perches.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxX+6LKKNggaYYAA--.20019S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4fXrWxKFWDur1xAF13Arb_yoW8Gw1Upa
        4rAa15Kr42kryrAa12g3W8XFyUKas0vFyrGFZ0qF1jyF98WFWvgr9akw45uF1UZr1rCa1a
        vF4rXryS9F1F9FUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU8BHq7UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2021 10:22 AM, Joe Perches wrote:
> On Tue, 2021-05-18 at 09:25 +0800, Tiezhu Yang wrote:
>> After commit 45107ff6d526 ("checkpatch: if no filenames then read stdin"),
>> if no filenames are given, it will read patch from stdin rather than exit
>> directly. This means the script waits for input indefinitely, which
>> confuses new checkpatch users at first.
>>
>> Add some help info on this behaviour of checkpatch to lower the confusion.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   scripts/checkpatch.pl | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 23697a6..825eb00 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -80,6 +80,8 @@ sub help {
>>   Usage: $P [OPTION]... [FILE]...
>>   Version: $V
>>   
>>
>> +When FILE is -, or absent, checkpatch reads from standard input.
>> +
>>   Options:
>>     -q, --quiet                quiet
>>     -v, --verbose              verbose mode
>> @@ -138,8 +140,6 @@ Options:
>>     --kconfig-prefix=WORD      use WORD as a prefix for Kconfig symbols (default
>>                                ${CONFIG_})
>>     -h, --help, --version      display this help and exit
>> -
>> -When FILE is - read standard input.
> This line is redundant/unnecessary.

This commit adds
"When FILE is -, or absent, checkpatch reads from standard input."
and delete
"When FILE is - read standard input."

>
>>   EOM
>>   
>>
>>   	exit($exitcode);

