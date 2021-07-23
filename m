Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2903D3A02
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhGWLeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbhGWLeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:34:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C113C061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 05:14:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o1so2139368wrp.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 05:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XAJbbJ2Fhb95D1bufSM9Sll38F8qYBcxQt3PahKULLo=;
        b=OHFHerECKRQuofmF4bzLbdsCWKHWrPzmTLptlrNBwaogFJGOXmtLabF1gPwUu3fXsD
         wek/Kecjhu1p1WHOxKPdXNAvDCes/dfwWjiQg+93bo7CauraR418vYOLC2XJ6Kfhiom9
         0JFDEQSCKzbSjgeDMb/dcmcsfcN+qo7JuiDkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XAJbbJ2Fhb95D1bufSM9Sll38F8qYBcxQt3PahKULLo=;
        b=Qppgg5zeJXvIeXxD35RxezQdjc6pDxplvDYCciZE0MceYRTJZ8eIfCZnmXrF45Hgbi
         c+EjKjVhMH+xC5zTLWqzxeD6KbtVWCiD/dPCeXvF5+zzc/DZWj9G+DXb6D5qowLAvCdn
         4pr07Ox1+sEAe2Dd+UPwTvkY8FC2jOz/HNVJOIFdcous1zHAQHygDZ8rGgrKCGkW206f
         OqSk2EnErBOWBBAOIYFVkUlEJ87Bihf0rxbVuPmcmY9OtWFOXlGBx28XzRLnChpAEvtS
         eQR5B678LnglCr8TS3T8KKyBjAhGZ3xGXj6Z+IXf/vOrd/82ICJ+WIVIE7RkukagiZGX
         d1wg==
X-Gm-Message-State: AOAM531AVRdaV2bQFb19D1ZuVh3zqaxRgEQLOmtrsP1yH7YV6im3ugN4
        reULBA4oLOrtea/zkNw8RsMdxQ==
X-Google-Smtp-Source: ABdhPJyAIq5ghCjE0vy5rcG9LcABJkjlflIDedVx1xH4vmIYNuGA8a2XRUmZf9WLbrKvMG2657E6Ig==
X-Received: by 2002:adf:d086:: with SMTP id y6mr5267284wrh.247.1627042483608;
        Fri, 23 Jul 2021 05:14:43 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:d571])
        by smtp.gmail.com with ESMTPSA id z25sm27965559wmf.9.2021.07.23.05.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:14:43 -0700 (PDT)
Date:   Fri, 23 Jul 2021 13:14:42 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the printk tree
Message-ID: <YPqysrTYsD7G0llm@chrisdown.name>
References: <20210720174300.018cc765@canb.auug.org.au>
 <20210723090136.04ca2091@canb.auug.org.au>
 <YPqkpsc/k0tXfISe@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YPqkpsc/k0tXfISe@alley>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

Petr Mladek writes:
>I am sorry for the delay. I waited for a patch with reasonable commit
>message from Chris. I did it myself after all.

My sincere apologies for the delay. I had it in my calendar to do yesterday 
afternoon, but ended up with no time left :-(

Thanks Petr for pushing them, and sorry for the trouble caused.
