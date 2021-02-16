Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE24131C808
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhBPJ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbhBPJ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:26:08 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20909C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 01:25:28 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o24so13711698wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 01:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Exh3jg3n/TtKnZWGfFfDIiOa1Lq+MYGlC1ET8Iputzc=;
        b=FChGD3IiT+eQbJpCR9t7O50n/LmrueYQUvA0eedPnhjL5FwTbBAttUChubzubHzzE+
         TeFuh3DkLKYTv67VzE91ha47D+tgaEiPVy7rJ8lWsQfLHaZRVt0jwRWzxCBbPr4HwnVv
         asszquvZj2WmDxHU3OWs1baFcapv1QK36SGy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Exh3jg3n/TtKnZWGfFfDIiOa1Lq+MYGlC1ET8Iputzc=;
        b=UiEvQGocy+gDutekLoRPI4mekgDLkNiJDbw6cAw/46qSiBZJwUpBmm04Ipc4dK9pkb
         PYg9csPvBlvORGvErFQ/7ssseLtXtzebmWWQB/npUmPbDhh5LfSCA23O9K6nXZ89JxYw
         UdI6Bwn67TdX/nvLgyRIZc0TJkspzcQt5Dzi5V69wW66QgeXEFnEgVW1XB17/0Bwb3vi
         xwL78C1qZjzIKpWNL/hg3CjjmbiTWKvtGQNLjZ3OSdvNcDL8f+fhJwzdhDY+uwLVuPPH
         3gfBfOMuQMiB3kUxlFkj3b5E2xx22PaLcxp+EeCrLw+2+oy3fyd1j5uxZ7R5CQhQHyDU
         fuFQ==
X-Gm-Message-State: AOAM532UEO0VKIOKLH0knJTwTUKBjVYBBH5sLZzRQjPzLUqKDqjqFNGA
        //SdkIpnOaarRGufBlRXQ0zEW3BFl5Fq82JC
X-Google-Smtp-Source: ABdhPJxCH8w9nrCrGj6DLgq7mUqO7jid+0L9+xJ/lCXaA3/b39BYFgNSlxIAXTKGgH2NqCvGcPhA6A==
X-Received: by 2002:a7b:c010:: with SMTP id c16mr2501284wmb.134.1613467526735;
        Tue, 16 Feb 2021 01:25:26 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k11sm26838869wrv.51.2021.02.16.01.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 01:25:26 -0800 (PST)
Date:   Tue, 16 Feb 2021 10:25:24 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org,
        lkml <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Sharma, Shashank" <Shashank.Sharma@amd.com>
Subject: Re: DMA-buf and uncached system memory
Message-ID: <YCuPhOT4GhY3RR/6@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org, lkml <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Sharma, Shashank" <Shashank.Sharma@amd.com>
References: <91ff0bbb-ea3a-2663-3453-dea96ccd6dd8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91ff0bbb-ea3a-2663-3453-dea96ccd6dd8@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:58:08AM +0100, Christian König wrote:
> Hi guys,
> 
> we are currently working an Freesync and direct scan out from system memory
> on AMD APUs in A+A laptops.
> 
> On problem we stumbled over is that our display hardware needs to scan out
> from uncached system memory and we currently don't have a way to communicate
> that through DMA-buf.
> 
> For our specific use case at hand we are going to implement something driver
> specific, but the question is should we have something more generic for
> this?
> 
> After all the system memory access pattern is a PCIe extension and as such
> something generic.

Yes it's a problem, and it's a complete mess. So the defacto rules are:

1. importer has to do coherent transactions to snoop cpu caches.

This way both modes work:

- if the buffer is cached, we're fine

- if the buffer is not cached, but the exporter has flushed all the
  caches, you're mostly just wasting time on inefficient bus cycles. Also
  this doesn't work if your CPU doesn't just drop clean cachelines. Like I
  thing some ARM are prone to do, not idea about AMD, Intel is guaranteed
  to drop them which is why the uncached scanout for integrated Intel +
  amd discrete "works".

2. exporters picks the mode freely, and can even change it at runtime
(i915 does this, since we don't have an "allocate for scanout" flag wired
through consistently). This doesn't work on arm, there the rule is "all
devices in the same system must use the same mode".

3. This should be solved at the dma-buf layer, but the dma-api refuses to
tell you this information (at least for dma_alloc_coherent). And I'm not
going to deal with the bikeshed that would bring into my inbox. Or at
least there's always been screaming that drivers shouldn't peek behind the
abstraction.

So I think if AMD also guarantees to drop clean cachelines just do the
same thing we do right now for intel integrated + discrete amd, but in
reserve. It's fragile, but it does work.

What we imo shouldn't do is driver private interfaces here, that's just
going to make the problem worse long term. Or at least driver-private
interfaces that spawn across drivers behind dma-buf, because imo this is
really a problem that dma-buf should solve.

If you do want to solve this at the dma-buf level I can try and point you
at the respective i915 and amdgpu code that makes the magic work - I've
had to fix it a few times in the past. I'm not sure whether we'd need to
pass the dynamic nature through though, i.e. whether we want to be able to
scan out imported dma-buf and hence request they be used in uncached mode.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
