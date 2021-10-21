Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F7443665E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhJUPhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUPhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:37:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8208C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:35:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so3427762pjl.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Iu7p8YJ09LKB7UxcfJBHKOYGTkw5Ln5vg4U6RHWQs3U=;
        b=N9mW0nfr9JesgpEOnQB8FV3Ivh/q2sth6ZHaD9wGtcKtpqmRzhrhCwn7iEgIOrylIj
         5EsJ+Tbqw+974E+HSwBeLr8wxqRMPf2BY/AZXguF0g/exRJO3b3jfPOjeiPDWnd2cPHZ
         wYz9RCkTOzpoP8WSjGQmAvWrwzRIR491+RImtx1tTk/HbvYu1IB6eeVgc1r09tp38jHl
         NJvrJXNj1Jf/fBGJMGLk6PkRZJOQnZuxJqwgoJlJgc7KUA/NDVi+L+3qln1TkraNLxci
         pREi1Q5DMXnsETVqNeGCoHrn4Guw74IPjlOLJlwZJa9DDVEy70km3BqcgUrJWL4Y6SjD
         MwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Iu7p8YJ09LKB7UxcfJBHKOYGTkw5Ln5vg4U6RHWQs3U=;
        b=1sq97Z31YjGjxV/7r7BzCbW0yIIj3ATntLhuL/1UH/728vQV6f5E5eQbS2eDOCQigZ
         yYSCQp1FOaibdCW7HdFz8+OM+nC6nLgyzbEtf3gx0/CSNTgkaJY6Y7N+XDDWKwrMf54d
         814ytMNEOvkZuwVD4EURNcALxsggIaqcnKNaoUKsJ+ZgZt1luarJZj5e1by9YoAptoUz
         Z3lYeRj7cfB3xXUDeHmXFyreAVStoMr9eZ7j6eEPUQeQf6M5I2ACibiF1GAhCwdAGlND
         WlSwKrkLz63azQ9dJQpT86e7onGmeYCBfsxiASSUrK7MjH7VqUTTkkZeocBRhLAmWuSG
         fa6g==
X-Gm-Message-State: AOAM532wMCaEbAFC/E2MUpQe1Q96PHK9FICaTIQdcNnnntvnpKyCYpW+
        oKdrQ6AjaOfBDFRkDAmR+xPscA==
X-Google-Smtp-Source: ABdhPJwDNaVwUCWUwB0He/hM/H9zr+hEw5kR1fOwUoC0BICsXfUjekend5YgMkCbXWfoNE1KdQA/BQ==
X-Received: by 2002:a17:90b:185:: with SMTP id t5mr1034947pjs.54.1634830507081;
        Thu, 21 Oct 2021 08:35:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:459d:a8c7:78e4:f487])
        by smtp.gmail.com with ESMTPSA id m10sm9996832pjs.21.2021.10.21.08.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:35:05 -0700 (PDT)
Date:   Thu, 21 Oct 2021 08:35:05 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Oct 2021 08:35:02 PDT (-0700)
Subject:     Re: [GIT PULL] riscv: dts: few cleanups for v5.16
In-Reply-To: <CAK8P3a0dnRE4Sr-En-hPYbRAWAYgYZ7FBtC2h39RXggy=tA_HQ@mail.gmail.com>
CC:     krzysztof.kozlowski@canonical.com, Conor.Dooley@microchip.com,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-0efa2067-b731-4121-9725-e40954222d89@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 08:18:16 PDT (-0700), Arnd Bergmann wrote:
> On Thu, Oct 21, 2021 at 5:06 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>> On Thu, 21 Oct 2021 06:09:50 PDT (-0700), krzysztof.kozlowski@canonical.com wrote:
>> >
>> > There is only one Microchip patch here (plic/clint). Others are for
>> > SiFive. All the patches are described in the pull reqeust:
>> > https://lore.kernel.org/lkml/20211021090955.115005-1-krzysztof.kozlowski@canonical.com/
>> >
>> > I had also second set of RISC-V patches for Microchip. These were picked
>> > up by Palmer:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/log/?h=for-next
>>
>> Sorry I missed this.  If you guys took this through the SOC tree that's
>> fine, otherwise LMK and I'll put it in the RISC-V tree.
>
> I haven't merged it yet, please add it to your tree then.

OK, it's in.  Sorry for missing this, IRC is always a good bet for these 
sorts of things as my inbox can get pretty hosed.
