Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204EC3A2DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhFJOPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:15:05 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:25298 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhFJOPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:15:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623334388; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Date: Message-ID: Subject: From: To: Sender;
 bh=00SuqU+Eq9YKOpZC5zCFS/rhtMr0RUQILFGaVCLOp3s=; b=eVVDzKM+wmcN7Z6KBkbQPQzGzo+IcfRVisJk9zTv6+IrAWlVoOU+TD1hB7uWDq2qwvOoRgSJ
 OEU21uLnvCcoxTMXhzd9DkpJ12COXCsDocIEKCD/5uJ1W9bF4cu2wUUbkyof6enMotISeXqv
 xwjl3YBnwkcl9Y2+0FW7WyvxKSo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60c21de2b6ccaab753df316a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 10 Jun 2021 14:12:50
 GMT
Sender: mojha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B46F1C433D3; Thu, 10 Jun 2021 14:12:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.108] (unknown [103.38.130.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA9D0C433F1;
        Thu, 10 Jun 2021 14:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA9D0C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mojha@codeaurora.org
To:     masahiroy@kernel.org, lkml <linux-kernel@vger.kernel.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Subject: Query on header test
Message-ID: <96589e2f-0063-f1ec-818b-d421ac80ae7c@codeaurora.org>
Date:   Thu, 10 Jun 2021 19:42:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We are facing issue while compiling kernel (5.4) in android (arm64) on 
ubuntu18 host machine
when header test is performed.
Note: there is no issue observed on ubuntu16.

And it is failing with below issue,

./usr/include/linux/videodev2.h:2323:20: error: field has incomplete 
type 'struct timespec'
         struct timespec                 timestamp;
                                         ^
./usr/include/linux/videodev2.h:2323:9: note: forward declaration of 
'struct timespec'
         struct timespec                 timestamp;
                ^
1 error generated.


where in one of the headers "include/uapi/linux/videodev2.h" is 
including "sys/time.h"
Inside include/uapi/linux/videodev2.h
#ifndef __KERNEL__
#include <sys/time.h>
#endif

and it is try to search this file in host machine in 
"usr/include/x86_64-linux-gnu/sys/time.h".
but it is failing with that as looks like ubuntu18  packaged 
x86_64-linux-gnu time.h is not
compatible while it is compatible with ubuntu16 packaged time.h has no 
issue.

Defining _GNU_SOURCE is somehow fixing the issue the somehow.
And now i am not sure whether it is maintaining as per the standard of 
header test or it somehow
violates it.

diff --git a/usr/include/Makefile b/usr/include/Makefile
index bfc7f8e..7b789f7 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -8,7 +8,7 @@
  # We cannot go as far as adding -Wpedantic since it emits too many 
warnings.
  UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration

-override c_flags = $(UAPI_CFLAGS) -Wp,-MD,$(depfile) 
-I$(objtree)/usr/include
+override c_flags = $(UAPI_CFLAGS) -Wp,-MD,$(depfile) -D_GNU_SOURCE 
-I$(objtree)/usr/include

Thanks,
Mukesh

