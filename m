Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743D743688F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 19:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhJURDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 13:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhJURDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634835666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C45rcZRW+kLqjdpIuOhUQvD5FAcBsxSwvOw5uYjICgo=;
        b=XYUjqe38+vPZJ9NokFqSWpW7qWb27o1NKarW7suzJ9MfTudHjj0pT/tp8gdXQ/O9b6DtJV
        F6ENg/hYkIodzHmTphqHrdAFwyRWV1hZTyYbbaX3lexKnGUBKURnZ4U6uS9GuKvv+mvYL0
        S+5+QrxDeLU02VZ6n8+N7E8fnRIhWUI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-RsWd4EZPOwm2k2zODq5ykQ-1; Thu, 21 Oct 2021 13:01:05 -0400
X-MC-Unique: RsWd4EZPOwm2k2zODq5ykQ-1
Received: by mail-ed1-f71.google.com with SMTP id f4-20020a50e084000000b003db585bc274so976728edl.17
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C45rcZRW+kLqjdpIuOhUQvD5FAcBsxSwvOw5uYjICgo=;
        b=0JkuTN5HaiVG3w6EHQwKs94k/5XRd7njhsjmryF6jkzmmKxCOI/Yf/FRCpkFmE2kl3
         IJFwbzBEszKPKTcdmv3cHAVMS3G31gVJj7ERMWm+Gn4PT7VRa95OZatNd8HoebJ7wSn+
         hW4fi9Kc93tjQxOsbj9Zoxzo18hLeP7/QRX9RiXPH8IwnL6n63KiZ6O/T9FLwMLyliHh
         8QV9SjVbkLmAvUyvb89ogIBoznrDxROdUD3yhQLXCrrsWt3V9D06cKiuw6jJy3RFHRYP
         0A80w3X+fm0VBCoT23fWbC/o8aL13sUDpEwe/4DOPCBIXUC8j5e/ifxFTEiJKBdfyEcR
         b0gA==
X-Gm-Message-State: AOAM532sRZ5j0QI7ToUyJ7aw6mXL8Xf0kvEp+nrbqbGf+uUPdbsXgjFV
        eFeU/8O90wvp3rURjhV47cgynZoSTHofOgUAbpIaOrTlO5IaY50RjzaiVcng9XMu8p3qRq3pLNI
        5qMk579Xv2elbdb8r4YNASE/g
X-Received: by 2002:a05:6402:4256:: with SMTP id g22mr9128970edb.399.1634835663941;
        Thu, 21 Oct 2021 10:01:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIDbn5BCIQe+EkVqvY9JP9XuhGRY7LsAzAyuI3Rha7kLn51b9yeCcCYREGW3hH7MObChkzhA==
X-Received: by 2002:a05:6402:4256:: with SMTP id g22mr9128934edb.399.1634835663780;
        Thu, 21 Oct 2021 10:01:03 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id f7sm3069873edl.33.2021.10.21.10.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 10:01:02 -0700 (PDT)
Message-ID: <19578a3b-e624-4002-81b0-d0346abee2f7@redhat.com>
Date:   Thu, 21 Oct 2021 19:01:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 2/2] KVM: SEV: Flush cache on non-coherent systems before
 RECEIVE_UPDATE_DATA
Content-Language: en-US
To:     Ashish Kalra <Ashish.Kalra@amd.com>, seanjc@google.com
Cc:     brijesh.singh@amd.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcorr@google.com, masa.koz@kozuka.jp, pgonda@google.com,
        thomas.lendacky@amd.com, vkuznets@redhat.com, wanpengli@tencent.com
References: <20210914210951.2994260-3-seanjc@google.com>
 <61709f42.1c69fb81.3b49.ecfeSMTPIN_ADDED_BROKEN@mx.google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <61709f42.1c69fb81.3b49.ecfeSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/21 00:58, Ashish Kalra wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Hello Paolo,
> 
> I am adding a SEV migration test as part of the KVM SEV selftests.
> 
> And while testing SEV migration with this selftest, i observed
> cache coherency issues causing migration test failures, so really
> need this patch to be added.
> 
> Tested-by: Ashish Kalra <ashish.kalra@amd.com>
> 

Queued for 5.15, thanks.

Paolo

