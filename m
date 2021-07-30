Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8623C3DC02A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 23:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhG3VW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 17:22:58 -0400
Received: from smtp-18-i2.italiaonline.it ([213.209.12.18]:37163 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230483AbhG3VW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 17:22:57 -0400
Received: from oxapps-35-162.iol.local ([10.101.8.208])
        by smtp-18.iol.local with ESMTPA
        id 9ZxxmK9xfxWyj9Zxxmk9Ao; Fri, 30 Jul 2021 23:22:50 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1627680170; bh=MIRh6b4BlqCNSWoiYnKkCTt6g5l7D5bTi3Cy1ajNnVk=;
        h=From;
        b=qcZjZfXvM43R5W6hKxrkHOoeu5uef+esI0zTC2CPyjMg0XjM68DSkxyF8R2hdAL+c
         LFRLTcDIoKdzQSvInsAfyDCuc1gln5zb91KfesU4hPRL72D8hByg5DTyYUNFOKyyml
         nno7iNqpGj6GzZamvbDHiCyXA31T0JDgoHpxhYjJMOkAyJb5ALzSmuu1qSarWP/7zI
         Wx5imZuwLgKMjVI5WxMTugs965rrPFkR9h74CiYp0lUUB/g/uJrACTtGyIKnMX4+5L
         Idk4YHf5869Q8IBt7d3uOxtU91XcwyiNLoklmegBhm6ukbX3E3XHe0J4Fmzz4UMew1
         ydR14enANGukQ==
X-CNFS-Analysis: v=2.4 cv=d+kwdTvE c=1 sm=1 tr=0 ts=61046daa cx=a_exe
 a=OCAZjQWm+uh9gf1btJle/A==:117 a=ph_LecQPeAcA:10 a=IkcTkHD0fZMA:10
 a=7HzzVYOy9wMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Clq-v84VBH2wsqQnF40A:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
Date:   Fri, 30 Jul 2021 23:22:49 +0200 (CEST)
From:   Dario Binacchi <dariobin@libero.it>
To:     Stephen Boyd <sboyd@kernel.org>, Dillon Hua <dillonhua@gmail.com>
Cc:     linux-clk@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Message-ID: <1098513125.52015.1627680169782@mail1.libero.it>
In-Reply-To: <162767443658.714452.1239845779696330360@swboyd.mtv.corp.google.com>
References: <20210725160725.10788-1-dariobin@libero.it>
 <CAPTRvHkf0cK_4ZidM17rPo99gWDmxgqFt4CDUjqFFwkOeQeFDg@mail.gmail.com>
 <1926284813.753014.1627553002984@mail1.libero.it>
 <162767443658.714452.1239845779696330360@swboyd.mtv.corp.google.com>
Subject: Re: [RESEND PATCH v4] clk: stm32f4: fix post divisor setup for
 I2S/SAI PLLs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev34
X-Originating-IP: 79.45.223.112
X-Originating-Client: open-xchange-appsuite
x-libjamsun: rqnWdyeqWISTUy7ZHXC51GaKgPrQD3at
x-libjamv: YVidEiow+UM=
X-CMAE-Envelope: MS4xfEv2HuVu70s5x/tl23e8NZEi5LwPXWPJ+Qq1UOZ2efPVf9+ZByj7mXUuSW5Dg6ShVAMU27eU2I7xBjDlWXh82UdfPiT8lTDENDLRJxoE4+0bVzb/SbZ8
 MBppciMk2uXYHLu3HSHDPjKQx+5stpbqsT5G7tX26IOFVB3Wv+BsQ+lnbsp5GJD+ltSTqBGvsGOArWz3K87QBcMNoRqXx/ZZjXqtGEhb97PbQeoVNSCEOsd/
 tazRbpq59fxxFgbiXqL8gjL7wPYo2HXqijzkX5I/li2zVzK+wro7TMTfwtYfYHyCwtebyF7nau8/JdUDV68nrDg8GllVnSgNkXqyQSPQNhLPb063nKijbijy
 m4ifJLGwHs5+m+E//qh4kv2LtdP7indFiGnM+wVyq75/iuPlxZx3expKsFgxAZjHKmBpI3duX0n1mKyF9dH1Wg7/zWeVdrUELOoN9vpCf9buK3f1rDax1I+i
 qCxMzV5YZfhbKQcRp1i9Iz1i90GbRupohVd8Jn0NiAvBGmP2akzcpFRydiZA855/xlaHJvupf870u1gTfe1CSdSyh9qiHHUMIQwfoA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

> Il 30/07/2021 21:47 Stephen Boyd <sboyd@kernel.org> ha scritto:
> 
>  
> Quoting Dario Binacchi (2021-07-29 03:03:22)
> > Hi Dillon,
> > 
> > > Il 28/07/2021 12:03 Dillon Hua <dillonhua@gmail.com> ha scritto:
> > > 
> > >  
> > > Hi Dario,
> > > 
> > > I have a similar patch [1] submitted last year.
> > > Unfortunately, it did not get accepted by the maintainer.
> > > 
> > > Just a reminder here for you, should remove
> > > 
> > > { STM32F4_RCC_APB2ENR, 26, "ltdc", "apb2_div" },
> > 
> > Thank you for your suggestion.
> > While testing the patch on the stm32f469-disco board I didn't
> > notice the white screen issue. I'll try to run the tests again. 
> > I will let you know.
> > 
> 
> Ok, I'll drop this from the tree.

The patch fixes commit 517633ef630e ("clk: stm32f4: Add post divisor for I2S & SAI PLLs"),
so IMHO it should not be dropped from the tree.
What Dillon suggests, if confirmed, should be fixed by another patch.

Thanks and regards,
Dario
