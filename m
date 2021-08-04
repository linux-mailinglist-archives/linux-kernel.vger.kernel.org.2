Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A05E3DFA20
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 05:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhHDDzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 23:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbhHDDzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 23:55:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C684DC0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 20:55:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nh14so1138062pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 20:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ty5sLKqikCprhTqXBn7mGVyZPTaeUkfmadpSzK6JouQ=;
        b=ub6PdD8k3w2qptjxXHE5ll6eh2H8dMg78J/6cmuXDJ0rWjrUYp3rW0p04ilG70NiZB
         tl9ovXiC7aNVJ+ke5F5IQ2j6J1ce3PyGpFj6PIuKXdpVeFDbeRM0jm6TbvDyKjKiq5Bf
         zo+tiR8vRhPcNg1qPgf+Vtdn7ELSlT5+/4KgIY6mOMseLH5MwVbupXF/XYlc2aNLtBq0
         a/lqZH+yOIPBbf/pCfqC2h9aTH5vqvJuaDtJieqEmw7l8uSF2YhwP5qPCwhjQq4s+hjf
         qlQ/DoXAZCNswBIQnZR6HlGSE7RprVxFy5BTat0nUg/Wyc1++9mRoX7zOt0NCcCpEEaX
         2gKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ty5sLKqikCprhTqXBn7mGVyZPTaeUkfmadpSzK6JouQ=;
        b=MKPVIaFNtaiiDZ1Z5HVkhZhEJ61NY2GZVfgocYY2Kbi96ZAMCWtHCxLKWp2Rp7NkTt
         vBpZi+q7/j5/xmx036jULEdWqWmE8NbxpUsCYhRgu41lQM66sKtwi9sTMflvlsRcRAk2
         0wlbs+tzBbjbMN8TBHvPiOJWHSCY4FmA8QyBItLPPxQ9whrJFC1AxO0wf8Mel07YwZDB
         ru7uZ06J0eO4Pq77zgXANgv88MOxTT2xWF/youRxTehi/bj95FaVXgNhNxzT/LLTkic/
         6tj+kZMOGVJDM/g8F0ED8n5xFdkO3CTW7bz5GZI/CO3nIOgNicO0qN2jv0I3LlMf8lvD
         p7Vg==
X-Gm-Message-State: AOAM531vJVIyQBvOg3WxRdKqdvAWGEE9jchsBknKsyPQG+kjGuNMuek9
        YXajsflTVLPdWJcaUANjHefs2Q==
X-Google-Smtp-Source: ABdhPJys6OFdQt2MwhQaEwuFopeRUiCsAm/1W1vzJ8t9FF0RiA0oORbu+y3XDvWSuPjEpIhVar+o6Q==
X-Received: by 2002:a17:902:9f8c:b029:12b:da2e:9463 with SMTP id g12-20020a1709029f8cb029012bda2e9463mr21466279plq.79.1628049302336;
        Tue, 03 Aug 2021 20:55:02 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n1sm816200pgt.63.2021.08.03.20.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 20:55:01 -0700 (PDT)
Date:   Tue, 03 Aug 2021 20:55:01 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Aug 2021 20:54:46 PDT (-0700)
Subject:     Re: [PATCH 2/2] riscv: dts: microchip: Add ethernet0 to the aliases node
In-Reply-To: <CAMuHMdVfRSGQcBQEFVbUZjoRBKHxPJnbXkddZvF8vcSDQ1v5jg@mail.gmail.com>
CC:     bmeng.cn@gmail.com, lewis.hanly@microchip.com,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bin.meng@windriver.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     geert@linux-m68k.org
Message-ID: <mhng-78538c33-fe7b-4eea-83c7-5dfe4f5824d1@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 04:34:02 PDT (-0700), geert@linux-m68k.org wrote:
> Hi Bin,
>
> On Fri, Jul 16, 2021 at 12:14 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>> On Fri, Jul 16, 2021 at 5:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > On Fri, Jul 2, 2021 at 3:44 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>> > > --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>> > > +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>> > > @@ -9,6 +9,10 @@ / {
>> > >         model = "Microchip MPFS Icicle Kit";
>> > >         compatible = "microchip,mpfs-icicle-kit";
>> > >
>> > > +       aliases {
>> > > +               ethernet0 = &emac1;
>> > > +       };
>> > > +
>> > >         chosen {
>> > >         };
>> >
>> > This should be added to the board DTS (microchip-mpfs-icicle-kit.dts)
>> > instead.
>>
>> I was wondering the same thing before doing this, but when I checked
>> all other DTS in arch/riscv/boot I found the aliases node is put in
>> the SoC dtsi file instead of the board on so I think that's the
>> convention.
>
> The numbering of the aliases is supposed to match the labels on the
> board, hence it is board-specific, not SoC-specific.
>
> Gr{oetje,eeting}s,
>
>                         Geert

I don't see a v2 of this.
