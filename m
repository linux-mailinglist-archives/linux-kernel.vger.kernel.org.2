Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5770A3D6DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 07:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhG0FJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 01:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhG0FJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 01:09:12 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C10C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 22:09:12 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k1so14325772plt.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 22:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jMb1KRUbiUlacJfAVD1/R8vrh+6l8zpcFNirbTWr1q4=;
        b=Yso/kk9zDSFsGRMyC/gs/cauJC8vGbPr+iUqMihO+rX6CTMTtNIqua+TvNUgtPbfYu
         KvqSzFhXJEijB4imj9I7mYJ54IITie8MTKgenGgW8uSXn1FBoxSqa0hebxLHjuFL9IaR
         MQZUY+2fd02tmll4YscUDlDhIP74HMLuip0H9/rKf5H+FFKWpRMv8NRfTHj1k/PVPVyy
         etRR4bWUS9hhtQJUF8eZsqavNk+oeWwPgbyAsmGECaxt2EL7+Hxr4QM8aoyTQP0SbA9T
         52D8/j9xLTXXhhGFygFrHx0rttkO5HtvR4Mt1+A4TnOxRx2YltlK50yNtaf1/VFprP0S
         hZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jMb1KRUbiUlacJfAVD1/R8vrh+6l8zpcFNirbTWr1q4=;
        b=RBks90iED7WB03M0IblDEyhPqddgvjgp0kkC6zuOV0GY1ZRW9SD2l1j63JaDPb9Lq0
         UTBZ4SkXI2MgpsHwXjIahZWnNGWOnvvfQRpMep2WbSLFYsbcSQBkrdlSoRaP/wLE5JbT
         qfvTKUIUtAyrUxuV5tkiSYSIKonE8olRn/Y+ZlpHC2TyDeP8JIuNCqwQxItp5fRb0UcM
         Gs1r0cOg4fuCWzPx4bvOl+dGcC9zPZyveGd0EvMvn7+AFGkOmRwAkjdWowdvoCeFvGCr
         YistV+k3xf+J6A0TY0IG9B8nBYgoE23rE5VV1RghX76Julv6lvKugT1wXoHvOr2pEF8b
         jbxw==
X-Gm-Message-State: AOAM532v1D5ScLGHHea/S0JCZOO2KVd6DM7N+whnfvvWDRUhUAgokkpu
        nnay9rtqKWhZJjs3Pd+CSjsr0w==
X-Google-Smtp-Source: ABdhPJwI0o/AFZSBs2tCGBCeJzWBzREp/9JaTjCOKUT78rlQB8bhoLyrYx24q4Coul5PQQhvFydbIQ==
X-Received: by 2002:a65:40cc:: with SMTP id u12mr17863936pgp.18.1627362551965;
        Mon, 26 Jul 2021 22:09:11 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id q4sm1913130pfn.23.2021.07.26.22.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 22:09:06 -0700 (PDT)
Date:   Tue, 27 Jul 2021 10:39:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH V3 1/5] dt-bindings: virtio: Add binding for virtio
 devices
Message-ID: <20210727050903.io6kbeotsyplt2lx@vireshk-i7>
References: <cover.1627273794.git.viresh.kumar@linaro.org>
 <fced2f2b9dcf3f32f16866d7d104f46171316396.1627273794.git.viresh.kumar@linaro.org>
 <CAL_Jsq+XXhe2g0Rmda1v_Ws4-E_-UE6X5HUsSk-GcAETqQZiCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+XXhe2g0Rmda1v_Ws4-E_-UE6X5HUsSk-GcAETqQZiCQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-07-21, 08:57, Rob Herring wrote:
> On Sun, Jul 25, 2021 at 10:52 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +    description: |
> > +      Exactly one node describing the virtio device. The name of the node isn't
> > +      significant but its phandle can be used to by a user of the virtio device.
> > +
> > +  compatible:
> > +    pattern: "^virtio,[0-9a-f]+$"
> 
> DID is only 4 chars? If so, "^virtio,[0-9a-f]{1,4}$"

It is 32 bit actually, so making this {1,8}.

-- 
viresh
