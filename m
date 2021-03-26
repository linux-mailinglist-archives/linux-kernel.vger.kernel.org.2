Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3BC34A3CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhCZJLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhCZJKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:10:37 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CDAC0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:10:37 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id n8so5039921oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4p7L0r2YVzvHUiWBzaSDayxmY/547g3xQbzU3O52T2E=;
        b=K//qQBOSq6LUJ/Ks7l0mrUPHs53l2Y1cWYTAx32Gr87z72QyvxSgd8n/3wdyZwBa9Y
         VJJFuBtSJQ2V34IWaPS9wqqDQJJKuwfWRH91wAzYmwMZOPX8SGtMk6qwguBjJ61lwP2b
         iLaoblkPZMm8b2E2yJvXXGHFj71px91XW31LHTtueSJ1lX4gcK/8Zr7Y+DYlXDtg9Eml
         igyHDBGqetdlCtKl9jiSRUCIomfnb1f9aMiqseOUPPlUE5mAtBD53/D8A++mRhTkyRdt
         WPYwhuFyxorKD3YQ5b+q4dVGIaFbHZ4sjTo5ELKGsWEO3mSmAWfPVZ+2ZNK09l9LovFX
         ZEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4p7L0r2YVzvHUiWBzaSDayxmY/547g3xQbzU3O52T2E=;
        b=TesOOZ4VdOKfXrrvIc703/pkbt3+NAYc8yBaETlLNRCKYrMIhpXUZKN1z/6h7de/Gp
         iPVczxfCA04HvA2dHyjLtIzksx+UmBQeZc/ASU0bItMy04OWV3hyJbpnxaOxR4NUIr5B
         g6UH/DfsancI+7agzVr6PzIhMVhAeM2QuW2oPbk5Upv5Xj/vQ0KAiHeqnlb8LvJjVBYj
         eN21N09S4uJuPZ3W6eqISuJ9w3r3YDee2bLekFRHSB3LL+zfwJ4/y93ubLoFovJrqS6H
         e9qf2OBYhJGnR3HXUtbw9sqrixz/Yh29HKkbi8/9B5gUl+mCMYutLApdpCyUEsL52frv
         pNRg==
X-Gm-Message-State: AOAM531xjmag14OyJYDPz0h6iMUFczDSdn5eDMIAvSepTfDybdU3dhRB
        xFgI/zRBqpAVhehcDmAxYMYjXYBc6+vNkmm+1hYY0MNeRkhbTg==
X-Google-Smtp-Source: ABdhPJzWYUEN40+bsyYL88YYVQP5NXJtFRzbznOQwcflZtD04abopFLejxa8uvUREgVwa5kx1YHlguTbvtlVwiiZfJM=
X-Received: by 2002:aca:1c02:: with SMTP id c2mr8944699oic.31.1616749836344;
 Fri, 26 Mar 2021 02:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201209094916.17383-1-zong.li@sifive.com> <87v99qyjaz.fsf@igel.home>
 <CANXhq0oLxFK1431WmTj5HRO5k_omYkQZCBTG+HORTk9=W_XyNg@mail.gmail.com>
 <CANXhq0p90Cgha_zLzxamK9mxmVPn3effh_cZq_CTLrcAkKZg2Q@mail.gmail.com>
 <87lfaj7cki.fsf@igel.home> <871rc4on36.fsf@igel.home> <CANXhq0pDge0BPgAjoLrX7Y2qtofb3dhV1_CPHBaCg0o4cEMrbQ@mail.gmail.com>
 <87a6qrk2pw.fsf@igel.home>
In-Reply-To: <87a6qrk2pw.fsf@igel.home>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 26 Mar 2021 17:10:24 +0800
Message-ID: <CANXhq0rOeAWnRYHAYKJfDeY4kYz6+5mU_dJSqU67+2p9u0STHQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] clk: add driver for the SiFive FU740
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Pragnesh Patel <pragnesh.patel@openfive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 5:22 PM Andreas Schwab <schwab@linux-m68k.org> wrot=
e:
>
> On M=C3=A4r 25 2021, Zong Li wrote:
>
> > take a look at this again. Could you also let me know which bootloader
> > you used (FSBL or U-boot-SPL)? Thanks.
>
> U-Boot SPL
>
> Please try this image:
>
> http://download.opensuse.org/ports/riscv/tumbleweed/images/openSUSE-Tumbl=
eweed-RISC-V-JeOS-hifiveunleashed.riscv64.raw.xz
>

Hi Andreas,

The following is the result of the test so far. I would continue to
see what happened there.

1. Boot on openSUSE-Tumbleweed-RISC-V-JeOS-hifiveunleashed.riscv64.raw.xz
w/ plugging ethernet cable
  - It seems that I encountered a different situation with you, my
system hung up and I didn't see the boot message you mentioned yet.

[  OK  ] Finished Generate issue file for login session.
[  OK  ] Finished Apply settings from /etc/sysconfig/keyboard.
[  OK  ] Started User Login Management.
[  *** ] (3 of 3) A start job is running for=E2=80=A6upplicant service (58s=
 / 1min 51s)
[**    ] (3 of 3) A start job is running for=E2=80=A6cant service (1min 28s=
 / 1min 51s)
[   ***] (2 of 3) A start job is running for=E2=80=A6cant service (1min 58s=
 / 3min 21s)
[   ***] (1 of 3) A start job is running for=E2=80=A6cant service (2min 28s=
 / 3min 21s)
[**    ] (3 of 3) A start job is running for=E2=80=A6cant service (2min 58s=
 / 3min 21s)
[ ***  ] (2 of 3) A start job is running for=E2=80=A6cant service (3min 28s=
 / 4min 51s)
[     *] (1 of 3) A start job is running for=E2=80=A6cant service (3min 58s=
 / 4min 51s)
[ ***  ] (3 of 3) A start job is running for=E2=80=A6cant service (4min 28s=
 / 4min 51s)
[***   ] (2 of 3) A start job is running for=E2=80=A6cant service (4min 59s=
 / 6min 22s)
[    **] (1 of 3) A start job is running for=E2=80=A6cant service (5min 29s=
 / 6min 22s)
[  *** ] (3 of 3) A start job is running for=E2=80=A6cant service (5min 59s=
 / 6min 22s)
[*     ] (2 of 3) A start job is running for=E2=80=A6cant service (6min 29s=
 / 7min 52s)
[  *** ] (1 of 3) A start job is running for=E2=80=A6cant service (6min 59s=
 / 7min 52s)
[    **] (3 of 3) A start job is running for=E2=80=A6cant service (7min 29s=
 / 7min 52s)
[FAILED] Failed to start wicked AutoIPv4 supplicant service.
See 'systemctl status wickedd-auto4.service' for details.
[FAILED] Failed to start wicked DHCPv4 supplicant service.
See 'systemctl status wickedd-dhcp4.service' for details.
[FAILED] Failed to start wicked DHCPv6 supplicant service.
See 'systemctl status wickedd-dhcp6.service' for details.
         Starting wicked network management service daemon...
[    **] A start job is running for wicked n=E2=80=A6rvice daemon (7min 59s=
 / 9min 22s)
[***   ] A start job is running for wicked n=E2=80=A6rvice daemon (8min 29s=
 / 9min 22s)
[  603.364988] BUG: workqueue lockup - pool cpus=3D1 node=3D0 flags=3D0x0
nice=3D0 stuck for 36s!
[***   ] A start job is running for wicked n=E2=80=A6rvice daemon (8min 59s=
 / 9min 22s)
[  633.444986] BUG: workqueue lockup - pool cpus=3D1 node=3D0 flags=3D0x0
nice=3D0 stuck for 66s!
         Stopping Flush Journal to Persistent Storage...
[  OK  ] Stopped Flush Journal to Persistent Storage.
[  OK  ] Stopped Journal Service.


2. Boot on kernel image which built by opensuse defconfig with
changing CONFIG_MACB to y instead of m
 - Although I got some problem for mounting the root filesystem on
this image now, but I didn't hang up at the message you mentioned, I
could go through after macb driver initialization

[    2.350309] libphy: Fixed MDIO Bus: probed
[    2.354476] macb 10090000.ethernet: Registered clk switch
'sifive-gemgxl-mgmt'
[    2.358752] macb 10090000.ethernet: GEM doesn't support hardware ptp.
[    2.361464] libphy: MACB_mii_bus: probed
[    2.366289] macb 10090000.ethernet eth0: Cadence GEM rev 0x10070109
at 0x10090000 irq 16 (70:b3:d5:92:f2:6c)
[    2.375570] e1000e: Intel(R) PRO/1000 Network Driver
[    2.380323] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.386338] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
...
[    2.687447] Waiting for root device /dev/mmcblk0p4...

3. I check the patch set of supporting fu740, it shouldn't impact
fu540, I'm going to dump and comparing the prci content and give more
testing.


> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
