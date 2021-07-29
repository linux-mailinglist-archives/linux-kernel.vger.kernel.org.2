Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBEE3DA04F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhG2JfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235622AbhG2JfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627551311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GL8yo4T1lYqtt20r6KuqjoBVUtGlVQrRHRnGsjw+oeA=;
        b=SVYGhUtff7HVqm4ldfTMiE7mUIbwMuKzfA5sz9KowUGAKOldUacrdry0waHK2eo/DEbNl3
        +8vE63TtUPwIEgN4A+StEo24H/JBfdkXa0/TPLZDBvxJtYrgeNbwuIVAxeTHjhLtdG6vAO
        JYoywO5jYEL8tBAUW5p14s8PRLgdJo8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-L8oo0smRNz-VgcmTYZGk_A-1; Thu, 29 Jul 2021 05:35:07 -0400
X-MC-Unique: L8oo0smRNz-VgcmTYZGk_A-1
Received: by mail-ed1-f71.google.com with SMTP id l10-20020aa7caca0000b02903b874f26036so2638418edt.20
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GL8yo4T1lYqtt20r6KuqjoBVUtGlVQrRHRnGsjw+oeA=;
        b=JyrX5lCi5LKq3QKKpKJX6U6I2TsX41IffFZ54YMdFkXtud7O5JXrlhX+pafFpNr8+g
         9usu7eMBhIOSdlqMMUp5tBkMuRxiOp3UBTuM/bjT03cv8rRPVmntJFdDBKrT43YfqkvQ
         qsmSmlvtaumDuI/m8pHmGzBB6P3y2prxZONFCnpx02ZGu7dIT857TzJR2JKDgSBDTpd9
         7tsb3J/E5mFUkVPC4p7jBDgYmNAlbV11MIvV1VP+ydQf9aGfLYpQ0+7vEd84F2GKA5Kd
         0vvL21HTWNyj4uw5zF7PWV/6i94zg56dfguKe5MCYaTLeKUmJahe+YJCxnn3Z2bBQXao
         xm/Q==
X-Gm-Message-State: AOAM531ITt3KG1YNenOXE1Sj18pB8Rd7UxYE3DNeBOm4UoJKO2luGoDt
        Lo4sutIxxocERsWODlBOC3uq6mO/MEeCKPU15KXVl8kWBSqWgXEFIYgRVqo5DHaU3RTOg6650AF
        Y9BzobpJ5kp/x0Iuynx2VYqiU
X-Received: by 2002:a17:907:2bd0:: with SMTP id gv16mr3889706ejc.49.1627551306420;
        Thu, 29 Jul 2021 02:35:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyDBQjZYIdLYt3llFOHVemIJWYi3AdcSIncArF9cUKmxLCuKQxPAnyKhTmwPhu61dMMjraXw==
X-Received: by 2002:a17:907:2bd0:: with SMTP id gv16mr3889691ejc.49.1627551306230;
        Thu, 29 Jul 2021 02:35:06 -0700 (PDT)
Received: from [192.168.10.118] ([93.56.169.140])
        by smtp.gmail.com with ESMTPSA id s24sm786053ejd.19.2021.07.29.02.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 02:35:05 -0700 (PDT)
Subject: Re: [PATCH v2 9/9] KVM: X86: Optimize zapping rmap
To:     Sean Christopherson <seanjc@google.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20210625153214.43106-1-peterx@redhat.com>
 <20210625153419.43671-1-peterx@redhat.com> <YQHOdhMoFW821HAu@google.com>
 <YQHTocEdMzsJQuzL@t490s> <YQHa1xuNKhqRr4Fq@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c2c83189-6bc4-1f3b-36da-be19b940dcf9@redhat.com>
Date:   Thu, 29 Jul 2021 11:35:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQHa1xuNKhqRr4Fq@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/21 00:31, Sean Christopherson wrote:
>> If that'll be a performance concern, no objection to hard code it.
> It's more about unnecessary complexity than it is about performance, e.g. gcc-10
> generates identical code for both version (which did surprise the heck out of me).

If you think of what's needed to produce decent (as fast as C) code out 
of STL code, that's not surprising. :)  Pretty cool that it lets people 
write nicer C code too, though.

> If we really want to isolate pte_list_destroy(), I would vote for something like
> this (squashed in).   pte_list_remove() already calls mmu_spte_clear_track_bits(),
> so that particular separation of concerns has already gone out the window.

Yes, that's fair enough.  Thanks for the review!

Paolo

