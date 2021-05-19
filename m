Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C99C3888D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhESIAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:00:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230284AbhESIAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621411124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hUKCkP4yfMCr/BxCyU0FR0t8N/b+HPDBhjsTQZT8gMo=;
        b=EWIeO8TkEvQf+FF8z/pj5iCE90But4rjokTwJHvj2bOooy0utKfDFSzyrVYPH4C7RBxoVi
        1sBG+jqMtn28rVRVWblDaHt5UUdTPYNz52v/fS18eXRn2m5egXz2iBpgTDy5kUqEacIZZN
        ntQELpQayY+j2Ac2q+d+0vFkiEtsXBY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-it_ABsKqP0G0ddfF_DDQRA-1; Wed, 19 May 2021 03:58:42 -0400
X-MC-Unique: it_ABsKqP0G0ddfF_DDQRA-1
Received: by mail-wr1-f69.google.com with SMTP id h104-20020adf90710000b029010de8455a3aso6796437wrh.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 00:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hUKCkP4yfMCr/BxCyU0FR0t8N/b+HPDBhjsTQZT8gMo=;
        b=gYrUd6LxuexkOS/yKijE+L8tj1F3JhMPhk4XelfhM7dVM81u22bUZVAalkclSmZOTY
         XePEHIHcAPRXXV6Cfld5t3bOv0UJc7TJ0BJ0tVlqrP2O/n8a4vNHmRdLxMZKPY1sgMpM
         hU6TVVdvn2HGefly8CZcOQHNIVXZ1M8O5iBWwuVNiPMtkf1LVu3ZLs3oP8Sh8TPOdqTt
         gXmlVq8vLkD5IWJv7bse7/7Y1HnubspG+d7MBjP83b+maa/8F2QZyJOyxhjlTrg2V5o4
         9JJlLAEDgefhoHzkYA/U36BCY50Z2XD06QRbss4jerMFuHTjNyQDlDnzwK2zPOGXS9Zu
         NzjA==
X-Gm-Message-State: AOAM532w+m/VbmcecKc5968K6+wPoTBcUexbh5a6qk3LeeMqlwqBwzMw
        TGXPDReT9VnF2ARz2E+Lam8IayE62DXwEcuSj7cfO8dqnqTv1+2bMyWGScArOSmsvdKCSrva/cV
        XMHJ7P1QiDfZT57Pv/Cmj5JJrSxEv0tH+YDHYwMRkP/bVzTSkc7XKulEMUmCS2/BcJsFRklBSJn
        T0
X-Received: by 2002:adf:ee44:: with SMTP id w4mr12459898wro.415.1621411121422;
        Wed, 19 May 2021 00:58:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGJPlUnhk9Zw0RyKtb0dmzV6Y0MYPLqenVcZP9Fuedvj5kMpJoPZsfmnJ0kzNmVU5dehp1YQ==
X-Received: by 2002:adf:ee44:: with SMTP id w4mr12459866wro.415.1621411121166;
        Wed, 19 May 2021 00:58:41 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x8sm24384081wrs.25.2021.05.19.00.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 00:58:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Kechen Lu <kechenl@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] KVM: x86: Use common 'enable_apicv' variable for
 both APICv and AVIC
In-Reply-To: <YKQmG3rMpwSI3WrV@google.com>
References: <20210518144339.1987982-1-vkuznets@redhat.com>
 <20210518144339.1987982-4-vkuznets@redhat.com>
 <YKQmG3rMpwSI3WrV@google.com>
Date:   Wed, 19 May 2021 09:58:39 +0200
Message-ID: <87r1i3jgsw.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, May 18, 2021, Vitaly Kuznetsov wrote:
...
>> +	/* 'enable_apicv' is common between VMX/SVM but the defaults differ */
>
> -1 for not throwing Jim under the bus :-)

I bought the 'messenger' argument :-)

>
> Nits aside,
>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
>

Thanks!

-- 
Vitaly

