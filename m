Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9132C3DDB7E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhHBOtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbhHBOts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:49:48 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578B6C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 07:49:39 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id x15-20020a05683000cfb02904d1f8b9db81so6132593oto.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=otW4PBFzPFP9S9Ll8i9O95kKgdyBa3g6lebgB3vbVvk=;
        b=d6CAnGX8yOnGG/zxuBmSZOHU4DNyBI4ifgTPny+0XVmbMv+ib7OFp8CJWMyZf4AhOC
         ZLnO0IyakO4PvT4yXKtoMZJ94cmEO+Wm2H4yVJMxeYnWafGLyLJRsStJks1d2N+sGT7a
         ayOuWHALni5bXJUGAFDswJiLGq6Z/LYgiQ4O82JTQmb6muNTjAYX6R1f0L4Rictqs9m2
         AmvBdTUA2WXZQwxgjDJVZ4brlEIZyzP4EnfP1FgBe/4HOQ8k/IREeVdUGn5pcykn4q8G
         Jv6mE8WPul5vudDCn9j6DP+UVzUx5lZ2FKZ1Fj4Swsz9xEJ6sh4cnyW9qhDM5O3FFq8u
         wF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=otW4PBFzPFP9S9Ll8i9O95kKgdyBa3g6lebgB3vbVvk=;
        b=j1B3KnZ6qb6Bbe3SszoRmTtll7WbUFjugEFOWDBlCkpuexVCVaLGoNkBjVUB3az0YA
         mhNKCzTRhD7YcuQAPNko5iiIRwKsbCptDWo9SHBIyYmnX19MlpaK2Lwn995YpyOhcqHT
         /bYsJKOI52evM13p2VHvS7ly0LssbOV5GlmsG3CC01fDDZYGFY6xD0gVJSqxcRfc3U3k
         MnCte8Sqd4wgoe1VsNunnxVSW+GG4WgeuC3ESBKQ94D35ciMIBzgWAIQX0Grt0Tugjhs
         hcZjbviA8nGuU5WkxpZZq+HPEpBYfc0PR1lZo1KDdeEb3lFsj6acfUmkWuG17RIvuP6g
         0ejg==
X-Gm-Message-State: AOAM532lGH3OKuxYhCboP2zGbsJgBcfjLeWPgd2uVh0GynYpu+Gx/O1t
        vF2Rux+2DexVTS1HyGMSGJQ=
X-Google-Smtp-Source: ABdhPJwkQa8mzAtjz83cHzUjPFU6MFgJDPI5BdaOOjjsKW/OqSD1pczoT3uqI231xEy9CyWBZSiqug==
X-Received: by 2002:a05:6830:19ca:: with SMTP id p10mr12194541otp.267.1627915778708;
        Mon, 02 Aug 2021 07:49:38 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id w35sm1879354ott.80.2021.08.02.07.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 07:49:38 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: kernel BUG in new r8188eu
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-staging@lists.linux.dev
References: <80042e9f-6811-38f3-010b-1c0951ba88db@lwfinger.net>
 <YQThm1A0Up1m4l1S@kroah.com>
 <c2a6746a-24e6-6888-9208-32fccebb3fec@lwfinger.net>
 <YQY/tfJJdBVg/mwf@kroah.com>
 <cef19337-5ff3-c0cd-33ef-4f9990bcd4ec@lwfinger.net>
 <YQfKohnSRWHjlht6@kroah.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <4f3e91f4-3d7b-a580-3134-757614d92491@lwfinger.net>
Date:   Mon, 2 Aug 2021 09:49:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQfKohnSRWHjlht6@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/21 5:36 AM, Greg Kroah-Hartman wrote:
> Ah, doh, that was my fault, sorry, that patch was incorrect (odd git id,
> don't know where that came from, it's a different id in my tree.)  Let
> me revert this commit and then will redo it correctly.
> 
> thanks for finding this.
> 
>> There are lots of these on Ebay from $2.47 up with free shipping!
> Any hints on the name for how to figure out which devices are supported
> by this driver?

I do not why my git id did not match yours.

It was no problem. After I determined that the original code was correct, it was 
an easy bisection - 6 cycles with only r8188eu needing rebuilding.

The driver supports RTL8188EU and RTL8188EUS. The name comes from the 8188E, and 
the U means a USB interface. The S indicates a new design that appears the same 
to the driver.

Larry

