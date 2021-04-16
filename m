Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBE5361AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbhDPHfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239201AbhDPHfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:35:40 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB0FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 00:35:13 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id n184so948903oia.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 00:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJD4Wffy8UFddOPkdi2YXR6U7i7vtfGmTFUKn6fdSpQ=;
        b=G+yNnwMnLDElOBnF2B2+GxANp7XTkHj2DLoP/s3CNBCAi6w7gglXHy8oFGuZ6Qp2Qm
         OkeIpoc212lPbkc1hyJkm4A51KOcLo2OlS6K9uJ5dEF7gXETSsxiw5XJDsJgsXb3s2oE
         lTp4C8qSueJ08ORlfJ2m5xth4v57F+vKbyegAMM9luRp1wBe//U+v9gUr3+lZXdesng9
         WwQpdi/QHfafpxLKTrJMbumRxFxzlDgN3ecEtb/fdhrAiLMY2USct0BXoIde0q8IFcLB
         IWa4uZRPhHVPfVLPtQM/ta90PyYBStMFJkJZJ9KNDBnVYP5W6ET3vQKd71EAnaMFp0Hu
         7rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJD4Wffy8UFddOPkdi2YXR6U7i7vtfGmTFUKn6fdSpQ=;
        b=heuAM+B3lbVv3OFir37gbOLsp5JL0ZxZhIySOTiTthwGSCz921g2leMh+/TGTIBBOh
         5E/A2Wxh1BtPZMGuM/w6ishdQXn15fy3yz1+SBGRh86y7I4lyFvftnXe9Do+vugyEwaz
         wjrmJGfV51spqq/gWgDTdYF08KDZq+zK6MBrTFKwKBC1+lB07Erli4K9LOvlFFxGP3KB
         Imh2+SvYDJmrvBUZANVN/vAEzMn0fb9azHOTGr0y+GOPz8qEQtBv3qYFi/21tmht6qTY
         stHxCG7W0d3OFrz9nhLAlHRGiQuwPiz5qWQ8i5x9lKhuyjlwGJzBcjetaBxViA42grgO
         DKdA==
X-Gm-Message-State: AOAM530WbfQa5YeKMiEl3ihmORTPATBiA3DbWZF3vuegbTqquuvlPo2U
        eTCYq/mR4Ldnw16xQeIbTcajmj01OQSC0CLaf7uFyg==
X-Google-Smtp-Source: ABdhPJyyb5uCrc4pETT//wgeijjcWgZHJwhyFG2hghIXA58CpkcDpTKOEaIX3WAcbBOMndCKUQq/lHReczEGRuQm9ms=
X-Received: by 2002:a05:6808:d50:: with SMTP id w16mr5521425oik.28.1618558512880;
 Fri, 16 Apr 2021 00:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210316085932.2601-1-troy_lee@aspeedtech.com> <CACPK8XeYtaLLWDMR8xZhERrQ_WCUJ2RM_JZmZNQ6oZSvgSDM_w@mail.gmail.com>
In-Reply-To: <CACPK8XeYtaLLWDMR8xZhERrQ_WCUJ2RM_JZmZNQ6oZSvgSDM_w@mail.gmail.com>
From:   Lei Yu <yulei.sh@bytedance.com>
Date:   Fri, 16 Apr 2021 15:35:01 +0800
Message-ID: <CAGm54UHgQSMh8WLzRf7Swhv9mmzNBuEK6eKf9eX0ASp95hjARw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1] ARM: dts: Fix 64MiB OpenBMC flash
 layout and aspeed-ast2600-evb.dts
To:     Joel Stanley <joel@jms.id.au>
Cc:     Troy Lee <troy_lee@aspeedtech.com>,
        John Wang <wangzhiqiang.bj@bytedance.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>, leetroy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 11:03 AM Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 16 Mar 2021 at 08:59, Troy Lee <troy_lee@aspeedtech.com> wrote:
> >
> > Aspeed AST2600 u-boot requires 600KiB+ flash space. Sharing the same
> > openbmc-flash-layout-64.dtsi requires to resize the flash partition.
> >
> > The updated flash layout as follows:
> > - u-boot: 896 KiB
> > - u-boot-env: 128 KiB
> > - kernel: 9MiB
> > - rofs: 32 MiB
> > - rwfs: 22 MiB
>
> Changing the 64MB layout will break the systems that are already using
> this layout. I'll get the Bytedance people to chime in, as theirs is
> the only system using this layout so far.
>
> John, Lei?

Because the kernel's offset is updated, several other changes are required:
1. The related offsets, which is already sent to
https://gerrit.openbmc-project.xyz/c/openbmc/meta-phosphor/+/39343
2. The u-boot patch to update the `bootm` address and make sure it
only applies to the 64MiB layout.

Without the above two changes, I would suggest holding the merge.

-- 
BRs,
Lei YU
