Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC5743B6F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbhJZQVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237343AbhJZQUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635265086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtrZ02+a7Y6c2uG+Rvt1nh9ebvVZMP9HOLLjO1Lvlk4=;
        b=Q79sFFXPNNYJI0QtLSqUL/qN67tJpNWB5kEWKK3zJ1X8JIz8PIInRN850mXqG8y+hEzOI4
        zjclXq1BDGYTsYJgoXiMtxSDfd6G6smHfPkFuHh3ZNxVvQ+Fh/dgHpnOCUXeeeQxPXaGjR
        VZfriYzn/f2mWQDFJ8wAT12uZw91zhw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-yIf2vdnnNGeEN73pg4WJLQ-1; Tue, 26 Oct 2021 12:18:05 -0400
X-MC-Unique: yIf2vdnnNGeEN73pg4WJLQ-1
Received: by mail-ed1-f69.google.com with SMTP id x13-20020a05640226cd00b003dd4720703bso7595514edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rtrZ02+a7Y6c2uG+Rvt1nh9ebvVZMP9HOLLjO1Lvlk4=;
        b=K4l6npfmxNtS9q1vMKqg3lUhicOzNbtUijH89N3S1GiC+/i3puGo68+ptmCMZ1hEeA
         EzCG/sw7pKX3Rh4OyYCMO7CgNtohERsBKkOC1pA9GttC5ka4h/FvVXsPc4H/4/f7bJcT
         NsNXYrMsunroleLiLwVDsWFsHAm8jmE+RdHwKgHd93LwGrvEqydluti8c0N7WD8gQ8sq
         YixI4Xg3Uyj29ZcdQYbFaJZmILl6AUPQU2QuiubR/zgstRhV4VB9BbAny0na/pdywz68
         O+1zLW/OoKY2R0Du2BFYwZF35Pe+K4J5kzERcXnQV2af2/SYb9kqDFfRyT28+t78KG41
         QnNQ==
X-Gm-Message-State: AOAM530+lek3U4arlLFc1Kn55BGIil44MPFmKn/H9Nsdz0+eIsPmiTBO
        CG+LPBzc1TEMunDlwzTBUR32WE0BdmdFJVetPpB9y9LvZZFoKm20YwBHjFleoQWmiSDigWIlkyP
        PrGvkdHqIMqZ8mfJMdG4EZI0f
X-Received: by 2002:a17:907:2071:: with SMTP id qp17mr1252069ejb.284.1635265083447;
        Tue, 26 Oct 2021 09:18:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUxAVnxfpnlov0+lOdcRwDqyC6BZ9EUFd/Acu3BIsW9KtyvlZtiHR+/eTmsV9k5nuSJEYMUg==
X-Received: by 2002:a17:907:2071:: with SMTP id qp17mr1252035ejb.284.1635265083192;
        Tue, 26 Oct 2021 09:18:03 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j11sm4679905edt.49.2021.10.26.09.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 09:18:02 -0700 (PDT)
Message-ID: <7e3fb7c6-265c-d245-dd97-24ab401a8ea3@redhat.com>
Date:   Tue, 26 Oct 2021 18:18:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] kvm: Avoid shadowing a local in search_memslots()
Content-Language: en-US
To:     Qian Cai <quic_qiancai@quicinc.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211026151310.42728-1-quic_qiancai@quicinc.com>
 <YXgib3l+sSwy8Sje@google.com>
 <60d32a0d-9c91-8cc5-99bd-7c7a9449f7c1@quicinc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <60d32a0d-9c91-8cc5-99bd-7c7a9449f7c1@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/21 18:14, Qian Cai wrote:
>> Maybe "pivot"?  Or just "tmp"?  I also vote to hoist the declaration out of the
>> loop precisely to avoid potential shadows, and to also associate the variable
>> with the "start" and "end" variables, e.g.
> Actually, I am a bit more prefer to keep the declaration inside the loop
> as it makes the declaration and assignment closer to make it easier to
> understand the code. It should be relatively trivial to avoid potential
> shadows in the future. It would be interesting to see what Paolo would say.

You both have good arguments, so whoever writes the patch wins. :)

Paolo

