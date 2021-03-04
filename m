Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD95532DAC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbhCDUB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbhCDUBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:01:38 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DAEC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 12:00:58 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id h13so1343189pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 12:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DZ9JIPjRlQrxm5gBVz908554FQTvWTlvFh8a4RdvXkQ=;
        b=FiGeRXYjnThBVK1bW7nY3KGkcqjRiuiPibElJxzUfzveAM7XCAJXO2APF55vEzdRzT
         E0GvRofOT0x06iptzB3bTppkX3PXQoScIltG+brYFPhmqEEg4QZMlCWaqCqacMh83NKm
         bUvq7MfwVVNX+QLjeReDLSWUeEB/YUyqBo36Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DZ9JIPjRlQrxm5gBVz908554FQTvWTlvFh8a4RdvXkQ=;
        b=qLkSoFhKl6z7BshH71vYdDI1wsyItD+wnoZL4eX7TM2G+cW+xcry306OVqaXIcbQW2
         ljjXaFVqgPQyAE8f6NnCaBJV3oaoV5nHwjboG+MRZA2tDbzYvdEeQkgvAdEWcXRZWPvn
         Qx108JiN4mAm5/C9HwdL6rqMtbvdfYig/0zp9b1oj1TSazIFAjyw+zv7RQZZSLfV6EIQ
         hIx7V39vfpzCSwxhLsNSvIMAXCGovuQ7sbKGbBDTEX5TYZLVHp5NZYDrQJCcaH3gJfM6
         ydDIKUu+hz77kjt2KDZsf4rdXwmjLj/u6Gro/hQbbu2usgSKsbrniHvcXDaTtveMOolX
         loMw==
X-Gm-Message-State: AOAM533kZPaV4NYvHng321LyayN/lbiRu1W/dVdUAdql6hwZo8VRVBl0
        Eegj48fDHOSbxbpiKzGnY/bCZg==
X-Google-Smtp-Source: ABdhPJxcp2ZPgYliuHW2Dbu754tmWlf9YNiow/ZD+SJfh1QGOVwkN/PYVSiXnpEdgeEQJU1Ul58FvQ==
X-Received: by 2002:a17:90a:8505:: with SMTP id l5mr6146108pjn.100.1614888057676;
        Thu, 04 Mar 2021 12:00:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 138sm194942pfv.192.2021.03.04.12.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 12:00:57 -0800 (PST)
Date:   Thu, 4 Mar 2021 12:00:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Hsuan-Chi Kuo <hckuo2@illinois.edu>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Possible bug kernel/seccomp.c
Message-ID: <202103041200.54C6009@keescook>
References: <83ebb916-20de-dba5-a5a2-c7f120ba7b21@illinois.edu>
 <84856991-dd5e-c2d6-0a0e-1c05097a1b86@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84856991-dd5e-c2d6-0a0e-1c05097a1b86@illinois.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 01:14:16PM -0600, Hsuan-Chi Kuo wrote:
> cc mailing list.
> 
> On 3/4/21 1:10 PM, Hsuan-Chi Kuo wrote:
> > Hello,
> > 
> > Should this line be atomic_read(&caller->seccomp.filter_count));
> > 
> > https://elixir.bootlin.com/linux/latest/source/kernel/seccomp.c#L600
> > 
> > I think the desired behavior is to synchronize the filter count.

Yecch. Yeah, that's a bug. Thanks for noticing that! Can you send a
patch to fix it?

-- 
Kees Cook
