Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840A93D5834
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhGZKWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 06:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56826 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232240AbhGZKWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 06:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627297400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dE+0oMPPF9l/Qntuesol5uWcf6whbHVja/WjOyULUPM=;
        b=EqrvCmmzOVSccqQiAsRNud4I8SJGtBDUNv2qjaLgI/qupcWPRfquuv8WVmOXH4mlqUlbWE
        BxTqY96WUSCAH10sLUKx1rPV4x8zoSJ4zh/47ofqWVUHSAF0OGk4qohjodsa9/HBC8p0hZ
        qZVek/rcVcjGN/y3yyKXlej0ChnyQwI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-c12TITXMPaGYoR7e05w19Q-1; Mon, 26 Jul 2021 07:03:18 -0400
X-MC-Unique: c12TITXMPaGYoR7e05w19Q-1
Received: by mail-ed1-f70.google.com with SMTP id f24-20020a0564021618b02903954c05c938so4558450edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 04:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dE+0oMPPF9l/Qntuesol5uWcf6whbHVja/WjOyULUPM=;
        b=LTI4gmpgiab5nxD27KfhqoVHmJQjjkCW8mFd9SkyhCCJOthdBgJq3NdmhxWmeAnq/b
         s2gG5l7FGmXDL8sZ+ODHwLx1Oqc62MbClScbyuY+cSzFlXfcoZPBUZ4udD1kn7tKDZP6
         ocxo4KRXn3X1D/IEPWkR+8c8zyYMPFHkGEQCnn7q/FUTDAh5MxK+hdAwOkIuytMoZxlQ
         Bwns3STYoQZ9jcmrvxoTvbL9Ha77ckph3GBBlayIXeCjsxAOVdqGnxdHxTM2ezZCT/jq
         V8azTQILAQLVg+DdIWTufyfYbqbHa3Ipj8+a+N05JAezInuSX/kYdtsEf0/NXLbEJRq3
         Hgmw==
X-Gm-Message-State: AOAM532voFhCaL3rY6b3RPDlXolIounmLjJ3WY8qQkbv/Eckj/CC+gSc
        fqa1OUJPgwMKVzvnnSq0yFwNj4uFEqOuD6wabPTlnCnYPKj4kbTjWCeLbAfEYX8V/QRnI/W6e0J
        VQ+jVJ0p89ozgNEmagCJrxjkM
X-Received: by 2002:a17:907:76f0:: with SMTP id kg16mr16195795ejc.309.1627297397524;
        Mon, 26 Jul 2021 04:03:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGU1YrC+pfA8EImPDOQUpBZdKwA00F5EP2vakSJV50T5fm+6nu7jmEom+URblqhrICMrMs+Q==
X-Received: by 2002:a17:907:76f0:: with SMTP id kg16mr16195780ejc.309.1627297397313;
        Mon, 26 Jul 2021 04:03:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e7sm14027593edk.3.2021.07.26.04.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 04:03:16 -0700 (PDT)
To:     Hillf Danton <hdanton@sina.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <20210715102249.2205-1-hdanton@sina.com>
 <20210716020611.2288-1-hdanton@sina.com>
 <20210716075539.2376-1-hdanton@sina.com>
 <20210716093725.2438-1-hdanton@sina.com>
 <20210718124219.1521-1-hdanton@sina.com>
 <20210721070452.1008-1-hdanton@sina.com>
 <20210721101119.1103-1-hdanton@sina.com>
 <20210723022356.1301-1-hdanton@sina.com>
 <20210723094830.1375-1-hdanton@sina.com>
 <20210724043320.1654-1-hdanton@sina.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
Message-ID: <d76f08d4-a653-1eb6-bf4f-050f6068753d@redhat.com>
Date:   Mon, 26 Jul 2021 13:03:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210724043320.1654-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/21 06:33, Hillf Danton wrote:
> 		lock WQ
> 		count += n
> 		no waiter
> 		unlock WQ

Ok, this is a write.

> 
> 				lock WQ
> 				add waiter for EPOLLIN
> 				unlock WQ

This is eventfd_poll().  It hasn't yet returned EPOLLIN.

> 						lock WQ
> 						count = 0
> 						wakeup EPOLLOUT
> 						unlock WQ

This is a read().

> lock WQ
> count += n
> no waiter
> unlock WQ

This is wrong; after "unlock WQ" in CPU3 there *is* a waiter, no one has 
waked it up yet.

Paolo

> ------------------------------- c1 = count

