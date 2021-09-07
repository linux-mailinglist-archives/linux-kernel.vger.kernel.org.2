Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8612A402C21
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345515AbhIGPr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345443AbhIGPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:47:57 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB25C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 08:46:51 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n24so13445026ion.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KOaW/FCCd5buwlfP5a4DsuSQ73kD/Vso/w0Ibmi1QWs=;
        b=trxl2Q0AgXEgGSuVsVcwVos8iVsRbOqFhwP6lSEbDH3DcRMGczxJqG69+Jvh2+EZoy
         D4IpzXDZE2qLkNutqjb27b9WUAP0dD6dA+TWgzP6DzhOOgEt7Xd5x+YJdCsyODWyUTbN
         oi8fZfXdRpodTdVMpMuOHEb7CJkBW9Hp0KafdX/h4BELe9kjnXK8VHp+86OdHTuMvXsR
         RfK5Qv8i4XhtvA4vcaxnRo7ZG67wcfXIbn/lVrJb6elmExPXjPGFqrNY2QOHEuqAILee
         8BeLUtbP6Qeyw2KILOFOysV0eFOs49bunaDkbTGtqEGnLmqP5qgd8p9vUYpjHN/+Yusq
         V9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KOaW/FCCd5buwlfP5a4DsuSQ73kD/Vso/w0Ibmi1QWs=;
        b=k75Qf8Xr3K0O5FtrajoLSsM1YHKSdbxj5vNc+AwL6+AF+gneMCLalbBV3PINs3YInm
         vFXcRqY+dP0idSRjrwa8wKwMnHJCuODtS0rpNSgxtFBEeMtU/zztXBRJoCOYzy3IMCsc
         XZNtPzDDzxdgc3lK0UKIJ5tFQbzoJLOxvaXju5FBWgrngkVoMGqV/j27kuU0sC9rvCVO
         kpZ728Rq2BDRvTqH5Pa7cusWUcWMTuTlCrYp08+eVaYp9uCRAecwjtqC6U0oyD2JVlDF
         ycSRomKt/OaNc+Q8N1X7mvGfbKifSG0fv4qK2icQLUu+QyUwXyTxDsVQjhHmpOICadHo
         9S8Q==
X-Gm-Message-State: AOAM533mNxRss2m0XbTy7MxIJ0XtPmWKBASUb4G1W5V6rTQKNFOcxVC0
        j7VHI389o+1il5Pd8LiE2tS0jQ==
X-Google-Smtp-Source: ABdhPJyW27+nsg7UUUuGxvLDcGa8uhbDMWBuVd5rNReKESFV1Hv5d7Avf4J+QjwVv378Dkey2mK3ww==
X-Received: by 2002:a6b:3b8c:: with SMTP id i134mr13773551ioa.29.1631029610543;
        Tue, 07 Sep 2021 08:46:50 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f3sm7386308iow.3.2021.09.07.08.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 08:46:49 -0700 (PDT)
Subject: Re: [memcg] 0f12156dff: will-it-scale.per_process_ops -33.6%
 regression
To:     kernel test robot <oliver.sang@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Roman Gushchin <guro@fb.com>,
        Serge Hallyn <serge@hallyn.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yutian Yang <nglaive@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com
References: <20210907150757.GE17617@xsang-OptiPlex-9020>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
Date:   Tue, 7 Sep 2021 09:46:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210907150757.GE17617@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 9:07 AM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -33.6% regression of will-it-scale.per_process_ops due to commit:
> 
> 
> commit: 0f12156dff2862ac54235fc72703f18770769042 ("memcg: enable accounting for file lock caches")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Are we at all worried about these? There's been a number of them
reported, basically for all the accounting enablements that have been
done in this merge window.

When io_uring was switched to use accounted memory, we did a bunch of
work to ameliorate the inevitable slowdowns that happen if you do
repeated allocs and/or frees and have memcg accounting enabled.

-- 
Jens Axboe

