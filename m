Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AA53D7846
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbhG0ONR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbhG0ONM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:13:12 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E889C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:13:12 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id a19so15223373oiw.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lPTpnuj+ppZumvGjtpl0oB0H/8XOiTCJbt7CWslnhLA=;
        b=XpDpYVIkt0AVCpZFp5FWk53akyEhKr02ZeIRUGxc19tIGB/fhoFhPB6m9S/3/87k7i
         wksxucq8kcGG9l/zem9gE3yzBD0efxWZay5xJvT7lBNRXY3tX2CIb8YvDRokAGsEvWKQ
         UHViAihBmO5o9i7Zh23iSIvZdQ/x+xQTkg/aCFnWatZRc7CMRZ+sa1f8THXUmpY1tnYg
         tKL8capcstGohIdFAAJeM5fAUEzxGfdDXXcrqcpj8SCHyrL6lXw9iDH94DsUQmyV5x3W
         S1si6X1ukovnV0BxQsjj+3ZrsLk3Iz7SHxfBq6tu/OGxIrHEyAoZCM4h2DFV8W4HkOQQ
         9LIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lPTpnuj+ppZumvGjtpl0oB0H/8XOiTCJbt7CWslnhLA=;
        b=GglGOte63JxijH3LmqGWciSbj5dHIBGzZ2jLNhrrQmgPSyBXV7Fq+Z+pc9c3G0OgUw
         q0X38ZzDrxA+u6h1vdI9K5s0C8BUjilKhzjhW7bqg1QO2A2sybB0WmrjRUCL9Xkn5at4
         ceLb92tl0WD0pChL6V1dMTCjavmKFHBLKIBGZwQ4I3t8tsf+K5m8Xbl0f+X0Q3qQhY2d
         slQv6qSD8z6tmR/G+JxcN38jlLguO91czn4TMk1bLV8KS1KqlEH1XWQyKqww+tPFfGVS
         6JZ7PN7/STXStQh1swGwKKaVDZrw6GYo0p7QWgWuudhxUkw9aaIu7MAX/JiFxNukswym
         hFxg==
X-Gm-Message-State: AOAM530YbACNnlZL1dTYi08sNokKAj6g819GZ6d69PKr0dIrod4UFqzP
        +VRF5ODdntqqO65J+OGSY3o=
X-Google-Smtp-Source: ABdhPJyB4wRVeWtUXzf1LSUyASgAIPTQWcLkqiRubOnS7RsYTgu6pxGf3DuLNCZNl4cEdmT3myMRLQ==
X-Received: by 2002:aca:3f84:: with SMTP id m126mr2947710oia.129.1627395191543;
        Tue, 27 Jul 2021 07:13:11 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id y52sm527856otb.52.2021.07.27.07.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 07:13:11 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH v3 0/7] staging: rtl8188eu: replace driver with better
 version
To:     Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Fabio Aiuto <fabioaiuto83@gmail.com>
References: <20210724001055.1613840-1-phil@philpotter.co.uk>
 <YQAE1q9ZWRPHqfK5@kroah.com>
 <CAA=Fs0nwOBUoCSbwzaE7TTQab_BZcCy2SL1RJby+Hmo=URw_Pg@mail.gmail.com>
 <YQAOdEz9GfhpCeBZ@kroah.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <c42ded8d-8027-eee3-c1c5-54e0736a1758@lwfinger.net>
Date:   Tue, 27 Jul 2021 09:13:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQAOdEz9GfhpCeBZ@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/21 8:47 AM, Greg KH wrote:
> On Tue, Jul 27, 2021 at 02:25:34PM +0100, Phillip Potter wrote:
>> On Tue, 27 Jul 2021 at 14:06, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>
>>> On Sat, Jul 24, 2021 at 01:10:48AM +0100, Phillip Potter wrote:
>>>> I had to break this patchset up a bit to get around the file size limits
>>>> on the mailing list, and also I removed the hostapd stuff which is
>>>> userspace related and therefore not required.
>>>>
>>>> The driver currently in staging is older and less functional than the
>>>> version on Larry Finger's GitHub account, based upon v4.1.4_6773.20130222.
>>>> This series of patches therefore:
>>>>
>>>> (1) Removes the current driver from staging.
>>>> (2) Imports the GitHub version mentioned above in its place.
>>>
>>> Let's do (2) first before worrying about (1), given that we can't get a
>>> version of (2) that actually builds yet :)
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Dear Greg,
>>
>> I'm confused - v3 patchset builds fine for me after applying in
>> sequence from 1 to 7?
> 
> Why does kbuild report problems?
> 
> Anyway, please let's just add the new driver in a new directory, get it
> building, and then we can remove the old one.  That way patches will
> continue to work and there's no confusion when backporting patches as
> the code bases are different.

I get no kbuild problems in the staging-next branch. I have no idea why the test 
robot is reporting errors.

Keeping the old rtl8188eu directory and builds will result in 3 drivers 
competing for the hardware including rtl8xxxu, rtl8188eu, and r8188eu.

Larry

