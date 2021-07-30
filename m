Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BCC3DBF4E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 21:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhG3T7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 15:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhG3T7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 15:59:53 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3E9C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 12:59:47 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id y18so14762954oiv.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=OnraWx5qTRp93j0CVIlVl1ZqO/lIu4qh2IAgjAxiQDs=;
        b=IruMxjxfiLT71vsNF66JLojpeerjaqTAoivTyp/iUBHvLcFqQEx77kv3MU0xFcGqW3
         ipl8uI4BgXeydJja5GHDU9U4VAqlejQuzJx+8iZOoiFTGXPdXfCL9v+vUKlamCf1/OVb
         +YzgeIUtxb3NNQnamiPM9727SykRFp2YgvRKWnDXT3aMT+3gka7/B1EMXpfjtank53Gm
         njBIJowD9Pel4Jw2LeQy/9RhHpscqw9/7eMkWja+gkLflmw4AlVgeghui7EA60Jze1g3
         4b/7JWMMJV6StelyN0YsyQ3hAdTCAKTsb9XjYqChRhZ8v7W7CFjmbzKq1sKYc/lMEtie
         1gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=OnraWx5qTRp93j0CVIlVl1ZqO/lIu4qh2IAgjAxiQDs=;
        b=nQ6xaxrROsgQ1JSjWNxtk2/2auaLxWVdr14j3Z8t9mgETEcGiKpWmxYHp6eJvx1daj
         SX/RrRRDjqEnWBITrfPHNolmPXYhtvqmkd8CqAQY3n1O54b8+Zy1iB282ODb+hcmN5Li
         o+G116yYPb+jJGJz2Y4gBe918oJHs4qf74pY+6h4xxcTBpYB5tU9Kh9L5AH1DReYxj6G
         MTCtw83m8XbBBjTeSGWWhQY6ln0rclsECHhLI0z4nwwxrcLqsJHeGFsiERR72nCesir7
         Mgt+ggKbyDexqJeEYgKwwMlSx/HsC7bKAwyrjyYhiN2mS32RKeTLo2Czyol0yOfuWutX
         CwnA==
X-Gm-Message-State: AOAM533FfD9Q3wdl2SqP4JyvQbCbm0GQOBwO6K4U0/oLJQomfC09/wPu
        HPLEG0D9AORWYWI3FmyUe/g=
X-Google-Smtp-Source: ABdhPJxYHmxzycgXU2OiG+lfvIa8PNJ/DaLWgwgJ1CxCwYmReUqVyCq/RkJmeKF0xbNGU7ytQrKS3w==
X-Received: by 2002:a54:4817:: with SMTP id j23mr3052561oij.59.1627675186547;
        Fri, 30 Jul 2021 12:59:46 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id e3sm403155oow.34.2021.07.30.12.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 12:59:45 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-staging@lists.linux.dev
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: kernel BUG in new r8188eu
Message-ID: <80042e9f-6811-38f3-010b-1c0951ba88db@lwfinger.net>
Date:   Fri, 30 Jul 2021 14:59:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

When I unplug the USB device with the driver loaded, I get the following BUG and 
my laptop freezes:

kernel: BUG: unable to handle page fault for address: ffffeb0200043248
kernel: #PF: supervisor read access in kernel mode
kernel: #PF: error_code(0x0000) - not-present page

The traceback points to a kfree() call. I do not understand this BUG. Can you 
explain what happens?

I think I know how to avoid the BUG, but that might be at the expense of a 
memory leak.

Thanks,

Larry
