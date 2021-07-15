Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79293CAF63
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhGOWtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 18:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGOWtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:49:19 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D610C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 15:46:26 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w1so6483527ilg.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 15:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PDRjDg+N0S3DSpjc+dVjqWHiIJo37OqBZ5jBNnXL3Qw=;
        b=dswt9SKj/DeGlkAO/cWq1G0Tu44eFfZRF9ygeqdmXH2JrCMjogNb+la+sTHq0BXBGp
         QGifXCrEp2yP5HaEAb/mGJMq8EmokITNqECk5nP72RVG3KoQV4k5w50sc7qJpm143kd5
         RlQ9YLqBp/QiyCpgZZl7t2BHrJ+1tWpVbS71Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PDRjDg+N0S3DSpjc+dVjqWHiIJo37OqBZ5jBNnXL3Qw=;
        b=TdY474+m8fbuoL1EL2bhuKWpbry+VaQU81n0T4o+y5+NJoDFcQSOTD2U6E9XfwMVnt
         cnBKdr86sUoFirt0xowq7x1nSf1jzqwWJ1X5lnEINfcr0fop0nSi0lc0vxt9v6xxbZgP
         pYHboNQYVuiWe0u2hHGr2lTj/75VuWhxjY8WvhCO5BteDLTjBcy5gfK1oH/XKNFgWGIa
         baht8xo5aLtw3vjC5u6rEeRSMu+Np+LvZWqzt00fYP81PF5iCZnnlTM52EnmlQsQukDs
         +tD+HGsbWs8gkW6XROBpW54i8pe1sri8cmSirHJM0d8DQhIPWIMYGCop4GRW4r+pehA8
         0bBQ==
X-Gm-Message-State: AOAM531lL+IkT1jah5vuadGGheiUtNcpyCTauLanoyXFh+OeiGBxPb4M
        IfRtzYbkwi8O7q6WFHghojtzpQ==
X-Google-Smtp-Source: ABdhPJx7P6a0LYSqkKYSdFlmz8AHCe00pCXoKXmmFdAGWiMrvBmoOQJpRHoWbP01KB3nomlOtYN4hw==
X-Received: by 2002:a92:d07:: with SMTP id 7mr4095367iln.114.1626389185702;
        Thu, 15 Jul 2021 15:46:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i7sm3511749ilb.67.2021.07.15.15.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 15:46:25 -0700 (PDT)
Subject: Re: [PATCH] firmware_loader: Fix use-after-free Read in
 firmware_loading_store
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     Hillf Danton <hdanton@sina.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+77cea49e091776a57689@syzkaller.appspotmail.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210708031321.50800-1-skhan@linuxfoundation.org>
 <20210709091721.1869-1-hdanton@sina.com>
 <d851dd11-1b4f-4ed2-bad2-0c267e3d6021@linuxfoundation.org>
 <3eb42554-c054-6e46-54ce-b9f637b72751@linuxfoundation.org>
 <20210715222817.tjsotu7fuhwz37ki@garbanzo>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d17eeb0f-a46e-2515-43a6-36c16002928a@linuxfoundation.org>
Date:   Thu, 15 Jul 2021 16:46:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210715222817.tjsotu7fuhwz37ki@garbanzo>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/21 4:28 PM, Luis Chamberlain wrote:
> On Fri, Jul 09, 2021 at 10:38:12AM -0600, Shuah Khan wrote:
>> However I am seeing the following over and over again in the
>> log - hence I think it is safer to check the aborted status
>> in __fw_load_abort().
>>
>> ? __list_del_entry_valid+0xe0/0xf0
>> [  348.604808][T12994]  __list_del_entry_valid+0xe0/0xf0
>> [  348.610020][T12994]  firmware_loading_store+0x141/0x650
>> [  348.615761][T12994]  ? firmware_data_write+0x4e0/0x4e0
>> [  348.621064][T12994]  ? sysfs_file_ops+0x1c0/0x1c0
>> [  348.625921][T12994]  dev_attr_store+0x50/0x80
>>
>> Also the fallback logic takes actions based on errors as in
>> fw_load_sysfs_fallback() that returns -EAGAIN which would
>> trigger request_firmware() again.
>>
>> Based on all of this I think this fix is needed, if only I can
>> test for sure.
> 
> Shuah, curious if you had read this patch from Anirudh Rayabharam
> and my response to that v4 patch iteration?
> 
> https://lkml.kernel.org/r/20210518155921.4181-1-mail@anirudhrb.com
> 

Yes. I realized I am trying to fix the same problem we have been
discussing. :) Sorry for the noise.

Ignore my patch. I will follow the thread.

thanks,
-- Shuah


