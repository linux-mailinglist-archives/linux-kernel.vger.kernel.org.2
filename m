Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6125C42687F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbhJHLNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:13:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232629AbhJHLNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633691466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=beL+lHu4Yb6ST/YHe2oKhpNvDASDezmXv1HiQU4m3Qg=;
        b=SA248/MngBr4V+O4KWXJhqYVAUc4QN6L4IzeVRGNsOinXZY7NS/54RammEPuqkQj98XsgB
        s6ZNGsLjzAmIZkpjPmujpceUykyOnunkF0fMUSor4xJaGv8r0FEqnK7WRg3Am9LwtbT9V9
        RmUVp+w3AHvi9PXJfmic+i2yr+iK6Io=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-Jo9VAmcQPvmVP0721dZY0Q-1; Fri, 08 Oct 2021 07:11:05 -0400
X-MC-Unique: Jo9VAmcQPvmVP0721dZY0Q-1
Received: by mail-wr1-f69.google.com with SMTP id d13-20020adf9b8d000000b00160a94c235aso7048831wrc.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 04:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=beL+lHu4Yb6ST/YHe2oKhpNvDASDezmXv1HiQU4m3Qg=;
        b=GHNPDkabVZWARJvDt3ymn3Ha1cp3e4fMUofq0QXkICX2g71hOJp+/Q0HSHPq2HVfk3
         jB4c82IScPm6RTMrIlqG7IlU2BK8Y7O99MABOiMbcuwqfN9qZEfePUQs8X2Jt1aIRZhL
         ea+o9IOL3Jyz/ezOlSr8MlP5rZ0DaaH5lAsgaJar12sz1XgyKToxUybs9zaEf7o8Cgmd
         TU+RTiQqcwK6cM5ih0ejVUwBHvEHFigurClmWg2uTKeoJSu7LptSWQum5xf2evdCTL9T
         1WUFSfngSb06UVORSz+0izEcQIOxZBx5mAGfMv4JzMnYC76pr/OdspTQSbhNMoR8YU5i
         H7RQ==
X-Gm-Message-State: AOAM5313rZYzCRXBC7NfIZ3esioq6Q5ZcfVR0GxiNKBiLIQZTxbtdvNX
        zEY2ZXUO3B4dbe5QnIh5ViTCW8HayWrHiLqWlWiBNGGeCv2trzwULModMAUgE7oAV5Lq9xS2GJv
        2flmRlkD4ih0aOBfchIq2Qr1F
X-Received: by 2002:a7b:cb4b:: with SMTP id v11mr2775632wmj.155.1633691464372;
        Fri, 08 Oct 2021 04:11:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJWz/YVYFIIpOplJfuo/FOI1MaHjPWY2n3Z2/U3ORFID7I1ioP6msn33W2JQQwEvNs6r+RHQ==
X-Received: by 2002:a7b:cb4b:: with SMTP id v11mr2775600wmj.155.1633691464206;
        Fri, 08 Oct 2021 04:11:04 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z12sm780472wmk.38.2021.10.08.04.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 04:11:03 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Long Li <longli@microsoft.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
In-Reply-To: <YV/dMdcmADXH/+k2@kroah.com>
References: <e249d88b-6ca2-623f-6f6e-9547e2b36f1f@acm.org>
 <BY5PR21MB15060F1B9CDB078189B76404CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQwvL2N6JpzI+hc8@kroah.com>
 <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQ9oTBSRyHCffC2k@kroah.com>
 <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
 <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <DM6PR21MB15135923A4CB0E61786ABC22CEAA9@DM6PR21MB1513.namprd21.prod.outlook.com>
 <YVa6dtvt/BaajmmK@kroah.com>
 <BY5PR21MB15060E0A4AC1F6335A08EAB4CEB19@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YV/dMdcmADXH/+k2@kroah.com>
Date:   Fri, 08 Oct 2021 13:11:02 +0200
Message-ID: <87fstb3h6h.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

...
>
> Not to mention the whole crazy idea of "let's implement our REST api
> that used to go over a network connection over an ioctl instead!"
> That's the main problem that you need to push back on here.
>
> What is forcing you to put all of this into the kernel in the first
> place?  What's wrong with the userspace network connection/protocol that
> you have today?
>
> Does this mean that we now have to implement all REST apis that people
> dream up as ioctl interfaces over a hyperv transport?  That would be
> insane.

As far as I understand, the purpose of the driver is to replace a "slow"
network connection to API endpoint with a "fast" transport over
Vmbus. So what if instead of implementing this new driver we just use
Hyper-V Vsock and move API endpoint to the host?

-- 
Vitaly

