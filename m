Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB76741E0B5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353319AbhI3SPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353127AbhI3SPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:15:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2094C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:13:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x27so29010297lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=21wP2EKfSU+Ufh6L89NcQ77tMoe103kEUQ8sF6bdyKQ=;
        b=OS7caeMplZM3tXloeqoV0mGVdFu2x8udydvRK5CxCqAj/9B7fEol2nS3CmLNS2+T9W
         5UEdZEm29xZOOBCLKoZk/DchNcmgW7C306wMUDAt/B3XMQBBpnLsmMVfMJa0L/g+zHMm
         UkS8zVTlHqoAsZqs1Gl7M5nqVgw9Qzr7w7PhlcRPuM7GtJQQhNGCcWAeJvshm5ttIBdi
         rB2vwTYfRs68oM+LzfczqETFCYuLVYoXFyJZ6+qO+lVtRtiTvsXHfEX+mIXEL1GqyG2u
         U2a4SMYcJLLPOY77hURTMrBwc20IjuhVPtTAaLxFYpJ9u++6RG0a/YpUA5fTxKQ22jIO
         53xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=21wP2EKfSU+Ufh6L89NcQ77tMoe103kEUQ8sF6bdyKQ=;
        b=l2LyI/rxr4touFZPbqKkSM7Eocv+kNECq7rr4gpTo4bQXJR6rCXDLp4+nl0eXIe5jF
         VFAcCLSC30B7xVRxhzfcEh3nuu1+ozj8uJJubinm7r+v8Oq4+jKtykuJON3L7e0a0ByG
         5pu0hYwJYp52YBV6+AhtcC2HBPhjoj1h2Ri/ksgKRG6jtlS/okoLmr8+2VTa7EQ4tSIn
         5leaVZK9jUjqbHQ1/HuzLvL6CGvTO9KUKqrO5CN6Tv7nJZfixTbMIaB0ipSqVMPi6sri
         3GekopTN1apdyIr+gma4sAOEhMAdKgYoZjCjMIkEoW8nmHKZJkniBvenrJX5sKS66/2A
         2++Q==
X-Gm-Message-State: AOAM5324M/QS2whMVSv4jy+wyulyYe/gSVAKwCSHDND0fUuasxxA4TMj
        1J5sMNWOwRadeDAjkFBfTRw=
X-Google-Smtp-Source: ABdhPJytVMhHv4TCK8GELEx5hOd4TlB/zAMKdLLbo/yDkc9oILmCbBxyiQ13M4IJewUL14FHijagag==
X-Received: by 2002:a2e:9c8c:: with SMTP id x12mr7246029lji.332.1633025613181;
        Thu, 30 Sep 2021 11:13:33 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.149])
        by smtp.gmail.com with ESMTPSA id w4sm495026lfr.150.2021.09.30.11.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 11:13:32 -0700 (PDT)
Message-ID: <7b77a803-7556-9343-74ea-ec98296d2f27@gmail.com>
Date:   Thu, 30 Sep 2021 21:13:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [syzbot] memory leak in bsg_register_queue
Content-Language: en-US
To:     syzbot <syzbot+cfe9b7cf55bb54ed4e57@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000323d2305cd29ade7@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <000000000000323d2305cd29ade7@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/21 01:16, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+cfe9b7cf55bb54ed4e57@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         1a0db774 scsi: bsg: Fix device unregistration
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a4a1f32762f17135
> dashboard link: https://syzkaller.appspot.com/bug?extid=cfe9b7cf55bb54ed4e57
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Note: testing is done by a robot and is best-effort only.
> 

#syz fix: scsi: bsg: Fix device unregistration


With regards,
Pavel Skripkin
