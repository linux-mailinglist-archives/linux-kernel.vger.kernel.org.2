Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815E23D7B29
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhG0Qhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229569AbhG0Qhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627403852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ANeePT+43ICSmK2dUrsUfTd9Zca9C1s5AnKaXEKa2c=;
        b=d8QMG8Y2d02pylZg8LGBaR1XgX+7nljkhd6ifUZ9TXeijRv1i93xorb+rCETFN9icIm43q
        CV2UF69Gj7YaydBodEYaENp6ddHcwcIsbunMWIU3o26ewFnFbB6kug8mPHmyhtYbg6o0tp
        5FFD85U/rbC+ugv/63dcuFLsjxLG6Kc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-R5wvztw_M3Ce9ejqwLSEYw-1; Tue, 27 Jul 2021 12:37:31 -0400
X-MC-Unique: R5wvztw_M3Ce9ejqwLSEYw-1
Received: by mail-qv1-f69.google.com with SMTP id t4-20020a0cef040000b02902e2f9404330so11039764qvr.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ANeePT+43ICSmK2dUrsUfTd9Zca9C1s5AnKaXEKa2c=;
        b=kgYMaTxwQb671HcneP+bt9CtcoEX+Ti1afJhjjdJ/TPsC9nD+Fac3BgaX700UqAYim
         p91E/2FMPQjvfwug20acb8cx1NmjHJSNy1AkDW2y79FQ4hKfF5V0OL8ZA2d4BbtBewUq
         rwOX0/a0B2ftmq8MtEb/iu7hc9h1Dpvf3m3aqoDO/Q01E835IyR5MlmiI2P3rQdxW36D
         Zi/bonNBGxufoMos83aPUUw87Zp6kZDcvuzrW/Uwwxb95E/8G4leqwHEepy1yHXq/6G+
         lrZaYpqJsG/AxqIsigE4XCrevK8nJewks2UyX+xKhvtt/FJKueEo1K0Msoez5OTM/bHi
         PIZg==
X-Gm-Message-State: AOAM532hwL1y5m2BgMT52CnI4WK/nyQRFeCdcejfva79eIzg1OlF5HxP
        9xVr7Rpc8KsXg5SjLCuYBNlEHnwG+qicT1hP6t9EUTn9ZMIBPNqx5y57Y/43/L1pF3nwFz6LU3a
        RoSm2YBJ3zU/aDSvBIK6ynoEj
X-Received: by 2002:ac8:5e51:: with SMTP id i17mr20344143qtx.359.1627403850662;
        Tue, 27 Jul 2021 09:37:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDQsbbsrXenTdjPv86mVGmdBOGQVu2pmX3xKpk7XYeSnBZwhGNzhI7fDt1yKeYtA38O9vNIA==
X-Received: by 2002:ac8:5e51:: with SMTP id i17mr20344127qtx.359.1627403850467;
        Tue, 27 Jul 2021 09:37:30 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id x28sm1720510qtm.71.2021.07.27.09.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 09:37:29 -0700 (PDT)
Date:   Tue, 27 Jul 2021 12:37:28 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] ioctl_userfaultfd.2, userfaultfd.2: add minor fault
 mode
Message-ID: <YQA2SC4ecPh7cz7f@t490s>
References: <20210604195622.1249588-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210604195622.1249588-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 12:56:22PM -0700, Axel Rasmussen wrote:
> Userfaultfd minor fault mode is supported starting from Linux 5.13.
> 
> This commit adds a description of the new mode, as well as the new ioctl
> used to resolve such faults. The two go hand-in-hand: one can't resolve
> a minor fault without continue, and continue can't be used to resolve
> any other kind of fault.
> 
> This patch covers just the hugetlbfs implementation (in 5.13). Support
> for shmem is forthcoming, but as it has not yet made it into a kernel
> release candidate, it will be added in a future commit.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

FWIW:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

