Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0393FF17E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346355AbhIBQes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242414AbhIBQer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630600428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9NTiKCExUohA1RnKrGeOhWiFFdORAso6f2Gqba6jrGk=;
        b=SXzOXYAN0yWIBV7JrbSZsq3UGFgNGNoc4+BkseHcopCssbKFShBfYyIeXMLmn82ORgsMj6
        VI/FrEwpTYISEl9QqO1nKJ5rp0qeou6vma+CpPEgPX/Z3cbGvzMNH/xnBkkRecGZZNA6uH
        /sYjdz9uOWNmaiKBSeDQ7DG2ZcU3Q7o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-ekYcrSR8MFi5fdkdMTmnag-1; Thu, 02 Sep 2021 12:33:47 -0400
X-MC-Unique: ekYcrSR8MFi5fdkdMTmnag-1
Received: by mail-wm1-f71.google.com with SMTP id s197-20020a1ca9ce000000b002e72ba822dcso1263474wme.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9NTiKCExUohA1RnKrGeOhWiFFdORAso6f2Gqba6jrGk=;
        b=D8GD7gGam0UmFDd9DNFebllaDAO3qEraMFVCKwEcjNfHteCf1hSzmgBo8w4RQL+Tr6
         xAHMGjQyJcaknszslc4Xyp+ld3dFXk/zYUn4OJl6Noz25jLyWuhSzyW9PA8SPxqOWe3i
         2NMu3iKxtH/3IxhBajHmaPBVVhZpdFtcandBdPenEwX3GMDJCy0FD5hjul8Wg7XfaBiQ
         gH2ehp2bDHBnm5tfO2A9qeeo7VCGWVfsInF9NdGwtESGPkAdXr6+ipJrZoSm1W5bG7+q
         YbLp7KeNMvZjyjJ8bsJuTIOBW+vHvmmhUabajRjUperyrk8cAeOfOo6gviMz4eoVMJYz
         dPjA==
X-Gm-Message-State: AOAM530Lval95P4r094UIhkEx4k+rPRFZZchQaYzBnj/IHmSECzVv7Li
        hXfhEPPttvnFaVPwBN9IRiepQry+CthsuyILflInfOSjwmR0kWS4xDUX03QQmddGfhy35VJWU7O
        1FDa5EDBFx3q1/DURpOWe0/nK
X-Received: by 2002:adf:b7cd:: with SMTP id t13mr4959386wre.63.1630600425923;
        Thu, 02 Sep 2021 09:33:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyosl8fLbBGrVtecJ67AaS0YdU+coBLRMcBv/DIsoOBrebeZ7AwYCjGOR/CMCn2/9XuEaN7hQ==
X-Received: by 2002:adf:b7cd:: with SMTP id t13mr4959365wre.63.1630600425761;
        Thu, 02 Sep 2021 09:33:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a6sm2166968wmb.7.2021.09.02.09.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:33:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] KVM: Drop unused kvm_dirty_gfn_harvested()
In-Reply-To: <20210901230506.13362-1-peterx@redhat.com>
References: <20210901230506.13362-1-peterx@redhat.com>
Date:   Thu, 02 Sep 2021 18:33:44 +0200
Message-ID: <87y28flyxj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> Drop the unused function as reported by test bot.

Your subject line says "Drop unused kvm_dirty_gfn_harvested()" while in
reallity you drop "kvm_dirty_gfn_invalid()".

>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  virt/kvm/dirty_ring.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> index 7aafefc50aa7..88f4683198ea 100644
> --- a/virt/kvm/dirty_ring.c
> +++ b/virt/kvm/dirty_ring.c
> @@ -91,11 +91,6 @@ static inline void kvm_dirty_gfn_set_dirtied(struct kvm_dirty_gfn *gfn)
>  	gfn->flags = KVM_DIRTY_GFN_F_DIRTY;
>  }
>  
> -static inline bool kvm_dirty_gfn_invalid(struct kvm_dirty_gfn *gfn)
> -{
> -	return gfn->flags == 0;
> -}
> -
>  static inline bool kvm_dirty_gfn_harvested(struct kvm_dirty_gfn *gfn)
>  {
>  	return gfn->flags & KVM_DIRTY_GFN_F_RESET;

-- 
Vitaly

