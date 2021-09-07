Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669FA402244
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 04:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhIGCbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 22:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhIGCbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 22:31:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E35FC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 19:30:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so564503pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=zl6BfDKA2Ub95iwelV68kNTqOPuhdqeFZ0nUlPUOcJM=;
        b=DzftnNz6qOgZYfeBcur6AuaQ4MVLbWoG+NcsoUIOh2IoDc/4yFFvrsfz3ceJdAd7Ya
         A3qY5pmNvbonv3Ya/LZBlErFcZd1qi4b7+C3mdwIXR8XZdPCCoFWvdGBVbNb02PnQU85
         S6OxzVmp+Ncq35QYQSP73qQ2re+7/YMheM8gacr7XYUX+1TJg5VI/vh3q+M0Tq3nC07z
         Y2+1owEUnH5Q/hK9x+h8TA9I6ndkXpgC56eVeeOZSNMI49ZCaEFpIIrpSNkOVh/UwxOJ
         FzYkPzVvi8jboGvl7DQoK8vRzsiQ/IsHXLwO/pAPg+lAn2jhh9UJRz8LFmrwJWf7BjCV
         3prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=zl6BfDKA2Ub95iwelV68kNTqOPuhdqeFZ0nUlPUOcJM=;
        b=ukY/7sWZw4UayEsIvcAYRliwR0EqFPo53KjP5FDoKW0hiJt3GEPJoJlFInz+MKQbJa
         z1GThnZtVd+YvEQDqwHbJS4dqreJCxRqCJ9hFBBVRny9JZLKoWgIvQC6iN4w+B0CagXM
         YkaJcQhpm/A9GQis2r8InFk9cOAW4oD2IJMcGeK37ipCmrgFSJ4XrBSsCF3v4ZnnA+j2
         dJz886n/m5peYkC1hUmzWcPCIfLsNt/TAunoH6I7CC+r5Z6EsFXkDVom0pvA8DLE6qGA
         hEnB6rhaJDtbeBDKR9kN5KRxW411J+s4IExdGRnJgRysng24NaW6OEDEyUH/BKkDUrSh
         r72w==
X-Gm-Message-State: AOAM5324aU1jnJ7UHePHyZnd9jL+tUsAojxrtpjUqMKozZbh6ilERRS/
        IPNsOEEWC30/pvgCwRQKFyZcA+XK7CA=
X-Google-Smtp-Source: ABdhPJx7v/nAinHF9sgOga2v+1NM3gLVKWPJ/cpDtclaa9HVBT1JATEfYboXU8526GljLF1gfRotVw==
X-Received: by 2002:a17:902:be0f:b0:13a:19b6:6870 with SMTP id r15-20020a170902be0f00b0013a19b66870mr8997920pls.64.1630981806161;
        Mon, 06 Sep 2021 19:30:06 -0700 (PDT)
Received: from [166.111.139.135] ([166.111.139.135])
        by smtp.gmail.com with ESMTPSA id o2sm11266323pgc.47.2021.09.06.19.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 19:30:05 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] android: possible ABBA deadlock in print_binder_proc() and
 binder_get_txn_from_and_acq_inner()
To:     Greg KH <gregkh@linuxfoundation.org>, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        christian@brauner.io, hridya@google.com, surenb@google.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <303401d0-25c9-d04b-e96d-3ca2aa0a616d@gmail.com>
Date:   Tue, 7 Sep 2021 10:29:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My static analysis tool reports a possible ABBA deadlock in the android 
driver in Linux 5.10:

print_binder_proc()
   binder_inner_proc_lock()
     _binder_inner_proc_lock()
       spin_lock(&proc->inner_lock); --> Line 662 (Lock A)
   print_binder_thread_ilocked()
     print_binder_transaction_ilocked()
       spin_lock(&t->lock); --> Line 5531 (Lock B)

binder_get_txn_from_and_acq_inner()
   binder_get_txn_from()
     spin_lock(&t->lock); --> Line 1833 (Lock B)
   binder_inner_proc_lock()
     _binder_inner_proc_lock()
       spin_lock(&proc->inner_lock); --> Line 662 (Lock A)

When print_binder_proc() and binder_get_txn_from_and_acq_inner() are 
concurrently executed, the deadlock can occur.

I am not quite sure whether this possible deadlock is real and how to 
fix it if it is real.
Any feedback would be appreciated, thanks :)

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai
