Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB109340DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhCRTDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhCRTC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:02:58 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A88C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:02:57 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id q9so3758876qvm.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9oJtMHxCsrBQS7eij0Ef7Bg7c2Ma4SKy0mv0sVHH/R4=;
        b=KG1oApByh6171S5xcF84CIjgKTXxa6yIsEIuszJTDMdOR0VFrCji00c3lA/oGFx236
         tfwUuyUR0c/oH5yixZPnRZzKToAK4Sx52rKU4sHnzz4xbbB3+wLUHmvjm7EcxUG8XDa7
         9g1dVwC6AaYEbPxibRoOEWGO4AP1dMMS22+s5tVdg3T2uI9PWh4T5hue6MGKuAlOJUmH
         VEM2wN6z4wYv3Kc59CuHK808Xww+R+K0ZpC5EkeGW1j2f8uE370gLswwja33sw9+IucS
         5eLeXLBhb5nQaN+9qKDVvj9iEO1rdbjWYhzYncLw8t5vM4esxXT3r7J0nQXTNf3vhZdj
         /uJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9oJtMHxCsrBQS7eij0Ef7Bg7c2Ma4SKy0mv0sVHH/R4=;
        b=XOk5JPDjz1iEdlUhpeMGW4vSMvyE62A3ZhR+hqb1YU2PcmH+abUjx65rh/NFmSvGgK
         ZkL7f2Mi53G1wa8ALy7sLeiVU/kP3H1/EIh2B1sFm9PA1iqZ6yzmSs2x/T4MlvWeui59
         LAWBOfERc4tnHvUZKyeVyZiTFp11JKAnBrjDtRg7tHA38HtGTEAJCkkI1mt537+ZfJRz
         DKBQm+1x6KOiBY1B6e4MtSZzOn9RqPNaCyfLtaBXZhrjRuWVgs+BGuDXLZQ6J4WIFxg5
         s82DTkIPOSDr7oWSF3TB9Fdg/JiJpsgVcVbVwA++WWAo+BcnTAU+t0pL0XqpLMvrgkIE
         PCpQ==
X-Gm-Message-State: AOAM532Xp+ZgQViVCzoJTclVdhTDGbblMsJi/SoZFoKVNEYd/bF3EyY4
        fIk7XzXAC1orq47UkSf6Zj4upSf79w6J4HJu
X-Google-Smtp-Source: ABdhPJzyCFMCMhW1nAAC2i67Ayqxj2rElRCJ8Xx8uQz+4qjy5BRny3d86j2X1oGtG3XI2oUDYGs9aw==
X-Received: by 2002:a0c:c583:: with SMTP id a3mr5678094qvj.15.1616094176952;
        Thu, 18 Mar 2021 12:02:56 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k138sm2353885qke.60.2021.03.18.12.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 12:02:56 -0700 (PDT)
Subject: Re: [PATCH][RESEND] Revert "PM: ACPI: reboot: Use S5 for reboot"
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <b8db79e6857c41dab4ef08bdf826ea7c47e3bafc.1615947283.git.josef@toxicpanda.com>
 <CAAd53p5Vh_+tUeEQx3xf_aLiCiKP1u5Y3VgYCUzZ82Kgtr-iYw@mail.gmail.com>
 <bebcaffc-d485-912d-0c42-c0781f9c7603@toxicpanda.com>
 <CAAd53p7eJk9EtMTLjB5i7RdoKA3WS1W4TRjQs08adi7iAux_jQ@mail.gmail.com>
 <78dfcd55-442d-dcc0-c37f-5576f65f91b5@toxicpanda.com>
 <CAAd53p6Lp8+S0yjWi=MikQJ_zywiWamUS5p19oKoqB6uYW8jzg@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0cd8b39e-3feb-87b8-e172-70b07692b82a@toxicpanda.com>
Date:   Thu, 18 Mar 2021 15:02:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAAd53p6Lp8+S0yjWi=MikQJ_zywiWamUS5p19oKoqB6uYW8jzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/21 1:42 AM, Kai-Heng Feng wrote:
> On Thu, Mar 18, 2021 at 1:25 AM Josef Bacik <josef@toxicpanda.com> wrote:
> [snipped]
>> "shutdown now" works fine with and without your patch.  Thanks,
> 
> Rafael,
> Please revert the patch while we are working on it.
> 
> Josef,
> Can you please test the following patch:
> 

That made it work fine.  Thanks,

Josef
