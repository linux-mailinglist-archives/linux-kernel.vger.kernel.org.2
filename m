Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6339283A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhE0HOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:14:50 -0400
Received: from foss.arm.com ([217.140.110.172]:53154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234709AbhE0HOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:14:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1445A11D4;
        Thu, 27 May 2021 00:13:13 -0700 (PDT)
Received: from [10.57.31.236] (unknown [10.57.31.236])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 011343F73B;
        Thu, 27 May 2021 00:13:10 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] EM / PM: Inefficient OPPs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <20210526034751.5fl4kekq73gqy2wq@vireshk-i7>
 <068fa9c4-2b55-3d75-adc7-cf5ef2174b12@arm.com>
 <20210526093318.cbtjkybzwdchxi5y@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a5882c26-ad1c-8e95-e529-f45fcc46099f@arm.com>
Date:   Thu, 27 May 2021 08:13:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210526093318.cbtjkybzwdchxi5y@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 5/26/21 10:33 AM, Viresh Kumar wrote:
> On 26-05-21, 09:56, Lukasz Luba wrote:
>> No, these OPPs have to stay because they are used in thermal for cooling
>> states.
> 
> This won't break the thermal tables. Thermal just sets the max-freq for a CPU,
> and it doesn't depend on the OPP table for that.
> 
>> DT cooling devices might have them set as a scope of possible
>> states. We don't want to break existing platforms, don't we?
> 
> I don't think we will end up breaking anything here.
> 
>> We want to 'avoid' those OPPs when possible (no thermal pressure), but
>> we might have to use them sometimes.
> 
> Why would we want to use them if they are inefficient ? Thermal or something
> else as well ?
> 
> More in the other reply I am sending to Vincent.
> 

I have responded to your email there. I don't know if you have seen it.
As I said there, these OPPs, which from energy perspective we call
'inefficient', might be used to provide enough performance under thermal
constraints.

Regards,
Lukasz
