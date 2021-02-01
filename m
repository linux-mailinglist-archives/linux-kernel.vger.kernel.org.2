Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D17230A88C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhBANV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:21:28 -0500
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:47902 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhBANTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:19:40 -0500
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.0.18])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1l6Z6E-0003lO-2b; Mon, 01 Feb 2021 13:18:38 +0000
Subject: Re: [PATCH v3 0/2] Let illegal access to user-space memory die
To:     Palmer Dabbelt <palmer@dabbelt.com>, tesheng@andestech.com
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        peterx@redhat.com, penberg@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        akpm@linux-foundation.org, walken@google.com,
        linux-riscv@lists.infradead.org, vbabka@suse.cz
References: <mhng-607cbd62-adc5-45a7-adde-476741f9d63b@palmerdabbelt-glaptop>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <ee1f254d-a06e-9725-57d1-ce0210751c05@codethink.co.uk>
Date:   Mon, 1 Feb 2021 13:18:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <mhng-607cbd62-adc5-45a7-adde-476741f9d63b@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2020 02:35, Palmer Dabbelt wrote:
> On Thu, 03 Dec 2020 21:42:57 PST (-0800), tesheng@andestech.com wrote:
>> Accesses to user-space memory without calling uaccess routine
>> leads to hanging in page fault handler. Like arm64, we let it
>> die earlier in page fault handler.
>>
>> Changes in v3:
>>     -Let no_context() use die_kernel_fault() helper
>>
>> Changes in v2:
>>     -Add a die_kernel_fault() helper
>>     -Split one long line code into two
>>
>> Eric Lin (2):
>>   riscv/mm: Introduce a die_kernel_fault() helper function
>>   riscv/mm: Prevent kernel module to access user memory without uaccess
>>     routines
>>
>>  arch/riscv/mm/fault.c | 28 ++++++++++++++++++++++------
>>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> Thanks, these will be on for-next when the merge window ends.

Just tested this and it seems to be working.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
