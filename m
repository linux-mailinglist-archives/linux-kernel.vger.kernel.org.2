Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7245D428E20
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhJKNib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236972AbhJKNiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633959381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHe86D0+9HSkQCQI9gdmYfNs35nscG967x0fei7/3Sc=;
        b=eNIkVUox3E0MyPTV2g6Olj7xkJK4LQShPTllLUT/PHMqlC7/MtL14JwKzKZd/WcQ44ut1R
        PM24cuIk6YcttA8mzX8gbvvt+zV6iB8f7DJOcxn5zzwZOnx/CrSqt7gsnQS40NAa2BAuDL
        JRgT3tEieudP0ZHnE9p7qNYfsQ2NY7I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-hZ8-C2wWNriX89zaQ197NA-1; Mon, 11 Oct 2021 09:36:20 -0400
X-MC-Unique: hZ8-C2wWNriX89zaQ197NA-1
Received: by mail-ed1-f69.google.com with SMTP id c30-20020a50f61e000000b003daf3955d5aso15939355edn.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 06:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uHe86D0+9HSkQCQI9gdmYfNs35nscG967x0fei7/3Sc=;
        b=axl3bhoZ156jCoXBHrbuAvz2KwyMzbUlEbGYd/d7ul5dnfPK3wnVG2GBnsTLbfsG2T
         odBy+WKu/BIsP6GlIBltgdpfc05r9AnbLBiFlxP9tBjGi1VRPCZCBzfSDga9PfPtNOS9
         w+Q67OCvfWkUj6O3ydBLowhVArveGCoVYQTGy3WwgEoCKgbmMwy/vA2IePFgyD1XKn8+
         vWEPZ4FLuzj8OGkK3Tbdisp014JKekuQKZUJHTncq/PYskUZO4Ua3I6RXFO8fROPoQh9
         o1Fk8cSNvLxHsCkMydUm27p1ex23in1h5kQyUam6/psiknhWOC7McrAJLg6yuhrWRLu/
         Wh4g==
X-Gm-Message-State: AOAM533H2Yx3at17dO4+QyifC5Zlbf6uZVfTwtOG2cuMgymT3tPzyOwm
        KPLio+5l6YmFnq9I/4GueuTy01dm4fKvzO2YpIczxdqS6wrVujye73/pXzGQ/tU3s69fTuhUA1K
        XNqbK1Rdt2zKu1IvU4PiMylmZ
X-Received: by 2002:a05:6402:2787:: with SMTP id b7mr16099559ede.238.1633959379474;
        Mon, 11 Oct 2021 06:36:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrJGPPxVQTyMxL0GifZrDFtfAmBX/n9m1xonFauKYVQffG6tYBEjVi/imTxjJfsMZ+H1bUFg==
X-Received: by 2002:a05:6402:2787:: with SMTP id b7mr16099531ede.238.1633959379286;
        Mon, 11 Oct 2021 06:36:19 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id x14sm4744935edd.25.2021.10.11.06.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 06:36:18 -0700 (PDT)
Subject: Re: [PATCH 0/3] platform/x86: intel_scu_ipc: timeout fixes and
 cleanup
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>
References: <20210928101932.2543937-1-pmalani@chromium.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <95257882-ed9c-eb04-f09e-9d6e559ece2c@redhat.com>
Date:   Mon, 11 Oct 2021 15:36:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210928101932.2543937-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/28/21 12:19 PM, Prashant Malani wrote:
> This is a short series to make some fixes and timeout value
> modifications to the SCU IPC driver timeout handling.
> 
> Prashant Malani (3):
>   platform/x86: intel_scu_ipc: Fix busy loop expiry time
>   platform/x86: intel_scu_ipc: Increase virtual timeout to 10s
>   platform/x86: intel_scu_ipc: Update timeout value in comment

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Since these are clear bug fixes I will also include these
in my upcoming pdx86-fixes pull-req for 5.15 .

Regards,

Hans


