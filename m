Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E77A4587CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 02:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhKVBmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 20:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhKVBmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 20:42:01 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A3EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 17:38:55 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id d1-20020a4a3c01000000b002c2612c8e1eso5887846ooa.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 17:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XMseNZAubaYtE/RBu8Q9+x2ild9p650jbxa5PZ+OpJ8=;
        b=ne/CAdyI251luSaiFRxZiRJDjXeCVmJwT7HH4fAw/5MU7PkeeTAVqSmDavr1POahXq
         B36bv+JqaJYNdMBd8NQEwDLt5FC0MG+skXxcCA2xJAJBVfhJUbk2JE3D4ouC+LJsd2Fj
         zkaaxRP7+WdGeNugJoVL8qRxngo/yV7FPiWQLPqXTreengs3ZkDdotSvIeS9JtWQ7wjR
         y78H5/W5XdWeDXTZmz0RYWMT9pyrL7nEQlyzRngabjtOnsK9n/LpQNTjQGY1AdOQ7gco
         s/x6lvdHY7g1YNnXwwUB1vaCihwU4y11EBEwmUXqHyw17u2Q7LnTHfRW7xMOZ61nVvaW
         2wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XMseNZAubaYtE/RBu8Q9+x2ild9p650jbxa5PZ+OpJ8=;
        b=tra8nNvhcjfyzTsP/JgWvCiIKmQWSfRLNoTSu/P4lJFA2HEs75iLZihTrRGWNZpsGK
         oNgJoa+1T12Pp6AUhiH3UsaUAyW/xmBJGOjivGrgb69u5CLMQgagMy9XcYgji3GqMVNe
         n5ERKBnKzanUkp2OoMhvGTa98bFdGRSyr5VAN1T5iiFmtvzBJTPDw2GlmESiHF9PSkIz
         6nIaJGHDd9hDDpNH1BZFzYYReBBPWr7/nv0xAyXpsvz2kk0og52JW2zszvf5Cj9v8un/
         zPBMsT1uWjhYglAiiANmq6vMMpp6D8tVpUxVANDQiBmR3UA5SNRhYU0FiDZmhBQJhu/D
         nRAA==
X-Gm-Message-State: AOAM533OH6qiBuAuDe2rFiwtm8yY2OpguTSVE/yrBpGiUJOb8QXk4cuM
        75Yzigc2OscnfmKNOqDUSTI=
X-Google-Smtp-Source: ABdhPJw5yW4Bcy3WvrQF341Hs/vyWr6YVKJduAZHLL3yDGHaoXGU7XJPe+OfEgCjFoRIknhRjwCCew==
X-Received: by 2002:a05:6820:508:: with SMTP id m8mr29149706ooj.38.1637545135081;
        Sun, 21 Nov 2021 17:38:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e3sm1339040otk.71.2021.11.21.17.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 17:38:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 21 Nov 2021 17:38:53 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.16-rc2
Message-ID: <20211122013853.GA1859143@roeck-us.net>
References: <CAHk-=wgMLMKjQUFoAA+chpZqaLJgpnUHsOJtBzWgFepT_DEwSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMLMKjQUFoAA+chpZqaLJgpnUHsOJtBzWgFepT_DEwSw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 02:06:56PM -0800, Linus Torvalds wrote:
> Nothing especially noteworthy stands out for the last week, it all
> felt pretty normal for a rc2 week.
> 
> The commit stats look normal, and the diffstat looks fairly regular
> too. There's perhaps relatively less driver diffs than usual, partly
> explained by the tools subdirectory diff being larger than usual (a
> quarter of the whole thing), mostly just due to added kvm tests. The
> rest is arch updates, filesystems, networking, documentation etc...
> 
> So fixes a bit all over the place, with nothing that really stands
> out. Details below in the shortlog.
> 

Build results:
	total: 153 pass: 148 fail: 5
Failed builds:
	csky:defconfig
	csky:allmodconfig
	mips:allmodconfig
	powerpc:allmodconfig
	sparc64:allmodconfig
Qemu test results:
	total: 482 pass: 482 fail: 0

Details about build failures see below.

Guenter

---
csky:defconfig
csky:allmodconfig
sparc64:allmodconfig

fs/netfs/read_helper.c: In function 'netfs_rreq_unlock':
fs/netfs/read_helper.c:435:25: error:
	implicit declaration of function 'flush_dcache_folio';

Fixed in -next.

---
mips:allmodconfig

ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!

Still seen in -next.

---
powerpc:allmodconfig

fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
fs/ntfs/aops.c:1311:1: error: the frame size of 2240 bytes is larger than 2048 bytes

Stephen marked NTFS_RW as BROKEN in -next.
Would something like "depends on BROKEN if PPC" be acceptable ?
