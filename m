Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B38A4325E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhJRSFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 14:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52353 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231318AbhJRSFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634580214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Thk5OLmfXHPG36uriH+bJ4mfoOC1g+fEVpm4vF4ZgqU=;
        b=eV0Ksfht2vhqqpw6RGiRK8KXMASPn9mnU5tyYRlTfYVUxk95F62qy7INBZXH/Vi64S2X3T
        M4ZU73kg9Iw3a/9yKmy2YxjB4xXtwoCSc4Wvr2+1z/rlvU/O9DRoyM27T8gwbaA0U8oJ7E
        szGslAbriJxyxGrvOb9OKQYQt08hCEg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-dxmKoaUeNt61Wg8nCeK9lA-1; Mon, 18 Oct 2021 14:03:30 -0400
X-MC-Unique: dxmKoaUeNt61Wg8nCeK9lA-1
Received: by mail-wm1-f72.google.com with SMTP id s10-20020a1cf20a000000b0030d66991388so3449425wmc.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 11:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Thk5OLmfXHPG36uriH+bJ4mfoOC1g+fEVpm4vF4ZgqU=;
        b=SVKCh5jhcp4hobhgCj1eDgVVhYEVRMI/X3lzBRTHti5k9xMMrLtsjwBD6cSHiD0Gb1
         vzGBU3sRqyLzDLTw79PDVWnvbXM9WiRCY52l+lbOBE6VLgl055zuUTPmIOO6L8gBWgAL
         ettM5MpoIO/EVzUlVVGiMcYUw1JAHPdcJ+V7NdVWhoThmwwZ4+UpzZSNEzdg2YohTS6/
         Rj9EkmzWe7UuiV0ruASqrC0dMGc9LQG9YXGRlAKFlWEqmDASBFAApg/lKf+XDj2FAI04
         Khmi1d2HtDB3XXbmk9QbEGoADkkd5lX9ZtCi8wHlgqgcFcpDTmTh8GbkmSLhxl8qMysO
         aGHw==
X-Gm-Message-State: AOAM532O/2VM0giRVDn6tbAXbVQD7/ina4oe0KxYZW+byE/e/J145vnn
        hN4hGDbTMSzA/4cGtyEKwiqBLoasalN+FrXfiCaq1cOUwGYclY9rST2Gh7QxdPgIqUuWzW1lbuf
        P7kBeuJS0zzh6OBBOHQGRhATg
X-Received: by 2002:a7b:c938:: with SMTP id h24mr448804wml.126.1634580209486;
        Mon, 18 Oct 2021 11:03:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxt8pjbMny9KaboDlf2A1tikNoWTJAds3ojSlzH86ZUnKOetCEzouUbLBa+VQi7kCuubJGBaQ==
X-Received: by 2002:a7b:c938:: with SMTP id h24mr448766wml.126.1634580209232;
        Mon, 18 Oct 2021 11:03:29 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b3sm13341298wrp.52.2021.10.18.11.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 11:03:28 -0700 (PDT)
Message-ID: <daba6b06-66cb-6564-b7b0-26cb994a07cd@redhat.com>
Date:   Mon, 18 Oct 2021 20:03:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [GIT PULL] KVM fixes for Linux 5.15-rc7
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jim Mattson <jmattson@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
References: <20211018174137.579907-1-pbonzini@redhat.com>
 <CAHk-=wg0+bWDKfApDHVR70hsaRA_7bEZfG1XtN2DxZGo+np9Ug@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAHk-=wg0+bWDKfApDHVR70hsaRA_7bEZfG1XtN2DxZGo+np9Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/21 19:57, Linus Torvalds wrote:
> The way to do a logical "or" (instead of a bitwise one on two boolean
> expressions) is to use "||".
> 
> Instead, the code was changed to completely insane
> 
>     (int) boolexpr1 | (int) boolexpr2
> 
> thing, which is entirely illegible and pointless, and no sane person
> should ever write code like that.
> 
> In other words, the*proper*  fix to a warning is to look at the code,
> and*unsderstand*  the code and the warning, instead of some mindless
> conversion to just avoid a warning.

The code is not wrong, there is a comment explaining it:

  	 * Use a bitwise-OR instead of a logical-OR to aggregate the reserved
  	 * bits and EPT's invalid memtype/XWR checks to avoid an extra Jcc
  	 * (this is extremely unlikely to be short-circuited as true).

Paolo

