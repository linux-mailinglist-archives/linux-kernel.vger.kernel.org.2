Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AAE347ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhCXObs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236217AbhCXObM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616596269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jtHaYpG/XZInPp8hHHKOOdzU2YSMvIuIW7BEJkipo8=;
        b=KqHRh/Wf0nk6pudXDypiBEZdt2ZySsNSFvB0+AwMW8iM9l8er6jJchvGa+bZCd0Y4XgpGB
        YOgogUzZbiMSn1adlCNR5db37w7xTrG+n7Dan2O8Y3fIKmyi8mh+o+hy1BEkak80RzOvXO
        CPKR/pfnFsYMdXU0gbmkwypkjF3r3PU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-StgQD8mhM_Gsnd5QZIXHCw-1; Wed, 24 Mar 2021 10:31:07 -0400
X-MC-Unique: StgQD8mhM_Gsnd5QZIXHCw-1
Received: by mail-wr1-f69.google.com with SMTP id p15so1146838wre.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+jtHaYpG/XZInPp8hHHKOOdzU2YSMvIuIW7BEJkipo8=;
        b=SvNA+sx2WYoDfCvDGcG6Borlld4ftXITD7JoOrBkTY4qf5Yf+YJ8vc+ct7V6MY4z5I
         ozEVXzgjPjQlkklNk8Lur2mY04M9HM06CfUWMq5CnTPqirapRYAUV4NoHGrobJeN+VCK
         fJo55SsH1d3FNJni44lsg3y2c5nPTdrDbhoHV5Uche1AROWtnHfvnPSvB3osyai85dcI
         wa+1Uo63KGrB1a19+1Sa+2Cornp2RhtxK4xn7OsP8RxmNHMTFVg2imuT7JPqnDilgK1p
         2DjusZbeS8npLdPYWznLv+OZKSS++1lanMnZWiIqKQdp13CaB7INCjfpefU4FepUe/NC
         SSOQ==
X-Gm-Message-State: AOAM5318nd6qUqdbThl1YM8Y+jBPSYFyATWlLipwt3il7y5tN43uFD/k
        1pxzmBW3mLZD3jXfe3AfY4254pS0ihsVQMylByOCB5szV23Xt969LnTQCdt6Lh5nqOKz5NCLgXd
        rg9+/EN4m5Mk4dczIyQyV7F4l
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr3977875wrw.247.1616596266460;
        Wed, 24 Mar 2021 07:31:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIf+VryoTPSfwti+YSTkQ2E1C0/b6Xuw3ivYfNPK4a9PF7c1OO41KjvaTv9A51GLRMrRGgKA==
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr3977856wrw.247.1616596266249;
        Wed, 24 Mar 2021 07:31:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u8sm3366640wrr.42.2021.03.24.07.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 07:31:05 -0700 (PDT)
Subject: Re: [PATCH 3/3] mm: unexport follow_pfn
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        3pvd@google.com, Jann Horn <jannh@google.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20210316153303.3216674-1-daniel.vetter@ffwll.ch>
 <20210316153303.3216674-4-daniel.vetter@ffwll.ch>
 <20210324125211.GA2356281@nvidia.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1a46866-cbc7-4e7f-0e17-79fee57b32a0@redhat.com>
Date:   Wed, 24 Mar 2021 15:31:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210324125211.GA2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/21 13:52, Jason Gunthorpe wrote:
> I think this is the right thing to do.
> 
> Alex is working on fixing VFIO and while kvm is still racy using
> follow pte, I think they are working on it too?

Yeah, or at least we have a plan.

Paolo

