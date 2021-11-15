Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1874544FEB0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 07:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhKOGgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 01:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhKOGgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 01:36:08 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9BAC061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 22:33:13 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id b31-20020a4a98e2000000b002bce352296cso5544272ooj.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 22:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nGtH8lM6I06P5khZiDCaAzoAZTuLqqNChjFkfWoolXA=;
        b=dURueV0S5219fUYRKHooL/2zN2N9MtJZSsyI27ZknViz8Glg7Pi6EZvMtRq9WN8QAW
         OuK9DyciMEgmk/C8b1WGLjx10cbUo7m/aalNKrtQSvFaJw7TzUrhv+l0hB18o+y++uO/
         wUwYfGyRaoWC2BKwcOGOi0PVlojjJwCYqgwKsoRO2wdnIAL4tx3z31o4tsU4vyuAlgMt
         SUohA1U606GUtyBBkkS3een3PXfykpb8IyLPV3p4idhEUvswtZf3BMvxq/eWMHWPONf6
         zDXcQ84fQuZFxHU9t1SV812KnhUZGkF91lJoxSrWsGdW3lTEgP+tSBrGkTRpuFHY4uLp
         tzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nGtH8lM6I06P5khZiDCaAzoAZTuLqqNChjFkfWoolXA=;
        b=2I0oLmG2NxlV/roVwF0DOi5fcpHrJgNhOG1bUZ1kfDzer3oYQuSemTAEzITqtPR+nR
         A4k84PAawEME2vFFQmOIERA/f62RxUQslmvPBT4b0WHE1cbH+C7L2r+FCq39wF9lPItX
         hO2igAAOtZipaMVb0i711H6jgBa9N8Pyb1FAqkllCSgaxgr5mO7+AhbUHfOR6oHQ/5gy
         l/tFLo3S8lFDjh3fvv56vXzUDhNfvX8zTYDOAHwhgPIAx1X6IX1/KN/1wrwtJQPd8xhh
         a5v2OciEznyWZI31hWZ6lMCR2QkPpP+juP1wfTwd8KKmWXqAd95gMbxrkMVxFP9ZGqzj
         D1Ug==
X-Gm-Message-State: AOAM533sAG9bms/08Ne6dX8iID3/gFTWXLlM0bCaDnU09WWo0evAaSfL
        VWVF1baS6dInrmz5VJLXiTIxy8jWqhg=
X-Google-Smtp-Source: ABdhPJwtXxLMo34syrE2xA4sV0cFK9joTUR4LCv9LH1x+dFV4BKWEe0mppZE4kJ5/s2tIW+0gC2+bA==
X-Received: by 2002:a4a:6215:: with SMTP id x21mr18632046ooc.16.1636957992427;
        Sun, 14 Nov 2021 22:33:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b1sm2780772otj.5.2021.11.14.22.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 22:33:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: Linux 5.16-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net>
 <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5c543c8d-5e6a-1b90-7498-816a2cab8c81@roeck-us.net>
Date:   Sun, 14 Nov 2021 22:33:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/21 9:21 PM, Linus Torvalds wrote:
> On Sun, Nov 14, 2021 at 8:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> With gcc 5.4, mips:mapta_defconfig
>> mips-linux-gcc.br_real: error: unrecognized command line option ‘-Wimplicit-fallthrough=5’
> 
> This (and the gcc-6.x ones for sh4eb/sparc/xtensa) are already fixed
> in my tree. They're all "old gcc didn't support that flag" things with
> a trivial one-liner fix.
> 
> I was hoping you didn't have older gcc versions, but you clearly do ;^p
> 

I have to, for qemu. In some cases the new compilers don't work with
old kernels (eg sparc) and I prefer to use a single compiler for all
kernel versions, in other cases newer versions of gcc have trouble (sheb),
and for xtensa building a compiler that works for a given hardware model
is tricky so I try to avoid it as long as I can.

Guenter

