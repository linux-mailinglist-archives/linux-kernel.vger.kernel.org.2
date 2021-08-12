Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841D03E9D40
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhHLEUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHLEUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:20:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E16CC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:19:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l11so5573390plk.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XAWS1Fzhv4ugWPxdQYgyaalWdh5gKPCIpOricQxOSqE=;
        b=BCFoXTQsHbkiIkvbjWEdPulFyID6opdl2wdKX1x4akrMJrAy2RCouDIu3Od9lY+Igk
         KD0e4sxVSkt7K3OGVAMA1pdbWdSrgF7zfLgULu58LXkpAtUajVokIcE4QPHOY7spnIBr
         bMDQ+UIvBWLD2Rin65XKoVyv+MfxAUS0badbIC7eB7GWdTjC/fH5fENAZmu5lxIpdcKa
         BxPiDs3DwME9i5w5joo9IkMhGuowhTie219wK0mbay1bcsQ/iLufsJRT96BBqYrO0o/H
         HiM5lqfgersR/WjcegQV0DVGds1Tn08I4f4LF8JrrgH1x4VSjjrsm8Rm6ikEZy2AS9IE
         FTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XAWS1Fzhv4ugWPxdQYgyaalWdh5gKPCIpOricQxOSqE=;
        b=saMpZUwFsW5bEVjnw90oyoZECtK7Q2eqDoeVn/iO4nA6/dnBmKztPYa0SgUHl7eVWW
         tJYGEcXaVVmllgIb+NbnLDLYt9b8wBgQMfdkarfSaO+Z4RxxpNaMlg7sWQXJU0NZS9qU
         9RaBpa6CikX769qiE+eeX/Pq61eMoO8cx0IpSSetdb1E1tuKOzjj1W6C2NdvfUOvuaaV
         55jMMKbyZ/PKv1p/nqLIplDHks7KbIZKwKKwDevIM3CkYR31y16wObshlvtuFAzde/WM
         XVVGuDvHC2iaiCAdDDG4yKB9/wEelxd0z9iBEei1oT09l3/fI5lw+sQD3huUhXKuylNG
         uAgQ==
X-Gm-Message-State: AOAM533RW9DVTkgLB/c3g54KdsZJ/bEqY4B0Mv9wyciihrgs2nlw8JBg
        1vGcpKdQfRcizN/Nl5fTUD8=
X-Google-Smtp-Source: ABdhPJyZSxBq0gd91vjWyhU0Jy/DtwrpyGcOKeoC/jVtnel4PMIK0UIHovlyTZ49DKvdG7qbSGKuOA==
X-Received: by 2002:a17:90a:fb81:: with SMTP id cp1mr2341998pjb.52.1628741982604;
        Wed, 11 Aug 2021 21:19:42 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:73b9:7bc0:297c:e850])
        by smtp.gmail.com with ESMTPSA id v10sm8480332pjd.29.2021.08.11.21.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:19:42 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        rafael@kernel.org, robin.murphy@arm.com,
        song.bao.hua@hisilicon.com, wangzhou1@hisilicon.com,
        will@kernel.org
Subject: Re: [PATCH] platform-msi: Add ABI to show msi_irqs of platform devices
Date:   Thu, 12 Aug 2021 16:19:30 +1200
Message-Id: <20210812041930.28931-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YRO5R0/N9KITjyY9@kroah.com>
References: <YRO5R0/N9KITjyY9@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > +static ssize_t platform_msi_show(struct device *dev, struct device_attribute *attr,
> > +     char *buf)
> > +{
> > + struct msi_desc *entry;
> > + unsigned long irq;
> > + int retval;
> > +
> > + retval = kstrtoul(attr->attr.name, 10, &irq);
> > + if (retval)
> > + return retval;
> > +
> > + entry = irq_get_msi_desc(irq);
> > + if (entry)
> > + return sprintf(buf, "msi\n");
>
> sysfs_emit()?

yep.

>
> But why isn't this all handled by the MSI core code?  Why would each bus
> need to have this logic in it?

i think i can extract some common code for sysfs populate/destroy to msi core from pci and platform.
but we still need some pci/platform specific code in pci-msi and platform-msi cores. for example,
pci-msi has specific data which will be accessed in its show() entry.

struct msi_desc {
        ...
        union {
                /* PCI MSI/X specific data */
                struct {
                        u32 masked;
                        struct {
                                u8      is_msix         : 1;
                                u8      multiple        : 3;
                                u8      multi_cap       : 3;
                                u8      maskbit         : 1;
                                u8      is_64           : 1;
                                u8      is_virtual      : 1;
                                u16     entry_nr;
                                unsigned default_irq;
                        } msi_attrib;
                        union {
                                u8      mask_pos;
                                void __iomem *mask_base;
                        };
                };

                ...
                struct platform_msi_desc platform;
                ...
        };
};

in addition, they are quite different in initialization/release and also need different places to save sysfs groups.
so probably i can let msi cores provide msi_populate_sysfs() and msi_destroy_sysfs() APIs. And ask pci and platform
to call msi_populate_sysfs() in their init code and save the groups in their specific pointers,  and then they can
free sysfs in their release paths by calling msi_destroy_sysfs()

>
> thanks,
>
> greg k-h

Thanks
Barry
