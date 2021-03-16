Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF9833CA5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 01:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhCPAbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 20:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhCPAau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 20:30:50 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CCBC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 17:30:41 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id x10so33640546qkm.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 17:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version:date
         :message-id;
        bh=u2hOxobQQ7N70NBKzVloCTb3n1+wpT22bqbV6rT/WDg=;
        b=m8FkuGtneQBpLgtKi+ofN462A9a6xiecDw2C0W8WRA9PrPEfAAFxnX5afC/p4Ux+oo
         XA5DIbCcRhJAnRbbboSztqFNq9XtL7w6Obn0m6oh6aAvpkrYiwjarnpAUTQTGr6GPAdC
         Usb2DIxws54WtNYPX6Zk5MhUmkwn3I86HqvD4+tkpuiXu5oamRQeSqzLf0FCXewQDx4N
         hAFPEYWxleX921w8Um0Vab7pT9bfZkRkWzBsL79E/TzMKkgSMQ2z7RbwNwJZYUE9NBjV
         nD7k1oExjf2VwTEvxRyt4HqQP1OdR/y9e0v0g1KohAgeb8dbtpYdXtDkIaQzLKq5JfkM
         ag6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=u2hOxobQQ7N70NBKzVloCTb3n1+wpT22bqbV6rT/WDg=;
        b=EzjCRmWQs2l4ytBRbIPIVogxuGjAGH0xWODD0qzJl2qjC67D37eIMBUMaqUbM6U4kv
         6kBWYEMidzQG3upLidoF2QYrCIivXnFzz72d022wJ0tStNDTkCr/VjpN/lwXHJM98D59
         9McAk8PlNW/FHg3cS1rwyvkwLZ9H+B97B6laZol/8uYK/2co+P4WHkqaKz1tELqT0nmW
         +6U0/KjYYLpIwGPSmAnCUONieo82EV/yjl4afJnLkCNE9e+N0E9LrSrs+a5AiJCCoYOC
         T89ALyKEXKxcr8Qw4hEZwWYrPuq4IGxhuyPtiUeiGQ/c14T4SsXW40fiDMMQNlBr8O5j
         ZIqQ==
X-Gm-Message-State: AOAM533vh4AwIsq6Q+T/rRmkUrRuNdkqjBnben9lofXwK15Y+F8d9SkD
        lzDZYMijOnSwYWkP87BA0Cdw0Q==
X-Google-Smtp-Source: ABdhPJytrqR676TiFsnS/tXlV+p+3r5sT2Bg7/v4cPAW0K05L9MsbG60smFZLQ4zLjoOSttm/pFjkQ==
X-Received: by 2002:a37:c07:: with SMTP id 7mr26807312qkm.312.1615854641008;
        Mon, 15 Mar 2021 17:30:41 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id y13sm11761961qto.39.2021.03.15.17.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 17:30:40 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Christoph Hellwig <hch@infradead.org>
cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: arm64: kernel/sys.c - silence initialization warnings.
In-reply-to: <20210315192300.GA154861@infradead.org>
References: <162859.1615542946@turing-police> <20210315111433.GA22897@arm.com>
 <20210315192300.GA154861@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Mon, 15 Mar 2021 20:30:39 -0400
Message-ID: <96852.1615854639@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 19:23:00 -0000, Christoph Hellwig said:
> On Mon, Mar 15, 2021 at 11:14:34AM +0000, Catalin Marinas wrote:
> > We do similar initialisation in arch/arm64/kernel/sys32.c and
> > arch/arm64/kernel/traps.c for example. It's a pretty common pattern
> > throughout the kernel.
> > 
> > So we either treat W=1 output as diff against the vanilla kernel when
> > checking new patches or we remove override-init altogether from W=1.
> > Mark Rutland pointed me to an older thread:
>
> Please just remove the override-init warning, it is not helpful at all.

The tl;dr: Christoph is *probably* correct that it's not flagging any actual
bugs. And since *my* interest is "get the kernel tree to a point where W=1
or sparse throwing a warning is something worth looking at",  I'm not opposed
to a patch to remove it from W=1 tree-wide if it has essentially zero chance of
flagging an actual bug.

The longer version:

So I did a quick analysis...

For an x86_64 allmodconfig, there's not that many left:

     16 drivers/ata/ahci.h
      1 drivers/ata/pata_atiixp.c
      1 drivers/ata/pata_cs5520.c
      1 drivers/ata/pata_cs5530.c
      1 drivers/ata/pata_sc1200.c
      1 drivers/ata/pata_serverworks.c
      1 drivers/ata/sata_mv.c
      4 drivers/ata/sata_nv.c
      1 drivers/ata/sata_sil24.c
      1 drivers/block/drbd/drbd_main.c
      6 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h
      2 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_sh_mask.h
      1 drivers/input/serio/i8042-x86ia64io.h
      1 include/linux/blkdev.h
      1 kernel/bpf/btf.c
      4 kernel/time/hrtimer.c
      1 lib/errname.c

The drivers/ata *.c warnings all appear to be the same type of thing:

static struct scsi_host_template serverworks_osb4_sht = {
        ATA_BMDMA_SHT(DRV_NAME),
        .sg_tablesize   = LIBATA_DUMB_MAX_PRD,
};

The preprocessor macro defining the struct contents, and then
overriding one predefined value. So that's half of x64_64 done right there.

There's a few corners still need looking at, like why drivers/ata/ahci.h
throws 16 warnings on x64, but 30 on arm and 28 on arm64, and why
there's 4 warnings on include/linux/stddef.h on arm64 but not arm or x86.

But the number is certainly small enough that it's only a day or two's work
at most to check every single one.  If I go through the rest of x86 and arm
and they're all legit, I'll send a patch to nuke it kernel-wide rather than piecemeal.
