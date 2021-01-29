Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7199F308F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 22:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhA2VLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 16:11:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233106AbhA2VL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 16:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611954600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXC0Ld1ahrZyhsUBN40K1GviFQKh4suqNGunCNrf6G0=;
        b=i7g0lNRi/925NcUqX6F1ZqkC8KNdwbkUslLeWsapMGeZpIac+1vYoMIh4tJ2BMuwcO/6Ub
        Qh+gjkkdkpQU9g5cYEvDhCJWlyXddDDf+1JNG0wsIFYfN1FUahRxou4z3Zn0IRpsvcL4OF
        WGhpEqufPcBFgASdmCz1oblVNkNrdhM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-SoXiexb9MHC7bHrNMlanyQ-1; Fri, 29 Jan 2021 16:09:58 -0500
X-MC-Unique: SoXiexb9MHC7bHrNMlanyQ-1
Received: by mail-ed1-f69.google.com with SMTP id e25so5550323edq.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 13:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BXC0Ld1ahrZyhsUBN40K1GviFQKh4suqNGunCNrf6G0=;
        b=pyfzHiDqdQuH2vJSAXze+0pOL6TlZMe9EIyFHF3aYsyN++PP2ZMcSphw/zVrYf5dYX
         l9IJ74qc/fZGPG6vZD9ykpZIIpBRPMijJo+EDvOIjfoMVB8G0FyiBV3gUDi4f0UvDYz+
         A9EajKPr0Q8kxWBKPDdEIbi2xJiLCw/3KaalLv1HBjho95lZ5E57gVwM3FfJE6/O8wQN
         tKKgFMFACM2DS1aRaTZeXOrL7ZpaF4VTkPg8WlGWzwq6SSfjbML3qENfKgVAtrDbveuI
         c76iWAg3y/ciC04lo9VGbJWHLlcCYjyE7RWk7AOvE/CNvaWIQOIWNJxfoQ+2Yz6lQLeJ
         BUVA==
X-Gm-Message-State: AOAM530iSM+pp19NDa1fv2ifDbvMf9LcrwrOY9+0R5XW4bvwDeQ0Kgi4
        NycrYTgDs2HZL9Loi9HW41ULmbJRYyL876F1+ArTcGP/ye74FVikOaiqnbVXMwF+yrZuovG3bjJ
        evTGn2pqwldDjLJLxFR6BVPJ3iTT4DyNPiibO55z9bpJIuERqCKdRYzurPppO7gmoH0KMTp9jsR
        6/
X-Received: by 2002:a17:906:94ce:: with SMTP id d14mr6406577ejy.121.1611954597175;
        Fri, 29 Jan 2021 13:09:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/sEIipjkXKiVTeV8HK1C1y12oGooChkjjR9DY6jS03/SNwWWh958GBsh2hRC2T2IXg5KJ1A==
X-Received: by 2002:a17:906:94ce:: with SMTP id d14mr6406565ejy.121.1611954596974;
        Fri, 29 Jan 2021 13:09:56 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id m10sm5173536edi.54.2021.01.29.13.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 13:09:56 -0800 (PST)
Subject: Re: [5.11 regression] "tty: implement write_iter" breaks TIOCCONS
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ce392dc6-d77f-b74c-8569-9a04ef8ad2d6@redhat.com>
 <CAHk-=wg6AG=1YjDC2gSspPYjEPWqDXkXaiaoPZS6X=Rg_XRUsw@mail.gmail.com>
 <98e2806d-81af-baf7-00f4-5a43870ff514@redhat.com>
 <8723f53e-9954-e0d2-16ce-933f53c776c3@redhat.com>
 <CAHk-=wifZZe44kGbeupwEo33J6DNiG=zGXpH9QW3AobiyjBf6A@mail.gmail.com>
 <CAHk-=whUWjLqe1=4O5B=PwfhwxUDqg7C7b0Yq50+bG-Jtvov6Q@mail.gmail.com>
 <CAHk-=wjXRFCTp5TVOa1WnXNwMDRv+tzKuBM44NLRs+_0UvUVYw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <98a4e417-bd2e-6333-47f2-36bf96d53053@redhat.com>
Date:   Fri, 29 Jan 2021 22:09:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjXRFCTp5TVOa1WnXNwMDRv+tzKuBM44NLRs+_0UvUVYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/29/21 9:28 PM, Linus Torvalds wrote:
> On Fri, Jan 29, 2021 at 12:02 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> It's fairly easy to work around in this in the tty layer by just
>> avoiding that function entirely, so I'll cook up a patch to do that.
>> But I'm adding the appropriate people to the participants here because
>> this really is very subtle if you ever hit it.
> 
> Here's the patch to make the tty layer just do the redirection
> entirely internally, avoiding that mis-designed vfs_iocb_iter_write()
> function.
> 
> Hans, does this fix things for you? I'm pretty confident it will, but
> always best to double-check..

I can confirm that the attached patch fixes things for me, thanks.

Regards,

Hans

