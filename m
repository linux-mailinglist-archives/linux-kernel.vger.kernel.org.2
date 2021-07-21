Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5B53D0E07
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbhGULCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:02:21 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13906 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238630AbhGUKx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:53:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626867266; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=5t2zxfusKHnDV28S1x7sohBVadjWu2fb4eMK0NRuRTQ=; b=GdCzW0gEm7H/5f5jjZj7aZMoemrpTpx1wWSKgmY5XsK2NjxyShmGLCls8fzCZYB/NUxODiER
 ewrdwoeiMNPKc/A3ZwPC9yvlnEP7gBLR7wXVAIRadEyjPv3V1mXG9gMvYnQqCQkLlJ/jY860
 7T6TyENOvt/XHRRt6aaQ2luLwss=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60f8064138fa9bfe9c26fbd2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 11:34:25
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7A67DC4360C; Wed, 21 Jul 2021 11:34:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from vjitta-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06470C433D3;
        Wed, 21 Jul 2021 11:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06470C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     michel@lespinasse.org, linux-mm@kvack.org
Cc:     ldufour@linux.ibm.com, peterz@infradead.org, mhocko@suse.com,
        willy@infradead.org, riel@surriel.com, paulmck@kernel.org,
        akpm@linux-foundation.org, surenb@google.com, joelaf@google.com,
        romlem@google.com, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org, Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [RFC PATCH 00/37] Speculative page faults
Date:   Wed, 21 Jul 2021 17:03:27 +0530
Message-Id: <1626867208-9367-1-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayanand Jitta <vjitta@codeaurora.org>

We have tried out the SPF patch series on our code base
and have seen significant improvements in app launch
latency and ebizzy tests. Please find the results below.

App launch latency (in ms) :

Apps		w/o spf	     with spf	  % improvement
--------------------------------------------------------
Changba		1531	     1252	   18.2
Taobao		1813	     1506	   16.9
QQlive		1966	     1775	   9.7


Ebizzy test (ebizzy_64  -mRTt 8) : 

ebizzy_64  -mRTt 8	w/o spf	    with spf	% improvement
--------------------------------------------------------------
Avg_records_count	2455	    2717	10.7
Avg_real_time		10	    10		-
Avg_user_time		0.74	    0.66	10.8
Avg_sys_time		12.2	    11.6	4.9

So, getting this series mainlined would be of great help.

Thanks,
Vijay
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
