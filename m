Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658F931EF16
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhBRS6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBRRRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:17:22 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D47C061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:16:37 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id fy5so1716628pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N8HGGBHeZbZcGDnU37/xWLHvQajs014gdX7wvvRA2bE=;
        b=NcflAH9R8CWXh6p4t+KHNPyYa3sV5tTEhWJ7uPquJWKY/n+H8blKBKJw0LSGjxGbiZ
         2V7kwupenPFX6tLlyz6gKA5XUzlGccBUiIsGqRRHW3VF9V+//4MwtcoBuaxIg/mwJHLb
         LLmtuX2F1m2EsD8fxbRKQH4Oz1nsZuhdLPlX3fAsaiDPUuBaMbWKb6imfhUmprw8WyQo
         uOSVHRqfVP8zg8NXR4DdkvKRIirr8Y5ffzSOHyDUTmKgCbmfFXolukJ2qdQtw7g8pAiI
         XwzZygxjhohlhs0U1cZYRJrbuuq7d4SwdShuMshqv9wak8RRMm4w3TnVfeWhDqG18hDb
         F1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N8HGGBHeZbZcGDnU37/xWLHvQajs014gdX7wvvRA2bE=;
        b=GN7O0BsViTwg0N4Uizo/DStB8Umrx1BlAfyS5WgXtHI7A/glkFjr9cwbuplsNfL/Aw
         AOut+1RmMVNsSNT1TorPju8BVW2tFbdFn0KplyfFjsLPC4r1SBgbJ1Zlx7LZPSU4YBfF
         aW25EeXi5bEXrt/f3VRi6ViZToYazXzDbElKZINwFLVTVYZ/qTlWLMQZK+Nm3vAsUjac
         HDx6RU4jTM9jY1qiEMhEbjoC3DrmJLSkys6kXW6dUSdEPR5+bj4Lm1/IUT5Rhy8AbIHF
         LNCSN8vwv1dfFDCVpLLHzFq9P+HLduzSYnYgkJ/xf4O6edZDzqaZ2nww3hgz+lOLUuhi
         OgPg==
X-Gm-Message-State: AOAM532/b/d1lUD440nRUWlKDrnkPEnq6y/9c+Yhnw+8JifbIhN53EZ/
        fSihL3vYqh1CR5Z1QHxG4HA=
X-Google-Smtp-Source: ABdhPJw6/xe/x6Eu52y5d1AxkffMbc8tmT3KIxhL6SJ+5TYVv08iKYg165+Nmbpo6M2RNIEXKJvcuw==
X-Received: by 2002:a17:902:8c8f:b029:e0:1663:fd34 with SMTP id t15-20020a1709028c8fb02900e01663fd34mr4805792plo.84.1613668597193;
        Thu, 18 Feb 2021 09:16:37 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c18sm6699352pfi.167.2021.02.18.09.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 09:16:36 -0800 (PST)
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
To:     Willy Tarreau <w@1wt.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com> <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <YC4atKmK7ZqlOGER@kroah.com> <20210218113107.GA12547@1wt.eu>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <311de080-d9b7-4907-8d5b-3edc3c471932@gmail.com>
Date:   Thu, 18 Feb 2021 09:16:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218113107.GA12547@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/2021 3:31 AM, Willy Tarreau wrote:
> On Thu, Feb 18, 2021 at 08:43:48AM +0100, Greg Kroah-Hartman wrote:
>> On Wed, Feb 17, 2021 at 11:48:21AM -0800, Scott Branden wrote:
>>> Other difficulty with the LTS version is the frequency it is updated.
> 
> What a stange statement! So basically if fixes come in quickly so that
> customers are not exposed too long to well-known issues, it's a difficulty ?
> I guess by now every serious OS vendor provides at least weekly fixes, and
> at an era where devices are all interconnected, it's really necessary
> (unless of course you don't care about your customer's security).
> 
>>> We would not
>>> pickup the changes that frequently to test.  A quarterly, bi-annually, or when a critical fix
>>> is identified would be when we update and perform any meaningful testing when in maintainence.
>>
>> How are you "identifying" these "critical fixes"?  We fix at least one
>> known security issue a week, and probably multitudes of
>> unknown-at-this-moment ones.  How are you determining when you need to
>> send a new base kernel update off to your customers?  At such long
>> intervals it feels like anyone using your kernel releases is woefully
>> insecure.
> 
> +1! It seems like this dangerous practice will never end :-(
> 
> Let me explain a personal experience. When I took over 2.6.32 many years
> ago, Greg asked me to adapt to the new maintenance process involving the
> patch reviews. At first I feared that it would increase my amount of work.
> And it did. But I also discovered how important these reviews were, because
> I started to get lots of "don't take this one in this version" and more
> importantly "if you merge this you'll need these ones as well". And very
> quickly I discovered how bogus the branches I used to maintain before
> had been, given the high feedback ratio!
> 
> So based on this experience, I can assure anyone doing cherry-picks in
> their garage from LTS kernels that they're doing crap and that they must
> not distribute these kernels to anyone because THESE KERNELS ARE DANGEROUS.
> It's even very easy to introduce vulnerabilities by doing this!

Yes absolutely.

> 
> The only set of fixes that can be trusted are the "official" stable
> kernels, because they are the only ones that are approved by the patches
> authors themselves.

Well, let us say that the authors had a chance to review the backports
being applied but given the volume maybe they did and silence means
agreement, or maybe they did not get a chance to review those changes.
Let us say that the trust level of the offical stable kernels is just
the highest of all kernels that are out there?

> Adding more stuff on top of stable kernels is fine
> (and done at your own risk), but randomly dropping stuff from stable
> kernels just because you don't think you need that is totally non-sense
> and must not be done anymore!

Yes, definitively not setting up for success.
-- 
Florian
