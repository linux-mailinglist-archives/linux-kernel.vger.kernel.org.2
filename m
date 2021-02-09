Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA993315ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhBJAR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:17:29 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:39412 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233992AbhBIUsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:48:18 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612903639; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Date: Message-ID: Cc: To: Subject: From: Sender;
 bh=tRp7lRzu7apqQnGrN4xD/Ckoz8eu1Epqqju1tUhZkAA=; b=uyI05LYnqzN4Hj/vqaMFjHU2j1sze6Ocdm8BvdqjofuTZNQqy0FZVBhqpogfVtM9v8MqAM/O
 sZjrpHQjBbcCI1naruWNdjRxSehsASm1hvfr1et0Thj/8jum20uCVYulwgf2WUfppaWVJzXk
 t0o5MIPsL/GdNpyXoetZ1dHA0gM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6022f4be81f6c45dce7be36c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Feb 2021 20:46:54
 GMT
Sender: mojha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C454CC43464; Tue,  9 Feb 2021 20:46:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.2] (unknown [49.37.87.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E25EBC433CA;
        Tue,  9 Feb 2021 20:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E25EBC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
Subject: Pstore : Query on using ramoops driver for DDR
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     keescook@chromium.org, Anton Vorontsov <anton@enomsg.org>,
        tony.luck@intel.com, ccross@android.com
Message-ID: <f71919bd-acd1-843c-3c9b-1d518f0d7b88@codeaurora.org>
Date:   Wed, 10 Feb 2021 02:16:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Can we use existing backend pstore ram driver (fs/pstore/ram.c) for DDR 
instead of SRAM ?
Was the current driver written only to support persistant RAM like SRAM 
or it can accept further change
to support DDR, If we have a mechanism to copy stored data from DDR to 
external device after the crash.

Thanks,
Mukesh

