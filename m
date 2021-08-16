Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59C83ED975
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhHPPFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232271AbhHPPFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629126304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABrWgRhABY2HK4NysZy+JCnEPDW3vpIo9/TFVUA3ibc=;
        b=RH/S2jLA9ZxGIxeMvRRwmfhUgsVbCpE8j/zR6EUZhcebKmNg3AWOe1gdnz/R9NXX81kpms
        gM0bUceO4jNsOPcfxrTrlETYB7bp/d1j73Nm/s0i2Cgiv+8dGoRKAF4MkitNztfkXpkzQG
        034tLuxd/XyP4SsWwlEcRTKTf1b5ANU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-t9Z_bZPcNVWwtCIv7lVzbA-1; Mon, 16 Aug 2021 11:05:01 -0400
X-MC-Unique: t9Z_bZPcNVWwtCIv7lVzbA-1
Received: by mail-wr1-f72.google.com with SMTP id p2-20020a5d48c20000b0290150e4a5e7e0so5548173wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ABrWgRhABY2HK4NysZy+JCnEPDW3vpIo9/TFVUA3ibc=;
        b=CblGU443LjDHP5HiLTxM2Po+CFrlSy3vTNFfxljN3hdVdw8u0cT5VX9FnT6YhmfvDd
         9biYHkezzyXYogXcJhgzciNFqXaJiYkxZw2qk2QFTp5WLYzieVoHPXnP2QNpKE+CCKV4
         nFd0iQviovfCR2ENtHqDL6ImMDsHJCK4nKLYtbr0esh0XtCZ2MAMbFb177aoeJIu7zNe
         ftSrfWkL+453T1tsCAsIk24xysc9l0P1vOJCJVBDOOp1GsoLsSSMKDBYtv0zM2A+BY4j
         nAHegTO//OmBdZOwTFEmBMJka8ByVsmnNY5uczEpwCU0U8H5V1Rkwobjx3KQV50vwgo9
         neqQ==
X-Gm-Message-State: AOAM530dia/3AI+qJF4y05DkSzoawW15cZO+Occ0Q7h+By19DH0EDGXo
        Jkv65xPzK0ZovqjqedyGF4BMSbMjkLzUqCuex8jV/EerWmL00bZ+0lkZCxlrA3XCGTTzL/i8zFN
        H809U0rGxB3nUg50+FuVeScx3
X-Received: by 2002:a1c:7dd0:: with SMTP id y199mr15424188wmc.23.1629126299867;
        Mon, 16 Aug 2021 08:04:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx09VPZkGLXWDG+tXpHYc3YeJl3pSZSqRdKI6EYU61EuoygC/wIwMn44PmYT5H+5icPrjj/xw==
X-Received: by 2002:a1c:7dd0:: with SMTP id y199mr15424176wmc.23.1629126299653;
        Mon, 16 Aug 2021 08:04:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id w29sm12856049wra.88.2021.08.16.08.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 08:04:59 -0700 (PDT)
Subject: Re: [PATCH 5.12.y] KVM: nSVM: avoid picking up unsupported bits from
 L2 in int_ctl (CVE-2021-3653)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
References: <20210816140240.11399-6-pbonzini@redhat.com>
 <YRp1bUv85GWsFsuO@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <97448bb5-1f58-07f9-1110-96c7ffefd4b2@redhat.com>
Date:   Mon, 16 Aug 2021 17:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRp1bUv85GWsFsuO@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/21 16:25, Greg KH wrote:
>> [ upstream commit 0f923e07124df069ba68d8bb12324398f4b6b709 ]
> 
> And 5.12.y is long end-of-life, take a look at the front page of
> kernel.org for the active kernels.

Ok, sorry I didn't notice that... it wasn't end of life when the issue 
was discovered. O:)

(Damn, the one time that we prepare all the backports in advance, we end 
up doing too many of them!)

Paolo

