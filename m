Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0003A3EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhFKJXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:23:35 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:38591 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhFKJXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:23:33 -0400
Received: by mail-ed1-f51.google.com with SMTP id d13so22790327edt.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CGc5CA/rls3HItW+7D7ycY5sKp100bjxVPK+/n8mTzM=;
        b=T5q5576OjaMXGrmhE/6QFLbaTulb3j1O7K0MCX/zDH4fMgR59Ig379SNOP6WIfhg+S
         sIVRKn5H/uUru4GsrWwaJehmckioKuEr8LinY6E8lXlykTrSQ7H8SKIUFwpT8dVn5In+
         ojIl35Cd+01fC3FnmfDr7GgMh5V3ZdlCEIRXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CGc5CA/rls3HItW+7D7ycY5sKp100bjxVPK+/n8mTzM=;
        b=ctwgpDhkUBMbXkak+O/df+YeAtMtbe59BCnD6DwYui7vd24ORWm+a0Ln/+xQmFwr5s
         odZ31GhLN+Gsuczr9n+P0WN3mdDBmrFbFzQiTTY4ryVuG/+Il+ljO/+q+YqwbT17Gyuq
         1KAjPTuQDjXQrzuGH4owUSBfmDDPx+A75NsCnDHz9sgJ53TjAGXnuQHg0Oikz8Po6Fkc
         hm7LmTkSfMDTCDBFfDE03WF2juCnEF9PLPwR8Z40t2Jz8Mrh+Qkfz301PODa7duuM3dl
         x5uy8Vd8jkzZV+1MGBHcDYQjr3GCC+iM/9HPOfqbt5ApSBwTx/U6CZ+U3Mn1euoGrw+f
         V6vw==
X-Gm-Message-State: AOAM533X0QYVCOQufMaCiTICeUObggrYohyzxM0SklrkZKxAv3P3q7BL
        8G/8GxFqJQU0M1VwObXxTLpt1Q==
X-Google-Smtp-Source: ABdhPJxLHD8WhYBB9EGCCP9ce802mfGbHPukNPB5XdussTThKAu1mnzpq1KvSGvqHXwGI+QRrQ51kw==
X-Received: by 2002:aa7:c1da:: with SMTP id d26mr2689892edp.92.1623403219760;
        Fri, 11 Jun 2021 02:20:19 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id gz25sm1906684ejb.0.2021.06.11.02.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 02:20:19 -0700 (PDT)
Subject: Re: [init/initramfs.c] e7cb072eb9: invoked_oom-killer:gfp_mask=0x
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20210607144419.GA23706@xsang-OptiPlex-9020>
 <d28354fd-0f72-559d-771f-fb2a80b51b05@rasmusvillemoes.dk>
 <20210611084817.GB26476@xsang-OptiPlex-9020>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <db82c1c9-edfe-6ee2-c403-d6740e8c46c6@rasmusvillemoes.dk>
Date:   Fri, 11 Jun 2021 11:20:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210611084817.GB26476@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2021 10.48, Oliver Sang wrote:
> hi Rasmus,
> 
> On Tue, Jun 08, 2021 at 09:42:58AM +0200, Rasmus Villemoes wrote:
>> On 07/06/2021 16.44, kernel test robot wrote:
>>>


>> Also, I don't have 16G to give to a virtual machine. I tried running the
>> bzImage with that modules.cgz under qemu with some naive parameters just
>> to get some output [1], but other than failing because there's no rootfs
>> to mount (as expected), I only managed to make it fail when providing
>> too little memory (the .cgz is around 70M, decompressed about 200M -
>> giving '-m 1G' to qemu works fine). You mention the vmalloc= argument,
>> but I can't make the decompression fail when passing either vmalloc=128M
>> or vmalloc=512M or no vmalloc= at all.
> 
> sorry about this. we also tried to follow exactly above steps to test on
> some local machine (8G memory), but cannot reproduce. we are analyzing
> what's the diference in our automaion run in test cluster, which reproduced
> the issue consistently. will update you when we have findings.

OK. It's really odd that providing the VM with _more_ memory makes it
fail (other then the obvious failure in the other direction when there's
simply not enough memory for the unpacked initramfs itself). But
unfortunately that also sounds like I won't be able to reproduce with
the HW I have.

>> As an extra data point, what happens if you add initramfs_async=0 to the
>> command line?
> 
> yes, we tested this before sending out the report. the issue gone
> if initramfs_async=0 is added.

Hm. Sounds like some initcall after rootfs_initcall time must
allocate/hog a lot of memory, perhaps with some heuristic depending on
how much is available.

Can you try with initcall_debug=1? I think that should produce a lot of
output, hopefully that would make it possible to see which initcalls
have been done just prior to (or while) the initramfs unpacking hits ENOMEM.

Thanks,
Rasmus
