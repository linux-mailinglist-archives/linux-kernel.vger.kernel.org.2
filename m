Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99F23F5366
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhHWWdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHWWdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:33:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E13C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:32:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d26so8053496wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QK0nYGFUqHQWTFniaZjb4pWhF5u+zRG36OlmvbNcxZA=;
        b=sf/88eEMM0Xnn1lTkkbFnuTTbaIsl14zVPV8vlQJ/Q2f1R7YJc3ILd9iu6Qroy7yyF
         d+FJkgoxQ3xVulEc+lQA1722L5QOsBjK8O+JGxiHR0ut2e0RlwVNZBQAKWcl1kIppTgi
         2x0z9EFanDIrJxWFiOVBRhnMIOVhLF57Re0ZvGH3j+7q4SA6hV4Haq8fvHW/v61qRmam
         zKQhcP2hnCy6EhRE3NSdDSi6pj71sxRuVJXV46IkBuwPCqaJNazBxxeXhdtK9XAE28A4
         q1rar5VjUjN/letnmHWIhSSv9TeXsDoEVDJPFCs9rY6AMNJqotZw/CsmHCUafsUjzYCu
         AgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QK0nYGFUqHQWTFniaZjb4pWhF5u+zRG36OlmvbNcxZA=;
        b=K85xxzGX8xgksRrQZ41flKY5u7qcTIAtAfzEyL5cv89lVP4MQzdtBZvqXyYv7yOMPv
         Qx7EcsbbEECHzwoW+n//i/8/yPZyTxntkV5HEYq1sYLmQrEed+Z43hNPGkArO9eB8s7Q
         TCST7FWh8jbiabbcC9UjIfRtYKobqofIobBaSfxFf3HthvgsjNZHAG4Fl665hSdfWWfn
         Hx+JwXI7PvrN7qobG4UaovijmnyKfr+usdkYQ6Oy4dbEXYlNxTKNwvtY037XHyJaS86X
         fK9FPWtwgPvVzHB3y2Ku3KHFJ4G2qJQs79xtMR0qMrxV+qk+tEAWeZl218QpoH2yiW69
         8a3Q==
X-Gm-Message-State: AOAM532ruaXC0tTY9z5c9dfnLOg7Dw3H0ZXoalcCSmqmoglJf++HyEsY
        2+ztdekSaGW7WHgcc/+tXewl7E88WlI=
X-Google-Smtp-Source: ABdhPJzmoD8YZhYtINsMDgdK3AKcXG2TGCinOiK2YoBxHXKoeMeyzgazs5kxGBm9URIoajPiXs0Pvw==
X-Received: by 2002:a5d:5144:: with SMTP id u4mr16377802wrt.30.1629757940288;
        Mon, 23 Aug 2021 15:32:20 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::687e? ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id a5sm458608wmj.30.2021.08.23.15.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 15:32:19 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: remove ip.h header file
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210823081820.9724-1-straube.linux@gmail.com>
 <CAA=Fs0=6=ueb53iNhyjSE5B8CdQvrpijgihAaN9YVwdDgNGiFA@mail.gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <cb8d08f7-c27c-d6f3-1128-4047350d6871@gmail.com>
Date:   Tue, 24 Aug 2021 00:31:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAA=Fs0=6=ueb53iNhyjSE5B8CdQvrpijgihAaN9YVwdDgNGiFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 12:21 AM, Phillip Potter wrote:
> On Mon, 23 Aug 2021 at 09:19, Michael Straube <straube.linux@gmail.com> wrote:
>>
>> The struct ip_options declared in ip.h is only unsed in the optlength
>> macro which is also defined in ip.h. All other definitions/declarations
>> in ip.h are duplicated from <include/uapi/linux/ip.h>. Remove the ip.h
>> header file and its includes.
>>
>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>> ---

> 
> Dear Michael,
> 
> Thanks for the patch. Sorry, but it seems to conflict with your
> earlier patch titled: "[PATCH] staging: r8188eu: remove if_ether.h
> header file". They apply fine individually, but not together - can you
> confirm this is the case for you as well and not just me?
> 
> Regards,
> Phil
> 

Hi Phillip,

yes I can confirm, sorry about that. I will rework and send both patches
in a series. Thank you for testing and pointing out this conflict.

best regards,
Michael
