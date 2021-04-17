Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0C2362FF8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbhDQMnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 08:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236092AbhDQMnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 08:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618663373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v6Mb+PkPBBrnApLNLzo6vlvHUrWkry8FXhN/7p3cu+A=;
        b=IBGkRIwZphjkbI/mk+yR0kPID1XFQMLRzNBm1hQrxIoDb4CElmutR2tAiZY9EJLT0+HFkw
        N3VRG2gCuzYU0MbPcpmxko9s93wlPllIVwIenm5JsUqsQCJ/G/hCGzucNo9X7XOT+E6fi1
        D5WZreWAKukFDl+QpM3U8s/EWBvCFPk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-IblgXdY8MTCDX8tqU7iOAQ-1; Sat, 17 Apr 2021 08:42:51 -0400
X-MC-Unique: IblgXdY8MTCDX8tqU7iOAQ-1
Received: by mail-ed1-f70.google.com with SMTP id h13-20020a05640250cdb02903790a9c55acso8576588edb.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 05:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v6Mb+PkPBBrnApLNLzo6vlvHUrWkry8FXhN/7p3cu+A=;
        b=U8m/oXY+j86d5uKsbv8WGNJBlvBGBtztt8OW8asrpqDPVoGnJvnUDDWhoggTR1CFZV
         CUjVw7hQh7+iUvmWhOqjv8wYx0inq9sG6f7hiqlj0Vp4TEVW8OGALl5zD0TSus21Wurq
         axkQRznsC/yf9ucGSeQ4XS4AB89Fg/wy7n8uzH/4mRGGZfARPeCSWBGH2LwEp/RDpCpk
         SiKJTIdIWlyax45TdstUl0pBPQCGWrKJW4fYyBArEV5ZSOvX7Mt+ZrcDSzdvpCF2qax1
         iWesvdpOtiDZL7ej4LmvokYwLqDAcP+c4M8KthWEaDUCBVUj5maC/0s2iXpoQ52Sirlu
         Y21Q==
X-Gm-Message-State: AOAM531NkNd5X+Ys6xRw52OSBIdZLwTBYhktXp+1th5JEXwrkJt+z9JB
        raS8QSoeiegRP6J0adz5bGLcbIvCG57gmU6bg5Qr32WLnQxoTsMa7OKaDI74MbATtShHSEd1cVj
        GKiOzPteI+J5pP03BxmhWhHMG
X-Received: by 2002:a17:906:af84:: with SMTP id mj4mr12538617ejb.195.1618663370345;
        Sat, 17 Apr 2021 05:42:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/rAGnhUeAhuXmI4Iows5d3uO86rHJLc+07xpKXycm1wPXBa+McxEFaQqCM2U2gMNK5/UkXg==
X-Received: by 2002:a17:906:af84:: with SMTP id mj4mr12538594ejb.195.1618663370133;
        Sat, 17 Apr 2021 05:42:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id ca1sm8198395edb.76.2021.04.17.05.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 05:42:49 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] crypto: ccp: Use the stack and common buffer for
 INIT command
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
References: <20210406224952.4177376-1-seanjc@google.com>
 <20210406224952.4177376-8-seanjc@google.com>
 <29bd7f5d-ebee-b78e-8ba6-fd8e21ec1dc8@csgroup.eu>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a75c54d5-d4af-5d67-ef35-025d3e4a3f51@redhat.com>
Date:   Sat, 17 Apr 2021 14:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <29bd7f5d-ebee-b78e-8ba6-fd8e21ec1dc8@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/21 07:20, Christophe Leroy wrote:
>>
>> +    struct sev_data_init data;
> 
> struct sev_data_init data = {0, 0, 0, 0};

Having to count the number of items is suboptimal.  The alternative 
could be {} (which however is technically not standard C), {0} (a bit 
mysterious, but it works) and memset.  I kept the latter to avoid 
touching the submitter's patch too much.

Paolo

