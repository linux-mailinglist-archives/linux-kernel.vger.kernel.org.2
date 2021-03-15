Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0933C42F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhCORaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30988 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236394AbhCORaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615829405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49lfJRWKKEBpIbOKRaFlvzL+cvb95zX4ZYi+xzBTlg4=;
        b=C2ybYC/JppgFOkRCu1aMp2PCKYtdaDaaQ9bIbbd12cDlI8owMOr/E+BUgr79GjMIAahHLx
        1kZ48RxsSvSJXo7zKPPmySBL5f1puaDHzaoevon2pQ11ieqW0h92tGvq7WFeFfOcDdFFjl
        FOrQdJ66SN2DwXO6eO1G8A25fz7VXGs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-WgrTz7zbO2ezphuvKbZh_w-1; Mon, 15 Mar 2021 13:30:02 -0400
X-MC-Unique: WgrTz7zbO2ezphuvKbZh_w-1
Received: by mail-ed1-f70.google.com with SMTP id q25so1579094eds.16
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=49lfJRWKKEBpIbOKRaFlvzL+cvb95zX4ZYi+xzBTlg4=;
        b=cBHyhf629dnvgYdFTm79OhM7w3Tfqo7IXS4P3EHEQ2Txv95GkP5uRvBeECOyZCx9f4
         xLBa3icw9sjwxBDxUSwi/a/nABtgEqF7JdMxQ3POTagccc1dlGs4zpqgxFHGcJD5grY1
         Uq1BBpX/e776EDMYLMyUy2km2+C2aCBiUExjwdUMuJ5PN/s1viaB2LcTn3SwkcNsyr4E
         kBkOLh7TKK3a/CyEMJZz2p9Gxfmyq4V73lpm8JAbVLB1y1cXqqyLuTi0/Su+xQRdyMd2
         v80oE/Ykvn+8wiSzR6oHC9wRosjhIkWLpauQx0rMGQcENmexwAMFSeEHE7USGH/NDY8Y
         Aowg==
X-Gm-Message-State: AOAM5337Vx8GfB9u1QOVEFMRR93zaZUK3qJvoWFI0ErB91ST36HXlq7m
        UgXVdNDnMa9Iq3gl0f+TYovpy00oaWq/hxic/bNnBEpQ7X6y+M4eAXeBJvbhVBl4hKR8B7GPrLI
        amSItt3soyrOn50JoqLnTBaYT
X-Received: by 2002:a17:907:d10:: with SMTP id gn16mr14108909ejc.304.1615829401651;
        Mon, 15 Mar 2021 10:30:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWcyiDNAeGBQsoY9WcHB0zHRZpCln4m3pBXhyKhHaDLYYLjNpzoNz75Ddz7iz/ieveaKhzcw==
X-Received: by 2002:a17:907:d10:: with SMTP id gn16mr14108876ejc.304.1615829401480;
        Mon, 15 Mar 2021 10:30:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id y17sm7810001ejf.116.2021.03.15.10.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 10:30:00 -0700 (PDT)
Subject: Re: [RFC] KVM: x86: Support KVM VMs sharing SEV context
To:     Tobin Feldman-Fitzthum <tobin@linux.ibm.com>, natet@google.com
Cc:     Dov Murik <dovmurik@linux.vnet.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srutherford@google.com, seanjc@google.com, rientjes@google.com,
        Brijesh Singh <brijesh.singh@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Laszlo Ersek <lersek@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>
References: <20210224085915.28751-1-natet@google.com>
 <7829472d-741c-1057-c61f-321fcfb5bdcd@linux.ibm.com>
 <35dde628-f1a8-c3bf-9c7d-7789166b0ee1@redhat.com>
 <adb84c91-1651-94b6-0084-f86296e96530@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <69004ca1-93a7-6a7e-b349-05f857756334@redhat.com>
Date:   Mon, 15 Mar 2021 18:29:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <adb84c91-1651-94b6-0084-f86296e96530@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/21 18:05, Tobin Feldman-Fitzthum wrote:
>>
>> I can answer this part.  I think this will actually be simpler than 
>> with auxiliary vCPUs.  There will be a separate pair of VM+vCPU file 
>> descriptors within the same QEMU process, and some code to set up the 
>> memory map using KVM_SET_USER_MEMORY_REGION.
>>
>> However, the code to run this VM will be very small as the VM does not 
>> have to do MMIO, interrupts, live migration (of itself), etc.  It just 
>> starts up and communicates with QEMU using a mailbox at a 
>> predetermined address.
> 
> We've been starting up our Migration Handler via OVMF. I'm not sure if 
> this would work with a minimal setup in QEMU.

Yeah, the way to start up the migration handler would be completely 
different, you'd have to do so very early (probably SEC).

Paolo

