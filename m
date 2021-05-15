Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976183814EE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 03:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhEOBbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 21:31:16 -0400
Received: from mail.loongson.cn ([114.242.206.163]:42846 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229999AbhEOBbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 21:31:14 -0400
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr+4PJJ9giqYWAA--.17524S3;
        Sat, 15 May 2021 09:29:51 +0800 (CST)
Subject: Re: [PATCH v2] samples/kprobes: Fix typo in handler_post()
To:     Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Koderer <marc@koderer.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jisheng Zhang <jszhang@kernel.org>
References: <1620979810-12779-1-git-send-email-yangtiezhu@loongson.cn>
 <cdf1a6fd7d1cbdd19e1c50b280e95b10a9114f6d.camel@perches.com>
Cc:     linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <574a6962-c4c2-9595-16e9-a1e395b83852@loongson.cn>
Date:   Sat, 15 May 2021 09:29:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <cdf1a6fd7d1cbdd19e1c50b280e95b10a9114f6d.camel@perches.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxr+4PJJ9giqYWAA--.17524S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyUGr4kWFy3Zw43Wr17ZFb_yoW8GrW5pF
        90y3WYkFZYgr15uFW7Aw40gryIv34DZF4kCrs2k34Yy3ZF9rn5AF4kKw4UJrs7ur9aqF4f
        Xr10kr98Aa4xCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9lb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2txhDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/14/2021 11:26 PM, Joe Perches wrote:
> On Fri, 2021-05-14 at 16:10 +0800, Tiezhu Yang wrote:
>> It should use post_handler instead of pre_handler in handler_post().
>>
>> Fixes: e16c5dd5157e ("samples/kprobes: Add s390 case in kprobe example module")
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>
>> v2: rebase on the latest mainline kernel
>>
>>   samples/kprobes/kprobe_example.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
>> index c495664..602db3f 100644
>> --- a/samples/kprobes/kprobe_example.c
>> +++ b/samples/kprobes/kprobe_example.c
>> @@ -89,7 +89,7 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
>>   		p->symbol_name, p->addr, regs->status);
>>   #endif
>>   #ifdef CONFIG_S390
>> -	pr_info("<%s> pre_handler: p->addr, 0x%p, flags = 0x%lx\n",
>> +	pr_info("<%s> post_handler: p->addr, 0x%p, flags = 0x%lx\n",
>>   		p->symbol_name, p->addr, regs->flags);
>>   #endif
>>   }
> Perhaps better would be to use pr_fmt and remove all the
> embedded pre/post strings.
>
> This would change the style of the output through.
>
> Also fix a defective format in handler_fault ending with
> an 'n' that should be '\n'

Thank you, it looks better, let me send v3 as you suggested.

[...]

