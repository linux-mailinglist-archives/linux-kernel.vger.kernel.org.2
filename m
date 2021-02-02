Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB6830C876
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbhBBRuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:50:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233873AbhBBRp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612287873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhoUfl+g0uoiRy2j1M8RxEcPRSJNsnmBHDUffwpMaPs=;
        b=b04CYGCCFdBVd7YQBIiS0ATr4TzKa/nREv9hGi0huUx1IN/naUAoVQJQMkdoYdOLP2VNar
        Y0UY86ZO910KCE72WF95CphXDoiAow5D5ziR2FYVHT7TKf3YaHgLn01ZFBH0DU94OflCSX
        Mel2aDJWnH7735OKOg0NKGZyM6cRq+M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-DbC_ZSzbMA29zJvJBaZhrQ-1; Tue, 02 Feb 2021 12:44:31 -0500
X-MC-Unique: DbC_ZSzbMA29zJvJBaZhrQ-1
Received: by mail-ed1-f72.google.com with SMTP id bd22so4038212edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FhoUfl+g0uoiRy2j1M8RxEcPRSJNsnmBHDUffwpMaPs=;
        b=BMOD8DSChmR4pEEKIbEcJNPdJuFwUKCyciu0lYOLtiN1I8BHCnf5HoBBi46kh4BnTA
         Iknk78iSG51bCNaXjTRvzKy+QQNsXwBeMX5njcZKUVnoPgRFxYur6GEFgexVoi8xPR4B
         HHuiSem9vA26LpUx9Pf4V2hoYXNJebLYPuz+iUEOqIOqkxaiS7eSQEz6Dis4/uo2WUND
         uxRr069gDMnK/0ls7NfqwbLzaGSnkegr4pWnWZnIdmyLWK/mRromhh2TgOfWYHFBuLpI
         by8YAdOTa0A25ZEpoHuHsNjRbn/gOgnz4F4wDMUFdSufMu+7q3fJ8hFAjdtkN/KJJpzM
         wioA==
X-Gm-Message-State: AOAM531J5vHg4DEMcrAvkzDTtBvyXI8ZFi/hT/xZNrwCcXGlwAgMWNIs
        ZOtBVD36F0eq7ywOCd6CQSsX7gY5dLaU3vx2KIqf4HQMOZBRaLybGPhpCwNVcpfTRvd+0NFw1uo
        MYaeWjeGRT80KM3AplENGhFfA
X-Received: by 2002:a17:906:364b:: with SMTP id r11mr12781961ejb.447.1612287870536;
        Tue, 02 Feb 2021 09:44:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwicWvfZ2GLDJ+wwicAsZuRGEGiXNAt178/3YEYrxcL6zuU0sY4SqYCG9xlEoxs/wHQ5j85tg==
X-Received: by 2002:a17:906:364b:: with SMTP id r11mr12781948ejb.447.1612287870342;
        Tue, 02 Feb 2021 09:44:30 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id hh21sm9725201ejb.13.2021.02.02.09.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 09:44:29 -0800 (PST)
Subject: Re: [PATCH 2/3] KVM: x86: move kvm_inject_gp up from
 kvm_handle_invpcid to callers
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210202165141.88275-1-pbonzini@redhat.com>
 <20210202165141.88275-3-pbonzini@redhat.com> <YBmOEt6YezYWtTjQ@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <986df9f0-9104-04f4-6cd9-db9f996223fc@redhat.com>
Date:   Tue, 2 Feb 2021 18:44:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBmOEt6YezYWtTjQ@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/21 18:38, Sean Christopherson wrote:
> IMO, this isn't an improvement. For flows that can't easily be 
> consolidated to x86.c, e.g. CRs (and DRs?), I agree it makes sense to 
> use kvm_complete_insn_gp(), but this feels forced. What about a pure 
> refactoring of kvm_handle_invpcid() to get a similar effect?

Yes, makes sense.

Paolo

