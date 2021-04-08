Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15883589C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhDHQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:29:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231893AbhDHQ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617899330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wrbAOZjrEmBl3SUhRJwLLYwLvrtd7NpWnCWVbIkN2Q=;
        b=WNV0rfN2mXXhVinwtYwmfXdYFkRCUta3Nm0DgNqYTRR+Fw58IivYRRrG4p5E3LM2zCVW4p
        I6ICCol5d+WyLWYmlYYkbOfxFl4IzCunxS56jFQoUgNDz3v4O/3UmZBtIeXDtpImHrDb+d
        qgAlXb+L/aGOVUnWxT1F443cnpPfcZs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-jhXsuluFPaauzq6QKzldjA-1; Thu, 08 Apr 2021 12:28:48 -0400
X-MC-Unique: jhXsuluFPaauzq6QKzldjA-1
Received: by mail-ej1-f70.google.com with SMTP id jo6so1099105ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 09:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5wrbAOZjrEmBl3SUhRJwLLYwLvrtd7NpWnCWVbIkN2Q=;
        b=ojG2RTb9RBjkuVl/5dqhojUF7Yb5KimePAnqJnORmD3GRx6urHMJ0uhFDq0IIE5OLw
         A86vU/bQor4awQATlC1c5IUuQmFrX8qk2Bgjwt3sED9GwiCcojw0Ozhj1zXWlVUFq6AR
         hzo8gEcsokQTEAtBiEI//CYIa+8qbZeqSmYsJe1dVbZXrBXEsoEtaPzeqoFx2gLQ4ccM
         reH1QcUibgcSF7VJLWtlNsK3soTmoKGgYb0dcOQ2ezdoBVTSdZPpzhCoOyyEdydccxaH
         VSS5gjlPDFNNWNaBptIYOqL0kyNJFtJoz1sgi5oAayVXUQEfNrWgO6NoDe3zdr2dZjFZ
         dEKg==
X-Gm-Message-State: AOAM532yIwyoodwsErohLyQNyjfzgf3zP/togbcUG+bV5D2bQKdo1kuQ
        hTljDShsUx8/FARpcBeTiZnmhiIs4esHE1RbTGz3FceZD1SOYAJhEZMufKDeEUyFZ4nVYCyyPRK
        tK+QtAX80gm5YD7VJqF9jMIA9
X-Received: by 2002:a50:ff13:: with SMTP id a19mr8705265edu.300.1617899327693;
        Thu, 08 Apr 2021 09:28:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRv3PJSwaeiHkKwTDMJVVmVj8qxGMjV4KPxbuV0IsMXJsgngLozjwulkFyEEMQZpwz0bE3kw==
X-Received: by 2002:a50:ff13:: with SMTP id a19mr8705244edu.300.1617899327555;
        Thu, 08 Apr 2021 09:28:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id r26sm6685065edc.43.2021.04.08.09.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 09:28:47 -0700 (PDT)
Subject: Re: [PATCH] KVM: vmx: add mismatched size in vmcs_check32
To:     Sean Christopherson <seanjc@google.com>, lihaiwei.kernel@gmail.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, Haiwei Li <lihaiwei@tencent.com>
References: <20210408075436.13829-1-lihaiwei.kernel@gmail.com>
 <YG8pwERmjxYQoquP@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c24c9d96-37c5-cfb4-8b84-cb3f8daee500@redhat.com>
Date:   Thu, 8 Apr 2021 18:28:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YG8pwERmjxYQoquP@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/21 18:05, Sean Christopherson wrote:
>    Add compile-time assertions in vmcs_check32() to disallow accesses to
>    64-bit and 64-bit high fields via vmcs_{read,write}32().  Upper level
>    KVM code should never do partial accesses to VMCS fields.  KVM handles
>    the split accesses automatically in vmcs_{read,write}64() when running
>    as a 32-bit kernel.

KVM also uses raw vmread/vmwrite (__vmcs_readl/__vmcs_writel) when 
copying to and from the shadow VMCS, so that path will not go through 
vmcs_check32 either.

Paolo

