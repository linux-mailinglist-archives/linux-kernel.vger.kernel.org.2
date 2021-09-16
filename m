Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C68440D086
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhIPADs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhIPADm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:03:42 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C10C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 17:02:22 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id d11so931276ilc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 17:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ax8LShNyO/ytGnXDG0PMZkXXR8JTT6V4lJvXKtadg9U=;
        b=SkOrlPfjrXdP/RELV+Vo7978cJgloQd/OPaiCrR1IlQJh60BxLSh4Jq3HO7QRKjsIt
         Vd3UzKhvuMbIu9EivUwLSukwAaPJD6nyAKBEgiYmdZ59wm9CluMW+9MchrdXvemv+KY6
         0UIBnyzjfRcB5cKCGhHx5SLBWPeDfZaJ3kFxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ax8LShNyO/ytGnXDG0PMZkXXR8JTT6V4lJvXKtadg9U=;
        b=TGayrHW9w8xzVtr+408YGev3XpV/Sf9CNvZX08GAndNQ72bn7H9kkvaKjxrVudPNGS
         w+9q6tPqsTP3NsONl0y+vWF7HaraRy+EvkRfZ/Ri5XCIOfSu3HeZgq6+RPzH4hYw85a1
         YcHqbtWUdwCp3P6WbdMjhpjcQtPFybw0nG4hBdCLiKMP7/3ZtRAzYJUdFrPj5Wb993eU
         Mi45Z2Hct2VjTYW6QZZgdZ9WgeomQ6aGwtYh90uB93+ehte6uzhs9tG7FuOiKq4eYgXR
         UtyAANOte02vFNJk6A4nSHC/8Z0dr/rY1UjB7HIK/15DXYWN+SeUQCLO2JSxluUlQNm9
         zBdw==
X-Gm-Message-State: AOAM533bU0eLol+BzLjvA9G3s3F69o/BaAXbWKGwxwsilPhIB1WqnOlq
        O1BT38yyYAm7V/PIgQbtjyM8cw==
X-Google-Smtp-Source: ABdhPJz/RWH8z4Hqoi2kvBlptcDKBKVHEfRehR1OOG7S9aDfiBX8O/Dmxg2CcInJc+gDvk3gjl/Ctw==
X-Received: by 2002:a05:6e02:1d8b:: with SMTP id h11mr1855401ila.94.1631750541908;
        Wed, 15 Sep 2021 17:02:21 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s10sm737176iom.40.2021.09.15.17.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 17:02:21 -0700 (PDT)
Subject: Re: [PATCH 0/4] selftests: kvm: fscanf warn fixes and cleanups
To:     Paolo Bonzini <pbonzini@redhat.com>, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1631737524.git.skhan@linuxfoundation.org>
 <56178039-ab72-fca3-38fa-a1d422e4d3ef@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <aca932b9-5864-be95-c9f6-f745b6a6b7f3@linuxfoundation.org>
Date:   Wed, 15 Sep 2021 18:02:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <56178039-ab72-fca3-38fa-a1d422e4d3ef@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 4:34 PM, Paolo Bonzini wrote:
> On 15/09/21 23:28, Shuah Khan wrote:
>> This patch series fixes fscanf() ignoring return value warnings.
>> Consolidates get_run_delay() duplicate defines moving it to
>> common library.
>>
>> Shuah Khan (4):
>>    selftests:kvm: fix get_warnings_count() ignoring fscanf() return warn
>>    selftests:kvm: fix get_trans_hugepagesz() ignoring fscanf() return
>>      warn
>>    selftests: kvm: move get_run_delay() into lib/test_util
>>    selftests: kvm: fix get_run_delay() ignoring fscanf() return warn
>>
>>   .../testing/selftests/kvm/include/test_util.h |  3 +++
>>   tools/testing/selftests/kvm/lib/test_util.c   | 22 ++++++++++++++++++-
>>   tools/testing/selftests/kvm/steal_time.c      | 16 --------------
>>   .../selftests/kvm/x86_64/mmio_warning_test.c  |  3 ++-
>>   .../selftests/kvm/x86_64/xen_shinfo_test.c    | 15 -------------
>>   5 files changed, 26 insertions(+), 33 deletions(-)
>>
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Thanks Shuah!
> 

Thank you. I can take these through linux-kselftest - let me know
if that causes issues for kvm tree.

thanks,
-- Shuah
