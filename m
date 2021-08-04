Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93F63DFA37
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 06:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhHDESv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 00:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhHDESu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 00:18:50 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6EFC0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 21:18:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c16so1608121plh.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 21:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=AVBDmbZxIiSB+JvUtCo7LKbGoRxIowV1K44hTYKQFcw=;
        b=Rn6RWWdeegjUJZwrfChQJszAOm8q4mGdqCPBrVnKncqPgLdOvKlG9j3WHQAKSCnhlX
         +MmfROqx+XxNn9wIzmHzcAEYSFP62wd8XeM0ijkVFlhVRuSMSIjQ9WiytmpWSVjOZoMJ
         gNcWvUAn/34VN3zzy+Zv+w5wCC8zHFhGme1m2Tmc6B7nA7H5Or56jj3D71T8dHGdQLSA
         eqTIzZljxmrCYbo3iM7HC7uASeVSxtmEXvJZB9wT4fiTlPSv9PgtXiEeRHOhaZLrKG+E
         1ri/uC4WIBmnA08OwWUsCX/AtFBCij2g2k/dNoLM5P+xSAqwe3CF6oxUFRODYEugarzt
         l0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=AVBDmbZxIiSB+JvUtCo7LKbGoRxIowV1K44hTYKQFcw=;
        b=aY7mW42OPXm73sW6+LU1buAZ3d1AomYGvIcc41oYaClz224UddwTjEBgOdcdeNGrbF
         8mNugq1lDjSVE1IHZMUKG8V54VdBpztZ585FgIKippxqBqUNpxGXjnDA6koPoIJ4/+8v
         YOUGte4buOITK7FP2O0rOWf7BpZCYwKQAwLDEtDdC+KdH4kp0niitu7p76BC2EabZO41
         IMQt7JTt096dY/r/Ufqx+zDYjHEhzH/uXGvjAWxUEIeFUUTGdO25vPQzWO1MSDT9+iwQ
         /p87VluFSwiKXcCtAXXRm2Mi8IEXcXSJxRrRsJe6jaXmRw0y1V18FQ8SdyX3doURPMyh
         fraA==
X-Gm-Message-State: AOAM531579cTx3biUNqokdMCfFplyJvkHbdVc3e4kxXzhwIdarrVMf7e
        AKGKTDbg1P84V1s8etjZsKk/Mw==
X-Google-Smtp-Source: ABdhPJybzW1336H4eQQJ/i9ieuJkpt9rQoV9Ju4Z17xmKuAHpCDCdw5bcgy8r+hMXLrCTz+zHQwWqg==
X-Received: by 2002:a17:90b:3b83:: with SMTP id pc3mr7744055pjb.42.1628050716835;
        Tue, 03 Aug 2021 21:18:36 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k25sm754679pfa.213.2021.08.03.21.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:18:36 -0700 (PDT)
Date:   Tue, 03 Aug 2021 21:18:36 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Aug 2021 21:18:34 PDT (-0700)
Subject:     Re: [PATCH 2/2] riscv: dts: microchip: Add ethernet0 to the aliases node
In-Reply-To: <CAEUhbmUkuKd7itzvQyzrYeqfUQv6LCqkXDsO=yufQppDBceLQQ@mail.gmail.com>
CC:     geert@linux-m68k.org, lewis.hanly@microchip.com,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bin.meng@windriver.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bmeng.cn@gmail.com
Message-ID: <mhng-e1c39f7c-9667-4711-b2fc-0875cd0695a9@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Aug 2021 20:55:56 PDT (-0700), bmeng.cn@gmail.com wrote:
> On Wed, Aug 4, 2021 at 11:55 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Fri, 16 Jul 2021 04:34:02 PDT (-0700), geert@linux-m68k.org wrote:
>> > Hi Bin,
>> >
>> > On Fri, Jul 16, 2021 at 12:14 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>> >> On Fri, Jul 16, 2021 at 5:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> >> > On Fri, Jul 2, 2021 at 3:44 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>> >> > > --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>> >> > > +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>> >> > > @@ -9,6 +9,10 @@ / {
>> >> > >         model = "Microchip MPFS Icicle Kit";
>> >> > >         compatible = "microchip,mpfs-icicle-kit";
>> >> > >
>> >> > > +       aliases {
>> >> > > +               ethernet0 = &emac1;
>> >> > > +       };
>> >> > > +
>> >> > >         chosen {
>> >> > >         };
>> >> >
>> >> > This should be added to the board DTS (microchip-mpfs-icicle-kit.dts)
>> >> > instead.
>> >>
>> >> I was wondering the same thing before doing this, but when I checked
>> >> all other DTS in arch/riscv/boot I found the aliases node is put in
>> >> the SoC dtsi file instead of the board on so I think that's the
>> >> convention.
>> >
>> > The numbering of the aliases is supposed to match the labels on the
>> > board, hence it is board-specific, not SoC-specific.
>> >
>> > Gr{oetje,eeting}s,
>> >
>> >                         Geert
>>
>> I don't see a v2 of this.
>
> Will send v2 soon.

Thanks.  I'm assuming you're going to send both patches.
