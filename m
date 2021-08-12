Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C6F3EA480
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 14:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbhHLMVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 08:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237432AbhHLMVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:21:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDB2C061369
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 05:19:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x12so8005667wrr.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ird/DtT5j4H+vmbNk8aXdEZWAxnDnv0Dy+c9wLK6i18=;
        b=qX7RVl+vyN71S8YgZXYl+f65pqazr4/Uf4BNfRTsZ3w2adR0oE35rreg0+bND/YUED
         AzgVACvvgTeSkBzJSzOe+zH33b28NtGTCi+1IfN4ljKPlJJl+6ICJZZj4ipSQZQXyax9
         TavQYi8cS4cEkNzd0RFIMi+iYfkUv/vQ0+lg6vFVez6JCijusxfLWVVfgxXHIH7SBjB9
         36CBcb+CjpKFbrMVDwcPRhslIPALi5lYorKDL5nlmAOxIQhypeoC+EVXd7GAPPYCmDAm
         qRhxCbzvihxLFJKtG8ro7ZcjNsaiosFdtv8V/PMFz3sZwzjT2xiKy5pxsr76hDoJwBiP
         zJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ird/DtT5j4H+vmbNk8aXdEZWAxnDnv0Dy+c9wLK6i18=;
        b=AOOYxmTGNLXffhWg4AL+f8VHM4TsDJkD0Ve3xXGRFmF5AYpv9UhujeM1DctSfFe/Ra
         rRkFzxl77YTX5S4nG1mK7Z/eG6EOyW9qDbuIbmD/7R0Hmjc/LsiG3dcqN/eaC/4Vuik+
         FCs4o8SAR00XiC77Vtlz2ZQNOQ9HtJUaEiM25Xo3rB4s1Wgw50lmu6W4/brJZCGfq9bO
         ZtHGZ0Lz77u9QJmhh8KtZSNaYNzoeu1DYU+hBpPaw387GDgTqY7IeXnhl9nn1beu1H5Y
         Mza+XjUcAqyXB5N/Su+IjjOv/q9j0/FG/ocAyWXzKgug6naAz4AZ2cFSN/o9XTRCTrru
         BtFQ==
X-Gm-Message-State: AOAM532X1aXk2xelAGKPY1Q9yrnMsqRikjxNO2ICvBFYVR5Rs4EAyQql
        BvxIc/PoHFDifiJSXsfIYaI=
X-Google-Smtp-Source: ABdhPJyCfB2XsM1E3ReM/1Ezb4pyV1C4YmG//olzt/ImVlpZZGG9J4tzZkcvCRV4QtM9uJ+ybg1+og==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr3732507wro.207.1628770798047;
        Thu, 12 Aug 2021 05:19:58 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::2571? ([2a02:8108:96c0:3b88::2571])
        by smtp.gmail.com with ESMTPSA id t8sm2805398wmj.5.2021.08.12.05.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 05:19:57 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: remove rtw_ioctl function
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        arnd@arndb.de
References: <20210810074504.957-1-phil@philpotter.co.uk>
 <20210810080640.GV1931@kadam>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <3af28555-34b3-99c3-cd48-7e4f81804ec5@gmail.com>
Date:   Thu, 12 Aug 2021 14:19:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810080640.GV1931@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 10:06 AM, Dan Carpenter wrote:
> Phillip, Michael, and Martin,
> 
> You are all working on this this same driver.  Could you Ack each
> other's patches?
> 
> regards,
> dan carpenter
> 
> 

Sure, I will look at future patches from Phillip and Martin
if time permits.

Regards,
Michael
