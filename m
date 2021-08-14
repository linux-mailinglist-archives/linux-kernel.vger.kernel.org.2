Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6D33EC524
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 22:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhHNUzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 16:55:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhHNUzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 16:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628974490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mky//yXfNfMGPffYt4X50VSwGymNfab5t3UGoEej/Ec=;
        b=OCM5WyH8+6QRzVs8H/fgNBSZvx8gmXphcjklZpGMzcheviZg2lQyzL7QNTQkkt7EsRK/Ec
        u5bPt4JR9c+V7Yy/qDzdHZlwlE1feKh93KaRW30wUnJEnhNOjjOPRcbGnnOBvOIYWjBLpr
        sZ6/E+x/ybW5VbmW165sWXwb2n4T6A4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-zLitF4oaNYSdZ2Qg7O-m-Q-1; Sat, 14 Aug 2021 16:54:49 -0400
X-MC-Unique: zLitF4oaNYSdZ2Qg7O-m-Q-1
Received: by mail-qk1-f198.google.com with SMTP id h186-20020a37b7c30000b02903b914d9e335so10285354qkf.17
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 13:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Mky//yXfNfMGPffYt4X50VSwGymNfab5t3UGoEej/Ec=;
        b=ipU6YYMmohvuevLOe9SrhJiUiWuqYo/0WDMhDMrfvlsOpSwdtqlRqdd/PnLeIDsdtd
         En0OjNO9lywc6rvR1JAq6fej9sh/GmILbGJZ5KRtphZQ3b5Z7mnxl7Bm+mu+xs7SkjDh
         P3tIiXDAKCYCL5FN1PTgBRVQOUDuM405GvyolSg9+Wdc/3RYMmidT3WQv9H6pUsD8lkU
         FcmItQDoKGZLYwzhjSbLQcwxua0lqswCVLKAz2GzS/MKz2suQqUbfqcuH0p3jY5S7GM3
         Eca0D9Ibbqqx3wDQB7TSabU0wsey4qoOAKORWqfmTNJGV/VXQsIRO7eKtIjHWaopjDFT
         3cVQ==
X-Gm-Message-State: AOAM532c8Ed7nxi6Xnp7ygTTOirg3CpF7T3VX0j0b8X0lhFaGtLCzW3z
        b1i4Tdru5RuPa1KlKSmWHnaBtYhT+r2JUl7ZePPmI9enJY2OkFv7iP0ni8oMdH7jrb08UcpQ4JU
        3Qj2dbVn5Ffo9MjImDs9LW1md
X-Received: by 2002:a05:620a:138c:: with SMTP id k12mr8710641qki.172.1628974488412;
        Sat, 14 Aug 2021 13:54:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVP0gaA6ZJthD6SLBfuYiy5Nkw48EN+QZLvsI1uutitRUmRVXTy+wksJeR0UQRScjsYsdmzA==
X-Received: by 2002:a05:620a:138c:: with SMTP id k12mr8710629qki.172.1628974488218;
        Sat, 14 Aug 2021 13:54:48 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id f24sm2698045qtp.1.2021.08.14.13.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 13:54:47 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 1/6] cgroup/cpuset: Properly transition to invalid
 partition
To:     kernel test robot <lkp@intel.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210814173848.11540-2-longman@redhat.com>
 <202108150418.2ORAqLSj-lkp@intel.com>
Message-ID: <150a4d86-3e50-67be-af2b-32dd8df0db3c@redhat.com>
Date:   Sat, 14 Aug 2021 16:54:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202108150418.2ORAqLSj-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/21 4:21 PM, kernel test robot wrote:
> Hi Waiman,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on cgroup/for-next]
> [also build test WARNING on next-20210813]
> [cannot apply to kselftest/next v5.14-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Waiman-Long/cgroup-cpuset-Add-new-cpuset-partition-type-empty-effecitve-cpus/20210815-014333
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
> config: ia64-defconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/56ec7dd271c77e3cc92f0df6fd766004a7a0aa88
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Waiman-Long/cgroup-cpuset-Add-new-cpuset-partition-type-empty-effecitve-cpus/20210815-014333
>          git checkout 56ec7dd271c77e3cc92f0df6fd766004a7a0aa88
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=ia64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>     kernel/cgroup/cpuset.c: In function 'update_prstate':

Oh, it was caused by a duplicated tmpmask in update_prstate() which 
isn't really necessary. Will send out a new version to fix that.

Thanks,
Longman

