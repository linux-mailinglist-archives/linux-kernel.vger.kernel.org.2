Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0A432BD60
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452650AbhCCPwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351168AbhCCLJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:09:44 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FD1C061788
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 03:09:03 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id u125so5906529wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 03:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MrgKs7AaAPjSu71bqqbhqpKHLtrghctRiTu/BX2ygw8=;
        b=FRekRJ5Nz3cuYK/fdGOcgaM6AWa1qil920H3kKq4lFukOc3ZwD8SjK6qpnsMwV2TQ7
         5BnY2nCQ3Z0rXltTRr1gF64IuwVC5GZ/7BDGhOCKm3M4Zfdj7nCQ8GgtYDv/XreD1tMa
         nerPCo83Rz7nSde1dO/VwB6Gjx6qZ8P2QhRVi93aTOeVz/kTLEbuh4Z6rIhJOcYxiSm6
         d4uZxTqyKSiQMrgs1l29hwka1QnS4gUVQQqJ0ZXg9MzeyCpQvCdsNBc1TqsZWvzwfe6V
         nSRA53tBAXvZdl1XZ/PMZ+HTLRuTbD/I/CgDQN+8XBRm5+hI9ma1/pc9+BbA7H3rgUSF
         Kk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MrgKs7AaAPjSu71bqqbhqpKHLtrghctRiTu/BX2ygw8=;
        b=DwX9RfAqtsYPMy30G27IUUD4Cz/6vcBk+JR3I9gowySpQ/59nmP+n53+Jq1Nkeispl
         Yamim6bJhwmUn9wYqUFXfcgfj3zhfBC5g9enojBOVE2i2XOqgHyl3/eRfwmI+JPiFQCi
         OOXRCmtPYBSLxGNgtxWnv1ocrTxQh8FqaZrWgEs9/8B1cS6EF5WGToMz10W+1dl8t17R
         Sd49lM8x/z9YM1ZsnnLdbrGz8v8I8RwXHZqYvZ64w5ayYczli617LjcZT3Z4KnqwfM3s
         9GOM8W8X30Mr2averhNs6L8bzrZCtXB0e97TOo52q3aDWPgPcUNIWeFg7z99TqVFRmH9
         fwvw==
X-Gm-Message-State: AOAM531p0HUSYXMZEviCaCvEU+/I4fFTILGuDawYZGdYTOZE5Zp6nG0U
        JtupELTnzfhcBFQ25jqg5iRdlA==
X-Google-Smtp-Source: ABdhPJxFT/FTy1GsdpssFmrNcBfUaVBDWruZyYIsCWz48j1d9N4bImoC/8FkC4KeJ3Nuf3JpJ9Rp5A==
X-Received: by 2002:a1c:bb89:: with SMTP id l131mr8855627wmf.47.1614769741728;
        Wed, 03 Mar 2021 03:09:01 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id r10sm7196657wmh.45.2021.03.03.03.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 03:09:01 -0800 (PST)
Date:   Wed, 3 Mar 2021 11:08:56 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jia He <justin.he@arm.com>, kvmarm@lists.cs.columbia.edu,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
Message-ID: <YD9uSPQtlP2WTObe@google.com>
References: <20210303024225.2591-1-justin.he@arm.com>
 <87sg5czhny.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg5czhny.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 Mar 2021 at 09:54:25 (+0000), Marc Zyngier wrote:
> Hi Jia,
> 
> On Wed, 03 Mar 2021 02:42:25 +0000,
> Jia He <justin.he@arm.com> wrote:
> > 
> > If the start addr is not aligned with the granule size of that level.
> > loop step size should be adjusted to boundary instead of simple
> > kvm_granual_size(level) increment. Otherwise, some mmu entries might miss
> > the chance to be walked through.
> > E.g. Assume the unmap range [data->addr, data->end] is
> > [0xff00ab2000,0xff00cb2000] in level 2 walking and NOT block mapping.
> 
> When does this occur? Upgrade from page mappings to block? Swap out?
> 
> > And the 1st part of that pmd entry is [0xff00ab2000,0xff00c00000]. The
> > pmd value is 0x83fbd2c1002 (not valid entry). In this case, data->addr
> > should be adjusted to 0xff00c00000 instead of 0xff00cb2000.
> 
> Let me see if I understand this. Assuming 4k pages, the region
> described above spans *two* 2M entries:
> 
> (a) ff00ab2000-ff00c00000, part of ff00a00000-ff00c00000
> (b) ff00c00000-ff00db2000, part of ff00c00000-ff00e00000
> 
> (a) has no valid mapping, but (b) does. Because we fail to correctly
> align on a block boundary when skipping (a), we also skip (b), which
> is then left mapped.
> 
> Did I get it right? If so, yes, this is... annoying.
> 
> Understanding the circumstances this triggers in would be most
> interesting. This current code seems to assume that we get ranges
> aligned to mapping boundaries, but I seem to remember that the old
> code did use the stage2_*_addr_end() helpers to deal with this case.
> 
> Will: I don't think things have changed in that respect, right?

Indeed we should still use stage2_*_addr_end(), especially in the unmap
path that is mentioned here, so it would be helpful to have a little bit
more context.

> > Without this fix, userspace "segment fault" error can be easily
> > triggered by running simple gVisor runsc cases on an Ampere Altra
> > server:
> >     docker run --runtime=runsc -it --rm  ubuntu /bin/bash
> > 
> > In container:
> >     for i in `seq 1 100`;do ls;done
> 
> The workload on its own isn't that interesting. What I'd like to
> understand is what happens on the host during that time.
> 
> > 
> > Reported-by: Howard Zhang <Howard.Zhang@arm.com>
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  arch/arm64/kvm/hyp/pgtable.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index bdf8e55ed308..4d99d07c610c 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -225,6 +225,7 @@ static inline int __kvm_pgtable_visit(struct kvm_pgtable_walk_data *data,
> >  		goto out;
> >  
> >  	if (!table) {
> > +		data->addr = ALIGN_DOWN(data->addr, kvm_granule_size(level));
> >  		data->addr += kvm_granule_size(level);
> >  		goto out;
> >  	}
> 
> It otherwise looks good to me. Quentin, Will: unless you object to
> this, I plan to take it in the next round of fixes with

Though I'm still unsure how we hit that today, the change makes sense on
its own I think, so no objection from me.

Thanks,
Quentin
