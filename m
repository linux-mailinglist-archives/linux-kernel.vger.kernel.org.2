Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D624F30E3B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhBCT7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhBCT71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:59:27 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F270AC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 11:58:46 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q7so700640iob.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 11:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=cc:from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=iBumuQ2xl7PWUunfr+5XCG2wfvDl+oJsEntLHQUnRoM=;
        b=PJYmBRC8/jAuvC7KPetZ+KazUHm905Rkga+lhU7oVaWL37SKwbs2WrYgYOc64tvwLi
         28FbdLAlO0glF5VEYVFO0YesNLN7sNRCvoxYrXN4aGoEG6FF60DGHnarjT1QvnGpaG+g
         yXSrq8lb+smqn4r188pVtEopzCif3Nu73X8pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=iBumuQ2xl7PWUunfr+5XCG2wfvDl+oJsEntLHQUnRoM=;
        b=Z3AS0SOG4AMDKQLkpTXmZeZB1I1RGXGLd+mO/UK3WfsFtBC44Qdfzas/7EtZLQG0qy
         k7SSJuKl3eCtQ2Qni/a38NBTO6iUimdFdLvqTlqxwWB+a0eXSRRjekZN0XcMYCaUd9bX
         BYj9qLIvr5AKnSJ75vzcU4t+nV3oawUu0Hrt/3Ebgil+figJPguBrZQSUIAryw+ayLha
         7DKP2EqB6NxHeJv1bgJ+h6FhxdXlwvz/PUmAn57A/Vt+XNT7sLiYVqGKRDHtiO4wH7XM
         LtY+Mago0aevTRGYEjLxg8gzDJHpY41sQ7I1xPazRzz5ILrYZyYdHFqnCjpa/VPyVj3G
         PdrQ==
X-Gm-Message-State: AOAM532Ioh3ARJGycjxQ1bbeWbP443Pb4y0soJkYu9z00Wv9kMqgz003
        kHl9XS3toolCGB2MrUggIq9L2Q==
X-Google-Smtp-Source: ABdhPJzgpUqBG5vdviXmVeBBOuvyp8nIPkwGaW3le/t3FUwlPckmjmGnUWHIoLQkBK24H7NGNvzLMw==
X-Received: by 2002:a05:6602:2b01:: with SMTP id p1mr3774752iov.156.1612382326457;
        Wed, 03 Feb 2021 11:58:46 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 14sm1594104ioe.3.2021.02.03.11.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 11:58:45 -0800 (PST)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        xen-devel@lists.xenproject.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux 5.11-rc6 compile error
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <8a358ee4-56bc-8e64-3176-88fd0d66176f@linuxfoundation.org>
Date:   Wed, 3 Feb 2021 12:58:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing the following compile error on Linux 5.11-rc6.
No issues on 5.11.0-rc5 with the same config.

ld: arch/x86/built-in.a: member arch/x86/kernel/pci-swiotlb.o in archive 
is not an object
make: *** [Makefile:1170: vmlinux] Error 1

CONFIG_SWIOTLB_XEN=y
CONFIG_SWIOTLB=y

I can debug further later on today. Checking to see if there are any
known problems.

thanks,
-- Shuah

