Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0111834ABC5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhCZPqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhCZPqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:46:37 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F66C0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:46:37 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id c17so5392386ilj.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9neBGUkGjeI9Wss3qn32vtUKfxnPNKgHyjXqvLAXo2U=;
        b=JF80Equ1gB3yG7jN/+29x9IlqK4Ui20FfaAFAYDVBr0IKlN1ib3rKnf5J2Pm9h5g9d
         DV0tmCOoETubjqAjQsuSM4Q9S0I5KKukBEA/TRN266CKIE/RyqbtOBX8XNv/YkuqryiN
         yZ4Stevs8aLoKsEUf9JUB6FJswGgu9rAMtmStyu8UrPbW4wG05UepFTwnRJNFhDUCVjW
         1g00yZVOV7FFZIDkVjHtzMrdCYJpGo1RugDXqeY3sLPHgA2DXdWgGsF0ahl8ZlXJi278
         m2v/K2KtaZ3ohgiUrxngmEsnsZtsVL/kXWE1bcmTVKDV8WKw8EK67lU8SaXivUVKiOF1
         /58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9neBGUkGjeI9Wss3qn32vtUKfxnPNKgHyjXqvLAXo2U=;
        b=ZQztiImQCElnMBlEWe7zlOwzGeJEopShRAM98LH40SrYZa9SAdtyFyZUL0YQaajkQu
         AL3uzOZidhHg07OQOi8jw6qJn6R2QiR6uCHayHSXYGq2cqtK4Tt8KrEXB7TnvFPAfMFJ
         bfFr/w85qZiA5JmmDm/WBvKjuNpwSKUhDE58139dpLxKFP8WcI37C9pdou+kAanXuvlx
         ussfYeWMKeQBHAks37MO69/k2fiJt9Lt81QlD3ExGC+hNrLOzalfzWKcWFG6mIucxXpZ
         U/UkjlDHBHRzeJwegxKjNP3D/6B9voylhPxfQJ4TZfk071BJmr+P8UdKMGWfX0n10htr
         3gtQ==
X-Gm-Message-State: AOAM531Q9let3WXUxQcmaxtG3BDy02uoHq6RYjzBP5jcRf9Uj/LhGg9i
        t4Xnb5oLNPnZj/pa9A7I4Q5MISBWK5gwew==
X-Google-Smtp-Source: ABdhPJwPBJfSOFUbk4FOeyWWAqmyOcvafcn2ucUp8HrIrijfyHm0mad4xPcCOGlR307l1SSHNCJ/gQ==
X-Received: by 2002:a92:3003:: with SMTP id x3mr10930135ile.124.1616773597176;
        Fri, 26 Mar 2021 08:46:37 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e195sm4540586iof.51.2021.03.26.08.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 08:46:36 -0700 (PDT)
Subject: Re: [PATCH 1/1] block: fix trivial typos in comments
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
References: <31acb3239b7ab8989db0c9951e8740050aef0205.1616727528.git.tom.saeger@oracle.com>
 <2831e351-0986-28d5-5eef-53edcf8f41c3@kernel.dk>
 <20210326154519.y2ztm2fqirxejaht@dhcp-10-154-182-208.vpn.oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <02e3bdd7-896c-2286-d090-1931c5cd807e@kernel.dk>
Date:   Fri, 26 Mar 2021 09:46:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210326154519.y2ztm2fqirxejaht@dhcp-10-154-182-208.vpn.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 9:45 AM, Tom Saeger wrote:
> On Fri, Mar 26, 2021 at 09:41:49AM -0600, Jens Axboe wrote:
>> On 3/25/21 9:04 PM, Tom Saeger wrote:
>>>
>>> s/Additonal/Additional/
>>> s/assocaited/associated/
>>> s/assocaited/associated/
>>> s/assocating/associating/
>>> s/becasue/because/
>>> s/configred/configured/
>>> s/deactive/deactivate/
>>> s/followings/following/
>>> s/funtion/function/
>>> s/heirarchy/hierarchy/
>>> s/intiailized/initialized/
>>> s/prefered/preferred/
>>> s/readded/read/
>>> s/Secion/Section/
>>> s/soley/solely/
>>
>> While I'm generally happy to accept any patch that makes sense, the
>> recent influx of speling fixes have me less than excited. They just
>> add complications to backports and stable patches, for example, and
>> I'd prefer not to take them for that reason alone.
> 
> Nod.
> 
> In that case - perhaps adding these entries to scripts/spelling.txt
> would at least catch some going forward?
> 
> I can send that.

That seems like a good idea.

-- 
Jens Axboe

