Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F94E44D796
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhKKNz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:55:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbhKKNzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636638756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKsmhhE87NncsEB4OeLA0vuGnBO/DIw9o6OFCfgf5e0=;
        b=aYbiMci/Vnwv/1JoLu4knYpBtLxb96iudS09+ING2vGQtFmJQVP5kErJ9UESGO9hpvhVjP
        xRPOZhYwmwx/jfSsRZPAm0TlrpOfpgfHtPpNlbWIAKUi8KUbuVKxgrsNSOeV0snOOxyFd7
        NDXRk72THlBCYFkFOL0E63Zct4XpDqg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585--CbYQMW1N9-30r6L9raPDw-1; Thu, 11 Nov 2021 08:52:35 -0500
X-MC-Unique: -CbYQMW1N9-30r6L9raPDw-1
Received: by mail-ed1-f69.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso5469070edj.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 05:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wKsmhhE87NncsEB4OeLA0vuGnBO/DIw9o6OFCfgf5e0=;
        b=6i/N8OnTD6wq5iX0Wy4IUJOlMD/djTQn3+ZtqK/+xkH+0sSwAFxOeIw1644X3ZWjpc
         hY6K9K5t8QqIEG3rHhU8bZzPzmADqh9RuDiJI7TFG1M9RhM+yTmvYt9COSkscxLtbFh1
         /pS4Hc5qqW9lEVz38SIT/08/UIV2bPu3wyVmP+DxLpBIXZ0qfJeE5Dvn0S9JK7OjAPBJ
         j6bdbeq8lKhu9mMoXCP0rectRZZWa2kHA3gszWl7zLtWIDNlKKg2gitlv1sr16j/HxQD
         8L1ga6r1imBVP4/3RcDKUnaXxz2sv0Jn8U9cGARLRlQoHevkC9X5kuolvDA6BYJSk+W/
         KMTA==
X-Gm-Message-State: AOAM532TtH63N914VmpAh2c83UHelqpLWRWrYjkLmW3PwPbnqiRR/TGP
        gByJ10gyPgl//R1eD+Fcb5iOmZwD/+Bi74Vafjmq6RgWohrXRgmXAmRYrKA1CV8wfJR+2z49dN2
        aI8thsKBNavryAZBGLo0U4M0k
X-Received: by 2002:a17:906:2ada:: with SMTP id m26mr4098589eje.571.1636638753906;
        Thu, 11 Nov 2021 05:52:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6tAm1LlFb1d15hHhP2P4MAOZSTk71Uf2lUs5DC6h5peV/1U8KiWmiR0dBTcZYlldhiwQCEw==
X-Received: by 2002:a17:906:2ada:: with SMTP id m26mr4098555eje.571.1636638753733;
        Thu, 11 Nov 2021 05:52:33 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id q8sm1648831edd.26.2021.11.11.05.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 05:52:33 -0800 (PST)
Message-ID: <49852dbc-548d-5bf1-6254-ec69d3041961@redhat.com>
Date:   Thu, 11 Nov 2021 14:52:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 2/7] nSVM: introduce smv->nested.save to cache save
 area fields
Content-Language: en-US
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
References: <20211103140527.752797-1-eesposit@redhat.com>
 <20211103140527.752797-3-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211103140527.752797-3-eesposit@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 15:05, Emanuele Giuseppe Esposito wrote:
> Note that in svm_set_nested_state() we want to cache the L2
> save state only if we are in normal non guest mode, because
> otherwise it is not touched.

I think that call to nested_copy_vmcb_save_to_cache is not necessary at 
all, because svm->nested.save is not used afterwards and is not valid 
after VMRUN.

The relevant checks have already been done before:

         if (!(vcpu->arch.efer & EFER_SVME)) {
                 /* GIF=1 and no guest mode are required if SVME=0.  */
                 if (kvm_state->flags != KVM_STATE_NESTED_GIF_SET)
                         return -EINVAL;
         }

	...

         /*
          * Processor state contains L2 state.  Check that it is
          * valid for guest mode (see nested_vmcb_check_save).
          */
         cr0 = kvm_read_cr0(vcpu);
         if (((cr0 & X86_CR0_CD) == 0) && (cr0 & X86_CR0_NW))
                 goto out_free;

(and all other checks are done by KVM_SET_SREGS, KVM_SET_DEBUGREGS etc.)

Paolo

