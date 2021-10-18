Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD90431198
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 09:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhJRHwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 03:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230375AbhJRHwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 03:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634543411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cmUEjMvKdE4r0VlhoDyQ4AGcJgL1QHXNAMf5p+m+CiQ=;
        b=Ziv0zJhEetxjheV0KjvvMcVzViYYbYPOV+v7AKvHhBNcIJA0QtrV3cbKtdolTAiERLKjRm
        Yb9pgaNOfkxj4d1HS61Zmlolg4ic9O7ReeQspBH1tU5r3t2v+2UC7OSji+f84M3v/6o9/W
        zOO8xaYiwojGlPXety7PlS0STnr+E3w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-kw4lZJHJOumgxM875iBYWQ-1; Mon, 18 Oct 2021 03:50:10 -0400
X-MC-Unique: kw4lZJHJOumgxM875iBYWQ-1
Received: by mail-ed1-f69.google.com with SMTP id i7-20020a50d747000000b003db0225d219so8931568edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 00:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cmUEjMvKdE4r0VlhoDyQ4AGcJgL1QHXNAMf5p+m+CiQ=;
        b=keHVZcQxie3M9HlhXhgclXRDWEXS/N4W2lXoCWwz0PBBQppqMimfoSEjyHVoRIiYev
         4WaBqoR4Z4uPiqWhX3CrojWDxSwcUfDKzDspPNJD1FEavaRMbKHS8FEwUM8LWDGcIMsW
         fpMtyiscnzYIb5loXHV0lAghVem6IoYAwMVi/WSqpp9/yh/V4DN0Dc3seAQN/S6jQf4f
         m1vtYkh2uTpaJfPFQGx8LN1NRkXUT1rbGLvmySQY8WX1HUHQrp7kTuvFU3MUL21R9Zji
         Uss/niSU6+iVNa0D0JlqPMdRFX6VZBWXRnCjJiI57tlMruz4pwaU4vYAVbM0qiMP+3KD
         m3uQ==
X-Gm-Message-State: AOAM531BKkYbvj5+u+/Ynja0uuySj+nfN46JjKVPxXq5M0Hbkau9bAGI
        rpU2wvIEvMKeKzdKzsU7kmBrMUXXz92MzrmYa5ZT2Hxh0O+UBksXW2ws4yI10GbViQY9SXuaSNd
        rLW32blonxQqLEF+yYYTArLhS
X-Received: by 2002:a50:e0cf:: with SMTP id j15mr43879058edl.23.1634543408939;
        Mon, 18 Oct 2021 00:50:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGqecflbkhXn6/d+bUvhqn3HokkMDIfFHxk40B17yyen9jLv9T9V/5qiLyonf33yklFJn63w==
X-Received: by 2002:a50:e0cf:: with SMTP id j15mr43879025edl.23.1634543408670;
        Mon, 18 Oct 2021 00:50:08 -0700 (PDT)
Received: from [10.40.1.223] ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id i19sm5918761ejo.101.2021.10.18.00.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 00:50:08 -0700 (PDT)
Message-ID: <2170cfdf-767f-969c-f241-4e61bfafd1f5@redhat.com>
Date:   Mon, 18 Oct 2021 09:50:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [BUG 0/5] bug reports for atomisp to make it work
Content-Language: en-US
To:     Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Patrik Gfeller <patrik.gfeller@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Kaixu Xia <kaixuxia@tencent.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nable <nable.maininbox@googlemail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        "andrey.i.trufanov" <andrey.i.trufanov@gmail.com>
References: <20211017162337.44860-1-kitakar@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211017162337.44860-1-kitakar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Just adding some folks to the Cc.

Regards,

Hans

On 10/17/21 18:23, Tsuchiya Yuto wrote:
> Hi all,
> 
> These mails contain RFC patches, which are almost bug report and some
> are just bug report, for atomisp to work (again). Tested on Microsoft
> Surface 3 (Windows) and Xiaomi Mi Pad 2 (Android model) with v5.15-rc5.
> Both are Cherry Trail (ISP2401) devices.
> 
> I'm still not used to Linux patch sending flow. Sorry in advance
> if there is some weirdness :-) but I did my best.
> 
> To try to take a picture, take a look at the series I sent earlier named
> ("various fixes for atomisp to make it work")
> 
> The 1st patch is required to take a picture with atomsip (again):
> 
>     [BUG][RFC] media: atomisp: pci: assume run_mode is PREVIEW
> 
> The 2nd patch is to avoid kernel warning message:
> 
>     [BUG][RFC] media: atomisp: pci: remove dummy_ptr NULL check to avoid
>       duplicate active_bo
> 
> The 3rd patch is to avoid kernel oops, which is almost required for
> using atomisp normally:
> 
>     [BUG][RFC] media: atomisp: pci: add NULL check for asd obtained from
>       atomisp_video_pipe
> 
> The 4th-5th mail is bug reports, no patches for these issues yet:
> 
>     [BUG] media: atomisp: `modprobe -r` not working well (dup video4linux,
>       ATOMISP_SUBDEV_{0,1})
>     [BUG] media: atomisp: atomisp causes touchscreen to stop working on
>       Microsoft Surface 3
> 
> I added further descriptions at the top of each RFC/BUG mails.
> 
> Regards,
> Tsuchiya Yuto
> 
> Tsuchiya Yuto (5):
>   [BUG][RFC] media: atomisp: pci: assume run_mode is PREVIEW
>   [BUG][RFC] media: atomisp: pci: remove dummy_ptr NULL check to avoid
>     duplicate active_bo
>   [BUG][RFC] media: atomisp: pci: add NULL check for asd obtained from
>     atomisp_video_pipe
>   [BUG] media: atomisp: `modprobe -r` not working well (dup video4linux,
>     ATOMISP_SUBDEV_{0,1})
>   [BUG] media: atomisp: atomisp causes touchscreen to stop working on
>     Microsoft Surface 3
> 
>  .../staging/media/atomisp/pci/atomisp_cmd.c   | 73 ++++++++++++++
>  .../staging/media/atomisp/pci/atomisp_fops.c  |  6 ++
>  .../staging/media/atomisp/pci/atomisp_ioctl.c | 96 ++++++++++++++++++-
>  drivers/staging/media/atomisp/pci/hmm/hmm.c   |  4 -
>  4 files changed, 174 insertions(+), 5 deletions(-)
> 

