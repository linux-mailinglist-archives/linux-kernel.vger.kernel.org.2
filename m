Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046483C9EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 14:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbhGOMes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229595AbhGOMeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626352313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lji8HOqs9rmdC3egSrWXR+ndAD3kQJhFKEhduaBBTA0=;
        b=c5uySOcv8tcqdqlogt9pNXXq5lDhqcu02Ct2u8oenaQ8ou5Njlgqo6QRaMSj3s1gC47KzE
        8Qed79lbNbPzKEworfUNvF+QUw0Ec83atYwUq0JsWmG0d7twG7dz2sjOBEh7roQXTeD0jc
        73EB+SyQHLdQx1ot79zKb4nUjYis+UM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-XqaVlvNPNEO-wSRj9VOfXQ-1; Thu, 15 Jul 2021 08:31:50 -0400
X-MC-Unique: XqaVlvNPNEO-wSRj9VOfXQ-1
Received: by mail-ej1-f72.google.com with SMTP id r10-20020a170906350ab02904f12f4a8c69so2149954eja.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 05:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lji8HOqs9rmdC3egSrWXR+ndAD3kQJhFKEhduaBBTA0=;
        b=D3mctoapoY4eT6dwn34s2svb/ekA3NNxfKVFlPx2tMblHhfJQx0rE2GJ56H1XGCnnd
         NA+GfYr1aRik9pmfRTe60xKh9zNDEjaLI1ngDvaPyQRoYcSHbdPbyeqeUXqufsGW1X+6
         bm6PRedC9l3fgQAodwo69RzSRIit3h5nkMqeeyuvNJ1CPcqEWAlLr29qHbXGRbyo9P1p
         zKHywIlSE3CjMGZlKy4GFGOA/aIBKZjlDW2XvvaCZaUYbMDe+XDxZDRd6iIiVSY4KSvk
         ask5xr69JvaeO3z5+PvwGCKE2TtCFrz6ja9DHN7Lgmlz0aS5lqr1jTJ9mVKM27ZsaQta
         NILw==
X-Gm-Message-State: AOAM5317Hq1eN6T6G541rnHbQJtMN+sxgmTL85t49hnP+xhrttqFiwM6
        ROm+Z9nPOpmHAyCeu6qBX1CgeVkiSXUYeNbaNRKlsz6WocjAbMRtakPjISlA1rdHfHtnBhsw92R
        /pgr8GACuhCgrtSqAXx1khtMn
X-Received: by 2002:a17:906:2a08:: with SMTP id j8mr5285341eje.449.1626352308962;
        Thu, 15 Jul 2021 05:31:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0EaEWiFne4OQJDl26qvYKYWhC9EgViZlqFlUaqtigTo9I0Fa/9MOFWVCHvzl0cKjP4odhgA==
X-Received: by 2002:a17:906:2a08:: with SMTP id j8mr5285318eje.449.1626352308710;
        Thu, 15 Jul 2021 05:31:48 -0700 (PDT)
Received: from x1.bristot.me (host-79-37-206-118.retail.telecomitalia.it. [79.37.206.118])
        by smtp.gmail.com with ESMTPSA id t6sm2319933edd.3.2021.07.15.05.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 05:31:48 -0700 (PDT)
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <20210715102249.2205-1-hdanton@sina.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <92933731-46aa-b5d8-72dd-0d05c0266f45@redhat.com>
Date:   Thu, 15 Jul 2021 14:31:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715102249.2205-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/21 12:22 PM, Hillf Danton wrote:
>> the lock needs to be per-pcu... but so far, so good. I will continue using the
>> system in the next days to see if it blows on another way.
> Curiou, is it so good as to see the warning no longer printed? Or your
> box still works even with the warning in log?
> 

Without the patch:

	- warn on dmesg
	- I lose my connection with VM (as a side effect)

With the patch:
	- no warn
	- continue using the VM normally...

-- Daniel

