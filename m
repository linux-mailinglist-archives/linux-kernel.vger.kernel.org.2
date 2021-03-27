Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0078734B945
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 21:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhC0UJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 16:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhC0UJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 16:09:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2D6C0613B2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 13:09:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t18so4153288pjs.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 13:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gl6K4yhW13Kr5byLAjtw6msM95S/bPbif0F7bCXuCTo=;
        b=ZpvGQmlVQNUjvDss7S/A9WVts56Zf4zThRGYI9SAPgvunBjxgkFZpvbhbiOPuf/6Sa
         UD/fxTC2ivppYJgO/Zw8j2E26D9DyvyagID+wZz9SzfvyE2Vgqnyg2pOzDeVyCarcQO6
         dq+cMKSjVktyzgf8uW8HIXr+1aRcrV1sxP/7nONAVQDIdH/MA4MCvQChMj/UfHkLBmNJ
         i3Fqpg1y0W8L6KLDFPP8CiabZ7S0j0rrhL8y5Bg0dYqRfGlcOS2fUZ6bx2CyyfavWtZ1
         J2BdmG+G3f3Vd50ky0Ku97VBEwMlSHt/6wbPn2+6qIFIVjhAAxWo+2I5gyQo3pJKdgf3
         spFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gl6K4yhW13Kr5byLAjtw6msM95S/bPbif0F7bCXuCTo=;
        b=k72lzuuj1wbHgnbjCB5YHcfryPT9HDlo3zyyIqGN/+mSBtQGoBHQyAK2PmjARIYWBh
         Y0m8Pul+A2yV0FICNUdR5bW3/6+DaDFH2Hdi4HIXOoy74ldx9S0jGGAEwGex2Ady7nVW
         +EHxtir3elcVvTv/lfaLpe1dqllttzSoXxEYiQ+6TmBGnNsNiTn72PBavmdD0hF/Dmn+
         aLUnUpC5kHLQRet/roSR5AERFD+6pZVDimo1PDvAGRgcqBsI4jJUbPhBxXulVGsgoRdz
         2fokacxhmYMXXcQudOY/4CEqsrKDgVNb/plJXPR4xADV8xl7CQWIuVXWOD1Zzk16p2wZ
         XTCA==
X-Gm-Message-State: AOAM531tYUzm9jJfkBG1gqd3FWKoZPGjhT81kDFHk3SLU7nCUXbVlLzk
        KWIhdbcLtVF1caPfh8ZrZAHi7e5D75z8RQ==
X-Google-Smtp-Source: ABdhPJyVHitKFRyW/+b4BAAeB3N1iyPYrhNX834K0F8siBnRjW6ZeSZra2xjQkXQiLobUcYQaIx13w==
X-Received: by 2002:a17:902:c48c:b029:e4:c093:593a with SMTP id n12-20020a170902c48cb02900e4c093593amr21093127plx.1.1616875740033;
        Sat, 27 Mar 2021 13:09:00 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 193sm13445271pfa.148.2021.03.27.13.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 13:08:59 -0700 (PDT)
Subject: Re: [PATCH 2/7] io_uring: handle signals for IO threads like a normal
 thread
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     io-uring@vger.kernel.org, torvalds@linux-foundation.org,
        metze@samba.org, oleg@redhat.com, linux-kernel@vger.kernel.org
References: <20210326155128.1057078-1-axboe@kernel.dk>
 <20210326155128.1057078-3-axboe@kernel.dk> <m1wntty7yn.fsf@fess.ebiederm.org>
 <106a38d3-5a5f-17fd-41f7-890f5e9a3602@kernel.dk>
 <m1k0ptv9kj.fsf@fess.ebiederm.org>
 <01058178-dd66-1bff-4d74-5ff610817ed6@kernel.dk>
 <m18s69v8zb.fsf@fess.ebiederm.org>
 <7a71da2f-ca39-6bbf-28c1-bcc2eec43943@kernel.dk>
 <387feabb-e758-220a-fc34-9e9325eab3a6@kernel.dk>
 <m1zgyotrz7.fsf@fess.ebiederm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c0888c0f-4490-227a-645b-f3664aaef642@kernel.dk>
Date:   Sat, 27 Mar 2021 14:08:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <m1zgyotrz7.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/21 11:40 AM, Eric W. Biederman wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 3/26/21 4:38 PM, Jens Axboe wrote:
>>> OK good point, and follows the same logic even if it won't make a
>>> difference in my case. I'll make the change.
>>
>> Made the suggested edits and ran the quick tests and the KILL/STOP
>> testing, and no ill effects observed. Kicked off the longer runs now.
>>
>> Not a huge amount of changes from the posted series, but please peruse
>> here if you want to double check:
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-5.12
>>
>> And diff against v2 posted is below. Thanks!
> 
> That looks good.  Thanks.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks Eric, amended to add that.

-- 
Jens Axboe

