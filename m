Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746054096DD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbhIMPQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347109AbhIMPPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631546054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLiPuLulR0KEA9PC+ni4AmJzEqtKLqvlUOW8UTnUXUA=;
        b=dN1KSImK0M0OznSJAoSlWg7h1mQL5wkVy0lnLjD7ISBawg92ch2yW0vryI2YS4vvIjXIxh
        sX+EWw/erV6X6vj3WF5GS03gHzPOlzZPkKmno2QW5nwg2vaK+YPaKBUE2ZAuHHljeOBGov
        XgSrRWoDjkgJtp5mEV8Jt6ddijxtw7Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-nZ3Bk7MZMpWvMPfgbbqGjA-1; Mon, 13 Sep 2021 11:14:11 -0400
X-MC-Unique: nZ3Bk7MZMpWvMPfgbbqGjA-1
Received: by mail-ej1-f70.google.com with SMTP id s11-20020a170906060b00b005be824f15daso3832685ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 08:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qLiPuLulR0KEA9PC+ni4AmJzEqtKLqvlUOW8UTnUXUA=;
        b=Q2wYcQv7zfyTngMR3laIwy2gpsaAwLq2EVhSBAG+3YSEpbYiNpKnIZUAmhD3+BF04N
         IsL5Wxvo0+tWM841hslENoS1v/lF9s9PXfr+ZYZAC7vsTXi8HZXrE1yX2ec2ouOPOeX7
         VejBIhkoBy2bAa3udmG8uiWZxiYtwVRPOjJUD2OfRUTk0JqK3CC4G+FsTPs6Ns497wkw
         ABnIXRwyFy1lzDlxdU9rOvALPfMlg8ifQmbZIulfznGz3wcuj7QUL/MCoJ+X322rt4Tv
         7wAl2T0+c+ahU6di2H6JUTyhKfQR9X5Iche0ZcWiXfP5u7zZpVWqgjlvPna5f8RboyJH
         XsEg==
X-Gm-Message-State: AOAM533e/6jIp13a0tXZGa+eLRoeyO3MefLPgEYqFvxVabEwJQzC+xNG
        FrxjGjYQRbC6p/hLtxZhiyL4dWX5Zr4GXiAc/pa53knbgMRwmis573G5MZaqBfq0AhJA7aPCF1v
        Rsr7//oZgqlGVKk58q/hevW7e
X-Received: by 2002:a05:6402:26c4:: with SMTP id x4mr10020106edd.95.1631546050204;
        Mon, 13 Sep 2021 08:14:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXlKwyLGX/MszHYats7cUI5Peb1wU+RRlbm432xsjeZYS7I2KrziDTrcT1CMh7Kk82MNf3XA==
X-Received: by 2002:a05:6402:26c4:: with SMTP id x4mr10020087edd.95.1631546050016;
        Mon, 13 Sep 2021 08:14:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id eg14sm4193586edb.64.2021.09.13.08.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 08:14:09 -0700 (PDT)
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org, jarkko@kernel.org,
        dave.hansen@linux.intel.com, yang.zhong@intel.com
References: <20210913131153.1202354-1-pbonzini@redhat.com>
 <20210913131153.1202354-2-pbonzini@redhat.com>
 <dc628588-3030-6c05-0ba4-d8fc6629c0d2@intel.com>
 <8105a379-195e-8c9b-5e06-f981f254707f@redhat.com>
 <06db5a41-3485-9141-10b5-56ca57ed1792@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] x86: sgx_vepc: extract sgx_vepc_remove_page
Message-ID: <34632ea9-42d3-fdfa-ae47-e208751ab090@redhat.com>
Date:   Mon, 13 Sep 2021 17:14:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <06db5a41-3485-9141-10b5-56ca57ed1792@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/21 16:55, Dave Hansen wrote:
>> By "Windows startup" I mean even after guest reboot.  Because another
>> process could sneak in and steal your EPC pages between a close() and an
>> open(), I'd like to have a way to EREMOVE the pages while keeping them
>> assigned to the specific vEPC instance, i.e.*without*  going through
>> sgx_vepc_free_page().
> Oh, so you want fresh EPC state for the guest, but you're concerned that
> the previous guest might have left them in a bad state.  The current
> method of getting a new vepc instance (which guarantees fresh state) has
> some other downsides.
> 
> Can't another process steal pages via sgxd and reclaim at any time?

vEPC pages never call sgx_mark_page_reclaimable, don't they?

> What's the extra concern here about going through a close()/open()
> cycle?  Performance?

Apart from reclaiming, /dev/sgx_vepc might disappear between the first 
open() and subsequent ones.

Paolo

