Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EED7441F11
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 18:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhKARTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 13:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhKARTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 13:19:24 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B152C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 10:16:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id k22so8930580ljk.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/z/u7zrhOOb0248ofbLp+UtjDibZ2pd/j9KJOwRj3AU=;
        b=T5LhsjeiajoRGWvWTMxBGyKDuGLmnF1yY6CIXbvM+oM71imu6/5kIfSpd9Y6bGro2T
         nW52jpDGjEUSPDbFLlXgCNMv2GymAhXvaXKC2LBJ2FmAsRDMkew25MXYqqMvleDcBFDe
         X9eYzjaTR62rmNQScRQbyskGLF9r1wNkfYVIYt9dsuurd7HnlcK3PAbe4D+15NR9jebk
         laF3iFQ4u5Ref+xRJetOtvABneLODG+QepiEEzdXYyD24n2HzasIoOXxZOzKe34PJzbX
         YLSQgDluMceUsJWjypmuMPOkt1l/V9Ojd7NVtEkQIYZoHfv6121SrZVQ2IfbYMiToIba
         Ex7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/z/u7zrhOOb0248ofbLp+UtjDibZ2pd/j9KJOwRj3AU=;
        b=4K0+8en4Y3pqIUJU+oeJ7be2PsHQBrzjocnFVRw/xXuRgAEY5SSEqYD5Y0o5dt5N4U
         5eXGCaCqDdc5PikFzSBFYy4B06Z5pHU40CxYjr2SGtZFvKVSFgGHTUipd8GwJbjCBYLy
         9tHzCaKH5OvBO6cspLM5h1NWH7pgaoQNBTVyu8Alh9iZpIXLaBP9Ezdg6VNz9H5llUah
         KTZuTe2v4rpRj0FQMgUK8HS9IamY3vQq2beuGbPBdbT1p5s/RhxYsEas8pUXatqDAJWg
         hHaELOyvu8fmnL+EvwP5gApf2mOHC2aFvRqmOLA/A514ZxyaC+3fBkOkfxP6YbM3hinL
         K5Lw==
X-Gm-Message-State: AOAM530kHXEA/f6crHlL9Dy0Hvr6Zt9pR/zIggnq52L/mu5SIJ6sozOt
        0XHS4b2qbI7pNUm8bCGeYLwhcsqaMQLiKPI/h0Y6NA==
X-Google-Smtp-Source: ABdhPJxdu3XY4tmRL1HtFXzkcsHDUwJgVUrYiYO9BPYkeVI4cZOU2Otj7lhLiApTrcxv7pSE7jYPKdwBQfoHLK5su6M=
X-Received: by 2002:a2e:9ca:: with SMTP id 193mr32630607ljj.83.1635787009104;
 Mon, 01 Nov 2021 10:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211028175749.1219188-1-pgonda@google.com> <20211028175749.1219188-5-pgonda@google.com>
 <c2076ecf-8b30-c96e-2169-bc1f031d309e@amd.com> <CAMkAt6rKZx=S7tRuNo-dnHw_iJ2uiDp1nzL-WiAgD+uQo+aCyA@mail.gmail.com>
 <SN6PR12MB27981792BC31C8FB0CB169B5F7879@SN6PR12MB2798.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB27981792BC31C8FB0CB169B5F7879@SN6PR12MB2798.namprd12.prod.outlook.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 1 Nov 2021 11:16:37 -0600
Message-ID: <CAMkAt6qHsAsbFsew+tijvbJNvabEiL2=iMNUxTAacL8qRH8rMw@mail.gmail.com>
Subject: Re: [PATCH 4/4] crypto: ccp - Add SEV_INIT_EX support
To:     "Relph, Richard" <Richard.Relph@amd.com>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        David Rientjes <rientjes@google.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        Marc Orr <marcorr@google.com>, Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Allen, John" <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 1:26 PM Relph, Richard <Richard.Relph@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
>
> > Does SHUTDOWN modify the SPI/NV area? Otherwise a separate comment about
> > why it is included below.
>
> Double checked the FW doc looks like it does not. Richard can you
> confirm? If it doesn't I'll remove this case.
>
> Peter,
>     SHUTDOWN does NOT modify the SPI or write to the NV area in memory.
>  Richard

Thanks! I'll leave it out of this conditional.
