Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54171443338
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhKBQmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbhKBQmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:42:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A566C0613F5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:05:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u17so7849708plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5B0niJFAo1yLajXmzI/5umMieXRxykE+f7gBMAitL9o=;
        b=Iw5Up6RHONQ29BqFjlltSOSNnScDVJl216dFmvRibW5KmOuLkvHI4DT06vmKyUv7/E
         wp79P+u7DSIY6KYclSQsNVPMutubWmEJlcCf7sBhDYsOwS5rZomieoealHfBJ/mVC1jR
         6rGhDXboSMu0RuH4A/bF0CWukrwkFtLyHYLa5ihg8ilvdv//emZ7pN4+0wVJWW50T4SP
         MA/J8te/VHCjudMrgh5bWfu9HLhyD8EO10R5/4txavkb0hJqUNL5qT132Hrv2HGX5Vg9
         fH5NZhvdpaq8nm9YLPKcvHSS6RGg45y3KHahyi9HpxZOORoZi2os2clRSu1Axxd+wIoL
         aEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5B0niJFAo1yLajXmzI/5umMieXRxykE+f7gBMAitL9o=;
        b=PVMJ0H6LiKFwNEzB34eGVPWVH+iiOfLX8kx8Ys/3H8A62fUYXHc1DzJrfVrSnf5Hca
         nSA/n7mycQxawwVDiieGv852A0dNn0Klb+6niP25Cn4085vMCS/20ua+w7mZqh/NXqm8
         bDGfA+WCn+vhvDcLtUylKfj5GLm/PlAc7TUBPmv7E4uh7vHtAPpy2PXYt2s94QSoBhUa
         aVC9PPcBHXVFbC9TR4riVI6pkGk0BPMJDgxlRK8dgrcUqj0+s0TQHS42FJD9aqxOc6RB
         KVEgaqc0ve9UADKwdL3tdDC66usEE3D/00gxV5bRJyRlhvQqGwJup/i0Bvap+MssjxBm
         gLsA==
X-Gm-Message-State: AOAM532xuLwYXK3oRyU9ftsttyd6JJ7DdGEPo80NIbcXWnfL+2BFErqY
        e8CjBL1uUKzytt7mEo04mepQkA==
X-Google-Smtp-Source: ABdhPJwRFVZqB/o9nUXVNlwNLZdudVoI5JAZf8giGWa6nGcBFS6nBP93XKgetD+wt5hRYP3Sm6vnQQ==
X-Received: by 2002:a17:902:e88f:b0:141:f982:777 with SMTP id w15-20020a170902e88f00b00141f9820777mr10055720plg.68.1635869155805;
        Tue, 02 Nov 2021 09:05:55 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o4sm2687173pfu.130.2021.11.02.09.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:05:55 -0700 (PDT)
Date:   Tue, 2 Nov 2021 16:05:51 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     thomas.lendacky@amd.com, Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 0/4] Add SEV_INIT_EX support
Message-ID: <YYFh323otsIauvmH@google.com>
References: <20211102142331.3753798-1-pgonda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102142331.3753798-1-pgonda@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021, Peter Gonda wrote:
> SEV_INIT requires users to unlock their SPI bus for the PSP's non
> volatile (NV) storage. Users may wish to lock their SPI bus for numerous
> reasons, to support this the PSP firmware supports SEV_INIT_EX. INIT_EX
> allows the firmware to use a region of memory for its NV storage leaving
> the kernel responsible for actually storing the data in a persistent
> way. This series adds a new module parameter to ccp allowing users to
> specify a path to a file for use as the PSP's NV storage. The ccp driver
> then reads the file into memory for the PSP to use and is responsible
> for writing the file whenever the PSP modifies the memory region.

What's changed between v1 and v3?  Also, please wait a few days between versions.
I know us KVM people are often slow to get to reviews, but posting a new version
every day is usually counter-productive as it increases the review cost (more
threads to find and read).
