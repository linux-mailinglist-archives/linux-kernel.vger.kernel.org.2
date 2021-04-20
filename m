Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE27366006
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 21:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhDTTJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 15:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233621AbhDTTJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 15:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618945714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xzIxCQz9dJkrU2k2A9+BTpoRFh3xXkAwoj6J7/2c9z0=;
        b=ZNAzOsp2LQO9ek0AGt9zv3R2RtBDdl7NdxL0LdP5dxVULaECMy1K2HgKFfCRe5650LxpXq
        zgTkRj34Zt2LGbdTEPfzh+MMxKJo0HX1KqzFcBs10QUdq4T6a6X3C35Am+mMyR69ish+L7
        qrqUoIe87VahiqUGTaWsKQFqYFN3khI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-DAGPBlP9PmWfNHYschVBvA-1; Tue, 20 Apr 2021 15:08:30 -0400
X-MC-Unique: DAGPBlP9PmWfNHYschVBvA-1
Received: by mail-ed1-f72.google.com with SMTP id y10-20020a50f1ca0000b0290382d654f75eso13631337edl.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 12:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xzIxCQz9dJkrU2k2A9+BTpoRFh3xXkAwoj6J7/2c9z0=;
        b=DRewH4X83pow57qu8xBs9pLvUkUVIRm68/yPDUDMhhVJlEqsUsWTG2tRCsQAmxPb9k
         Z4zRasAs1ipRiXDBYxGHEBA4beOjx/vxCf5o4WEOmo2brQEFy9qBd4h0vmuvrS+7B1RB
         zl9/wmNWRHx6R6L22+bd+3+GdFWN7xcNMwFtFXPKcVpq24wJmtCaJd+VjLosujWuZhhW
         d3Smo5yWA7+Uiugjv7hCvLqzFrGtn1MDBrp/NL/dIvZSve0OxgvsFWEsDkor/zmKMm1O
         a4pQaTrCSEKkfp7WQwkKbFHICTfkHRZ1ukfTxkR1a2+UUJBluvzoHAMz77XJUpeRvWxJ
         huHQ==
X-Gm-Message-State: AOAM531I7xnDjLXj6yfLE0q9/we9T3pBxbEP6kbvxQZhSCjMefRsbhes
        h2QhC0Z7JVP/R4Lj5GXMf71/E8xmnDqhFo5yeTiM7xXaDSTW3UOD7qa60enNrnHNb8l0xDm0s0H
        SdB4550BXZFil68mGno9IsRu0
X-Received: by 2002:a17:906:70c4:: with SMTP id g4mr16664466ejk.443.1618945709508;
        Tue, 20 Apr 2021 12:08:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGqxHNHbZCDe6mb7p2nY9TIgzHG0FAEjVhnv9ou4NsLim5ASSKjnjjCS5e+6dzUm7Xi6wHGw==
X-Received: by 2002:a17:906:70c4:: with SMTP id g4mr16664445ejk.443.1618945709367;
        Tue, 20 Apr 2021 12:08:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id g26sm13413869ejz.70.2021.04.20.12.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 12:08:28 -0700 (PDT)
Subject: Re: [PATCH v13 00/12] Add AMD SEV guest live migration support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        thomas.lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        seanjc@google.com, venu.busireddy@oracle.com, brijesh.singh@amd.com
References: <cover.1618498113.git.ashish.kalra@amd.com>
 <65ebdd0c-3224-742b-d0dd-5003309d1d62@redhat.com>
 <20210420185139.GI5029@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4deae424-85c1-57a7-3952-23d1d65e30ab@redhat.com>
Date:   Tue, 20 Apr 2021 21:08:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210420185139.GI5029@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/21 20:51, Borislav Petkov wrote:
> Hey Paolo,
> 
> On Tue, Apr 20, 2021 at 01:11:31PM +0200, Paolo Bonzini wrote:
>> I have queued patches 1-6.
>>
>> For patches 8 and 10 I will post my own version based on my review and
>> feedback.
> 
> can you pls push that tree up to here to a branch somewhere so that ...

Yup, for now it's all at kvm/queue and it will land in kvm/next tomorrow 
(hopefully).  The guest interface patches in KVM are very near the top.

Paolo

>> For guest patches, please repost separately so that x86 maintainers will
>> notice them and ack them.
> 
> ... I can take a look at the guest bits in the full context of the
> changes?

