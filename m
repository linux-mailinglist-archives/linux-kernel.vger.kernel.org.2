Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA293A45CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 17:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhFKQAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:00:30 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:44673 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFKQA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:00:29 -0400
Received: by mail-pf1-f180.google.com with SMTP id u18so4776094pfk.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 08:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HkaVMicttHWpif94nSMHfmpNValFfWFmY2lqzd1F/tM=;
        b=iVWSscEg9lP/TSFaYNPBDglj9ekDVC8jkpVOtAp7uNlYHkiiDfc+7sUvF+0q9dAox+
         kiadnEz4k8XsOpxqXVwt5+y98CN45p4Io+29DOHjnKIEGPUqofCFXrCRCz7GSydQvPUo
         uP8/NiivHAqAXtYejbkV/wJ1Hmz56Zi+YWWOrxrVBazQcZCWXksru80VlmSK4EOl+hwc
         o6MMUDUvvF2min26VPYLNbkUr4y+/3z2sq1x6D0SIeUPOmJKRC/yGWwHbbAcoOYll2mG
         vSecGnxRvviDFmfJxzNPV46oagqOsEugJUkuB/9xOjqSzLKROCDZ8R9mCr/wzST0ajtT
         61ZA==
X-Gm-Message-State: AOAM530tRDM5ILhYTZ++drgYbld9vdrxi8lXXWtvmKRvr/M5LCcQ5WGW
        6omlGkUa86acNEFI4xa4XR8=
X-Google-Smtp-Source: ABdhPJybmppigp3NJuIk1u7epBR3fkml9Rml1nWXfhdshQIWpWfdGiO30eVbOLQTOdQv5p5vDW1rrg==
X-Received: by 2002:aa7:921a:0:b029:2cf:b55b:9d52 with SMTP id 26-20020aa7921a0000b02902cfb55b9d52mr8642367pfo.35.1623427111236;
        Fri, 11 Jun 2021 08:58:31 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id v15sm6034254pgf.26.2021.06.11.08.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 08:58:30 -0700 (PDT)
Subject: Re: [block/mq] 2aa18c32fd:
 WARNING:at_block/mq-deadline-main.c:#dd_insert_requests
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20210611070434.GA26476@xsang-OptiPlex-9020>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3e58f0b5-3dbe-b38a-ea2f-2399f5a451f5@acm.org>
Date:   Fri, 11 Jun 2021 08:58:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210611070434.GA26476@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 12:04 AM, kernel test robot wrote:
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

In the dmesg output I found the following:

kern  :warn  : [  100.174333] WARNING: CPU: 0 PID: 1055 at
block/mq-deadline-main.c:714 dd_insert_requests+0x1b5/0x300
kern  :warn  : [  100.521569] WARNING: CPU: 0 PID: 1055 at
block/mq-deadline-main.c:474 dd_dispatch_request+0x280/0x380

So these warnings are triggered by:

#if defined(CONFIG_BLK_CGROUP)
		WARN_ON_ONCE(true);
#endif

and in both call stacks I found the following: blkdev_issue_discard(). I
will take a closer look.

Bart.
