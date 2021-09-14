Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F2D40A37F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbhINCV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238318AbhINCVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631586035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rcYJHx/4UcJXZGKmDo86svliqJbYFIRBfH+q9c03jV8=;
        b=TnHw1ihxeqPgn2RmlTE5nT5D0L/+yP+zqcvUy/6pzOtxw1vW/RD6sB3S6A6tTdqf8Xz+9G
        5nOCM6wdWt6ME27C1sq+g79Phn+rHXfQwUtbxrOx1nEj74TFgxUslQP2122sl9llQzlC1F
        K7NanROu/3R4pJz3di0f7ivSStJhmH8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-5xHKaJR1OD2fUzjbk_EB1A-1; Mon, 13 Sep 2021 22:20:34 -0400
X-MC-Unique: 5xHKaJR1OD2fUzjbk_EB1A-1
Received: by mail-pg1-f198.google.com with SMTP id h10-20020a65404a000000b00253122e62a0so8524236pgp.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 19:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rcYJHx/4UcJXZGKmDo86svliqJbYFIRBfH+q9c03jV8=;
        b=NKT6VLv5SGGmccAxcEZaXtDGgX+6UkOyTEM2rF25X5PwLHOPxiC8JfuoG12ujITNjz
         fn5QSGOzu89Eh7AxjOHn9XVXd0dggmh6SQFjnzItyUQ9K7V8jr/3kt+/H0Ph5LiIlKf4
         e+gaR3cAOhXIvfeg6f6jiL73yPKsedH2NK0MGTxxJ4qLnoFcmGVfgZ3dmnJwM0GEy7b1
         GnbtL8fdCav/TaFdNABG598zkew594x8w8iBLt1/L4BGv6L6qxwi5d/5lXU+VyNQK1XZ
         05gSbyykHu2UPRcb/Nh184HQwSdmhivt1g2aMrrURz9GLWXL1wgB/Lg3/B8QK9pw773Y
         auzA==
X-Gm-Message-State: AOAM5308ghRoItrUbwbfDSzkxq8+BXMdSDDuErssLooSp4FpKmme04C1
        NOtr7d25HLJyHNK9PJUZt5mE2YNYOZP3CrKozXHaTsuLS4xHuKdyqdiKMc8wBtPGBl8rmxk1t2g
        IfnhoLTx5251whfzxWl53do2e
X-Received: by 2002:a17:902:bcc6:b0:138:d3ca:c356 with SMTP id o6-20020a170902bcc600b00138d3cac356mr12957356pls.6.1631586033278;
        Mon, 13 Sep 2021 19:20:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTi2t9kwRmgzAkZOi4siQl5/JqG3e4HK5NmMFCXfex3BVoLj5jj59CSw0hkzWSUkEcyY9uOw==
X-Received: by 2002:a17:902:bcc6:b0:138:d3ca:c356 with SMTP id o6-20020a170902bcc600b00138d3cac356mr12957317pls.6.1631586033012;
        Mon, 13 Sep 2021 19:20:33 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g3sm7944621pjm.22.2021.09.13.19.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 19:20:32 -0700 (PDT)
Subject: Re: [PATCH 6/9] virtio_pci: harden MSI-X interrupts
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        pbonzini <pbonzini@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-7-jasowang@redhat.com>
 <20210913015711-mutt-send-email-mst@kernel.org>
 <CACGkMEva2j57tG=-QYG7NdgEV28i-gpBReRR+UX7YwrHzRWydw@mail.gmail.com>
 <20210913022257-mutt-send-email-mst@kernel.org>
 <CACGkMEsWJq0SMMfTBdoOxVa1_=k9nZkrRu2wYZo7WO-01p_sgQ@mail.gmail.com>
 <20210913023626-mutt-send-email-mst@kernel.org>
 <20210913024153-mutt-send-email-mst@kernel.org>
 <CACGkMEu+HPBTV81EHOc6zWP7tTgTf4nDaXViUeejmT-Bhp0PEA@mail.gmail.com>
 <87bl4wfeq1.ffs@tglx> <20210913164934-mutt-send-email-mst@kernel.org>
 <87sfy8ds53.ffs@tglx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <98ddcf92-b0c8-77c3-d1ca-9855896a2600@redhat.com>
Date:   Tue, 14 Sep 2021 10:20:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87sfy8ds53.ffs@tglx>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/9/14 ÉÏÎç6:31, Thomas Gleixner Ð´µÀ:
> On Mon, Sep 13 2021 at 16:54, Michael S. Tsirkin wrote:
>
>> On Mon, Sep 13, 2021 at 09:38:30PM +0200, Thomas Gleixner wrote:
>>> On Mon, Sep 13 2021 at 15:07, Jason Wang wrote:
>>>> On Mon, Sep 13, 2021 at 2:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>> But doen't "irq is disabled" basically mean "we told the hypervisor
>>>>>> to disable the irq"?  What extractly prevents hypervisor from
>>>>>> sending the irq even if guest thinks it disabled it?
>>>>> More generally, can't we for example blow away the
>>>>> indir_desc array that we use to keep the ctx pointers?
>>>>> Won't that be enough?
>>>> I'm not sure how it is related to the indirect descriptor but an
>>>> example is that all the current driver will assume:
>>>>
>>>> 1) the interrupt won't be raised before virtio_device_ready()
>>>> 2) the interrupt won't be raised after reset()
>>> If that assumption exists, then you better keep the interrupt line
>>> disabled until virtio_device_ready() has completed
>> started not completed. device is allowed to send
>> config interrupts right after DRIVER_OK status is set by
>> virtio_device_ready.
> Whatever:
>
>   * Define the exact point from which on the driver is able to handle the
>     interrupt and put the enable after that point
>
>   * Define the exact point from which on the driver is unable to handle
>     the interrupt and put the disable before that point


Yes, this is exactly what this patch (and INTX patch) want to achieve. 
The driver should only able to handle the interrupt after 
virtio_device_ready() but before reset().

Thanks


>
> The above is blury.
>
>>> and disable it again
>>> before reset() is invoked. That's a question of general robustness and
>>> not really a question of trusted hypervisors and encrypted guests.
>> We can do this for some MSIX interrupts, sure. Not for shared interrupts though.
> See my reply to the next patch. The problem is the same:
>
>   * Define the exact point from which on the driver is able to handle the
>     interrupt and allow the handler to proceed after that point
>
>   * Define the exact point from which on the driver is unable to handle
>     the interrupt and ensure that the handler denies to proceed before
>     that point
>
> Same story just a different mechanism.
>
> Thanks,
>
>          tglx
>

