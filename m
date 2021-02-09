Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C8A3148F4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhBIGgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhBIGdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:33:43 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F36DC061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 22:33:03 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 8so9165093plc.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 22:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1yfWtyKyTZvhHLdRd0Os+HgXY0IXloCRl6/1X6y49yY=;
        b=I8sAs6STSD3viziWc9zjdGpRV2Ij0huuBcH4DTqpEpqza+Sa89+jcmi0lEr6QyU3Yc
         L7rP/rH0/RfRBI83gH4R47SJOVgSrDffjCf/VWsaIa4tSZ3K01/puYHwXeA+73O+NMbj
         Mayn3mIGAEUCdMMblgZt8JrLoIUQfDCTzzdMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1yfWtyKyTZvhHLdRd0Os+HgXY0IXloCRl6/1X6y49yY=;
        b=nWQCRSWr9fvdPgLgfpVKxIYojyQpu1UJwjN4ERID/RaWUal3eMwMpfn67C2XStbkUr
         9pMOvv/YHxjDt2FxronKp8hQL1qBEvk003cndbm3y05YXP2jeojFnwyWGcA8YeHhIdv0
         xNUDKvrgtpRFpA41CDwqO4/WIqwbqwD/Ovss94jY4rX9ah7jJYdH9bqNCOFpIk/jzMHQ
         AnU0FJ75o0GS+0W3jy66cYbgHOaiOJo1xCYuR3y96v7kBS3x5gkOvElH1ReBHtE9NyeX
         Z80mQZ4plxmKlMa4EsbKFnm4oN90jSBAdzwleJaCjbPlFz/n5K1K9Hc/0iJskVRxCtyu
         An5w==
X-Gm-Message-State: AOAM531sfSHRn5fMCHRCY1vHaiNV9126DYRvn8s5BS00f0OrzVlEvICA
        pwdyLAsGWwWL0eLtUdR4xDSKozrd7WOCoA==
X-Google-Smtp-Source: ABdhPJyIIQm7rCEr9M2o5Kchx9EM7M/SQ5MngTWW0b9+AAZxoCYQLqqyZoIWEprGE9VoKWVQyyZz7w==
X-Received: by 2002:a17:90a:5a86:: with SMTP id n6mr2699031pji.65.1612852382477;
        Mon, 08 Feb 2021 22:33:02 -0800 (PST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com. [209.85.215.175])
        by smtp.gmail.com with ESMTPSA id t22sm22158188pgm.18.2021.02.08.22.33.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 22:33:02 -0800 (PST)
Received: by mail-pg1-f175.google.com with SMTP id m2so5104772pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 22:33:02 -0800 (PST)
X-Received: by 2002:a6b:144c:: with SMTP id 73mr18274991iou.69.1612852048986;
 Mon, 08 Feb 2021 22:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org> <d7043239-12cf-3636-4726-2e3b90917dc6@gmail.com>
 <CALiNf28sU1VtGB7LeTXExkMwQiCeg8N5arqyEjw0CPZP72R4dg@mail.gmail.com>
 <78871151-947d-b085-db03-0d0bd0b55632@gmail.com> <CALiNf29_PmLJTVLksSHp3NFAaL52idqehSMOtatJ=jaM2Muq1g@mail.gmail.com>
 <23a09b9a-70fc-a7a8-f3ea-b0bfa60507f0@gmail.com> <CAAFQd5DX=AdaYSYQbxgnrYYojkM5q7EE_Qs-BYPOiNjcQWbN1A@mail.gmail.com>
 <c7f7941d-b8bd-f0f3-4e40-b899a77188bf@gmail.com> <CAAFQd5AGm4U8hD4jHmw10S7MRS1-ZUSq7eGgoUifMMyfZgP2NA@mail.gmail.com>
 <7fe99ad2-79a7-9c8b-65ce-ce8353e9d9bf@gmail.com>
In-Reply-To: <7fe99ad2-79a7-9c8b-65ce-ce8353e9d9bf@gmail.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 9 Feb 2021 14:27:18 +0800
X-Gmail-Original-Message-ID: <CALiNf2_rRufFoxNN=i0_LkVvw31tXetKasm3SrzYy7O8o-sfgg@mail.gmail.com>
Message-ID: <CALiNf2_rRufFoxNN=i0_LkVvw31tXetKasm3SrzYy7O8o-sfgg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] Restricted DMA
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Tomasz Figa <tfiga@chromium.org>, Rob Herring <robh+dt@kernel.org>,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, grant.likely@arm.com,
        xypron.glpk@gmx.de, Thierry Reding <treding@nvidia.com>,
        mingo@kernel.org, bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4 here: https://lore.kernel.org/patchwork/cover/1378113/
