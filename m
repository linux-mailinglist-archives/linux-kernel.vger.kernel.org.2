Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A338CE9F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 22:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhEUUJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229451AbhEUUJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621627691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6SLlOvYcpJb9PnH2v8qQWMs/sPrQdiipYeANWUm+37s=;
        b=ivdMdBP8O0cxRvV2wEKYfo8GcnjzfXA7DUFbLjidd3HpehhdrAqVpkgSUDux4YzLcZFxHc
        bZl8fm2GNpZbPjQiaUc1fAmqygVwudJ8wWHlpqoP7L3z0bI11ONVEgBT1EbCUjwPC5NRdA
        +vBdYAtyTfE6JKnnqD5qjuylVUN9JD8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-bbDC2A12ML6A72IVDnK4jQ-1; Fri, 21 May 2021 16:08:09 -0400
X-MC-Unique: bbDC2A12ML6A72IVDnK4jQ-1
Received: by mail-qv1-f72.google.com with SMTP id n12-20020a0cdc8c0000b02901efdf8d3bc7so15418159qvk.23
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6SLlOvYcpJb9PnH2v8qQWMs/sPrQdiipYeANWUm+37s=;
        b=smDGUYp1Nbkc31uoVV7qyolQa0b9oiekC2KOk7GYDoj7BA6dDqDIaEucBS7Gc1JuAw
         aAjtIbvaNI5IepQQDkHTzkd/Uy4pprt9OqCbY2cNY67990aP7M6+7aPPd3OBlMEGO2xG
         kEf1NpWmX1/71NNVQydFabWb8TFWTAwpOmAgWnIer3O2l3QRb1qvLUnPjuY6UpzCS0ga
         DKmKS3tjMFSk+pqx+i9KCDLIVfzClGvaRjSBt8dLgPDtJ4+SP7wOdi9S4jpQv8ffPWeb
         gXwO6oqUWOGEmZJV7yHUcAiX02br+hqlKh7O5cUPAIJf2oGSOjQphMgKW99p+aTtt/YF
         YQKg==
X-Gm-Message-State: AOAM532d663PmYmhsVXic774gp6LWSdWGss+2M3fReDlfK7cGFOvqSQR
        FZbRI1jOadXfuvHr9X59drJlJ0rHE6vBgqaiTfHnsfzRkO2FQak44/TsTu1AkMhAUr6cZoBRe6m
        8pUnOxniwvIfmE/D0G7L5gUqB
X-Received: by 2002:ad4:5f07:: with SMTP id fo7mr14729651qvb.54.1621627688942;
        Fri, 21 May 2021 13:08:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzzSaiCm9wXeWJHd3potrPtUisr0+MximgUPLbaSdQjQsFQj8zMXuNhj2iGG7ireBg86+TEw==
X-Received: by 2002:ad4:5f07:: with SMTP id fo7mr14729622qvb.54.1621627688639;
        Fri, 21 May 2021 13:08:08 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id y8sm5334555qtn.61.2021.05.21.13.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:08:08 -0700 (PDT)
Date:   Fri, 21 May 2021 15:08:06 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        ardb@kernel.org, jthierry@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, jmorris@namei.org, pasha.tatashin@soleen.com,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/2] arm64: Introduce stack trace reliability
 checks in the unwinder
Message-ID: <20210521200806.nk3m7aldelmi3l2r@treble>
References: <20210521161117.GB5825@sirena.org.uk>
 <a2a32666-c27e-3a0f-06b2-b7a2baa7e0f1@linux.microsoft.com>
 <20210521174242.GD5825@sirena.org.uk>
 <26c33633-029e-6374-16e6-e9418099da95@linux.microsoft.com>
 <20210521175318.GF5825@sirena.org.uk>
 <20210521184817.envdg232b2aeyprt@treble>
 <74d12457-7590-bca2-d1ce-5ff82d7ab0d8@linux.microsoft.com>
 <20210521191140.4aezpvm2kruztufi@treble>
 <20210521191608.f24sldzhpg3hyq32@treble>
 <bf3a5289-8199-b665-0327-ed8240dd7827@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf3a5289-8199-b665-0327-ed8240dd7827@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 02:41:56PM -0500, Madhavan T. Venkataraman wrote:
> > Or is frame->reliable supposed to be checked after all?  Looking at the
> > code again, I'm not sure.
> > 
> > Either way it would be good to document the interface more clearly in a
> > comment above the function.
> > 
> 
> So, arch_stack_walk_reliable() would do this:
> 
> 	start_backtrace(frame);
> 
> 	while (...) {
> 		if (!frame->reliable)
> 			return error;
> 
> 		consume_entry(...);
> 
> 		ret = unwind_frame(...);
> 
> 		if (ret)
> 			break;
> 	}
> 
> 	if (ret == -ENOENT)
> 		return success;
> 	return error;
> 
> 
> Something like that.

I see.  So basically there are six possible combinations of return
states:

  1) No error		frame->reliable
  2) No error		!frame->reliable
  3) -ENOENT		frame->reliable
  5) -ENOENT		!frame->reliable (doesn't happen in practice)
  4) Other error	frame->reliable  (doesn't happen in practice)
  6) Other error	!frame->reliable


On x86 we have fewer combinations:

  1) No error		state->error
  2) No error		!state->error
  3) Error		state->error
  4) Error		!state->error (doesn't happen in practice)


I think the x86 interface seems more robust, because it's more narrow
and has fewer edge cases.  Also it doesn't have to distinguish between
error enums, which can get hairy if a downstream callee happens to
return -ENOENT for a different reason.

-- 
Josh

