Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFD6365459
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhDTIlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229696AbhDTIlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618908048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zB438UsN4r9986PE2xEGkDVIweUkvDdpBp47AfbjynM=;
        b=bei4g08qL7FL1WCCniujyQSbFO+Ayow4K377cRJq2y5vWNMFj2UHlVA96gadEVHbRnwsTl
        GytxwnHRJ3bvqfWvVtDEA64eLmBUDhjwcAy9ThSInI2mfb4y4gYisgyjYtq4OwhSSqxqNb
        0JllmMKIApq7u6sQ1KcyEnipu9pEoBY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-f_UzkOA3MkGNMwpZtscISg-1; Tue, 20 Apr 2021 04:40:46 -0400
X-MC-Unique: f_UzkOA3MkGNMwpZtscISg-1
Received: by mail-ed1-f70.google.com with SMTP id l22-20020a0564021256b0290384ebfba68cso8885191edw.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 01:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zB438UsN4r9986PE2xEGkDVIweUkvDdpBp47AfbjynM=;
        b=OIKmWBgqK/E97h/u+uTmezZn9xuCGGJnLn+4E/9QD8d8ViP/T9A7tabvL7l8Jt5SHy
         89cinwLZvvZk3ko+9KUzVH7wZWyqPZcCP2H2aT+mhWGdFO2uqMX5vPakbUcaRz2EwHsm
         5I+c8L8n2pTQVIBwhBJEX8M8dGjrmQ+zjjqK27V3b0aRqEhVC3ZVcPZ1NuPqHo6ohO36
         WmAzOPzNWUUYvXpaK+CaIX4o8KJzEF4GTIqTnTY/XY3b7QdfhgOGyH9s16aCmf0fyZAF
         pO3ijHkKk7rLSTKbOSPe8AJfWDOf5E/wWAmlCDDXQO+1mMyPBY3SeeMTMvpn+eLSgyx/
         80xA==
X-Gm-Message-State: AOAM530AbfsVnBIP22tgmGIY0gCg8acuZFE8VLOX0Zaq4joFBoDXQvCQ
        Ad800tHvYwZUfQB1OmKg6Ti4g53F9hsirp4aX0jkNVDGgJ3biAKZvEbGl7xh42X2TKfRIU2ZZM2
        iv+QIOVrqFVGyWwntpUlwr14C
X-Received: by 2002:a17:906:8a79:: with SMTP id hy25mr26634052ejc.461.1618908045436;
        Tue, 20 Apr 2021 01:40:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/ILxTwqgMLmyPwiD0e4MVWECB2Ha6lNaMT8x9NpakkGaBMmEIL306sPzWycnszm1yervXzg==
X-Received: by 2002:a17:906:8a79:: with SMTP id hy25mr26634034ejc.461.1618908045217;
        Tue, 20 Apr 2021 01:40:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n15sm5177405eje.118.2021.04.20.01.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 01:40:44 -0700 (PDT)
Subject: Re: [PATCH v13 05/12] KVM: SVM: Add KVM_SEV_RECEIVE_UPDATE_DATA
 command
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        joro@8bytes.org, bp@suse.de, thomas.lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srutherford@google.com, seanjc@google.com,
        venu.busireddy@oracle.com, brijesh.singh@amd.com
References: <cover.1618498113.git.ashish.kalra@amd.com>
 <c5d0e3e719db7bb37ea85d79ed4db52e9da06257.1618498113.git.ashish.kalra@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4488123-daac-3687-6f8d-fb54d6bd4019@redhat.com>
Date:   Tue, 20 Apr 2021 10:40:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <c5d0e3e719db7bb37ea85d79ed4db52e9da06257.1618498113.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/21 17:55, Ashish Kalra wrote:
> +	if (!guest_page)
> +		goto e_free;
> +

Missing unpin on error (but it won't be needed with Sean's patches that 
move the data block to the stack, so I can fix this too).

Paolo

