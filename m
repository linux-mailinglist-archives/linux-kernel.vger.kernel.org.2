Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85ACE37F9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhEMO3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:29:32 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64984 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbhEMO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:29:25 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 14DERvja018415;
        Thu, 13 May 2021 23:27:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Thu, 13 May 2021 23:27:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 14DERvca018407
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 May 2021 23:27:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: LOCKDEP customizable numbers upper limit
To:     "J. R. Okajima" <hooanon05g@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
References: <30795.1620913191@jrobl>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f323397b-dbe7-b655-4624-d243c2f68d81@i-love.sakura.ne.jp>
Date:   Thu, 13 May 2021 23:27:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <30795.1620913191@jrobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/05/13 22:39, J. R. Okajima wrote:
> Hello,
> 
> According to the commit in v5.13-rc1,
> 	5dc33592e9553 2021-04-05 lockdep: Allow tuning tracing capacity constants.
> several lockdep numbers have their own range as 10--30.
> But if we set all 30s, we got a compilation error.

Thanks for your report.

Initial proposal at
https://lore.kernel.org/lkml/1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
allowed only "double the upper limits", and subsequent proposals allowed arbitrary sizes in
response to https://lore.kernel.org/lkml/CACT4Y+YXT9iLij-AbrUwj=yPq-YNFw=Au9g0LQJCKwYonaHCDQ@mail.gmail.com/ ,
but practically increasing by a few bits should be sufficient.

I'm never expecting to use 30. I'm sure that setting 30s will become a too
much memory consumer that will prevent the kernel from booting correctly.
Thus, I don't think we need to care about randconfig kernels.

Please submit a patch that avoids only BUILD_BUG_ON().

Regards.

