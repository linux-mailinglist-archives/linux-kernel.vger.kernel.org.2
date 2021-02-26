Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B08D32636C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhBZNet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZNel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:34:41 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE72C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 05:33:58 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n20so14863905ejb.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 05:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TR4ROb9u3k/JUX1C8O83s/lzOAb5fJz5eMXmTKrTDk8=;
        b=OaX5BxBkOTPi9DrDcHjiYcHW14XYRQuDgcFIO2hnWgoNnb1rkYMATyjiNmcg//syij
         04MA14aqlYDW3p3Xqr7eI+ah/J/WdArrWtRtjYktL7O+EfGPBOallAE6WbnHubPS7fl7
         USgeVbvSO8zVgURSarX61kRT+Vqm+LhywoNPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TR4ROb9u3k/JUX1C8O83s/lzOAb5fJz5eMXmTKrTDk8=;
        b=SHYBc7vIRm3ErdzqIFVup970ey8ugPp/QQQ6+2cmUsRWbRC/8ucUSOzwF6JSUFs3Al
         t/jxuDMOiFc0wCHF+LUuoQcQOIBkMlEfy/yEDY0X/5EIB+uhcmdBki6DFBG1CJnZ9iHl
         s2YEoEtZCwaN3//Ip5ULg/jnVPyxJrWgK6e3fYfBNBxkTo/uCnQIo/CEUFTcnu6y3xMS
         epIwtL2CuSNfhtUCaO6+Engg7x/tPvYM6lOdC3THNWpVgVVeP5OtYSa2U6Q8BftYugn6
         0Qv5uZFWvtRsnCnFur7Uhx0iORRcicEIDoPcL7s4lAISygpbsorVspTEvU12BnEzcx6Z
         cxkg==
X-Gm-Message-State: AOAM533RM6QDSftQ9RyqpY/ke0mNX3jk24xnAOCQq2bBLwPoS4Zzt2X6
        fiATIAryqiPB1+Z/UYdUF2edMw==
X-Google-Smtp-Source: ABdhPJw4NXTQMfCY5B6L0Ltfe3/KsEVXetKw3JnjvFskdV3m6C1QRBULloZQcG3Q9Gp9LKov2sU1KQ==
X-Received: by 2002:a17:906:73cd:: with SMTP id n13mr3279138ejl.535.1614346437566;
        Fri, 26 Feb 2021 05:33:57 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id z12sm5602252ejf.15.2021.02.26.05.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 05:33:57 -0800 (PST)
Subject: Re: spdx spring cleaning
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <84ce357f-3400-2a4d-02e9-01e659829560@rasmusvillemoes.dk>
 <YDjwhAIMvCWAPSUY@kroah.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2f5c3ba2-972a-6d2a-620c-465a52196b25@rasmusvillemoes.dk>
Date:   Fri, 26 Feb 2021 14:33:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YDjwhAIMvCWAPSUY@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2021 13.58, Greg Kroah-Hartman wrote:

> What exactly are you trying to "clean up" here? 

For example, just inside
Documentation/devicetree/bindings/display/panel/, the exact same thing
is expressed in four different ways:

(GPL-2.0-only or BSD-2-Clause)
GPL-2.0-only or BSD-2-Clause
(GPL-2.0-only OR BSD-2-Clause)
GPL-2.0-only OR BSD-2-Clause

AFAICT, lower-case "or" isn't even compliant to the spec. The outer
parentheses doesn't really serve any purpose (even single-item
"(GPL-2.0)" appears), and that, and the random whitespace garbage, just
makes the tags appear different unless one does a lot of ad hoc
normalization.

But feel free to nak/drop it, just a suggestion.

Rasmus
