Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D722433FAB6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 23:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCQV72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhCQV7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:59:11 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53822C06174A;
        Wed, 17 Mar 2021 14:59:11 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id f145so472918ybg.11;
        Wed, 17 Mar 2021 14:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3Otpm753TRESEn/Jw6lvw2JEQhdQDlasHJrIeBnSNY=;
        b=cZeNXJ4T/qqJ2koR/zI88vWkwaQONufhI8SYQoK7KX0XgFnf67Myjew1bqrE0o8MWI
         AtyvsHn4NyIp3oqLvwPzMVVcjd4RnUXJvs0yQna+U3VlBn1FJsy2bY+KrEgVURfx61pF
         POQULsg7GD36bjwMqBlyGR/ZJjf2ZgPYgNLjklF+p7zsA29zhpGTIY89w2eHnHa6UZTz
         uwmNfRExjP4LUguS9RyK/TJWwI4p0/xUNSwrupCjTYFTrTq8y/JZpG8A6uAMz+TxV2ca
         4bGqthZvP5UXxjYnzaZIW8drYnvMuLt1xdbx4LypIxtco5yHOTp9N4Kb/Y6WsgIVgFS1
         uLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3Otpm753TRESEn/Jw6lvw2JEQhdQDlasHJrIeBnSNY=;
        b=nGvv7XmhkQTi7q6TrggZ1nHidv/quhzWGdcMAEbm8Hq58opa+gdz14CPqKxMxjT4n4
         y+NyP6lMYFGmafgLYZ2iBDSkYD7GFO2aRv7BQ37zDfSH3g09BRqyBurgKohq7JzcKGzc
         fa2wdyxdNCIDRA9QgRKK0syGc7tzij4G50Cq5chE3Z49aQjAvi//uZN0FsEngfG+K/bf
         zWzeP6jGYPpDBlxi87z9aNdLwBhaoxE8Qr87X66TuIROHjLaVHLU6EEK71oEjx+hRqCW
         6P/feSB70ztlMjdfSI4A1gRLhJyIFfSNMCzQ0/PbHup6Un1pZaB8jgZp0SVPj26ywPUH
         UmVw==
X-Gm-Message-State: AOAM531IdvMkHOJYZCj78Ee3Gqts06k7PbE7onMj1cVtpryQLKEHDtwU
        SvdNh1YMiI6LLYuZB9wZm6HK6d0P9no5tcQ6H6o=
X-Google-Smtp-Source: ABdhPJx9GDDOjSYvBgLPBfg5/24QZCi7VQtNAmESus4hMZHFvFS/Q3GaktmVhF+dbErJzHltqn21yij4q9H9uohv4mc=
X-Received: by 2002:a25:800c:: with SMTP id m12mr6771712ybk.25.1616018350636;
 Wed, 17 Mar 2021 14:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <255d6b5d-194e-eb0e-ecdd-97477a534441@physik.fu-berlin.de>
 <8735wtr2ro.mognet@arm.com> <cf4d7277-54a0-8bc7-60fb-9b2f6befb511@physik.fu-berlin.de>
 <87zgz1pmx4.mognet@arm.com> <20210317211424.33090a37@sf>
In-Reply-To: <20210317211424.33090a37@sf>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Thu, 18 Mar 2021 00:58:59 +0300
Message-ID: <CADxRZqx_udmWyfXxeWkMGN+LwND=+QP427oytuLVdHQNVLdL2g@mail.gmail.com>
Subject: Re: [PATCH 0/1] sched/topology: NUMA distance deduplication
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        debian-ia64 <debian-ia64@lists.debian.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 12:42 AM Sergei Trofimovich <slyfox@gentoo.org> wrote:
> > > On 3/17/21 8:36 PM, Valentin Schneider wrote:
> > >> I see ACPI in your boot logs, so I'm guessing you have a bogus SLIT table
> > >> (the ACPI table with node distances). You should be able to double check
> > >> this with something like:
> > >>
> > >> $ acpidump > acpi.dump
> > >> $ acpixtract -a acpi.dump
> > >> $ iasl -d *.dat
> > >> $ cat slit.dsl
> > >
> >
>
> Looking at 'arch/ia64/**' NUMA presence is detected by SRAT ACPI
> tables (and generic ACPI also wants SLIT, those probably exist on large
> ia64 boxes?)

hardware is HPE Integrity BL870c i4 nPar, debian sid/unstable ia64
installed (one of the buildd(s) of debian-ports):

mator@lifshitz:~/acpi$ cat slit.dsl
/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 *
 * Disassembly of slit.dat, Wed Mar 17 21:52:16 2021
 *
 * ACPI Data Table [SLIT]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "SLIT"    [System
Locality Information Table]
[004h 0004   4]                 Table Length : 0000003C
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : 7B
[00Ah 0010   6]                       Oem ID : "HP    "
[010h 0016   8]                 Oem Table ID : "BL860C-4"
[018h 0024   4]                 Oem Revision : 00000001
[01Ch 0028   4]              Asl Compiler ID : "HP  "
[020h 0032   4]        Asl Compiler Revision : 00000001

[024h 0036   8]                   Localities : 0000000000000004
[02Ch 0044   4]                 Locality   0 : 0A FF 14 FF
[030h 0048   4]                 Locality   1 : FF 0A FF FF
[034h 0052   4]                 Locality   2 : 14 FF 0A FF
[038h 0056   4]                 Locality   3 : FF FF FF 0A

Raw Table Data: Length 60 (0x3C)

    0000: 53 4C 49 54 3C 00 00 00 01 7B 48 50 20 20 20 20  // SLIT<....{HP
    0010: 42 4C 38 36 30 43 2D 34 01 00 00 00 48 50 20 20  // BL860C-4....HP
    0020: 01 00 00 00 04 00 00 00 00 00 00 00 0A FF 14 FF  // ................
    0030: FF 0A FF FF 14 FF 0A FF FF FF FF 0A              // ............
