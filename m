Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B343B3AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 03:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhFYB5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 21:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhFYB5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 21:57:46 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45F6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 18:55:26 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i6so6802350pfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 18:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DgvXn3PwiL33+V2MPigrwm2vtPfix09cjVm/yIwhB0s=;
        b=s504KnWSPBnvlcVjrEkj0svXJJPV6FPA89XUVCkhTJUFi3FXCxXk0vrr+kE/IWAQLw
         COILHQO/0uk6k4XjWfxli245zRoL5KQrd3PzK9eyzyl69Dc44ZS90zepOBMSuPFKqNdC
         NPqrg9y7CMaLdTSygxpqPWstw4cIfQtBJp5qV50EzWtU6QgDeUdyik0NdWC4dBXlYf+7
         XsGa0Nsow2vmK8WHFEroSERvbLoGgxq15Fn02eSDy+uiO2b5cvI6duDNHv4e3KTBmMFE
         mHesyVocr9PpxKjE4gWng4Wxb3CbAKBGZuf53Xc8lK4WGIWUyIdBedPkVn0kVV2qe21z
         FXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DgvXn3PwiL33+V2MPigrwm2vtPfix09cjVm/yIwhB0s=;
        b=RfLvwvBA7rA3+tMh5WKWRrI5tsvH23wDx/fZHEx3re/1tCggR7X+73cx23g7DmjhDy
         E2Cz+0/CxCGAVCijHliZtauN8v3vroJcolpYJy0232NjxRRM+9GJNBXEjsIHxRM0Zj+X
         z/2U+7C6+y1YCNOkhYcsvlLWaVXp7ShtXEk0pr5dkA4auGzMFP+NpGNqCDlG54xka+iA
         MYJKKfi7L3garZ3P7WBpFYkPf743Vm5RD9R+DTYiVCj+rNMQaIBjsM2jO5T3cbvrSiym
         3mLPfOHLktbycnvGuocQXBD0ztNvShqZWYWosaH9ojqoPATn01Bb1wU7lkjpzNbhZhdt
         eVcw==
X-Gm-Message-State: AOAM531H052zD7+SGkTJ4w3lT1PZ2Z2h0UVb8oa3KlSPERS8KlkyZuiU
        nf2Q2djfDyRqH1qJRfYEt5YM6A==
X-Google-Smtp-Source: ABdhPJyEk9Rv3KTOVxXC0NHAHj1jU5hyD7crHmZ2gsBN42qlG53UAeVEt8i2HW6LabaIKUQoWsPqjw==
X-Received: by 2002:a62:5444:0:b029:2e9:c69d:dc64 with SMTP id i65-20020a6254440000b02902e9c69ddc64mr7771482pfb.32.1624586126291;
        Thu, 24 Jun 2021 18:55:26 -0700 (PDT)
Received: from ?IPv6:240b:10:c9a0:ca00:55ca:cffa:65dd:ae53? ([240b:10:c9a0:ca00:55ca:cffa:65dd:ae53])
        by smtp.gmail.com with ESMTPSA id n69sm4037663pfd.132.2021.06.24.18.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 18:55:25 -0700 (PDT)
Subject: Re: [PATH 0/4] [RFC] Support virtual DRM
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        devicetree@vger.kernel.org, Takanari Hayama <taki@igel.co.jp>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>
References: <20210621062742.26073-1-etom@igel.co.jp>
 <7cde82a9-c60c-e527-eeac-eaad0c5842a1@metux.net>
 <1cfab5f9-f275-aa53-00de-5da3fcea71c5@igel.co.jp>
 <20210622111239.73aa87aa@eldfell>
 <ee0161b5-c88b-40ce-c02f-86e0927b70bb@igel.co.jp>
 <20210623113922.1e603139@eldfell>
 <ab816c34-ff98-911f-e53d-b91cd3be6f2b@igel.co.jp>
 <20210623144115.1bc55db1@eldfell>
From:   Esaki Tomohito <etom@igel.co.jp>
Message-ID: <b212df8e-4e71-9cb5-d796-7f5d1e193b7e@igel.co.jp>
Date:   Fri, 25 Jun 2021 10:55:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623144115.1bc55db1@eldfell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/06/23 20:41, Pekka Paalanen wrote:
> On Wed, 23 Jun 2021 18:22:47 +0900
> Esaki Tomohito <etom@igel.co.jp> wrote:
> 
>> On 2021/06/23 17:39, Pekka Paalanen wrote:
>>> On Wed, 23 Jun 2021 15:56:05 +0900
>>> Esaki Tomohito <etom@igel.co.jp> wrote:
>>>   
>>>> Hi,
>>>> Thank you all for your comments.
>>>>
>>>> On 2021/06/22 17:12, Pekka Paalanen wrote:  
>>>>> On Tue, 22 Jun 2021 13:03:39 +0900
>>>>> Esaki Tomohito <etom@igel.co.jp> wrote:
>>>>>     
>>>>>> Hi, Enrico Weigelt
>>>>>> Thank you for reply.
>>>>>>
>>>>>> On 2021/06/22 1:05, Enrico Weigelt, metux IT consult wrote:    
>>>>>>> On 21.06.21 08:27, Tomohito Esaki wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>       
>>>>>>>> Virtual DRM splits the overlay planes of a display controller into multiple
>>>>>>>> virtual devices to allow each plane to be accessed by each process.
>>>>>>>>
>>>>>>>> This makes it possible to overlay images output from multiple processes on a
>>>>>>>> display. For example, one process displays the camera image without compositor
>>>>>>>> while another process overlays the UI.      
>>>>>>>
>>>>>>> Are you attempting to create an simple in-kernel compositor ?      
>>>>>>
>>>>>> I think the basic idea is the same as DRMlease.    
>>>>>
>>>>> Hi,
>>>>>
>>>>> indeed. Why not use DRM leases instead?
>>>>>     
>>>>
>>>> In this use case, I understand that this is not possible with DRM lease,
>>>> am I wrong?
>>>> I understand that it’s not possible to lease a plane and update planes
>>>> on the same output independently from different processes in current DRM
>>>> lease.
>>>>
>>>> If this is correct, what do you think of adding support for plane leases
>>>> to the DRM lease to handle this case?  
>>>
>>> Hi,
>>>
>>> I would love to see support added for leasing individual planes,
>>> especially to replace the virtual DRM proposal which seems to be
>>> eradicating everything that atomic modesetting and nuclear pageflip
>>> have built over the many years.
>>>
>>> However, please note that "on the same output independently" is
>>> physically impossible. Semantically, the planes define what a CRTC
>>> scans out, and the CRTC defines the scanout timings. Therefore it is not
>>> possible to update individual planes independently, they will all
>>> always share the timings of the CRTC.
>>>
>>> That combined with KMS not allowing multiple updates to be queued at
>>> the same time for the same CRTC (atomic commits and legacy pageflips
>>> returning EBUSY) makes the plane updates very much inter-dependent.
>>>
>>> If you want to avoid EBUSY and have planes update on the vblank you
>>> intended, you really need a userspace compositor to pull everything
>>> together *before* submitting anything to the kernel.  
>>
>> Hi,
>>
>> Thank you for your comments and advice.
>> I will consider leasing a plane.
> 
> Hi,
> 
> I wish you considered a userspace compositor first, once more, with
> passion.
> 
> It does not need to be Weston, and it does not need to use Wayland.
> Just a userspace daemon that owns the whole display device and somehow
> talks to whatever else wants stuff on screen.
> 
> I have not seen any evidence that leasing individual planes would do
> you any good. I can easily see it doing you harm. I'm only saying that
> it would be better than the virtual DRM proposal if you absolutely have
> to go there. Please, consider not going there at all.
> 
> "On the same output independently" is not possible for the very simple
> reason that the pixel data needs to be streamed serially to a monitor.
> 

Hi,

Thank you for your advice.
Once again, I'll consider a userspace compositor first.

Best regards
Esaki
