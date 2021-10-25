Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F122E439DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhJYRtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 13:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhJYRtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:49:17 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719F6C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:46:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id l203so6720206pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lRCLonp2m0ZX/kiQpm22eJ4VdDoH6ZXlTAQKw42QYHM=;
        b=BkvodgijNEcYV6LipVkdNO7Uk4Gx5XoOY1SvowNsr2pVsYsfL8JLEnIE0jMiw407lz
         4m4sCoHuxvK/rByGutr3rZokoqC60KIr11xvgf1chF8oP286qMReKqjJ7mdLwfEltm86
         nwxmTqxC5KIM+lEVFg76qtEUn4pyVk9V2pj8LU6iJ1zXIgXoy/DqoBUsIE3V6M/sOYSF
         uspWDNr5qUJJr2wLPtdOcsr7VUmEhwEzPIYMqPzrjXCb6af5oN+gVW9GXY159fmy7kul
         Jqwkl0zQtkklB7JCtKH+ZQjH5piDGedizoE6FirWiAedgse2zc+Ds3CO2eCqz/Dr0eGc
         v3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lRCLonp2m0ZX/kiQpm22eJ4VdDoH6ZXlTAQKw42QYHM=;
        b=Av+xJOOTXSuV3y5MkYsrIcqRvywIQ3vUQP1noKQolhEjQaZNV8BtXRrk9orXoA0o4u
         eyu0r80xTAklNSyMaAAqmIuOnLuDaJTRwfhxlqbO6znxzqYVyBUsTSvUtZWTcVsMPLjO
         4H3JAsRZLWOCSmb+WRn9J+vNPIveb30PKgJnsrfVUk2BOkvScH0g5hZDZ+2ysHfhI0uM
         k5TkefIfKoHIxln0glRsVd9pQgvfqW1S3JRPRQThoPh2acajdrVc3WrskZYdQ54Qt/6T
         slc20PduSeBbKrJ1SdzgGfHWHaSGaCWDcfERXzkXy9oJKUDTLN+S08790uLNsA+uf54A
         AEzg==
X-Gm-Message-State: AOAM531zl8/qUhLzd79Gf8uN3zY2ofWsQfxC0a5DRyCYblcgzE51nl7c
        eMniCjB/no17+fJcV6AtGGu2n2a6CJ4=
X-Google-Smtp-Source: ABdhPJzQWu/Q2DLK/fUyYZu+CvIe9LlEWeg7Z5LQxaYwtsg8Ymyq1d9sYVLhL3DGgCunbixrc1IkKQ==
X-Received: by 2002:a05:6a00:198b:b0:47b:ac2d:68f4 with SMTP id d11-20020a056a00198b00b0047bac2d68f4mr19545483pfl.1.1635184014896;
        Mon, 25 Oct 2021 10:46:54 -0700 (PDT)
Received: from [192.168.1.4] ([59.95.95.35])
        by smtp.gmail.com with ESMTPSA id b10sm20770695pfl.200.2021.10.25.10.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 10:46:54 -0700 (PDT)
Message-ID: <896901f9-7659-7e05-ab61-2a76b76e999e@gmail.com>
Date:   Mon, 25 Oct 2021 23:16:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH] staging: r8188eu: core: remove goto statement
Content-Language: en-GB
To:     Larry Finger <Larry.Finger@lwfinger.net>, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YXafzp5F8T7/+tk2@Sauravs-MacBook-Air.local>
 <7dc4eba4-c009-b8b7-bc08-5b608bdf86a0@lwfinger.net>
 <e2020caf-1b0c-ce0e-3d94-d105be85ed38@gmail.com>
 <de1bddd8-8e09-4b8f-1fd8-ae9047e60269@lwfinger.net>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <de1bddd8-8e09-4b8f-1fd8-ae9047e60269@lwfinger.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/10/21 10:56 pm, Larry Finger wrote:
> On 10/25/21 12:00, Saurav Girepunje wrote:
>>
>>
>> On 25/10/21 8:45 pm, Larry Finger wrote:
>>> On 10/25/21 07:15, Saurav Girepunje wrote:
>>>> Remove the goto statement from rtw_do_join(). In this function goto
>>>> can be replace by return statement. As on goto label exit, function only
>>>> return it is not performing any cleanup. Avoiding goto will improve
>>>> the function readability.
>>>>
>>>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>>>> ---
>>>
>> Hi Larry,
>>  
>>> You need to read section 14 of Documentation/process/submitting-patches.rst to learn how to submit a revised patch.
>> Resubmitting such a revision using the same subject line is likely to confuse reviewers and maintainers alike, if not patchworks.
>>>
>> This is original patch (v1). I haven't get any review comment for this patch.
> 
> Why did I get it twice? At least I got two messages with that subject line.
> 
> Larry

I checked on lore.kernel.org . It is one patch with subject "[PATCH] staging: r8188eu: core: remove goto statement"

https://lore.kernel.org/all/?q=Saurav+Girepunje

Regards,
Saurav

