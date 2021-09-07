Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5A2402ADE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238290AbhIGOg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:36:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232120AbhIGOg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631025351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eaLboUY48g3XaNlGiNocJABzksN+CWWniJMz110LpTU=;
        b=aXpuGIGbBzTLMIIUoOntii6GBkRdo1F20slj5tbh2EVGXfDnIyhKCeMVw5yPUdNJ1vWcZz
        BQ7sZDj7aFBHk5AXZ3C4YF4xJz11lpINBhpd15MwnhQSiSEXBN+ZPZiYMCXrkh/RNQkqeL
        T3zNtupR2K0shWNlHelnwpYNTKktJHY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-jm90rmsuNPqZNaBB2EJBCg-1; Tue, 07 Sep 2021 10:35:50 -0400
X-MC-Unique: jm90rmsuNPqZNaBB2EJBCg-1
Received: by mail-wm1-f70.google.com with SMTP id u1-20020a05600c210100b002e74fc5af71so3483190wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=eaLboUY48g3XaNlGiNocJABzksN+CWWniJMz110LpTU=;
        b=USZ9GcJf3nZKZlI0yVAVYjB0nLNZeShuQ62VaiHyyLDjEQhlcgYfYY76Hr+PVXATh6
         Ejj32BV08qyyZaIHvVa3QCN+OHDtDVdZ1H1qhI4/amaW/UO9jER5RiCGQ6ydgZsKgHZ3
         U7HRLPhhkvAu7fDG2mYGK6KX0KHNIiQwI+XSBaYZLZtZ2EiSxQfV2M67bZmJwLhf2qi+
         n7bjPBIsmW362XX1JaH+NFnzBbgXZP4AAKGOM2xz06s6Owd2ZGVvc74Et6BCcs2Bk8qu
         nhTjr+EnA59vBhadQxvrWsZQ1YfcujjlAKlaAI5J3gQYIRV0kOujY9QAHnyRLuFQ+tKu
         SZQA==
X-Gm-Message-State: AOAM532VemPazVilk0nM1L0bu3ZWqO5avmYUfx3vxiiZeDaYWw2v1rtF
        tOawm4UPWd5EVGpjSDwCZF8Y4lJ01Z8VIUb3zsD0NUWWqjAFovCIR0LOC2Ln/fSY340XL75v/y+
        7zqbPT7PlvYdr7ERRv9xwbrQP
X-Received: by 2002:a1c:210a:: with SMTP id h10mr4397560wmh.117.1631025349077;
        Tue, 07 Sep 2021 07:35:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgeLpZEOpO3VKZ9adrgzeqSEIm7Dj1Y8UJhODgJPaaHR+70YSgSGN/wqeiyQwrxaLk4ZEueA==
X-Received: by 2002:a1c:210a:: with SMTP id h10mr4397542wmh.117.1631025348886;
        Tue, 07 Sep 2021 07:35:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-2.dyn.eolo.it. [146.241.241.2])
        by smtp.gmail.com with ESMTPSA id l7sm2640734wmj.9.2021.09.07.07.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 07:35:48 -0700 (PDT)
Message-ID: <ade152d7877b21adfd3b9680d729c185ef701bb9.camel@redhat.com>
Subject: Re: [veth]  9d3684c24a:
 kernel-selftests.net/mptcp.mptcp_join.sh.fail
From:   Paolo Abeni <pabeni@redhat.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, mptcp@lists.01.org
Date:   Tue, 07 Sep 2021 16:35:47 +0200
In-Reply-To: <20210907142758.GD17617@xsang-OptiPlex-9020>
References: <20210907142758.GD17617@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 2021-09-07 at 22:27 +0800, kernel test robot wrote:
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

It's not entirelly clear to me which are the relevant "changes" ???

[...]

> # 36 add multiple addresses IPv6          syn[ ok ] - synack[ ok ] - ack[ ok ]
> #                                         add[ ok ] - echo  [fail] got 1 ADD_ADDR echo[s] expected 2
> # 
> # Server ns stats
> # MPTcpExtMPCapableSYNRX          1                  0.0
> # MPTcpExtMPCapableACKRX          1                  0.0
> # MPTcpExtMPJoinSynRx             2                  0.0
> # MPTcpExtMPJoinAckRx             2                  0.0
> # MPTcpExtEchoAdd                 1                  0.0
> # Client ns stats
> # MPTcpExtMPCapableSYNTX          1                  0.0
> # MPTcpExtMPCapableSYNACKRX       1                  0.0
> # MPTcpExtMPJoinSynAckRx          2                  0.0
> # MPTcpExtAddAddr                 2                  0.0

is the referred change is the above self-test failure?

I belive this is unrelated to the mentioned commit (which behave as no-
op in this scenario). We are working to make our self-tests as stable
as possible, but there are still some sporadic failures. 

I could not reproduce this failure locally.

Cheers,

Paolo

