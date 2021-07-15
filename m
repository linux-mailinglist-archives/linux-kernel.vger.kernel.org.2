Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477A83C9C32
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbhGOJyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232473AbhGOJyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626342697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dR8uPancX/qqeTPCBjElsarS+8BXPFXgvmywV29J+tI=;
        b=BdakbEAJ8MAATnMejq7Zt0BjtVcr8Iv9C39kjg0ImXGkxIFHI7RoG65aHMVo/B8Ge88wiY
        WqjiYprr5v8lgNVE+4824+D/VcOEZkIpphC/DYiIdHdU2Rm82iRTTIIgfeMa7TK3DnSU5e
        LathBIvoWoPchxx66K84cgiq8xByToU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-51R01BeJOKetsMC0hx08YA-1; Thu, 15 Jul 2021 05:51:36 -0400
X-MC-Unique: 51R01BeJOKetsMC0hx08YA-1
Received: by mail-wr1-f71.google.com with SMTP id m4-20020adffa040000b02901404c442853so3066601wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 02:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dR8uPancX/qqeTPCBjElsarS+8BXPFXgvmywV29J+tI=;
        b=emK+NooPYIcOkmDgoTr36t9ep+5Xoj/w2uE+LcP/Li3Rn1OcrCC5edWX6Bn6FmXEhk
         gnDth4BI2Of7dmBqXwYp57+Acy4DqWlEs6B+oZCrzemK7AHPXnZiTqEInuOlrT1hAHx/
         0cScduuZEBK7NlycEEtH6fCQY6eYKm5QdfafFyJR6vQ2pixcl71nlDD0oLmzcOaVKXXB
         mrWABK0CIrml2cA9EtM4hWB2OkrMxbSV+YzgeF3nlRvSIXEAalrfxxiuBSFYCVOHCN8v
         CUmH+vEvWu4tNyUoeU305GmjzyOuqFD7yzHeJcztPzBYZNnC2KCbqo7o55XXJON+lRTF
         pYNA==
X-Gm-Message-State: AOAM532OIGRx4i4ts9LcR1m85eerEJZXTlCVXZGut5QbJ+1UFJYtbbjV
        ec2b+j/hBKPmQt5x1jtZh9wxURhHOrPNugvQs3BBcOplKw1zynt/200qqb7R0b2W59k9R6O5xhg
        BtG8S/oFwm3QI9X06iYBifo5J
X-Received: by 2002:a1c:493:: with SMTP id 141mr3682735wme.172.1626342695232;
        Thu, 15 Jul 2021 02:51:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxHnBTQd8EBvDvE+fh/H5JOd3n98Hv/0MLO3UGlbOtPJQDckheenHBNWf8+fW1YAIvzkbM/w==
X-Received: by 2002:a1c:493:: with SMTP id 141mr3682713wme.172.1626342695002;
        Thu, 15 Jul 2021 02:51:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id b9sm7137793wrh.81.2021.07.15.02.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 02:51:34 -0700 (PDT)
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     He Zhe <zhe.he@windriver.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <a56ddd50-2cd1-f16e-5180-5232c449fbd0@redhat.com>
 <ab85cd9e-f389-0641-8084-cdfbc5c91e0b@windriver.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b73f8986-9071-6fbb-5c6a-d7892ba2302b@redhat.com>
Date:   Thu, 15 Jul 2021 11:51:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ab85cd9e-f389-0641-8084-cdfbc5c91e0b@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/21 10:44, He Zhe wrote:
> It was to increase the recursion depth to 2 so that vhost_worker and
> kvm_vcpu_ioctl syscall could work in parallel

The count is per-CPU, so parallel operations cannot cause it to become 
2.  Your patch might fix calls from ioeventfd to vhost_worker to another 
eventfd, but not *parallel* operation of KVM and vhost (except on 
PREEMPT_RT).

You should identify the exact callstack that caused the warning for 
vDUSE, and document that one in the commit message, so that reviewers 
can understand the issue.

Paolo

