Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D800405F56
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 00:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345195AbhIIWSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 18:18:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54557 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232075AbhIIWSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:18:44 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 189MHJMJ242442
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 9 Sep 2021 15:17:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 189MHJMJ242442
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631225840;
        bh=xYFXSYgT8pV/OFMDZ1ZrM3Ko4Zj8/rlJ1V9afzlYGJc=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=hOz2k/9kliVm2ll1OoXmiuftHAzes38g1nuiOtE64Hn5W1N7FBEMuWX6kIFiOsTkz
         yn1W+QpAwqJFktGO6Rgai4rOw9dXtw/cbjsefqiZT9mPnaKrYbJoGHUX07aYAkc4LB
         dJme2/QRemfIX8Uuccd5t1PFIA5RH9BxHGoQ2GLn+1pFD64GU7ignVXiyXgYpm3m3y
         hm3cr2fSVAihBMLi/hSu0gBvU0acRlcAYbTBjTNjC1NkbqDjtrYVrmW4y39V07h+lR
         HM4qvscIZPLW28uW1A9ihn/fXC2DJO/L2y/6rpK4mr9wSSueS7o2hHbS5UbrZPjoq2
         nEBx2VkMvb/pQ==
Subject: Re: [PATCH] x86/asm: pessimize the pre-initialization case in
 static_cpu_has()
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210908171716.3340120-1-hpa@zytor.com>
 <YTo92+0ruBlkcaDf@zn.tnic> <1a73e0c2-8efe-fee9-5141-f7e9a95c748d@zytor.com>
Message-ID: <f59dbeee-8d2f-0964-90db-bf9c3c176763@zytor.com>
Date:   Thu, 9 Sep 2021 15:17:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1a73e0c2-8efe-fee9-5141-f7e9a95c748d@zytor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 2:28 PM, H. Peter Anvin wrote:
> 
> Because it is shorter and thus can fit more contents
> 

... into the visible part of the subject line, that was supposed to say. 
This is rather important when browsing logs, e.g. using gitk.

	-hpa

