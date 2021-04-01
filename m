Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78BE350F79
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhDAGx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:53:26 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63918 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDAGxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:53:15 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1316r72H021987;
        Thu, 1 Apr 2021 15:53:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Thu, 01 Apr 2021 15:53:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1316r6LX021899
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 1 Apr 2021 15:53:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] misc: vmw_vmci: initialize payload passed to
 vmci_send_datagram()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        George Zhang <georgezhang@vmware.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20210401055747.3820-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <YGVlnbTIVsps8FeJ@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <29011e79-edb4-35ce-10ab-6d0fd5fd2ec5@i-love.sakura.ne.jp>
Date:   Thu, 1 Apr 2021 15:53:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YGVlnbTIVsps8FeJ@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/01 15:18, Greg Kroah-Hartman wrote:
> On Thu, Apr 01, 2021 at 02:57:47PM +0900, Tetsuo Handa wrote:
>> KMSAN complains that the vmci_use_ppn64() == false path in
>> vmci_dbell_register_notification_bitmap() left upper 32bits of
>> bitmap_set_msg.bitmap_ppn64 member uninitialized.
>>
>> KMSAN also complains that vmci_check_host_caps() left the payload part
>> of check_msg uninitialized.
>>
> 
> What commit does this "fix"?  Can you resend with a proper "Fixes:" tag
> so we know where it needs to be backported to?

It seems that this problem exists since the introduction.

  commit 83e2ec765be03e8a8a07619e65df70b48a1db023
  Author: George Zhang <georgezhang@vmware.com>
  Date:   Tue Jan 8 15:53:51 2013 -0800
  
      VMCI: doorbell implementation.
  
  commit 1f166439917b69d3046e2e49fe923579d9181212
  Author: George Zhang <georgezhang@vmware.com>
  Date:   Tue Jan 8 15:55:32 2013 -0800
  
      VMCI: guest side driver implementation.

But this patch should be safe to backport to as old as possible, for
this patch is merely explicitly initializing variables.
