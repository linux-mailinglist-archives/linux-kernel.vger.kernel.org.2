Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0913A41E15B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbhI3SrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhI3SrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:47:24 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18594C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=L8XmYJY9cxUHM/LBimhrEUxExZJMF5wge+V9GPP/pr8=; b=N/karnnYCL/HKThK9hRKkZT+L0
        EJjMDC1A/yKqV56NBcpOb1s5uwGWMpa3MOu32sTH+Mwq3z9ftRhFVK2rD7rc+LEChPt9AUK9bTGSc
        PsN8vmJH//I0cQf4/zSl9beKrffOoXr3z7cfFvbchH72kEoD6KVOMxK+eWO7P+//Fcm5o+/+iAzZj
        UeXLvHO5x4Ry4P+E5kfu/R9bXQNR3BRyyFkDw8BIlOiIahDxWO+96/8Jmqentx4TxBdgj0yp9zEQ1
        3mofbb0pMpVXs3ZXBf1ytphQoUn4SV+SYcH+A590e/AuqhqcuHXvWy03wcUdf+V3ibXGVFn6IQ3o8
        su+chTUw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mW13r-00Fg8P-46; Thu, 30 Sep 2021 18:45:39 +0000
Subject: Re: [PATCH v2] HSI: cmt_speech: unmark comments as kernel-doc
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Aditya Srivastava <yashsri421@gmail.com>
References: <20210928183536.30645-1-rdunlap@infradead.org>
 <20210928185727.GA10433@duo.ucw.cz>
 <85f5c28b-3b70-8e31-47a0-7317ebdc216f@infradead.org>
 <20210930170138.xlspkxshgr4od7t6@earth.universe>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5465ad4d-8999-ad3d-8858-c2e1b8b463f8@infradead.org>
Date:   Thu, 30 Sep 2021 11:45:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210930170138.xlspkxshgr4od7t6@earth.universe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/21 10:01 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Sep 28, 2021 at 12:52:03PM -0700, Randy Dunlap wrote:
>> On 9/28/21 11:57 AM, Pavel Machek wrote:
>>> Hi!
>>>
>>>> Fix build warnings from the kernel test robot:
>>>>
>>>> drivers/hsi/clients/cmt_speech.c:831: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>>>       * Block until pending data transfers have completed.
>>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Cc: Sebastian Reichel <sre@kernel.org>
>>>> Cc: Aditya Srivastava <yashsri421@gmail.com>
>>>> Acked-by: Pavel Machek <pavel@ucw.cz>
>>>
>>> If noone applies it, you may want to send it to akpm, he's  often
>>> helpful in pushing similar patches.
>>
>> Yes, good idea. Thanks.
> 
> Looks like I missed v1. The patch LGTM and I can apply it to the hsi tree.
> If you already sent it to akpm, that's also fine. Not much is happening in
> HSI nowadays and it probably will be the only patch for the next cycle.

You go ahead with it, please.

thanks.
-- 
~Randy
