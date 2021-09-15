Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89C740CF58
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 00:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhIOWe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 18:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232852AbhIOWes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 18:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631745208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fDx/Hr0zc1j4NXN/rU1ooxqT+kr9dmLC76FBxnVhemM=;
        b=SVHebgT+o/jk+1jy8zPXh5kIuVUAus2ZPKrzdqieeAx5n1WB1xEL3XJVeMzIxAHWb938vi
        F0/pXY8LOxmxFXnmfUpdxdZFICj3v1p3P5BkgVilORin9RR92/QH+ypcdtcraIDVwYNG6K
        y/N1ZfJafu09MphvoOoxn2wX/VCZtJ4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-qz9W0TSMO3CDu3dXmmjhiw-1; Wed, 15 Sep 2021 18:33:27 -0400
X-MC-Unique: qz9W0TSMO3CDu3dXmmjhiw-1
Received: by mail-ed1-f72.google.com with SMTP id r7-20020aa7c147000000b003d1f18329dcso3155513edp.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 15:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fDx/Hr0zc1j4NXN/rU1ooxqT+kr9dmLC76FBxnVhemM=;
        b=bEdsnvlUvAJIOO8wFLN3/x1yxs3wSMAidoJodHs412ZUUcn0ypIHBzRaB9WhVxuumx
         sVbwlEfEK2DK49AMjzBWHfUojv9zpjxwa1jpNsq0B9j29cAakYMQaUkBOWEGm48neRJW
         eK78QKxqOyyL1xF1Vqa+4j9fh1s8pmjQMSzbq739c8vRvq3sQqO54MjU9jszXeKeZGzB
         6PkcskhQvoooYRLyio4p0ovSKsIBxapjFjqz1bC+Dcxk3iF4Tvzy3YDT/eDafcbTCizk
         RzBsrQXGjfjlWeX5OxoAhb0GojPTKoiOV3e9C8F8IGcnwNOEeqmqq3jVWxH5NjMTzMxT
         fIqg==
X-Gm-Message-State: AOAM533ZScthnoAeFZllkkj9yD+w0BhwLUBjLtDeE/FGzr5ap98Ud6hv
        VIX2e2wHhB22rJy9DkpboAdfe4J71L67F+tlG29JweyZZLb++vYQiJvDu9zbmluR1ZNkozc0ZW3
        O3ffbo+zOMIi0bdTuuJen3djoQ/ah9bGHiFI+fIFaovtBOuUOjXpU9J0B7dGEENy90ATkfnPtCc
        MU
X-Received: by 2002:a05:6402:1428:: with SMTP id c8mr2269625edx.128.1631745206135;
        Wed, 15 Sep 2021 15:33:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUJFtYM9G6+R9bGG1vMz7osgEWwyPrwk4Z98OZ0Q4jPrnjDELrmFauFLB3m0vrCnBTkdhmGw==
X-Received: by 2002:a05:6402:1428:: with SMTP id c8mr2269599edx.128.1631745205935;
        Wed, 15 Sep 2021 15:33:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id w25sm580072edi.22.2021.09.15.15.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 15:33:25 -0700 (PDT)
Subject: Re: [PATCH] KVM: SEV: Disable KVM_CAP_VM_COPY_ENC_CONTEXT_FROM for
 SEV-ES
To:     Peter Gonda <pgonda@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        kvm list <kvm@vger.kernel.org>, Marc Orr <marcorr@google.com>,
        Nathan Tempelman <natet@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
References: <20210914171551.3223715-1-pgonda@google.com>
 <YUDcvRB3/QOXSi8H@google.com>
 <CAMkAt6opZoFfW_DiyJUREBAtd8503C6j+ZbjS9YL3z+bhqHR8Q@mail.gmail.com>
 <YUDsy4W0/FeIEJDr@google.com>
 <CAMkAt6r9W=bTzLkojjAuc5VpwJnSzg7+JUp=rnK-jO88hSKmxw@mail.gmail.com>
 <YUDuv1aTauPz9aqo@google.com>
 <8d58d4cb-bc0b-30a9-6218-323c9ffd1037@redhat.com>
 <CAMkAt6oPijfkPjT4ARpVmXfdczChf2k3ACBwK0YZeuGOxMAE8Q@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9feed4e4-937e-2f11-bb56-0da5959c7dbd@redhat.com>
Date:   Thu, 16 Sep 2021 00:33:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMkAt6oPijfkPjT4ARpVmXfdczChf2k3ACBwK0YZeuGOxMAE8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/21 18:10, Peter Gonda wrote:
> svm_vm_copy_asid_from() {
> 
>     asid = to_kvm_svm(source_kvm)->sev_info.asid;
> + handle = to_kvm_svm(source_kvm)->sev_info.handle;
> + fd = to_kvm_svm(source_kvm)->sev_info.fd;
> + es_active = to_kvm_svm(source_kvm)->sev_info.es_active;
> 
> ...
> 
>      /* Set enc_context_owner and copy its encryption context over */
>      mirror_sev = &to_kvm_svm(kvm)->sev_info;
>      mirror_sev->enc_context_owner = source_kvm;
>      mirror_sev->asid = asid;
>      mirror_sev->active = true;
> +  mirror_sev->handle = handle;
> +  mirror_sev->fd = fd;
> + mirror_sev->es_active = es_active;
> 
> Paolo would you prefer a patch to enable ES mirroring or continue with
> this patch to disable it for now?

If it's possible to enable it, it would be better.  The above would be a 
reasonable patch for 5.15-rc.

Paolo

