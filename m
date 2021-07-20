Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E273CF7BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 12:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbhGTJkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 05:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbhGTJjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 05:39:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979DCC0613E1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 03:18:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so2157271pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pjGXHhlsJXpMCFuAdGKhMv/rBK1kCdyMKVIj/X10+qU=;
        b=OgMYs9wdRGDVFn92Cde46FS6HH/GLxa9ZfDpj0LDOb/LlyAk4NiJMLagfMvjuQXhld
         bbEzaAOM5GZVAyMlN5owyX6H9AOevEu+LdEex+lJ/gCqA+kQHhNELg1LK1ds1OmbwCPV
         YHUd6koNim1cPqx407RenfEoKPDfR9ckvI7cXlBdwTIELlXTFoSzgp0eXqu5PriqmC79
         /lZGjilHrGbh2he7slmtTfvl4G/9oFvpu9C3HqspM8lwBIX8R8g6hh7h53Kp3cplyyCH
         PKZ6naph/JES0YtELdXN8XkrdeoG6l3vHitnqkRha7egJYDx7Q5lVEL0zeh63Uel2NY9
         aegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pjGXHhlsJXpMCFuAdGKhMv/rBK1kCdyMKVIj/X10+qU=;
        b=NMZQ75milJtIW//BC7lkqfgS0GmVBPa9owlGYZjVRB/tK41aE6CQXr+pR3jvbCOmeq
         a9eJs7Tzmw60b0Rev8t6mqzDpGbTeG/qKZYDcSclNtIpbzZ76SNCukLSZKWWpCipwrd+
         IovYP+IpSo5yHmT8UhmCfCcfIlKkXVykjPXV724buzws3IwsCe1nSuchrGtazpVIqh7u
         nj63WVehhYweG2BuRMCBzEM1CcUKF5vaYapuYP8ibrOY40mp1z30dDcbnIUlHP/Q2xPc
         knnISUXYGhkczginpMGy+XS7dlgJO9a9NJ8Zm5gDTOSquTSlMFJ7U8WKzO6dGGYhrcm/
         vvaQ==
X-Gm-Message-State: AOAM532KIG5NpAwIHZ4QsRua9DbKgZvyR4hWF9GF5XqLoNK8pkh7GkmS
        /Cz66u0poJAs94wIdqCLKWORgveKPx9Trg==
X-Google-Smtp-Source: ABdhPJz0teYPmNQHBdbGCNYldG1/FoD32crh2/voQ9Zgt5lnx9h6hzVS3/YS2b6hLl+U15a5jYFfvw==
X-Received: by 2002:a17:90a:510d:: with SMTP id t13mr34487868pjh.28.1626776319022;
        Tue, 20 Jul 2021 03:18:39 -0700 (PDT)
Received: from [10.252.1.51] (ec2-52-196-129-95.ap-northeast-1.compute.amazonaws.com. [52.196.129.95])
        by smtp.gmail.com with ESMTPSA id u37sm23843190pfg.140.2021.07.20.03.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 03:18:38 -0700 (PDT)
Cc:     akira.tsukamoto@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] riscv: __asm_copy_to-from_user: Fix: fail on RV32
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <37097718-c472-025a-2058-55667badc5b9@gmail.com>
 <93a6ae3b-3271-5edb-0a1b-260ba789f3f1@gmail.com>
 <CAMuHMdUnD58W6qAbxnT3y-BMTHb+De+z29YNGYVA3mWD0B-37g@mail.gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <9b2bff0b-7ebd-80f4-47be-9844aaed1393@gmail.com>
Date:   Tue, 20 Jul 2021 19:18:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUnD58W6qAbxnT3y-BMTHb+De+z29YNGYVA3mWD0B-37g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 7/20/2021 6:49 PM, Geert Uytterhoeven wrote:
> Hi Tsukamoto-san,
> 
> Thanks for your patch!
> 
> On Tue, Jul 20, 2021 at 10:51 AM Akira Tsukamoto
> <akira.tsukamoto@gmail.com> wrote:
>> Had a bug when converting bytes to bits when the cpu was rv32.
>>
>> The a3 contains the number of bytes and multiple of 8
>> would be the bits. The LGREG is holding 2 for RV32 and 3 for
>> RV32, so to achieve multiple of 8 it must always be constant 3.
> 
> RV64

Thanks, the LGREG is holding 2 for RV32 and 3 for RV64 (not RV32).

Akira
