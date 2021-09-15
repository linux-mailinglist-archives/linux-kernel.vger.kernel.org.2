Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D1E40C9CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhIOQM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhIOQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:12:23 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF67BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:11:04 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id m21so3934052qkm.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n4Qnqbu11Fuo96IE/TgFwqX5rTo16bth+fQjOuHF8Qw=;
        b=f/6XS8ROr3zX3dKYXjYy/3oxaU2gHeK3GOC1Zc/TPNplUws1qV/8r8+tFzZa9AbaPs
         QSqRWhVH8Sbz7HeIZzVm2yMCxeLzQ/UrbkGCMJhzYDOVGaAQU3W0fJXnSPISEBcrAOwh
         5m3KZIU63FH9bRgeYtmO61wJHaw1tgFhsQ3Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n4Qnqbu11Fuo96IE/TgFwqX5rTo16bth+fQjOuHF8Qw=;
        b=T+bXbmk8J1CJyVfRVuJRjsAPo+wKA7hPXtAfvG+u1se/CqPzBRAsriabXDYrRyZQVC
         FZuyCzw3+tXWq1eDIsBGsj39YUee8nE2GxpvRt8X2DzAIV1IftgVhFd1BOFVIENC/U0k
         oNGTXw5G5GIPaPRzbaOV0pu9In2Y8Dbzh20+4u7LRUrNqhK4m0MSdk6NmNqrjGSlGrbO
         gpCgjonu+mS+oANYKJ0sGvbTnrq9BEdYRgzCMgpj66hzkAAMiMokX7LgmUvah3XAbJoQ
         w5N3hNe1lDYVQKyEeM7nhk774jx8WNpPaOL8fWVxE0Osph1pV+Ki/ZgD2YuYB3GRnnot
         aZiw==
X-Gm-Message-State: AOAM533teLgDhSF3gUhHC4ONp0K2ocjezUoFWcUFD5CfS5cNgSTJLCx4
        ZOZNhI9VR7imxO5rGuTMRCQtPw==
X-Google-Smtp-Source: ABdhPJySdABmG9XMVgnIZ2unXJDHlF1rmbvnPaUsRMFANrAP29f+XLWxajI3mJhGtvYnoD/p3KV/Zw==
X-Received: by 2002:a37:a4c5:: with SMTP id n188mr685012qke.273.1631722263890;
        Wed, 15 Sep 2021 09:11:03 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id w7sm189790qtv.93.2021.09.15.09.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 09:11:03 -0700 (PDT)
Message-ID: <1efba77b-965f-62cc-8f80-1e2b0a4f5c2a@labbott.name>
Date:   Wed, 15 Sep 2021 12:11:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Reminder: Voting procedures for the Linux Foundation Technical
 Advisory Board
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
References: <fccbdadc-a57a-f6fe-68d2-0fbac2fd6b81@labbott.name>
 <b90db9e7-9b6b-c415-d087-3505ba0be0d6@labbott.name>
 <YUH+DO5aHWGVdNb7@pendragon.ideasonboard.com>
 <dc45975a-86df-a70d-ff15-58a3bdcf09ee@labbott.name>
 <6db59b8a4874b60cab7069fd06d180c2601bb427.camel@sipsolutions.net>
From:   Laura Abbott <laura@labbott.name>
In-Reply-To: <6db59b8a4874b60cab7069fd06d180c2601bb427.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 11:49, Johannes Berg wrote:
> On Wed, 2021-09-15 at 10:36 -0400, Laura Abbott wrote:
>>
>> I did make an attempt to send e-mails to the > 50 commits individuals
> 
> So if we got the "look for your ballot" email from you, that means we're
> on the list?
> 
> I agree with Laurent, it's a bit confusing now to figure out whether we
> should request or not, and if we have to request before the automated
> ones are sent out, we can't wait for that either.
> 
> I'm sure I'm on the list, but I guess others aren't quite so sure.
> 
> johannes
> 

You should only request a ballot if you think you have between
3-49 commits. I agree this is a bit confusing and this should
have been worded better and we'll make sure to do better next
year.

Thanks,
Laura
