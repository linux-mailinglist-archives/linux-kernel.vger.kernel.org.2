Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B4312F2F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhBHKiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:38:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231969AbhBHK0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612779913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZLTt/jNc10VT6gCbdoD+Af1czjbyy0IIAwPBoEn8bfI=;
        b=RdR/5tHMGLrB9Yli9GGVEuvgADv2VM8ivNOePwn6D6Bkw1ZMiM/e1A+jb7hVKVVWveCnYD
        L2Xecsh51Qq0V0JIyduYL1/mtdcso+FxTh1dKmaReTBhbAPCTZgIA3p+ARVrbZxeP+lIBW
        IGnRZPMik0gzSQ7ZD/DsGTpgcdiS6PY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-9GVVxEFsMxSzcwpw7rRejQ-1; Mon, 08 Feb 2021 05:25:10 -0500
X-MC-Unique: 9GVVxEFsMxSzcwpw7rRejQ-1
Received: by mail-wm1-f70.google.com with SMTP id u138so3331472wmu.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 02:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZLTt/jNc10VT6gCbdoD+Af1czjbyy0IIAwPBoEn8bfI=;
        b=WNw590WGs99Zw5kNSFuSe/zj5cDp/aWKhxc6fK86kbTIWeuHAgXDov33SGQ9HLCxKE
         NgkRr98bzGnqoR0VjtPsHUQ0OV8PoQ69EYN5O6Cr9mlv5lQsjkYQYzrBG4PS4k2i0ym/
         Lf1ON0qhUOY1VRXDjoWX6Hea0BeS0VDznr45Sn5r5r4SHcDfGck5vUigi6WpNd01eaCu
         skw1vE2lYL2TvoXUE1Zo8IV8e+usvneISCaBTYx/T878nyVY0N9S/FZr2P5bvWT71GyX
         yRP8c+LwQNl4rYbWU5qgyja25i2jx1YjPN0eCpLx0GLtJJpbGWsw/wqEfTBhvznrDBOx
         5H4Q==
X-Gm-Message-State: AOAM531kKa9zRVdqfQC3pPRnCx4kUzcMFC1/9XoTwj9MCzlBjaCqvxgQ
        RbbQZlY2CAS48mkfQNnoaVKFzDKfyyKBtcV0633WMpPbUh7EStIfgyb7goDfxUzUp/OfM/LWHCN
        cSrqz3a2G4Cmq+Cs3R+RiGhbT
X-Received: by 2002:a05:600c:4a22:: with SMTP id c34mr11448628wmp.167.1612779909314;
        Mon, 08 Feb 2021 02:25:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDJbuA+bT9BWr/82QdoxgeJVD7iz8YuJ2/fpkdBD9z6cfpfXGhTBk0ggBKywLZGIhZPyDfTw==
X-Received: by 2002:a05:600c:4a22:: with SMTP id c34mr11448613wmp.167.1612779909131;
        Mon, 08 Feb 2021 02:25:09 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id t2sm14392608wru.53.2021.02.08.02.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 02:25:08 -0800 (PST)
To:     Jing Liu <jing2.liu@linux.intel.com>, seanjc@google.com,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jing2.liu@intel.com
References: <20210207154256.52850-1-jing2.liu@linux.intel.com>
 <20210207154256.52850-4-jing2.liu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 3/7] kvm: x86: XSAVE state and XFD MSRs context switch
Message-ID: <ae5b0195-b04f-8eef-9e0d-2a46c761d2d5@redhat.com>
Date:   Mon, 8 Feb 2021 11:25:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210207154256.52850-4-jing2.liu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/21 16:42, Jing Liu wrote:
> |In KVM, "guest_fpu" serves for any guest task working on this vcpu 
> during vmexit and vmenter. We provide a pre-allocated guest_fpu space 
> and entire "guest_fpu.state_mask" to avoid each dynamic features 
> detection on each vcpu task. Meanwhile, to ensure correctly 
> xsaves/xrstors guest state, set IA32_XFD as zero during vmexit and vmenter.|

Most guests will not need the whole xstate feature set.  So perhaps you 
  could set XFD to the host value | the guest value, trap #NM if the 
host XFD is zero, and possibly reflect the exception to the guest's XFD 
and XFD_ERR.

In addition, loading the guest XFD MSRs should use the MSR autoload 
feature (add_atomic_switch_msr).

Paolo

