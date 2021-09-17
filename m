Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D888B40FC26
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhIQPYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbhIQPYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:24:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3907C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:23:26 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i25so34841730lfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qme74H7nTKZWlp83x/X8Ld8D+VkxfyGb4OUt72XjpFA=;
        b=OtB0kyPv+JFXBLnXN0XEadsFWqc30HEaRDwF/JCOjutgsVRFnqKE0PXMpt/e7jpD01
         CGHB2+GcbMlnn/+i0X2YJn5Hj/x3xObEAbXeYQ0qMX2HzsMP04nL3qE7dMysbW7MVj6f
         Y5pOjqmfrmDPx/YVI7GVWqHhl2aguApFxxVFB77FUoFKw4wl6TltxjD0d3LhBXVP3ItU
         lLLOFcDANp+HFuw7mxIOMXucjhkZHRb4HNKRirS7foi0FtHRyEhPGxycjerslv3iUTWu
         oPLjNU36vcEcspz9fpfkZBoJ8c7Hwwi38Aa22YupyGeoQdqfyNoq1N9wvRTbK9TG0DRo
         DD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qme74H7nTKZWlp83x/X8Ld8D+VkxfyGb4OUt72XjpFA=;
        b=sAIb0efnlsc0tKGhRIIo8p/NLEE1/fqKSJdd+ieLtdh0Y/g+Ynk0g8W0z9CdwlXRip
         cDyBeTKhEwm3R2f2JGxSvPqCuocGq5BSgGGdqig7Em6AOFCgqBFcl1/Gnh+oiMSMrjsn
         p3J7ESXjuk5AAaRWsh8Wx5sTSciPvrVFLpSU30QroS3TJf2dqZYXXBxuICcVynOMD05L
         xCOWNmNWHJmlOJPiLWnwOzKfqqzWy8ab+yqZ7qbZTMdpVHWCLnv3wDe2csoEbifpMYim
         fwBMiTi3fD6ACdl+OIjGReHZQk+KvUsO3zP5RC5vi+5WPwv5Z6R8VSIrXBQYcvOPopT7
         yFmQ==
X-Gm-Message-State: AOAM532ucUoIv2HiuUcF0DekTTYoUxOLrvmmNSVmoO7gk2MPPC2ZR5yH
        j6LlChcApnOKyatYczZZ/cI=
X-Google-Smtp-Source: ABdhPJynBeK8RH+6fgWWVCBlVAZnebACzwigzUuAYmQrX4X7UsXvmmU9qG46o0NTQJEyaLLqdLtoJw==
X-Received: by 2002:a05:651c:10a2:: with SMTP id k2mr10643964ljn.262.1631892205128;
        Fri, 17 Sep 2021 08:23:25 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.49])
        by smtp.gmail.com with ESMTPSA id b15sm552549lfp.221.2021.09.17.08.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 08:23:24 -0700 (PDT)
Message-ID: <4e39e4ef-995d-49ce-58d6-75fd6a27da96@gmail.com>
Date:   Fri, 17 Sep 2021 18:23:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v7 19/19] staging: r8188eu: remove shared buffer for usb
 requests
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
 <20210917071837.10926-20-fmdefrancesco@gmail.com>
 <YUSsa+3NjQVGD9gb@kroah.com> <ef2a89f5-f68c-e7e2-9338-78e70dc41701@gmail.com>
 <YUSxtQ7D0w6QkB/N@kroah.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <YUSxtQ7D0w6QkB/N@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/21 18:18, Greg Kroah-Hartman wrote:
> On Fri, Sep 17, 2021 at 06:03:52PM +0300, Pavel Skripkin wrote:
>> On 9/17/21 17:55, Greg Kroah-Hartman wrote:
>> > On Fri, Sep 17, 2021 at 09:18:37AM +0200, Fabio M. De Francesco wrote:
>> > > From: Pavel Skripkin <paskripkin@gmail.com>
>> > > 
>> > > This driver used shared buffer for usb requests. It led to using
>> > > mutexes, i.e no usb requests can be done in parallel.
>> > > 
>> > > USB requests can be fired in parallel since USB Core allows it. In
>> > > order to allow them, remove usb_vendor_req_buf from dvobj_priv (since
>> > > USB I/O is the only user of it) and remove also usb_vendor_req_mutex
>> > > (since there is nothing to protect).
>> > 
>> > Ah, you are removing this buffer, nice!
>> > 
>> > But, just because the USB core allows multiple messages to be sent to a
>> > device at the same time, does NOT mean that the device itself can handle
>> > that sort of a thing.
>> > 
>> > Keeping that lock might be a good idea, until you can prove otherwise.
>> > You never know, maybe there's never any contention at all for it because
>> > these accesses are all done in a serial fashion and the lock
>> > grab/release is instant.  But if that is not the case, you might really
>> > get a device confused here by throwing multiple control messages at it
>> > in ways that it is not set up to handle at all.
>> > 
>> > So please do not drop the lock.
>> > 
>> > More comments below.
>> > 
>> 
>> We have tested this change. I've tested it in qemu with TP-Link TL-WN722N v2
>> / v3 [Realtek RTL8188EUS], and Fabio has tested it on his host for like a
>> whole evening.
>> 
>> I agree, that our testing does not cover all possible cases and I can't say
>> it was "good stress testing", so, I think, we need some comments from
>> maintainers.
> 
> Ok, then make it a single patch that does nothing but remove the lock so
> that we can revert it later when problems show up :)
> 

Sure! Thank you again :)




With regards,
Pavel Skripkin
