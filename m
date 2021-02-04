Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C669730F8F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbhBDRBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbhBDQ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:59:21 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176EEC061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 08:58:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 7so4421852wrz.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 08:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSXClwte+EBaSfb73OT9a258Z0fuumQByG0sZ3xvY0o=;
        b=kF3mIgExZ6yqH4eVMQt6WD7DEfAMygEvJlEbz5Xto3mUv0YDv1L49BGJIm43dk9bU1
         iXTPifKJP86J0pow9upJIpWRGPhVO1f2EMyxp18Untk7OSKOV1noZ4nOqj1K5+vZn89G
         y8rpqE5p8fJ2NUkDxK1tbqWLU3qx+6Ux/u9co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSXClwte+EBaSfb73OT9a258Z0fuumQByG0sZ3xvY0o=;
        b=oso6Da3D96dlxEaGUvfa4eMnyisTENZ32MLwhcyb4Q2Ur+deQKTFJD84M2Eqhm6Z9M
         8kHnUWQC1YbJncW7sFJQfdQkcg17QOjZrbZe4CQrbvyy5flvgW8gCfg1yXg8o5A2OO0P
         WZJd/zrqx8fOTZO9XGXIklhGXMx8Z44qYgUQTnLUKUsg/5oM/hSIdbdKQJL79h80GoUp
         9WuQfquE/64Djvo0YL7DXeb/9T/oNnRjo/YTHXH0edl8iM6nbFnxfAD7PXaw94v83riS
         /Jup4o72yJToZwV6Ej61ybG8sijOapBj5V7gvYekOyANkCVVTEyTY1Y/VtN9rpr+yfg/
         RGkw==
X-Gm-Message-State: AOAM533opeO9R4APHuK/RKkaysRT/+/4V/Zpa0YOW0cRNe4k2Pi5Y2TJ
        ZFFeEhkpGYf2my5JaOjXXG1VaF/ZKtAr1Mjj
X-Google-Smtp-Source: ABdhPJzQxOtjiSlI6HeHAkG205a5zhJRcBC5cKGPxy6h1VeNvxXZzxclR5CwPfNihVa2lXiEvFOWdA==
X-Received: by 2002:adf:decb:: with SMTP id i11mr313945wrn.78.1612457918861;
        Thu, 04 Feb 2021 08:58:38 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i64sm6700187wmi.19.2021.02.04.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 08:58:38 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 0/2] pci sysfs file iomem revoke support
Date:   Thu,  4 Feb 2021 17:58:29 +0100
Message-Id: <20210204165831.2703772-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a revised version of patch 12 from my series to lock down some
follow_pfn vs VM_SPECIAL races:

https://lore.kernel.org/dri-devel/CAKwvOdnSrsnTgPEuQJyaOTSkTP2dR9208Y66HQG_h1e2LKfqtw@mail.gmail.com/

Stephen reported an issue on HAVE_PCI_LEGACY platforms which this patch
set tries to address. Previous patches are all still in linux-next.

Stephen, would be awesome if you can give this a spin.

Björn/Greg, review on the first patch is needed, I think that's the
cleanest approach from all the options I discussed with Greg in this
thread:

https://lore.kernel.org/dri-devel/CAKMK7uGrdDrbtj0OyzqQc0CGrQwc2F3tFJU9vLfm2jjufAZ5YQ@mail.gmail.com/

Cheers, Daniel

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org

Daniel Vetter (2):
  PCI: also set up legacy files only after sysfs init
  PCI: Revoke mappings like devmem

 drivers/pci/pci-sysfs.c | 11 +++++++++++
 drivers/pci/proc.c      |  1 +
 2 files changed, 12 insertions(+)

-- 
2.30.0

