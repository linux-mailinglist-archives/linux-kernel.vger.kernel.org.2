Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE4540EE59
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 02:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbhIQAbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 20:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241596AbhIQAbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 20:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631838601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a8+9SVNu2ZHQgtfu6GlimC8OO9mKCwMSWTrH27gnhz0=;
        b=Cg8imrDUYdeGcIhYKLH31Y9vrwOnbfhIl4QhDoRG+tkwC4yI11kyi7U94K+Gu2rIoAA6Pc
        370CNI49NVmxIDcMifAGeQiYnpe1DPqa/jyKMvKkXSktgSLDiIXJ94nzFDxz3FeZPDASaD
        IICHF6+F3q/vZuXwhKNTiZ2OIO8ovbA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-4bzBtOS8PsGm8HksfO1p5Q-1; Thu, 16 Sep 2021 20:30:00 -0400
X-MC-Unique: 4bzBtOS8PsGm8HksfO1p5Q-1
Received: by mail-qv1-f69.google.com with SMTP id p12-20020ad4496c000000b0037a535cb8b2so80528391qvy.15
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a8+9SVNu2ZHQgtfu6GlimC8OO9mKCwMSWTrH27gnhz0=;
        b=xruBFd1/2CwyI2Mto8YqKoWsd3FoUXs3D7o5JKRn0GRM+HTg+bMCt1XKyJ0ZiVZr68
         nhRM/fWAo4Cvh23y59pfcEIXQx1ri4k72u/T0zLorWZ27MBWOJvtC2HMqxzuzNNxfG/v
         mQ9X4sQWk7GYYWIDK8etXDUMZQOfO8StGi1XvB7Xkt7ontqSuOlNHdL0CC1YuiBOjcOE
         h55tJA8I8OOMAINspMQyjcK6ph++ahdM2E+ismciTiipquIydURKDM9BLGTJFjgxrM/f
         CEj8NGtWqePW4vGIZxa65ejph/W8bw1SImWWLft+KhuiXDOLxaIwEP/AlFbdcLYVOyA+
         NAAw==
X-Gm-Message-State: AOAM532KbYXi8zZz0AiOglt43/nC30HgOlUma3h7vy7aPFKCmCEMGX9s
        +/Ux8DDUG90BEGBgXBpnXz+lZPJJQwAhGedB6n96SeYB+dZIq00L8DDBG+NWjb9U2g5Bfo+sJ5o
        H85RzobJwsfMLEPNKAI1Hec6c
X-Received: by 2002:a37:a554:: with SMTP id o81mr7882228qke.231.1631838599986;
        Thu, 16 Sep 2021 17:29:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyMIOHSqvz3Pg8wA+G8mfHUhJtQN8oib5UDYbn+4kZKz5Vj+nJtVsgnQGqnLvmGQmNxhfgfA==
X-Received: by 2002:a37:a554:: with SMTP id o81mr7882208qke.231.1631838599699;
        Thu, 16 Sep 2021 17:29:59 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id l1sm405907qkj.65.2021.09.16.17.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 17:29:59 -0700 (PDT)
Date:   Thu, 16 Sep 2021 20:29:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/smaps: Use vma->vm_pgoff directly when counting
 partial swap
Message-ID: <YUPhhXPGlizmd4dj@t490s>
References: <20210916215839.95177-1-peterx@redhat.com>
 <738511ae-b253-9927-eca1-97d621d9f149@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <738511ae-b253-9927-eca1-97d621d9f149@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:17:32AM +0200, Vlastimil Babka wrote:
> On 9/16/21 11:58 PM, Peter Xu wrote:
> > linear_page_index(vma, vma->vm_start) of a shmem vma is exactly vm_pgoff.
> 
> Could you use "vma->vm_pgoff + vma_pages(vma)" instead of the other
> linear_page_index() then?

Sure.

> 
> But now I wonder, is smaps_pte_hole() broken? it calls
> shmem_partial_swap_usage with addresses, not pgoffs?

Hmm, that seems true..  I guess it still gets the right number when start==0
and when the vma covers the whole file (which could be the simplest scenario),
but not otherwise.

I'll add a new patch.

Thanks,

-- 
Peter Xu

