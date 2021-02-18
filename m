Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E7231EF3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhBRTIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbhBRRWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:22:25 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D22C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:21:16 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gx20so1910958pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+8dxtjoZbQHJJrfhAe5+1vp/FfbWXhHtNKWHEDTCyRE=;
        b=ZDyz/GOfRYNIditftM0QbDOr+DOznLnkqtCmGUY2Ya3w0F6wUJfvjcFO6G5qo6udY9
         X4MH4uHASeMRT1Mdx3Oc8rcJE2VFzwD/cez1ek2+L82eIqgji0t5zXChhSKgDHBmNLry
         5Iny7cOw8rGQTkz0oDMdMxriAFQQv6S7ROewGp65oWdFUaAQUBQ0YVKSUusWb0ZvI4is
         BahGnK1JO111Wk4jXhuiz46RxuoWaxNI4FBie8kUDhAGOfTD/ad6WhcuXAI5BNIoA3wE
         JE8O4oucFdb0UtnKlCewVAUQ4tvthIDgYYFbPqEVeT2nqBFe7lXSlvX27VIU87C0YKkq
         +Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+8dxtjoZbQHJJrfhAe5+1vp/FfbWXhHtNKWHEDTCyRE=;
        b=nrBtRuiEc/RuQKcHju0lHxSKIIdhpTDcvgI3vm6WHrvHMcM2KXA0wGcPDTNzxZn5m5
         JUPSKfPoLLMS3G3PFIyR6KJpw68W1hjUOlPZX4aourYEPHIGKi1EfO56lhkl4gkJMiAT
         zPQbOj/KsLydDyZtUYaMO2/iarlFziqvy1OU3lOuwaBsBdiFIbY5p+up8F+RvfkXv+Ym
         KC87ajG+Kw6FYkaIV+PYqgTC0lE058D3eHRpoadM5ZUd+i3Zz8IN/axJMZbBa+BmdwkS
         bmmx7NJSkE3UCK/erU3/sXtctdv5zPggEjFZot4RyKsUxgrnGoMvS3xx5hQwqEtZXg63
         X3sw==
X-Gm-Message-State: AOAM530KXKoO3TK9q+mIT8JQtOwZBh1qxm6SbtaTx54WYWcI+OEjFxCW
        sS4UqsyM/Jt9wvfbbT5yTbAX12TqcHQ=
X-Google-Smtp-Source: ABdhPJxTQci6XzAJRGyjNgQuVy7B9h7G7GvQ2jPvF7cGdSpVCjiF21XgS4Wu5gAdSD/+5txvfEOpqg==
X-Received: by 2002:a17:90a:4213:: with SMTP id o19mr5014812pjg.144.1613668875900;
        Thu, 18 Feb 2021 09:21:15 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id mp20sm5249622pjb.34.2021.02.18.09.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 09:21:15 -0800 (PST)
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
To:     Sasha Levin <sashal@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com> <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <20210218165104.GC2013@sasha-vm>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <00b9e2fb-d818-58d6-edae-4dbd6aa814f7@gmail.com>
Date:   Thu, 18 Feb 2021 09:21:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218165104.GC2013@sasha-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/2021 8:51 AM, Sasha Levin wrote:
> On Wed, Feb 17, 2021 at 11:48:21AM -0800, Scott Branden wrote:
>> On 2021-02-17 1:40 a.m., Greg Kroah-Hartman wrote:
>>> Following up on this as I did not hear back from you.  Are you and/or
>>> your company willing to help out with the testing of 5.10 to ensure that
>>> it is a LTS kernel?  So far I have not had any companies agree to help
>>> out with this effort, which is sad to see as it seems that companies
>>> want 6 years of stable kernels, yet do not seem to be able to at the
>>> least, do a test-build/run of those kernels, which is quite odd...
>> I personally cannot commit to supporting this kernel for 6 years
>> (and personally do not want to backport new features to a 6 year old
>> kernel).
>> And customers are finicky and ask for one thing and then change their
>> mind later.
> 
> Why would we commit to maintining an upstream LTS for 6 years then? If
> no one ends up using it (and we don't want anyone using older LTS
> kernels) we're still stuck maintaining it.
> 
>> We'll have to see what decisions are made at a company level for this
>> as there
>> are added costs to run tests on LTS kernel branches.  We already run
>> extensive QA on
> 
> This sounds very wrong: it's ok to get volunteers to commit to 6 years
> while the company that is asking for it won't do the same?
> 
> Shouldn't Broadcom commit to the work involved here first?

There are different groups within Broadcom, and Scott and I belong to
different groups, so I can only speak for mine. We can talk about why I
do not use the same email domain as Scott if you would like, and no, I
cannot help you fix the Broadcom Wi-Fi drivers :)

My group is committed to using the 5.10 kernel for the next 6 years
because of Android TV and we will do our best to test the 5.10 stable RC
as they come. We are a small team of 7 people in the grand scheme of our
larger business activities, and we get pulled into way too many things,
so we may skip testing a few stable releases once in a while. I do not
know how to make it more official than that.

As a company, we are most likely shooting ourselves in the foot by not
having a point of coordination with the Linux Foundation and key people
like you, Greg and other participants in the stable kernel. The usual
left hand and right hand not having yet discovered each other, hey hi
there left hand! I can see about remedying that at least for the
interest of the group I work in.
-- 
Florian
