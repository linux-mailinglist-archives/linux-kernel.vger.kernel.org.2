Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519773AF160
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhFURIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhFURIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:08:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB59C0599EB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:54:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id hq39so2894254ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P2Td/+tIipAgfyxPjVHvnCAo9n1WaYveTmTAYM/j+jY=;
        b=diuj5gabJqISgVVxx3Akhkd9RYmJFByRkUBchT88Z00CkuGWojs+VGfxVUt18Ow1NT
         iIs9CPaqGh7r/1KD5cILlcpveOUj3CJF4M7DbQqERFA9+ywOFCmKxKF8X0t8+AlKR+tN
         jXwgDjJn9NupBFYxyzDNQyDRkmzMZohSurPoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P2Td/+tIipAgfyxPjVHvnCAo9n1WaYveTmTAYM/j+jY=;
        b=qgX3Hjc683YSC/3tiw/moJUdw64FXOFZSngD8xwGW8d/mahHe2pCEBqr6pwu3rzELC
         KhgCxngHHiQKlp8V+w9u9oOXkkpXG/TdJIkxFxQ1zHKfk11DQmBM1jd4Y5+BN4WlQ31P
         ypakDBuHwFu9q1sxXquFs5pMJAb0Xd5vTBSkRfTDhlg0qbeYm2lITsjJpWjzXtXEwLpV
         SG/cXtm8fG+sbRyUnkF9mEvzzyavjEq313AQZR8WjDcUA+bnEBpFK3S58Go+jX3tDNMM
         2e1H1pcy2k943qfpADDSiaU7Zz6csw8fOk3KIV3AAAVPYi9ZL2jZOTyERnaxd+g79IHn
         gLSA==
X-Gm-Message-State: AOAM532gF12gFuTLOKVoVutIE2InLlkkZwTlGdsxIRNIz/3CrNgoJ16b
        /llp5dri3omp3vG/m+1TY42rRg==
X-Google-Smtp-Source: ABdhPJxjYawB6DJpcIRc0YMX54xgWCzAW7ksE8qOaz7mcYqVsYntvbdMZwPqOAEECmQCM421IbYweQ==
X-Received: by 2002:a17:906:264c:: with SMTP id i12mr25567215ejc.101.1624294441554;
        Mon, 21 Jun 2021 09:54:01 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id f14sm313127edd.69.2021.06.21.09.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 09:54:01 -0700 (PDT)
Subject: Re: Linux 5.13-rc6 regression to 5.12.x: kernel OOM and panic during
 kernel boot in low memory Xen VM's (256MB assigned memory).
To:     Sander Eikelenboom <linux@eikelenboom.it>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        kernel test robot <oliver.sang@intel.com>
References: <ee8bf04c-6e55-1d9b-7bdb-25e6108e8e1e@eikelenboom.it>
 <CAHk-=wjgg67NMBNG99naEQ1cM0mXBBzdhCJaYFH-kC+mLK+J2g@mail.gmail.com>
 <9108c22e-3521-9e24-6124-7776d947b788@rasmusvillemoes.dk>
 <0b12f27b-1109-b621-c969-10814b2c1c2f@eikelenboom.it>
 <7338064f-10b6-545d-bc6c-843d04aafe28@eikelenboom.it>
 <e7f9c4f8-1669-75ce-b052-1030350a159e@eikelenboom.it>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <bfdd1d6b-77a3-450b-71f4-63e9cc314ace@rasmusvillemoes.dk>
Date:   Mon, 21 Jun 2021 18:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e7f9c4f8-1669-75ce-b052-1030350a159e@eikelenboom.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2021 03.06, Sander Eikelenboom wrote:
> On 17/06/2021 21:39, Sander Eikelenboom wrote:

> 
> OK, done some experimentation and it seems with 256M assigned to the VM
> it was almost at the edge of OOM with the 5.12 kernel as well in the
> config I am using it.
> With v5.12 when I assign 240M it boots, with 230M it doesn't. With 5.13
> the tipping point seems to be around 265M and 270M, so my config was
> already quite close to the edge.
> 
> The "direct kernel boot" feature I'm using just seems somewhat memory
> hungry, but using another compression algorithm for the kernel and
> initramfs already helped in my case.
> 
> So sorry for the noise, clearly user-error.

Hm, perhaps, but I'm still a bit nervous about that report from Oliver
Sang/kernel test robot, which was for a VM equipped with 16G of memory.
But despite quite a few attempts, I haven't been able to reproduce that
locally, so unfortunately I have no idea what's going on.

Rasmus
