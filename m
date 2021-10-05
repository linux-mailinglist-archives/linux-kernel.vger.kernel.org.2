Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B77E422EE1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 19:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbhJERRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 13:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236689AbhJERRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633454150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SqMOCWm0rmfs9tFcXMth2/WPo3/ZpdQDJCYD1hfrOb8=;
        b=iXTUvEqrykrwDqv36YMfWmYtATJjBmYeCwjZTyF3fHSgrSTho/6KyxHCGJL6BKu/8Y5/yb
        2z86iPel8qVk/rQ3B6MaSeR0pKhbp5bJEVwLB98NW9cCpJPLC29R5Q0dR4kvNBA7oKjGgC
        4K1E5qj8tvoF/gMHSo3BwkHYDh44QIo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-WBuRa4OvOxyUrSvuPe2sWg-1; Tue, 05 Oct 2021 13:15:48 -0400
X-MC-Unique: WBuRa4OvOxyUrSvuPe2sWg-1
Received: by mail-ed1-f69.google.com with SMTP id v2-20020a50f082000000b003db24e28d59so395303edl.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 10:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SqMOCWm0rmfs9tFcXMth2/WPo3/ZpdQDJCYD1hfrOb8=;
        b=zSyFQc6kvgYZOuf5E6JFdNln5bk6TwPEVZN/oLj4jzVIkaJh3tfqG2FwOH6ORt0kNM
         lJqfKjXoc/pIkt+P9cUXIrRrqxiGB+eJ7DfSn0ZdEmb14oSDXd4wrMJk6xtcvVEftfzm
         nVmj+gH+CvN6IH0NL8pkhfBYK/+J3ifRT2JHAMlV6YqpbQjHccULUl2Kn4bBM15svXm4
         PzoSJGoZ1QWkInAgTgU+0DVmEcxSdRlbwKjT0gtXHunYPzamJUIAXtv+gHT0Z8D2hSI+
         WH0HPSmuYVn9RyRDXe6kh6fULHElgYP/mWImGW3TfH4e/5sETXNSTkJdc6hWgQxr0r3f
         Tsqw==
X-Gm-Message-State: AOAM531fkmyOY+wmWCygwPkEttkdcZDVltRRusjisrOvipQR+js4U7k7
        CxzvrnyB7xm/V2w4K3fPN/8bXQkGigCFOHN1FIA/IplVI8WpQyMJ6QJdK+n7rJFetorGr5i2vSy
        Ntjsj55y0rHPGA8t9xuGQhcIh
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr25952283ejp.427.1633454147713;
        Tue, 05 Oct 2021 10:15:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/XaDhlbNvacD57xV4blEW+j/Z0hYH1wET78/YBCPs2M990/p9GqNkNMKhkvTs0As+b95XiQ==
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr25952254ejp.427.1633454147509;
        Tue, 05 Oct 2021 10:15:47 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e7sm297875edz.95.2021.10.05.10.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 10:15:46 -0700 (PDT)
Message-ID: <9c1fa821-2eaf-7709-7bd2-be83f92d2ee5@redhat.com>
Date:   Tue, 5 Oct 2021 19:15:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v1] KVM: isolation: retain initial mask for kthread VM
 worker
Content-Language: en-US
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, vkuznets@redhat.com, tglx@linutronix.de,
        frederic@kernel.org, mingo@kernel.org, nilal@redhat.com,
        Wanpeng Li <kernellwp@gmail.com>
References: <20211004222639.239209-1-nitesh@redhat.com>
 <e734691b-e9e1-10a0-88ee-73d8fceb50f9@redhat.com>
 <20211005105812.GA130626@fuller.cnet>
 <96f38a69-2ff8-a78c-a417-d32f1eb742be@redhat.com>
 <20211005132159.GA134926@fuller.cnet>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211005132159.GA134926@fuller.cnet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/21 15:21, Marcelo Tosatti wrote:
>> The QEMU I/O thread is not hogging the CPU 100% of the time, and
>> therefore the nx-recovery thread should be able to run on that CPU.
> 
> 1) The cpumask of the parent thread is not inherited
> 
> 	set_cpus_allowed_ptr(task, housekeeping_cpumask(HK_FLAG_KTHREAD));
> 
> On __kthread_create_on_node should fail (because its cgroup, the one
> inherited from QEMU, contains only isolated CPUs).
> 
> (The QEMU I/O thread runs on an isolated CPU, and is moved by libvirt
> to HK-cgroup as mentioned before).

Ok, that's the part that I missed.  So the core issue is that libvirt 
moves the I/O thread out of the isolated-CPU cgroup too late?  This in 
turn is because libvirt gets access to the QEMU monitor too late (the 
KVM file descriptor is created when QEMU processes the command line).

Paolo

