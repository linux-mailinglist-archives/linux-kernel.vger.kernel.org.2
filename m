Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77503A2D05
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 15:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhFJNbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 09:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230280AbhFJNbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 09:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623331779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUww2H6mOYMFrVyPJua5qMXJgouUiMizecBkG9cRXMQ=;
        b=i3d9UTPk3RihOXNsIsxSn1nGRaMD6NLRnh7yOmDRNoB+54fd4TL/utDQKBe/VsT9KG7nin
        LR7itkhQ8F9B+S19nneHjY12uUvRm9zhY7FY3WRgD/OT4VMD0ZiKENP837RDI+iayjHXSr
        aFhfr8HFaMVrmru0WciShILMnwt2kJ8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-Ipf5rP99MTOCnHOlY82qvw-1; Thu, 10 Jun 2021 09:29:38 -0400
X-MC-Unique: Ipf5rP99MTOCnHOlY82qvw-1
Received: by mail-wr1-f70.google.com with SMTP id u20-20020a0560001614b02901115c8f2d89so901489wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 06:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hUww2H6mOYMFrVyPJua5qMXJgouUiMizecBkG9cRXMQ=;
        b=AUlcOZfe8mw8FzzohpDN5KXD+nooveBpdzqen4O8yncuviC9V0xHcl85ZXcQKwJuI5
         TaEso1SN5uf0qomuWsPOqssV/VS+ADxrGL0z7xOOhLE9bNk5uKy5VlFZP5omq8nxhPs/
         iAd1CIpFMof8P5PmWgjV6pf7jXGPvn/i1Y15Lg5i7CMbmagIZcXQ7XuUpNR/9LMoOKsx
         bY8pRExuzBmKE7rkqRoB+M58vS2lLAbzTFhsFvcyLRRWxWGMV0Jf9ACl/r9+e8opB1FG
         IPZuKj7K0hsRms9tpH5/eDyABgn0t7peiTq00YwKIgrgzjc3z8KXRFn9W4XjTQ9xra1S
         DH3Q==
X-Gm-Message-State: AOAM532ILXlkp4i2P+Cyg4lEn2eEd0O/5lNTokrm67PLIf2vrgYiXD8W
        ARQSdVquZxaNOG+rtPSzJaH6aCECxtsj/x2dzsNmed8FMOdiXjqvdQy5hugZDgsm3drf/Y4jOgQ
        1vr1KIYqNSyZz8yUXx/WTLEWm
X-Received: by 2002:a05:6000:154c:: with SMTP id 12mr5449701wry.126.1623331777228;
        Thu, 10 Jun 2021 06:29:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvjcRem46QPjln9QkPMp7aRjPQpdNLR+LC2+I4KyWl25z655aAlQqmyfSiC9AjFjCPQJB2Rw==
X-Received: by 2002:a05:6000:154c:: with SMTP id 12mr5449675wry.126.1623331777028;
        Thu, 10 Jun 2021 06:29:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id m3sm3750147wrr.32.2021.06.10.06.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 06:29:36 -0700 (PDT)
Subject: Re: [PATCH 2/9] KVM: x86: Emulate triple fault shutdown if RSM
 emulation fails
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+fb0b6a7e8713aeb0319c@syzkaller.appspotmail.com
References: <20210609185619.992058-1-seanjc@google.com>
 <20210609185619.992058-3-seanjc@google.com>
 <87eedayvkn.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <61e9ec9e-d4f5-bea5-942a-21c259278094@redhat.com>
Date:   Thu, 10 Jun 2021 15:29:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87eedayvkn.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/21 10:26, Vitaly Kuznetsov wrote:
> So should we actually have X86EMUL_CONTINUE when we queue
> KVM_REQ_TRIPLE_FAULT here?

Yes...

> (Initially, my comment was supposed to be 'why don't you add
> TRIPLE_FAULT to smm selftest?' but the above overshadows it)

... and a tenth patch to add a selftest would be nice to have indeed.

Paolo

