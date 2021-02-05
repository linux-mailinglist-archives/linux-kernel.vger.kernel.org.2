Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F93118CE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 03:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhBFCqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhBFCfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:35:41 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1FFC08ED8A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 15:42:46 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x23so3851883pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 15:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yeCMNeiz4/N/4CmycM03VrWoQHeIEnKdm63IdnFSFvs=;
        b=G6F+1RVEiF9GM0EvHs2dMwOril+1HpHQtrFxawa7jaZsGtTExqadaxFSbWns/QlQE7
         sBGOMYGgUG5u3thx4BD4mf7OQc34PE/NIDLjZWr6hDvTotPZRVdy08k4MsY6IXQFjhhH
         E6BMuqGZLqeJLpA3TFUPvdX8Ca1ZD6cRP9l3x07jEq/wS3GFBdPiBoDd8DDa80A1haUq
         HlqulMhUZzwPfJTGwPlKv6AkEfPoB+pB/xsrIFOaHZKIa313ecpWuy8DijhAzNH3phFK
         re793AhwZx0SZix6qReN+ocgon8HPMWIZmLyxwGLZUZiBP1xfx9t1eH9FyuRbSxZdyC2
         6rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yeCMNeiz4/N/4CmycM03VrWoQHeIEnKdm63IdnFSFvs=;
        b=JligajI5I87OZFztVablVS+7yPNstFfRTpK2cTjIcjq1hNOHIUcZOq5/cdEjMCD6fy
         ogS+BU4t7jyuCZ/UlF48yEUo1xlpJ2Dk0fZMhh6CqiQbh9wgOuCSNLUcgXoXRY6LE59E
         vgBpnxD5/sEWPTVW6uJvzuCGKz1/we0ILPVU26jrIgFAOSNbLWYFxJvOWehADZ15mQZe
         /7vpje4qVASj2xbTlLUJdu9fIfOwI/ap4co6bMWP/ykekh5CATDcfQHzq+51O9yBE+NV
         4rhfzcuH0OvrsQwi2ddS8+tHv9/dggnNmex4IzDFxFLbjWCwknmfioDbIJ1IxTZJgYD6
         ARMg==
X-Gm-Message-State: AOAM532NJBw2poBLQLuifP1qXGds28DjIpTk8SLGDOspuNnaDBE7QwQT
        paWyfj2HihPxmclJK0EEGmjhgUK1ype7vA==
X-Google-Smtp-Source: ABdhPJzs8rXXmJEdRIkq9J09L1nx4tZPgQN4YOHvffjK/M7T22mxg2Cy2BpFO09s0ByCzzarfOKUwQ==
X-Received: by 2002:a62:ea14:0:b029:1bf:f580:3375 with SMTP id t20-20020a62ea140000b02901bff5803375mr6901014pfh.53.1612568566171;
        Fri, 05 Feb 2021 15:42:46 -0800 (PST)
Received: from google.com ([2620:15c:f:10:d169:a9f7:513:e5])
        by smtp.gmail.com with ESMTPSA id k11sm9982981pfc.22.2021.02.05.15.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 15:42:45 -0800 (PST)
Date:   Fri, 5 Feb 2021 15:42:39 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH v2 13/28] KVM: x86/mmu: Ensure forward progress when
 yielding in TDP MMU iter
Message-ID: <YB3X753GYXQMXYfY@google.com>
References: <20210202185734.1680553-1-bgardon@google.com>
 <20210202185734.1680553-14-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202185734.1680553-14-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021, Ben Gardon wrote:
> @@ -505,8 +516,8 @@ static bool zap_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
>  
>  		tdp_mmu_set_spte(kvm, &iter, 0);
>  
> -		flush_needed = !can_yield ||
> -			       !tdp_mmu_iter_cond_resched(kvm, &iter, true);
> +		flush_needed = !(can_yield &&
> +				 tdp_mmu_iter_cond_resched(kvm, &iter, true));

Unnecessary change to convert perfectly readable code into an abomination :-D

No need to "fix", it goes aways in the next patch anyways, I just wanted to
complain.

>  	}
>  	return flush_needed;
>  }
> -- 
> 2.30.0.365.g02bc693789-goog
> 
