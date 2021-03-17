Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6233F6BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhCQR0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhCQRZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:25:55 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3608C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 10:25:54 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id 94so2033395qtc.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BMh1FxvLp/X4e3iQXeMsg0+HSIoOFiGMsXX3U/LrG1Y=;
        b=n4YrMY2nWSxWprrPdOMEuVJV40WsnFkIjLvvxHHZAWUtgwo2NUDDkPSofC3LZyEF7y
         t+47Bp65zhYvvn9CJxGRRy2AdyZHd2+tmBZjtgX69ryxysEk2LJYPdZMbH3xne9EB46w
         edkMpwCkdpcIE2DkVHJWlIirmCZoo/VN6XdzsxRDSKvFtsb0ngCGqWIOi32195yMLyrd
         DiTOD/zNcNMUElzIMfHkDp4PEIkc7TI+eFUxVS3io7fKhS1BTUCG/OSkILgtZRJNa1aa
         xpHCWXnxwTZcDiD5yiEA5xNFQnfqwNXFTnI4RVjJIL+C3YNHS+yLdhkuP4gqyGNHmB7y
         4PJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BMh1FxvLp/X4e3iQXeMsg0+HSIoOFiGMsXX3U/LrG1Y=;
        b=Q1cH2XGiu89+oibNEVyAR+aanTZG+LnUNAzOhE8jljDQsrUerrar58A6rwYZ6EDQ0D
         9/Ucp1lqxM+OiQ/lbysXlGdiYCbMVNQlRnzwgt4tnMPLXIR5jsSt4Bxf7O0CqReHJoQl
         HhhfmRnWmlbICHgoOkbxjMU2/cx2jcQIdUza1FiU/4QfhaauedTaxH0TCtb3/83xlSub
         FzODk/34aoOqhPINLDHo8gOzXUCDrrjawj2gVQNQ69/rIMsBrnG/T538M3t4eGN133eT
         V3FZz0DhX8TbHfru3F0F8KEG0eF/eb3LiDjyaTQjeiHXDRrhg+HkF1TN46YFFjU/D3Oh
         dNrA==
X-Gm-Message-State: AOAM531YqQiIaD1RSlXroBeYa5Gq6YVBejiSdNzb6xzeYCjaHHnZmvl2
        xJdS/d7TFxRE6KreIaikM8XHDg==
X-Google-Smtp-Source: ABdhPJw7shQV5CI1Azt22eO4zUqvLMApAgwcB6txv2wDTd6jpUzvn9hdkpRyxqdWYxGTC5fy2Rqp1g==
X-Received: by 2002:ac8:4c90:: with SMTP id j16mr70106qtv.223.1616001953435;
        Wed, 17 Mar 2021 10:25:53 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e2sm15795759qto.50.2021.03.17.10.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 10:25:52 -0700 (PDT)
Subject: Re: [PATCH][RESEND] Revert "PM: ACPI: reboot: Use S5 for reboot"
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <b8db79e6857c41dab4ef08bdf826ea7c47e3bafc.1615947283.git.josef@toxicpanda.com>
 <CAAd53p5Vh_+tUeEQx3xf_aLiCiKP1u5Y3VgYCUzZ82Kgtr-iYw@mail.gmail.com>
 <bebcaffc-d485-912d-0c42-c0781f9c7603@toxicpanda.com>
 <CAAd53p7eJk9EtMTLjB5i7RdoKA3WS1W4TRjQs08adi7iAux_jQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <78dfcd55-442d-dcc0-c37f-5576f65f91b5@toxicpanda.com>
Date:   Wed, 17 Mar 2021 13:25:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAAd53p7eJk9EtMTLjB5i7RdoKA3WS1W4TRjQs08adi7iAux_jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 12:14 PM, Kai-Heng Feng wrote:
> On Wed, Mar 17, 2021 at 11:19 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On 3/16/21 10:50 PM, Kai-Heng Feng wrote:
>>> Hi,
>>>
>>> On Wed, Mar 17, 2021 at 10:17 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>
>>>> This reverts commit d60cd06331a3566d3305b3c7b566e79edf4e2095.
>>>>
>>>> This patch causes a panic when rebooting my Dell Poweredge r440.  I do
>>>> not have the full panic log as it's lost at that stage of the reboot and
>>>> I do not have a serial console.  Reverting this patch makes my system
>>>> able to reboot again.
>>>
>>> But this patch also helps many HP laptops, so maybe we should figure
>>> out what's going on on Poweredge r440.
>>> Does it also panic on shutdown?
>>>
>>
>> Sure I'll test whatever to get it fixed, but I just wasted 3 days bisecting and
>> lost a weekend of performance testing on btrfs because of this regression, so
>> until you figure out how it broke it needs to be reverted so people don't have
>> to figure out why reboot suddenly isn't working.
> 
> That's unfortunate to hear. However, I've been spending tons of time
> on bisecting kernels. To me it's just a normal part of kernel
> development so I won't call it "wasted".
> 
> Feel free to revert the patch though.
> 
>>
>> Running "halt" has the same effect with and without your patch, it gets to
>> "system halted" and just sits there without powering off.  Not entirely sure why
>> that is, but there's no panic.
> 
> What about shutdown? pm_power_off_prepare() is used by shutdown but
> it's not used by halt.

"shutdown now" works fine with and without your patch.  Thanks,

Josef
