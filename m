Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788ED361D68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbhDPJuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242084AbhDPJu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:50:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBBEC061574;
        Fri, 16 Apr 2021 02:50:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 12so43675653lfq.13;
        Fri, 16 Apr 2021 02:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tvtg6aVXxIBB0vWz8Hrg/nrQeUwgt00ywj2SguplQsQ=;
        b=Xun+J7l8RVZbLt2UPSgIF9EAkBcMtlyEO+zZssn81K9BaPmN3u1Hv96g0gE4J4X8Cy
         XMfXjQtF5eGDpN6c+lwUkccF2qwtmhj37JgdHPUJjTMiCw1E4h+hAWnk3OyHwb+HoYbE
         TvI9+5cOZbpgj3OKUjaEZI0PZuuV5Y5lGaGtbWx7luod+rHjicNoMvR+GsJsRZBe/AU5
         oeIpjtlJk6T6+uRFIvZEymSTUShZ8AEhCK2UEFyoGJRGQrPK7fQVd4/ahYVLXWhaBHJT
         Brb2xieYzWYUC8QF8WAziiDmSmcOmEwyhmdsRXzysZcgPTnQU0DauRpa1qlminij14BK
         8zWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Tvtg6aVXxIBB0vWz8Hrg/nrQeUwgt00ywj2SguplQsQ=;
        b=VXVbtXYj1MkYN/HX7kQzG1aNfLroJlfbpMLO4ADU6NTlHF7GrDWbzyRizwCncL/VcY
         ljt3hvAwIR7Z0ypCeaIZ7pDs+K+fygU450tLCLI7BO2cPf+epkkoW5DQFzAkY+FGFrlV
         Hl+sLsx9dvyVPUSz9Lp4Lm5U7K83hivRcw9sfTj3A2t3nZNACK/B0A7l18VKgjPMz8rv
         pvjE828UH+5H/qKGwWRsVvvHdLxNWExxku5vedP0xEDbOdETv8uWoPRTtlJPnqjQzLFM
         mIivQinn17/IID3KYskdEA9wTBpZxfsI3BhjmNIZijzo6g6o3nBWNvgoCvPDRAfriDo5
         w/Ew==
X-Gm-Message-State: AOAM5318qE8Zzb2loJmc8hNh7FV2PK7HEUUIuH5DdQLpj8/svpISNMHL
        NFS8OsnaACrMoLl/5+RAzsfXh/Sar7U=
X-Google-Smtp-Source: ABdhPJxzUgNJFrEwsJvyGTD3zf3qb/87rSdg5K7Rs8ASJGtyrZ24hmzgX7QtaDuPM9qBCfRGRkSg1A==
X-Received: by 2002:a05:6512:3f8d:: with SMTP id x13mr2376810lfa.43.1618566603234;
        Fri, 16 Apr 2021 02:50:03 -0700 (PDT)
Received: from [192.168.1.100] ([31.173.80.250])
        by smtp.gmail.com with ESMTPSA id l26sm944777lfk.101.2021.04.16.02.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 02:50:02 -0700 (PDT)
Subject: Re: [PATCH] usb: misc: adutux: fix whitespace coding style issue
To:     Malte Deiseroth <mdeiseroth88@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210416080843.GA137657@utop>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <e0e91387-255d-9194-c4e1-0b6c18c5aee9@gmail.com>
Date:   Fri, 16 Apr 2021 12:50:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210416080843.GA137657@utop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.2021 11:08, Malte Deiseroth wrote:

> Correct missing space error ceckpatch.pl is complaining about.

    It's called checkpatch.pl. :-)

> Signed-off-by: Malte Deiseroth <mdeiseroth88@gmail.com>
[...]

MBR, Sergei
