Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8205F3D21B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhGVJYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:24:34 -0400
Received: from m32-153.88.com ([43.250.32.153]:49321 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231442AbhGVJYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=8GzoFqIn2zvp7Hciws/xl3fniGp7hLEvlKQRf
        9Ooq3I=; b=I/ps7mB5ScVzob4c29jcdKdUPTep5l3C9oVSCyMsRvUw3ktuYklNW
        2pOaiRKIOza6y5Erb/Ogd+61JpUgcAEXVMyFNiabTNNmx25Fl9CbJM9KWyTelq0C
        XQH8eJ6zBbgxz39VopygKZvIZKJ6QoFYGJviEwNtB8n9Ust/ooAsRE=
Received: from [0.0.0.0] (unknown [180.120.41.43])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgCXFqe+Qvlg3cAAAA--.2761S3;
        Thu, 22 Jul 2021 18:04:53 +0800 (CST)
Subject: Re: [PATCH] checkpatch: add grammatical judgement for total output
To:     Joe Perches <joe@perches.com>, apw@canonical.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
References: <20210721151416.30530-1-src.res@email.cn>
 <68b4f05607e9e44559e174d9b50e435fb58ef5aa.camel@perches.com>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <1e0a9acb-e973-7371-8425-05e066db0827@email.cn>
Date:   Thu, 22 Jul 2021 18:04:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <68b4f05607e9e44559e174d9b50e435fb58ef5aa.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: GiKnCgCXFqe+Qvlg3cAAAA--.2761S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF45ZFW3GrWDtrWxZr1kZrb_yoW8AF18pF
        yrK3WkJF90k3y8Aa1Syr9aqFyrGw1vyayDGr15GFyayFW5Za4IgryYgr1q9r9rKrZ3Aw13
        XFWj9ay7uryvva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUymb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0x
        vYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_
        Cr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbI
        xvr21lc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1U
        Jr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jHpBfUUUUU=
X-Originating-IP: [180.120.41.43]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/7/22 上午12:03, Joe Perches wrote:
> On Wed, 2021-07-21 at 23:14 +0800, Hu Haowen wrote:
>> There lacked a English grammatical identification within the final
>> output of checkpatch.pl such as the following:
>>
>>     total: 1 errors, 11 warnings, 4094 lines checked
>>                   ^
>>
>> Which violated the rule about the usage of the singular form and the
>> plural form. Hence fix the issue up and make it output the proper
>> sentence.
> NAK
>
> I appreciate the desire for precision but I don't want to require
> any automated downstream user of checkpatch to be changed.
>
> I think users understand the output even though it may not be
> grammatically correct in some cases.


How about another modification, which turns "errors" into "error(s)"?
In this case not only did the meaning convey but automated users won't
be confused toward their automatic programs.


>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -7439,9 +7439,14 @@ sub process {
>>  	print report_dump();
>>  	if ($summary && !($clean == 1 && $quiet == 1)) {
>>  		print "$filename " if ($summary_file);
>> -		print "total: $cnt_error errors, $cnt_warn warnings, " .
>> -			(($check)? "$cnt_chk checks, " : "") .
>> -			"$cnt_lines lines checked\n";
>> +		my $errors_str = ($cnt_error == 1) ? "error" : "errors";
>> +		my $warnings_str = ($cnt_warn == 1) ? "warning" : "warnings";
>> +		my $checks_str = ($cnt_chk == 1) ? "check" : "checks";
>> +		my $lines_str = ($cnt_lines == 1) ? "line" : "lines";
>> +		print "total: $cnt_error $errors_str, " .
>> +			"$cnt_warn $warnings_str, " .
>> +			(($check)? "$cnt_chk $checks_str, " : "") .
>> +			"$cnt_lines $lines_str checked\n";
>>  	}
>>  
>>
>>  	if ($quiet == 0) {

