Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D97C45576E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244958AbhKRI5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:57:51 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:35860 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244813AbhKRI5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:57:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Ux9CJNh_1637225640;
Received: from 30.22.113.233(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Ux9CJNh_1637225640)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Nov 2021 16:54:00 +0800
Message-ID: <1de8e282-f7a0-c557-6aeb-fdff2c58da6c@linux.alibaba.com>
Date:   Thu, 18 Nov 2021 16:54:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH V5 00/50] x86/entry/64: Convert a bunch of ASM entry code
 into C code
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ping

Thanks
Lai
