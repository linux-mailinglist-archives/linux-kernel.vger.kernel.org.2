Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B863D97C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 23:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhG1Vv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 17:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230156AbhG1VvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 17:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627509083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BgiDqK985Ktel1mCxB8sOugAZbOGexb63bUDm0TnYDk=;
        b=AiJ9xSxUOnxMoCq+5G7EFlLFMh9z4M1s9296Vb6ul5BR7wqjgrv5mpGw98VZEF8PqUJSR6
        uS9Ak3Uzo42dTMpn3YwPOXnywfnXmFTQu3ix5LacvrcYG5u+23Znw3c9yIy49hJ1xIK8n7
        GTk2yf4PZXffNoSrm0YgD9l0PocMj0g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165--NB-DduNONmdgdhhX5TDXg-1; Wed, 28 Jul 2021 17:51:22 -0400
X-MC-Unique: -NB-DduNONmdgdhhX5TDXg-1
Received: by mail-qt1-f200.google.com with SMTP id f9-20020a05622a1a09b02902615523e725so1725806qtb.21
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 14:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BgiDqK985Ktel1mCxB8sOugAZbOGexb63bUDm0TnYDk=;
        b=khgkG7H1MjKNPQNt5eiNP1dLpEEnpR3EbJqtWQEo2Do6eC28/lKBRHk/4jl79JTiKA
         9v06AFoVCEsYlTaTotHFt98kgkMCzVccKEkdXW8nOnS2SkcmaPz9qWtClKqKW7FNB08A
         yyf/XsBfI2bUsyvyc51xXkwDAIDE7sOz+wE0DT07gxXXylhTOmh8bAT/FWK4qaC3DtQB
         h2+Y/OFbLjNxkiNyq1Ml/DzVNEBc+HJfGaXce6uT2U/wfQN9KuDg7EH3AoTH6PZ/Q0S+
         wuZFfMkM8TWGyd3gCiMN+eKahffsACBkLGi0uwvJQaiNoRqb64Di/YUzd2n9jKlsTJAJ
         kprg==
X-Gm-Message-State: AOAM533oS+/h3dLEH7GXxqtfmgAeyCZjTmq9V4pTAITybbOHqOEmbpZZ
        jNFPH/oGkqSjBmj6Hcw6QbnX1Wi5O4eRDkfS6iNLQHS33hanT70wyMaUiNmMAo3Hek28Jfjcaw2
        z+VWdLHzjTRpU8fn9YD1yEKkb
X-Received: by 2002:a05:622a:142:: with SMTP id v2mr1531755qtw.343.1627509081658;
        Wed, 28 Jul 2021 14:51:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjg24v44i0E2XNaQXy3CApzsAmGvMGrjOxbDpdx0PiWsCpkBDaJgrK3Kem/PGJhXXtIry3hw==
X-Received: by 2002:a05:622a:142:: with SMTP id v2mr1531743qtw.343.1627509081473;
        Wed, 28 Jul 2021 14:51:21 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id h68sm642530qkf.126.2021.07.28.14.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 14:51:20 -0700 (PDT)
Date:   Wed, 28 Jul 2021 17:51:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 8/9] KVM: X86: Optimize pte_list_desc with per-array
 counter
Message-ID: <YQHRV/uEZ4LqPVNI@t490s>
References: <20210625153214.43106-1-peterx@redhat.com>
 <20210625153415.43620-1-peterx@redhat.com>
 <YQHGXhOc5gO9aYsL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQHGXhOc5gO9aYsL@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 09:04:30PM +0000, Sean Christopherson wrote:
> >  struct pte_list_desc {
> >  	u64 *sptes[PTE_LIST_EXT];
> > +	/*
> > +	 * Stores number of entries stored in the pte_list_desc.  No need to be
> > +	 * u64 but just for easier alignment.  When PTE_LIST_EXT, means full.
> > +	 */
> > +	u64 spte_count;
> 
> Per my feedback to the previous patch, this should be above sptes[] so that rmaps
> with <8 SPTEs only touch one cache line.  No idea if it actually matters in
> practice, but I can't see how it would harm anything.

Reasonable.  Not sure whether this would change the numbers a bit in the commit
message; it can be slightly better but also possible to be non-observable.
Paolo, let me know if you want me to repost/retest with the change (along with
keeping the comment in the other patch).

Thanks for looking!

-- 
Peter Xu

