Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B504A35EDB5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349367AbhDNGtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbhDNGtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:49:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5963C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:49:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sd23so21056637ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=B+6jr48Ojmznsxy4oxkxofQU/L6ur022KHUmb08+AKw=;
        b=dXA+vORs75v7tBI7xHzxHssLv0Cv7a82SFSTESmFZkL5LGkytxDvh583n8epxC/EkQ
         JKpmDMzL/H396ZiXVe8P/hbdFa7DElz+SsdTAAdixv8X9tOBkvprSSg75wUUtjEPHy9J
         L++48dCtpybt6/XC8KNFRItR6w4tLCSkzPIFAtbd/8tRnnT5DG//tA9TeljD//7B+W/H
         ROTyziBZk9kdwhTZdGuadddQZtXUy5da2eM3wnRp9KIp29i528dGFO/mq5seHrTC41Nh
         lH3r+/OhGN6Xa8HB0s48ZR7FL4H566Jk2kWbMwyYhq3KNy7bEv2bCDaHkhTsAybEbmHP
         +3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=B+6jr48Ojmznsxy4oxkxofQU/L6ur022KHUmb08+AKw=;
        b=R+Hv6LSDzt+TEuKixqzCvVl9XJ+e9GNvudzCrny9yTTFr6BdQ8NkEbZjLpgG2h/vEY
         g7WEUXH0vkUnHDt8TuKfc1rjhBobPOwLr+dSw7/G7+6/apSE2STeNMsjnz8B1oKYsa5L
         qWxh/MBm/rw7Hm51bPS7XiQTN1Vv97MMfr8bRqv2XDY8/nR8Y2xxVNgPmiMo1tVna6gj
         28hFFsHIuKhDpEAorsdpZb8nuHQ4upP35UVxtqpWZzOo8SBzGSoP22qa8Ty/HqxIp5IW
         TFGbRrMPNnYFFVRrAzkvrhSVJ2QCIBY5y8cbPsmaOwRNCBEvbWp1Cx+BnGhBJyPV3qSs
         0bhA==
X-Gm-Message-State: AOAM532Vg1Wg+z5NuS50UnPXWUiRESyx9raVZrkVZdob55EhMAUWUipX
        o2LkQIPaMB4BSIgtgV1eSRu+Bsj32u8=
X-Google-Smtp-Source: ABdhPJyiZSX8xkF7d5J5ttZet1s3oX9W153kD9Z9vwQiVCXCHKDxuyS3zDOtIdT1Pq0+z5KBgm7xvw==
X-Received: by 2002:a17:907:7283:: with SMTP id dt3mr13149444ejc.47.1618382939554;
        Tue, 13 Apr 2021 23:48:59 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:eb49:bad8:5b80:ea48? ([2a02:908:1252:fb60:eb49:bad8:5b80:ea48])
        by smtp.gmail.com with ESMTPSA id c2sm11244029edr.57.2021.04.13.23.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 23:48:59 -0700 (PDT)
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com>
 <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com>
Date:   Wed, 14 Apr 2021 08:48:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 13.04.21 um 23:19 schrieb Mikhail Gavrilov:
> On Tue, 13 Apr 2021 at 12:29, Christian König <christian.koenig@amd.com> wrote:
>> Hi Mikhail,
>>
>> the crash is a known issue and should be fixed by:
>>
>> commit f63da9ae7584280582cbc834b20cc18bfb203b14
>> Author: Philip Yang <Philip.Yang@amd.com>
>> Date:   Thu Apr 1 00:22:23 2021 -0400
>>
>>       drm/amdgpu: reserve fence slot to update page table
>>
> Unfortunately, this commit couldn't fix the initial problem.
> 1. Result video is jerky if it grabbed and encoded with ffmpeg
> (h264_vaapi codec).
> 2. OBS still crashed if I try to record or stream video.
> 3. In the kernel log still appears the message "amdgpu: [mmhub] page
> fault (src_id:0 ring:0 vmid:4 pasid:32770, for process obs" if I tried
> to record or stream video by OBS.

That is expected behavior, the application is just buggy and causing a 
page fault on the GPU.

The kernel should just not crash with a backtrace.

Regards,
Christian.
