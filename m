Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332F532CAA6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 04:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhCDC7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 21:59:42 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60030 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232035AbhCDC7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 21:59:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UQJAT7t_1614826708;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UQJAT7t_1614826708)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Mar 2021 10:58:29 +0800
Subject: Re: [PATCH] PATCH Documentation translations:translate
 sound/hd-audio/controls to chinese
To:     huangjianghui@uniontech.com
Cc:     Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210301122019.80234-1-huangjianghui@uniontech.com>
 <8735xe4lsb.fsf@meer.lwn.net> <20210302032220.GA938@akg>
 <e9937016-3b09-fb43-8fbf-a6c9b21597ac@linux.alibaba.com>
 <20210302091339.GA12203@akg>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <125f1e49-522b-1aa6-e18c-9fad90f841fe@linux.alibaba.com>
Date:   Thu, 4 Mar 2021 10:58:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210302091339.GA12203@akg>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2021/3/2 ÏÂÎç5:13, huangjianghui Ð´µÀ:
>> we usually include patch into email instead of attach it as attachment.
>> You can try use 'git send-email' to post your patches.
>>
>> Thanks
>> Alex
>>
>>
> I am sorry to do those, my patch is shown below:

Hi Jianghui,

I cann't apply your patch:

$ g am ../Re_\ \[PATCH\]\ PATCH\ Documentation\ translations_translate\ sound_hd-audio_controls\ to\ chinese.eml
Applying: PATCH Documentation translations:translate sound/hd-audio/controls to chinese
error: patch failed: Documentation/translations/zh_CN/index.rst:20
error: Documentation/translations/zh_CN/index.rst: patch does not apply
Patch failed at 0001 PATCH Documentation translations:translate sound/hd-audio/controls to chinese
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".


You'd better try to use 'git am' apply your email patch from your email client,
before send it to linux-doc.

There are some process doc of how community working:
https://landlock.io/linux-doc/landlock-v27/translations/zh_CN/process/

Thanks
Alex
