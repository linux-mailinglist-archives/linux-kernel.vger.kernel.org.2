Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D723F7388
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbhHYKmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239037AbhHYKmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:42:42 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B80C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:41:56 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i28so52003728lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rGRHoxWTYsZ2ancUp4Mt0E/4VV8VJ/nnMF5nCt2kATU=;
        b=ooR9aQ9YBN+6sdCKSrhKZFMEHsttqfWZ4p4NsKi0f0mWDcfU6QmsNRQhCIIOz6QlQB
         3MMqYYxgRrA/hEQi3gMOM6lQL3bN2Fw6smJv4qqtdhzWvRCHcGmjB5/vrDsfC/tk1Llt
         r0UqCJBfbwP+tf3rgcF9TRZwRh6cnxdmFlI3vq4EniTDj6S6PDULagOScgl4dm4LH5UR
         qeJAFWhj8QF4lt/dTOl2FuLRo3eN+inECiBTCI9xFnaYb0fvnzjEvNRtzLT37SKtRD53
         p6K/PBA9AUSfKIfLov2AllN92umVq4yt6P+J11JgEIBfwfrl/cjTj8rWEAXyNsBMN/Qq
         yKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rGRHoxWTYsZ2ancUp4Mt0E/4VV8VJ/nnMF5nCt2kATU=;
        b=a+wQ2RAOYY5GhmhWGzzLtJ6UhAyPl8kO4/fb05hpjNt5/nZ9y45+ezexDAI+yXSgcy
         HgI32CshSpbWCEuAjjZajCzxHG+Q6pUynyutTFnUtjQ39mpxCCwg7SMTTUCxlOSJzC3O
         eCp6cKy/ZSOcIxlezupmiYp+MTRWw1UGTpuS6l3tmJhvrUMjGlN6dgqFLBLFTVQViL1h
         XrMUanSuH/pHXE41F40tN6/CUDtPsQujji1+4E3++mEgR8xVU/LSzffzXcmBhTO3jdo6
         VGvKI8Uuijd7I3hh5TqwPAsGrAYs0jduYSuw9gG6EAl/zeuWW6Z26k4bFWFf/NHtjfeR
         eLyA==
X-Gm-Message-State: AOAM530RYwLslF4SbI9Lyqf/QDs0fdY0hmd1XUB7ZtHV5P6ux0y6CP3G
        S1a0VP21/RYZgUuCppnEMGjV6XtBhsPIDg==
X-Google-Smtp-Source: ABdhPJygjsmJWLm0id3fQ1AG48XpgXk0LJRMjIVEwaVM0OORRZGLvuatloMoJEaj6Jb3uNaHDfwFSA==
X-Received: by 2002:a05:6512:3d16:: with SMTP id d22mr32405295lfv.132.1629888114427;
        Wed, 25 Aug 2021 03:41:54 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id l14sm2010480lji.106.2021.08.25.03.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 03:41:53 -0700 (PDT)
Subject: Re: [PATCH v3 4/6] staging: r8188eu: add error handling of rtw_read16
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1629789580.git.paskripkin@gmail.com>
 <1665728.ljvk3MsED4@localhost.localdomain>
 <ab20fcd7-69a8-0530-7770-0e309178b0f0@gmail.com>
 <2227654.mbYB7oqmoa@localhost.localdomain>
 <794dfd94-fe88-43ac-c4ec-9ff7df9db6de@gmail.com>
 <20210825100647.GS1931@kadam>
 <3396277b-6d80-b621-0ef0-71de7d581602@gmail.com>
 <20210825103802.GS7722@kadam>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <a38b05bc-abeb-7d30-736f-1bd68c2517c3@gmail.com>
Date:   Wed, 25 Aug 2021 13:41:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825103802.GS7722@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/21 1:38 PM, Dan Carpenter wrote:
> On Wed, Aug 25, 2021 at 01:13:54PM +0300, Pavel Skripkin wrote:
>> On 8/25/21 1:06 PM, Dan Carpenter wrote:
>> > On Wed, Aug 25, 2021 at 12:55:37PM +0300, Pavel Skripkin wrote:
>> > > The main problem, that no one knows who is the "old". Greg can take patches
>> > > in any order he wants
>> > 
>> > Patches are always taken in first come first serve.
>> > 
>> 
>> 
>> Ok, but if pending patch needs new version, then it will be taken at the
>> end?
> 
> Versions don't matter.  No one is tracking any of that.
> 
> A patch arrives.  It is either applied or rejected.  First come first
> serve.
> 

Ok, big thanks for explanation

>> 
>> Here is the situation we have:
>> 
>> 	I have the patch series based on old function behavior, it was
>> 	posted first
>> 
>> 	Then Fabio posted refactoring of the function and it changes
>> 	return values.
>> 
>> 
>> Both series are pending right now and made on top of staging-next branch.
>> Who needs to rebase? I think, applying these series as-is can broke the
>> driver, since error handling will be broken
> 
> That's a bug then.  The patch should be rejected.  You're not allowed to
> break the code.
> 
> Also don't write patches which lead to merge order breaking the code
> silently.  That makes it difficult for stable as well.  For example,
> don't do this:
> 
> -void frob(int a, int b);
> +void frob(int b, int a);
> 
> In that case, you would change the name of the function so that the
> build would break when people mix old and new code.
> 

Understandable, thank you :)





With regards,
Pavel Skripkin
