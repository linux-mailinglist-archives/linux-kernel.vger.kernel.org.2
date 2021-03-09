Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C8C332586
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhCIMd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:33:26 -0500
Received: from smtpweb146.aruba.it ([62.149.158.146]:54070 "EHLO
        smtpweb146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCIMdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:33:19 -0500
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id JbY4l71r51jmzJbY5l3Ryc; Tue, 09 Mar 2021 13:33:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1615293198; bh=j3heIUHIr7biLXov/TrN9B4E4bRdSkSc8d1BvpiMePs=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=akta9IbcUohSJOWtmnbLkzllVd+viGpW6snF3ZHUon2tYYbVh+mimzPyHRS54dCq1
         4fpZ55VNZFeYhPxrl/EkXXWdYSfvm2hRHRHOj/Yq0DF6gU/P58ucw00MVztSvrfhbw
         Ky/zLxQnBvHQY4SCu3NlpO3NYF0bRW+rfqc304VpblJ5tHE/I6hS7SyfO+4IQw8GwS
         vgHCvKwOAaw7ponHUxfh4LqL2voNCBe2EvrTTVfZv7CUEgBd3AmtFddn5tNKS1Spze
         YIc9slsNRYyrMmDy/z9kOChKbAdXdXY/frQnS03/2WO2VoBapB7/S6geP1jCdKM+Hi
         LlY4DD8BEV6+A==
Subject: Re: [PATCH v1 1/7] pps: clients: gpio: Bail out on error when
 requesting GPIO echo line
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
 <YDkp5Jh8ZXWgr+zl@smile.fi.intel.com> <YEdSVD+hU+Il5W/7@smile.fi.intel.com>
 <ca333fca-e2d2-c2fd-fa4f-8238ccef1be1@enneenne.com>
 <YEdb0z/SJLknJlrp@smile.fi.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <67148ebf-7230-7fcd-02d2-0eee68587478@enneenne.com>
Date:   Tue, 9 Mar 2021 13:33:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YEdb0z/SJLknJlrp@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOfWwRsXII+VZRog9b7YRjeiBcoR0zGf4CIG7/wjt95W4JwsdcCdniLprfp+y62KlgW5Z806MxXp/vIjdM9/HinlP/IpzFMqK15G7exCVZr9wdMMbExs
 BmfICwieujLyYL19F/f8gBWeEfKZxem4UMSnv/g6eu+3RDVQRRqofFgFZPelxD8+2QtBLsl7hHR/HWbghdM6uFLoSNsBahXRdi241iSOEpgHNYH01ScdEtI1
 /JHQtwbBwNWyCwRZuwRXr7f0iSyZsHjxn4OHQaEMiMyHcD3w05ANnQVshoRNOJAX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/21 12:28, Andy Shevchenko wrote:
> On Tue, Mar 09, 2021 at 11:51:58AM +0100, Rodolfo Giometti wrote:
>> On 09/03/21 11:47, Andy Shevchenko wrote:
>>> +Cc: Greg
>>>
>>> On Fri, Feb 26, 2021 at 07:03:32PM +0200, Andy Shevchenko wrote:
>>>> On Tue, Feb 16, 2021 at 01:31:48PM +0200, Andy Shevchenko wrote:
>>>>> When requesting optional GPIO echo line, bail out on error,
>>>>> so user will know that something wrong with the existing property.
>>>>
>>>> Guys, any comments on this series?
>>>
>>> Greg, seems PPS maintainer keeps silent, can I route this series thru one of
>>> yours tree (resend implied)?
>>
>> I'm sorry but I suppose I missed this patch... -_-'
> 
> Entire series (7 patches) has been Cc'ed to you :-)
> 
>> Can you please resend it to me?
> 
> Okay, I will resend with Greg included just in case.
> 
> Done!

Thanks! Got them and acked. :-)

Sorry for delay.

> For the future, I recommend to switch to b4 tool (most likely already in your
> Linux distribution), so
> 
> 0/ Install b4 tool (if not yet in distro: `pip install b4` should work)
> 1/ Find message ID for the thread, for example,
> 	20210216113154.70852-1-andriy.shevchenko@linux.intel.com (v1)
> 	20210309112403.36633-1-andriy.shevchenko@linux.intel.com (v1 resend)
> 
> 2/ `b4 am -s $MESSAGE_ID`, replace $MESSAGE_ID with one of the above
> 3/ it will download a mailbox that you may apply with `git am ...`

Uao! I'm going to use it for sure! Thanks.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
