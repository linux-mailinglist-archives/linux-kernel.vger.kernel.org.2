Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D943A1241
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhFILV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238815AbhFILV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623237572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HXqVwTnASpC+nIzC1ZP9Vkwf/4P5Ctyk3R0WhAf1tMM=;
        b=NQXcl1rs9zgP5a3IY+S/jiBkWk5hmI0VsaWcJRqkG4vp//lH+mKwq0GwRrWhH8ktQ1grZx
        UwCqCWFR9BK5x76F+7i4y93x1HGHkFY3uSv222UuV/XQSskOJs9wpTJqiVemUxWlVd31ZO
        PNGGzuNHy4YhiVid708/7wcCiDkTSD0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-6V9Xgfd6NWGZzNZhnSiq-Q-1; Wed, 09 Jun 2021 07:19:31 -0400
X-MC-Unique: 6V9Xgfd6NWGZzNZhnSiq-Q-1
Received: by mail-wr1-f72.google.com with SMTP id e11-20020a056000178bb0290119c11bd29eso5769344wrg.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HXqVwTnASpC+nIzC1ZP9Vkwf/4P5Ctyk3R0WhAf1tMM=;
        b=K4+i9lAaYvzkujj9TO43vvTrhX11jGMhz/v7eW1moEZuSo46TfNLl1+09pcO+m5Vmt
         6k0ZmtbqY2frr44JFlkLPgQMG69KPqeDNaFL1OY022YYPMFAW8L/0cWhi/tCP/HwRsqw
         ENdLX6M2RNEYB/12TcS0oviYQo3ViWs+Q1M+CN32F1bVYxstI3JZn9X8oH1K3UQ7/twN
         eW1iIOfaH3GCwrhym1dnKja/4USM2eDl+697TuuQGP6NrdYLcHIddeQkGODeB0wf0tkM
         hv6lK5/YR7L5nOHnm7JXgF//bos4Jt3H0PYQYKBdM77qoO2GQ5NHnGvAkXtFiNDQipF6
         FppQ==
X-Gm-Message-State: AOAM532rvpPC3bqq35fCoVDgfW9QXNbHv94twtV9uQtMs2f50LJO/il3
        1fVM0GZ10IPFLKaPaPhK1j9xiG/QSwMEHVkbwUYyOL/KkrpRgG6k/eFTURGw6tK58BLOTH5kGH9
        nYo8MA9rsZ2f/T15SUbpsZg6L
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr9269543wmk.147.1623237570011;
        Wed, 09 Jun 2021 04:19:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxkQ4yaJtDvcqAOFQCE+NtOTgjEw4SoDiwEa4p8GZrxX++FSnSA2ZvZ0jnJ+v5Fcx7Ma1E2A==
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr9269528wmk.147.1623237569795;
        Wed, 09 Jun 2021 04:19:29 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id h6sm14828393wrt.20.2021.06.09.04.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 04:19:29 -0700 (PDT)
Subject: Re: how to return a chunk of kernel .data to free mem ?
To:     jim.cromie@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Jason Baron <jbaron@akamai.com>
References: <CAJfuBxxo5hQLK36J1yL2MV3Zkfdnk=OmGh6Fms1adjB0GWULqA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <196e42a7-d50f-48e0-b4bd-e7f3701bfc6d@redhat.com>
Date:   Wed, 9 Jun 2021 13:19:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAJfuBxxo5hQLK36J1yL2MV3Zkfdnk=OmGh6Fms1adjB0GWULqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.21 16:50, jim.cromie@gmail.com wrote:
> I have convinced DYNAMIC_DEBUG code to not need
> about 15% of its __dyndbg section, about 30kb on my test kernel.
> 
> This memory is not kmalloc'd, so krealloc wont work.
> (I tried anyway, on a loaded module, it panicd)
> 
> Is there a way to return a chunk of init .data memory to general use ?
> 
> heres the patchset;
> https://lore.kernel.org/lkml/20210529200029.205306-1-jim.cromie@gmail.com/
> 

Hm, you could try free_reserved_page(). But obviously, only full pages 
can be handed to the buddy.

-- 
Thanks,

David / dhildenb

