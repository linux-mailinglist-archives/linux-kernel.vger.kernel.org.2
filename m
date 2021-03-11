Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849FE337F58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCKVH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:07:56 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:41383 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229809AbhCKVHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:07:46 -0500
Received: from [192.168.0.2] (ip5f5aed13.dynamic.kabel-deutschland.de [95.90.237.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 166AE206479CB;
        Thu, 11 Mar 2021 22:07:40 +0100 (CET)
Subject: Re: [EXTERNAL] Re: [PATCH] kexec: Add kexec reboot string
To:     Joe LeVeque <jolevequ@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guohan Lu <lguohan@gmail.com>
References: <20210304124626.13927-1-pmenzel@molgen.mpg.de>
 <20210310213258.da50fe5f81086ab0147f6167@linux-foundation.org>
 <MWHPR21MB047848DAF9A5D35FEC1EC6D5DA909@MWHPR21MB0478.namprd21.prod.outlook.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <36da8b81-1958-2dd1-29d7-7fffbc7f7f6d@molgen.mpg.de>
Date:   Thu, 11 Mar 2021 22:07:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB047848DAF9A5D35FEC1EC6D5DA909@MWHPR21MB0478.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Joe,


Thank you for replying.


Am 11.03.21 um 19:14 schrieb Joe LeVeque:

> Is this all your looking for? If not, please let me know.
> 
>> Signed-off-by: Joe LeVeque <jolevequ@microsoft.com>

It’d be great if you answered Baoquan He’s question, how it’s actually 
used in SONiC. (I just sent the patch upstream to reduce the out-of-tree 
patches in SONiC.)


Kind regards,

Paul
