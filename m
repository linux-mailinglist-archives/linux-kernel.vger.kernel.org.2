Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775A5397410
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhFAN0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:26:08 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:42956 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhFAN0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:26:05 -0400
Received: by mail-wr1-f54.google.com with SMTP id c5so3141699wrq.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 06:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=h8VbcOfb3+RdW8LaQuUQw9dnmTWlit7uMfdLFgHeOVM=;
        b=q9cvIKZjY9L1nplc2xYtcwP3FTUMt/vK3E1Alp0yiKITRx9fVhleqQ2xPoFy73XkpP
         WIuIWWhWKWwdqd5SuQzJRZ91A4wHd5mBoUPbHNxUXGstBDdBXK64pzUjSFNoJuqqZxLp
         eLvAQX2cIaSQAOntAqh9TPAnzShAg3ALD+fBkx9z4a/obqSVZjjPlxUo/DoKYk8y5Ylo
         4djXG9Mh6iXNz2CUWQoGdLPp9nbn/AJzA/rv+DIY6/oevZlT3qQGzsclcBofBppnxdX2
         VgpYrzlyz2L8253IM8XtUlEABWJvZNqhBUUZV7yzlFUmuGPMvLs9Wnxy9Uh45cYt6Asz
         6l2g==
X-Gm-Message-State: AOAM531tlM1r4BQDWOgL37pEUVpqpzCDXn3e+vGQBPsaAwtHZHEE5g9F
        Tiz+dHwnTds81U5ru7Me6IGpPiEL4S+GBw==
X-Google-Smtp-Source: ABdhPJz399TTaI9I2Cz52dUweXpzVGEhNXiLGldeikRvmyrwYiAZUAOK44NvlaMlh4ZmgeCVbVqPrA==
X-Received: by 2002:adf:a353:: with SMTP id d19mr12026623wrb.363.1622553862022;
        Tue, 01 Jun 2021 06:24:22 -0700 (PDT)
Received: from Johanness-MBP.fritz.box ([2001:a62:141b:f301:fcc0:44c6:21e1:ed3])
        by smtp.gmail.com with ESMTPSA id h46sm3647723wrh.44.2021.06.01.06.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 06:24:21 -0700 (PDT)
Subject: Re: [PATCH 1/1] mcb: Use DEFINE_RES_MEM() to simplify code
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210601064038.9936-1-thunder.leizhen@huawei.com>
From:   Johannes Thumshirn <jth@kernel.org>
Message-ID: <cb067fd1-cfa8-8515-7161-7d1008030de0@kernel.org>
Date:   Tue, 1 Jun 2021 15:24:21 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210601064038.9936-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 01.06.21 um 08:40 schrieb Zhen Lei:
> The value of '.end' should be "start + size - 1". So the previous writing
> should have omitted subtracted 1.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---

Thanks applied
