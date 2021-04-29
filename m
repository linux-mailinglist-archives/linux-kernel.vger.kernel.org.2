Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A39636E86C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbhD2KKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240262AbhD2KKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619690964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ZFyr5mpRghduXOnoE7H3sxU/6BfwiFPot9Qqrp6hRU=;
        b=JwsXeJhKjYVh8SedOeXpuGXDj4MzMujSt1F4l1E7rky9idkL4B0dpD+OT1aAP86ZQvLnee
        mmo5U3pcTCQ3PRxsFgDiOUtNk7RlqSt+G74eaIDNtJ1aeU/qrxQPLJGr3PwnnJ1j4KDOsL
        d/0Ct/n0dvW5zmS6w+O6U2G8g6Pz5cc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-8aAoDgGhOYGo1qCKVmm5gw-1; Thu, 29 Apr 2021 06:09:19 -0400
X-MC-Unique: 8aAoDgGhOYGo1qCKVmm5gw-1
Received: by mail-ed1-f71.google.com with SMTP id c15-20020a056402100fb029038518e5afc5so21041911edu.18
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 03:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7ZFyr5mpRghduXOnoE7H3sxU/6BfwiFPot9Qqrp6hRU=;
        b=ixSRtzprlKWHSsgCNz3+r6yMylKC3pimhA8j4Yj1vl3VdbNKzv7zcV5at34U6WD6iY
         OZK2uvKwq9WrRWMGJmuGXwizxJBqAoKXMcpcZeLUGPNNECMNRfBEBmnBVxqQ+7LtDEFy
         2N8GIfOTWtHDhcgDoJ2vZ5esTrInAaAaqztmHjgJUCCDpxP1KnIXxGC1IvpkZdJ11Co9
         yDdA65HA9otBJZvHo+QJaKjURZ7w1SH6psf/TzYlRg2YkIrAi+k84DnWAXUTAKUcPcv/
         6vDI4M+I+cN9Be7rkLpKkTrs9eSF4jnKHc2UYXxZPJ04dU3C7ZlL11o2aZMgaAn2BqLo
         SRYw==
X-Gm-Message-State: AOAM531SN8CmHSjTleAOJ1nibNNT7Gb8keuQlkO2gNMmEX3dLQN4olVu
        JtbVcHEGCdoEBFCFhWOpeIAfoEQNyxS8YwGBrPNSVu2/HrNX7rSJ2mzTKU+JNUbaDw8nCMqfB0r
        LgIhTGRW1DjRoxZUdHz912F41
X-Received: by 2002:a05:6402:2211:: with SMTP id cq17mr16993721edb.28.1619690958432;
        Thu, 29 Apr 2021 03:09:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1YMOL4t+paQHX+lVQsNYt9WN5JUhsRxvn9uu0mM2C1D//VngYDfIF/6Qg3bG0hhfeHSGVxw==
X-Received: by 2002:a05:6402:2211:: with SMTP id cq17mr16993705edb.28.1619690958290;
        Thu, 29 Apr 2021 03:09:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t15sm2010629edr.55.2021.04.29.03.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 03:09:17 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] KVM: x86: add MSR_KVM_MIGRATION_CONTROL
To:     Sean Christopherson <seanjc@google.com>,
        Steve Rutherford <srutherford@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
References: <20210421173716.1577745-1-pbonzini@redhat.com>
 <20210421173716.1577745-3-pbonzini@redhat.com> <YIiMrWS60NuesU63@google.com>
 <CABayD+dKLTx5kQTaKASQkcam4OiHJueuL1Vf32soiLq=torg+w@mail.gmail.com>
 <YInAT6MYU2N0tKSW@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cc0c6333-6c2f-e8f3-f838-3cb2492f007a@redhat.com>
Date:   Thu, 29 Apr 2021 12:09:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YInAT6MYU2N0tKSW@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/21 22:06, Sean Christopherson wrote:
> But there's only multiple meanings if we define the bit to be specific to
> page encryption.  E.g. if the bit is KVM_READY_FOR_MIGRATION, then its meaning
> (when cleared) is simply "please don't migrate me, I will die".  KVM doesn't
> care_why_  the guest is telling userspace that it's not ready for migration, nor
> does KVM care if userspace honors the indicator.

Makes sense, I'll change that.

Paolo

