Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EB530EE5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbhBDIaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:30:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234646AbhBDIaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612427324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2oFYh6GVLYKdkPoje25sIawi2slxCLU7zLus+5oLCk=;
        b=h/pYbo9iOuvSXS19SC+X1Zle9Ei9rhi2l4rmmoqzlggMhlhPqY/Lin7sgMX/xrabT7UZhz
        NJuJIaPzqmoELA1DDRnHA+QsZkiYE1Zllm9+SR6V0Nyi3ovS667gIpnwjdUldZ6jMTUJVH
        5JpTFLpo596Aa5eLGT/T1kyCm4HuL6Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-O2fiNHjKM4ehtvaz-oWbLw-1; Thu, 04 Feb 2021 03:28:42 -0500
X-MC-Unique: O2fiNHjKM4ehtvaz-oWbLw-1
Received: by mail-ej1-f71.google.com with SMTP id by20so2054382ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 00:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P2oFYh6GVLYKdkPoje25sIawi2slxCLU7zLus+5oLCk=;
        b=njDqm9u7zJWpgfmZyqr2BuXL4jvX9QeL4JyAGjpRL/W9dwW/WUYFySd7iva3nhY9mn
         HJdA9eh2Vm/k9qxItSUR/qGz7kZx8kIhTEK4U5WVAnI+KDnkdapmjqG4koTx6irzI+RE
         wWWoicDZOSjtPPgVwYECSd3o3Mg5uiAgSy52slro/xvZZhMjLBpCJSKydLzb373IuESy
         IDgWduClbyG5vfU+AMoMgcRQ5aJRqqwuk6/BYIEac05kzw7jsyJInUyd2buFpe5BXbwf
         LH2n4CEyuaxkDc6DiQpOa+ZCybf3J/0aBUpJRgJ/TGVnXtkiJ+LWrZ0t/1KIHCrrYCin
         /zRg==
X-Gm-Message-State: AOAM530oi1o7S9zCJksAAGkOPnmKiP/1MrVOBX5Vx4k0xBS3NAfgU/U3
        MjRUZHJ/Vju6f36+akqf3ainbspzMn8MCb5bRhIA9RMrFjS61uVUlCzK3cgClxiWqphGBMmqxns
        qNQGsjKsUVTZfovlSI7+1FwuD
X-Received: by 2002:a17:906:36cc:: with SMTP id b12mr4960399ejc.323.1612427321478;
        Thu, 04 Feb 2021 00:28:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhUozLKCqWBce20CvYC68TLIJHGPCCMCYWvHS3x3dpV/ZT5Q1tLgy0cJnAg7GfHz3Ml5fH/g==
X-Received: by 2002:a17:906:36cc:: with SMTP id b12mr4960379ejc.323.1612427321081;
        Thu, 04 Feb 2021 00:28:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y20sm1999655edc.84.2021.02.04.00.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 00:28:40 -0800 (PST)
Subject: Re: [PATCH v15 04/14] KVM: x86: Add #CP support in guest exception
 dispatch
To:     Yang Weijiang <weijiang.yang@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     jmattson@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yu.c.zhang@linux.intel.com
References: <20210203113421.5759-1-weijiang.yang@intel.com>
 <20210203113421.5759-5-weijiang.yang@intel.com> <YBsZwvwhshw+s7yQ@google.com>
 <20210204072200.GA10094@local-michael-cet-test>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d41eaeaa-4470-33a5-0d18-cdcb4b180197@redhat.com>
Date:   Thu, 4 Feb 2021 09:28:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210204072200.GA10094@local-michael-cet-test>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/21 08:22, Yang Weijiang wrote:
> Thanks Sean for catching this!
> 
> Hi, Paolo,
> Do I need to send another version to include Sean's change?

No, it's okay.

Paolo

