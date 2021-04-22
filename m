Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F453687C6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbhDVUR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236915AbhDVUR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619122612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6HkNIXnsQ0jUlhEdnv+PnYZxDWWdvNCPtrwXlIdkmc=;
        b=g6vtC3eqTh8TDpAbIf0sD8KcMjPgGbeCPgRNpEl13GfMCWGZWRytoNgEMqFh/Xv2cJjQls
        TZPsMbJFrJVZasNtZUcW5NljKydrDGtNayEr7qZWgBpdWozvcWe2bfRV2XQx1SaBXd3/Go
        /VWCsKWBK9oS20rnO3uJNExG8WyS0Eo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-PWZa5fXGNLSJp7jiTiM90g-1; Thu, 22 Apr 2021 16:16:49 -0400
X-MC-Unique: PWZa5fXGNLSJp7jiTiM90g-1
Received: by mail-qk1-f198.google.com with SMTP id w3-20020ae9e5030000b029028013f752dbso12882403qkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=F6HkNIXnsQ0jUlhEdnv+PnYZxDWWdvNCPtrwXlIdkmc=;
        b=S2Q8z6NotYb9wS9dUrNbBttChQPhAHlBBdCrIgGetuZS8eWv2uizbuGDaQzBDiwo3z
         ofdR7PB56EY8zijGpT/h5YfOobzCdP4f4quBaTPn7P3IYC//lww7M3xYRLbRTwqKMVxT
         cFUUwQ2rK0HvxS5xOa5JBQEoP3KeIGwCJpfYBt7aXUBZiQzDDx3OwJ3OP0xmIzpgFhH+
         w35HLHK/C4lagyybs0TBWMez2mke+8bzTw0jKw538PKJkSV8zYT4fNdrlfjZTGL7gB+G
         nqcpKkBaRnEC6puFvdUa4Y0i414mWsmBNjxI8lQWWEXr/ue4NhpmQA59KT97qcyypd1a
         lCoA==
X-Gm-Message-State: AOAM531eynVFUMHhsCw4ud/34FCXrLRtrjs/ggV4lekyXuFJoQNNuLNP
        IG+USzsYwVNxur8/C7tpAmeYdh09N2gnwsaj4HjBqK8fL+sz4YtYFULH0qP7C9+1QuWZ+LR6kQn
        b3PZ3NyKa10K6E7mAyXaREL13
X-Received: by 2002:a0c:db82:: with SMTP id m2mr262144qvk.37.1619122608055;
        Thu, 22 Apr 2021 13:16:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytE+xQEguBXGQZlvwJ1qtOPecl4N0Kjsn9TELwI1t3EWQPLCqM+dsvQai1V7Y+XCx7xnLthw==
X-Received: by 2002:a0c:db82:: with SMTP id m2mr262125qvk.37.1619122607871;
        Thu, 22 Apr 2021 13:16:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:184:417f:70c0::42e6])
        by smtp.gmail.com with ESMTPSA id x13sm3090600qtf.32.2021.04.22.13.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 13:16:47 -0700 (PDT)
Subject: Re: [PATCH 2/2] lib/test: convert lib/test_list_sort.c to use KUnit
To:     Daniel Latypov <dlatypov@google.com>,
        andriy.shevchenko@linux.intel.com
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
References: <20210421183222.2557747-1-dlatypov@google.com>
From:   Nico Pache <npache@redhat.com>
Message-ID: <d7b2b598-7087-0445-4647-8521f3238dc2@redhat.com>
Date:   Thu, 22 Apr 2021 16:16:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210421183222.2557747-1-dlatypov@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can we change this to CONFIG_LIST_SORT_KUNIT_TEST to follow the convention used by other KUNIT tests?

Maintainers? thoughts? I recently posted patches to convert some of the other tests that break this format [1].

Cheers,

-- Nico

[1] - https://lkml.org/lkml/2021/4/14/310

On 4/21/21 2:32 PM, Daniel Latypov wrote:
> [SNIP...]
>  config TEST_LIST_SORT
> -	tristate "Linked list sorting test"
> -	depends on DEBUG_KERNEL || m
> +	tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> [SNAP...]

