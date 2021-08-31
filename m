Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE6F3FCBCA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbhHaQvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240210AbhHaQvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:51:18 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3531CC061764
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:50:23 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id a13so25717412iol.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9DgEycQMGsPFJfjxU5xvxrR4KHhDrk4WSJNzhOW4AfQ=;
        b=MfjSCVNRe434fYhenU9ffr8sZqfGAcf1uUoqNOVaIRgH+JaKZSNKzJHusmvxK81+C3
         8CDko/RSC3or7OxXyVLlmiifUT5pRiw5wyL47f3ED22Kad1Ie/Q1cWV7Ruotylp+l4Vp
         WB40MKtUpWJ1InzLUYKdHuVwCVDgddn42mr+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9DgEycQMGsPFJfjxU5xvxrR4KHhDrk4WSJNzhOW4AfQ=;
        b=Z7lYp2atc8euM7eFW/FedPvzoibtDyOc/xlm65Dx32vgHi8fwYBWsSDO2wJ32WY3su
         3pKCQIG3i9cbEwMmeIX2JS9bjLMT9kqDK7yY+xmDcQvnwUXJZ85yVwHIqKXnVCcN6tLp
         xnl1DvpbsTBRyfbgY+rCYm9UHU9liROGy0ugnyN1ItMaY8c+6/eM56xMmwvmSlT07CQi
         ExRZPtn+E1lzfCZ31EKUK/Xou6TW0otA8i9NtO6yqsNIKLWqMRpU0g5BO67jmKn9A/Jx
         QvznBOIeBGtfiam8J6aMY+0xzjBUM8DtUneEcoYmO34WeH9v53y9e+0AUvBbMKMS1PpK
         fJPA==
X-Gm-Message-State: AOAM5314M4Pb7+H3dHUMkwZFydE8yVVgyDoE+3e2tjXc1bTan3OZlgq5
        LMWYCHTwuTGUNB1KTY2kR+gHkA==
X-Google-Smtp-Source: ABdhPJyJg5KBLvWmLAPWyRpm+uePjJeTSZiwMFAFjgh5Ssa6EJ4XJ4Xc7U5XLea3QhF1v9iT5FAxQA==
X-Received: by 2002:a6b:7a03:: with SMTP id h3mr23648569iom.39.1630428622224;
        Tue, 31 Aug 2021 09:50:22 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 3sm6079565iln.79.2021.08.31.09.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 09:50:21 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] kselftests: clean configs
To:     Li Zhijian <lizhijian@cn.fujitsu.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     philip.li@intel.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210831102316.280512-1-lizhijian@cn.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3a386a77-80f5-81c0-5bda-df656c057fa6@linuxfoundation.org>
Date:   Tue, 31 Aug 2021 10:50:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210831102316.280512-1-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/21 4:23 AM, Li Zhijian wrote:
> 0Day will check if all configs listing under selftests are able
> to be enabled properly.
> 
> For the missing configs, it will report something like:
> LKP WARN miss config CONFIG_SYNC= of sync/config
> 
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: linux-pm@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Li Zhijian (2):
>    selftests/sync: Remove the deprecated config SYNC
>    selftests/cpufreq: Rename DEBUG_PI_LIST to DEBUG_PLIST
> 
>   tools/testing/selftests/cpufreq/config | 2 +-
>   tools/testing/selftests/sync/config    | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 

Thank you. These two patches will be queued up for 5.15

thanks,
-- Shuah
