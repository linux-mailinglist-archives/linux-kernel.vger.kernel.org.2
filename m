Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282FC3CF93E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 13:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbhGTLQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 07:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbhGTLQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:16:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C77EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 04:56:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m11-20020a05600c3b0bb0290228f19cb433so1358385wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 04:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WheQ7fUX5EA867I+bv9cFye5SAD4lIhGyGX5hYkcj+M=;
        b=vhIcOCOvy5Rai9IUroGOqHvmtz2lTrczf34W0vWXkqQkyInbPoQYwfN0oToFxuLqji
         ir9eSpzqiHc4OYCUazxINKpDTodBu3AhlbpSxd7yywx03U7AmZ2V27Tz9BMu5d6Y4dqQ
         4nQTxB8Ji3Ng/pegFcNH2Lwx7Evla81MoA0JPk4OFxMNXo6T6zsBd9rZy2w3QhMQq/Rb
         /SEWgi8DzAYYNDXHhXGjJimRiuoL0wwvbGpG7AYgfjYuKeoSm2a9B6gvWOpYVLFIxC02
         SocqIuB4fm7W3uVn4Leh6atXqmdtuTkkskx06YtjEMbA/2vDqNc3uNraOjezdjS8A6iz
         V5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WheQ7fUX5EA867I+bv9cFye5SAD4lIhGyGX5hYkcj+M=;
        b=rnpxIORzoaMOevuEvY1OtZPb+HfFUIS1NNuQtYbyupqNWNF1QfuSovdTWZJwkgXXJ9
         34pMewaScGsVsVzZZHIU54Q/3U9lfBord2USZazd6B2ywROR7UPx2FFyUNSQkSdNxP9j
         F1xlk7qOhSQfzJoeGYvemaKbcvoSY1kS8jqvOgsQYlk7OHYi/20fCx3dsGkUl7BGRYmS
         Ma23gqapF+WFBL+x3pX5lsFEvPxGD5W1N5InSJwj50uoKzil69rOqHxtqg8RFLDQPfEz
         4b3f2ApgUaZ0wu5/hs6g1IgC1AoFArVW397SI/2bxi+DbR96R3uE6/V5pes/QU7piLpt
         KxBg==
X-Gm-Message-State: AOAM531/T8OEOUATbZwY+fWli57wO0zPZ4cudJYYln/G3iJn91Y0akPV
        Thkq5TTRPZgQbpx6+IYLdRqM+g==
X-Google-Smtp-Source: ABdhPJwJrV/b4HrNOBTUVc50mwLqlvQcj8GwTPDgrlDwpIuPjeOwLY1hcD8a9O+QoPfgfmLgXfG+yQ==
X-Received: by 2002:a1c:1f47:: with SMTP id f68mr31394200wmf.58.1626782216570;
        Tue, 20 Jul 2021 04:56:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
        by smtp.gmail.com with ESMTPSA id j12sm23997076wrq.83.2021.07.20.04.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:56:55 -0700 (PDT)
Date:   Tue, 20 Jul 2021 12:56:52 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 03/14] KVM: arm64: Continue stage-2 map when re-creating
 mappings
Message-ID: <YPa6BGuUFjw8do+o@google.com>
References: <20210719104735.3681732-1-qperret@google.com>
 <20210719104735.3681732-4-qperret@google.com>
 <87lf62jy9z.wl-maz@kernel.org>
 <YPV+2jQ/Q/ie14Fn@google.com>
 <875yx59ysd.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yx59ysd.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 Jul 2021 at 09:26:10 (+0100), Marc Zyngier wrote:
> Right, but this is on a different path, right? Guests can never fault
> multiple mappings at once, and it takes you a host hypercall to
> perform this "multiple leaves at once".

Right.

> Is there any way we can restrict this to the hypercall? Or even
> better, keep the hypercall as a "one page at a time" thing? I can't
> imagine it being performance critical (it is a once-off, and only used
> over a rather small region of memory). Then, the called doesn't have
> to worry about the page already being mapped or not. This would also
> match the behaviour of what I do on the MMIO side.
> 
> Or do you anticipate much gain from this being able to use block
> mappings?

Not really no, especially given that mappings of shared pages will be
forced to page granularity thanks to the other patch we discussed in
this series. I was just hoping to reduce the overhead a bit by reducing
the number of hypercalls. But as you said, this probably doesn't matter
all that much, so happy to rework that. I'll look into making the hcall
use one page at a time, and hopefully that'll simplify a few other
things in the check_host_share_hyp() path near the end of this series.

Thanks,
Quentin
