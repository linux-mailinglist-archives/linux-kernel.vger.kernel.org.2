Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5713A210A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 01:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhFIXyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 19:54:44 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:41931 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFIXyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 19:54:43 -0400
Received: by mail-oi1-f169.google.com with SMTP id t40so97816oiw.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 16:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I8N1Lg6aLlgY3iCD2TCkxgwLYxPyIq0eUn542GgkUOk=;
        b=OzSw3MC3Gh28jgO8jPvZlsDZoR7nfums0Lvnoq0EqS3/pkdrd43aA4voAoO3yN+P4x
         kVsfkRaLZots7I7MYWwh8PyfgS3a399qoJYtQD0GTOzmZ3XqL2bWlNVX1QO0Y+Jx8hrU
         u/JGvebGaVn/ohrlcGh20Sa4zMjwYJfnmAnmJHnOIoRFP7Ct8h3TxruqxRc1qJcqPE90
         k/D/ikHm+wCKRkZAFYUq769gf5Qo5XPhSniXzXSW5Pbh0zgYmtw3Z9J41XmVYqf0fa1B
         1cIJAjQMAePYHf4qJ0y3YJUz4+oHWpLWK1aXknCat8ozr+prK0RKM6q/EHHaRtFaRr7C
         goJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I8N1Lg6aLlgY3iCD2TCkxgwLYxPyIq0eUn542GgkUOk=;
        b=LsV10g2agLUKkZt6uweRGsGS3hguTgJOBOlGjXiOMo0Afh7BqlbRoKx+sQvTVMr7Qt
         jiWcszNW1MfvQNiELxY/+t9a6msYFQWlVkEwveZo+TYWzuFHwuh+A8rITvJOx/LsEEH7
         5cU9MXjAqcRQEpv27yTgLDqnoKMrHvI14Fg1ptLYPuXg5twtBTkK7pkbrB0M+nq0PyqY
         ESplx4Bs7M4845WsSdoDmIrWtrPpDuIrsL+W6YMJiIl7baTONhIrtk9PWRu25M306rsQ
         +bxN94LFleqT8dtXAiji2yJDju7vE/MyXXCUr+QSoWQvALh7d6szl4irSxxV+yxFWQ6W
         yz9g==
X-Gm-Message-State: AOAM5334eohO2pH39v6qQbhk7579dSi6Cuha6RE4ub40uqRuP2VR9rlb
        iQr+VYvtqJYxmUvGv1MeUjr4SaALVCN6np/QiNiIN2yVVtI=
X-Google-Smtp-Source: ABdhPJxVZMiL6ssPfBbTDpBirNrNhAaRu67YPz6QtIorEAznDPDKmL/A+lxUDj5dkvRYg4ZJeMlyiDZvEHQmMpBXuFU=
X-Received: by 2002:aca:1910:: with SMTP id l16mr1369486oii.69.1623282698554;
 Wed, 09 Jun 2021 16:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAMcO1Vu0e3mfK-s-vh57UmRu8_L_E_Q6n_d95U88j3wG3Sxaow@mail.gmail.com>
In-Reply-To: <CAMcO1Vu0e3mfK-s-vh57UmRu8_L_E_Q6n_d95U88j3wG3Sxaow@mail.gmail.com>
From:   Austin Kim <austinkernel.kim@gmail.com>
Date:   Thu, 10 Jun 2021 08:51:28 +0900
Message-ID: <CAOoBcBVf2FNHu_CqNt9HoBR9Hm5y8+H0dLhvh2yD66b50E2ssA@mail.gmail.com>
Subject: Re: Reserving memory
To:     Sean Quinn <spq@g.ucla.edu>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

2021=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 5:33, Se=
an Quinn <spq@g.ucla.edu>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi,
>
> Kernel newb here, sorry if this is could be sent to a more suitable list.
>
> I have an embedded project using a Zynq based SoM (Enclustra
> MA-ZX2-10-2I-D9 SOM). We have a device using a DMA that writes data
> into system SDRAM shared by the processing system/OS.
>
> [..]
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address deafe000

It seems that void *fdt contains deafe000, which is not handled by mmu.

https://elixir.bootlin.com/linux/v5.4.124/source/scripts/dtc/libfdt/fdt.c
int fdt_check_header(const void *fdt)
{
size_t hdrsize;

if (fdt_magic(fdt) !=3D FDT_MAGIC)  //<<-- exception point
return -FDT_ERR_BADMAGIC;
