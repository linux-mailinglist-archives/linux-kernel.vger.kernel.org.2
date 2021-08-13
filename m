Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4683EAFD6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 08:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbhHMGEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 02:04:33 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:42074 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238757AbhHMGEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:04:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UirLXgM_1628834642;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UirLXgM_1628834642)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Aug 2021 14:04:03 +0800
Subject: Re: [PATCH v6 1/2] tty: hvc: pass DMA capable memory to put_chars()
To:     Jiri Slaby <jirislaby@kernel.org>,
        kernel test robot <lkp@intel.com>,
        gregkh@linuxfoundation.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210812094532.145497-2-xianting.tian@linux.alibaba.com>
 <202108122040.lBf24DNp-lkp@intel.com>
 <0c808001-7643-fdcf-66ba-738654ec0c21@kernel.org>
From:   Xianting TIan <xianting.tian@linux.alibaba.com>
Message-ID: <854daaf0-4d8f-82fa-a584-0b0830349a53@linux.alibaba.com>
Date:   Fri, 13 Aug 2021 14:04:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0c808001-7643-fdcf-66ba-738654ec0c21@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/13 下午1:53, Jiri Slaby 写道:
> Hi,
>
> On 12. 08. 21, 14:26, kernel test robot wrote:
>>>> drivers/tty/hvc/hvc_console.c:190:26: warning: variable 'hp' is 
>>>> uninitialized when used here [-Wuninitialized]
>>             spin_unlock_irqrestore(&hp->c_lock, flags);
>>                                     ^~
>>     drivers/tty/hvc/hvc_console.c:149:23: note: initialize the 
>> variable 'hp' to silence this warning
>>             struct hvc_struct *hp;
>>                                  ^
>>                                   = NULL
>
> So you clearly didn't test your change as it would crash quite 
> instantly. I wonder, where do you intend to get hp from in the 
> console::print() hook?

I am very sorry for the inconvenience caused.

This is caused by my carelessness:(

I take it for granted that there is no problem when I just switch to use 
array(cons_outbuf[]).

sorry agin.

>
> thanks,
