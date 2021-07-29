Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CEE3DA7E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbhG2Pxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238050AbhG2Pxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627574010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WIqDiJp6VaSn9dpR1kfsnItFG7gaXoSJekhGozotnW4=;
        b=On+0sdxgZ4DxLbqSKFJMkaFBfBtVDQtNbNRMOp3gCovJ6/QdXPqjY4Cz+W/y9ZO2ryknTH
        3Zhfk5MOailE9OwEDy0YiN4feJx+O0SPOj16wPwwLe0eMFqxQOpJ1EYvP+GfhTh121FTo5
        8nGrLsy+Naj9QLdAm1HCGFV6BtqSrmI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-37PSxDm4NsyYDO6bWxICsQ-1; Thu, 29 Jul 2021 11:53:29 -0400
X-MC-Unique: 37PSxDm4NsyYDO6bWxICsQ-1
Received: by mail-qt1-f200.google.com with SMTP id l24-20020ac872580000b029024e988e8277so2907041qtp.23
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 08:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WIqDiJp6VaSn9dpR1kfsnItFG7gaXoSJekhGozotnW4=;
        b=c+Z1L4eB8k4zpekZspb/CGmgfNV7HoTlqeikcU295c5G8fiZOGicC/C3YeVAZ8zcTo
         4JpAq6IFaJBXnPsQ8+Ca9fp7XyRksZkZPAjDm/EoALlvdgRBiM2aRh2c5u97gFcAkSr1
         lHIQysPyeR46gj2Mh9h+egwxRh7+k1YmW7gXm76MtmZcVZdTC6rB+8I+FvCZCMs8IUjL
         z17muLBv7zBNyxJQK4JIoymo1t+h+ZmuABXMSVrMGe9usS4kmTk01Mhl5V44p7Cy1q8O
         DO+NGbCznhdpGWZp5wzg4kRpugieWs59OPF1D0yU6EIEhVoJnRJ7o1p+xMFBp+M4NntG
         dlOQ==
X-Gm-Message-State: AOAM530jrv+yTor1tgC/1IHgI7vrr0eLRAxn7A0La6zAQLiHtjmV6qSU
        IjtSrGgT6oH2bDC/WVki61zfBle21rVBiZcSG3N4iUCwDXAiJHUNWIrpCNfYT148qLYRJsPbV/t
        pESSRGvGTgCtna1us+3lvRbs4
X-Received: by 2002:a37:46d1:: with SMTP id t200mr6017848qka.491.1627574008555;
        Thu, 29 Jul 2021 08:53:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx20AvvmwA3zsdeUzhxGgr6AKaj+/c2//3SiKDGKEF0n2dtIKt7qPdZIpPiTl4sSwosnRnUXg==
X-Received: by 2002:a37:46d1:: with SMTP id t200mr6017833qka.491.1627574008362;
        Thu, 29 Jul 2021 08:53:28 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id u186sm1990880qkb.11.2021.07.29.08.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 08:53:27 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:53:26 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v2 8/9] KVM: X86: Optimize pte_list_desc with per-array
 counter
Message-ID: <YQLO9upwcrBTIiqx@t490s>
References: <20210625153214.43106-1-peterx@redhat.com>
 <20210625153415.43620-1-peterx@redhat.com>
 <YQHGXhOc5gO9aYsL@google.com>
 <YQHRV/uEZ4LqPVNI@t490s>
 <dc9eb6da-59ce-2dd3-c39c-8348088cadcb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc9eb6da-59ce-2dd3-c39c-8348088cadcb@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 11:33:32AM +0200, Paolo Bonzini wrote:
> On 28/07/21 23:51, Peter Xu wrote:
> > Reasonable.  Not sure whether this would change the numbers a bit in the commit
> > message; it can be slightly better but also possible to be non-observable.
> > Paolo, let me know if you want me to repost/retest with the change (along with
> > keeping the comment in the other patch).
> 
> Yes, feel free please start from the patches in kvm/queue (there were some
> conflicts, so it will save you the rebasing work) and send v3 according to
> Sean's callbacks.

Will do.  Thanks,

-- 
Peter Xu

