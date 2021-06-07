Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF53039D7E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhFGIwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:52:07 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53119 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGIwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:52:06 -0400
Received: by mail-wm1-f46.google.com with SMTP id f17so9492469wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R2ZopsQZZdXEYjl6azm31E2MzYfojsymg///Se/cAKM=;
        b=RxBciWEa0mOrwTDqwBl7XhVt1Z3tGfff3KVAXfjjxbhvucwuitAYpCjW2AiOfmc4hY
         MW0YwzUHKGA/WeKdlYLraPeOhx4a5uKzxp6v4lLraANt7WimKeIInnK9T/6eWrQjXCT9
         WjObcZ+HYZ3Go8GMia3x24cyu5tbYPVgn1JDv/sRYAPZlA5vtodNND9A/q6x8y8UnXk6
         SuJuhS9v8M4MwoSC+c+Tx7H+ePDwkcKPvy620Tt8pc5u8pj0IFei8NsOk08p/27eHLhl
         SoI75OyhpQKO1uzn4yXdmbM/CqtG6q0nD58HzKEwZj7xuk0c/z3vpR8i7Mvpj1PS7VyY
         r5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R2ZopsQZZdXEYjl6azm31E2MzYfojsymg///Se/cAKM=;
        b=TsLJEUBkOTahCEJ9jNfL1+wRKACI4I7lEz5VAyCknDom0jJJH29TPptmiW57XyY+sB
         4mHbO903aBUg1iUrwzpoKmRBEsyIgi9rsrrmRiFmp/j0Ax4j1pGKXb2ufEHe2vGarNE5
         xrPazUf5Ln1O7GDlps9Tj8ZYgm9mU5DClssToue1FwtbPbcyRMJOhzxtqOLCA325aSZ+
         ZmsImDIs1+2Q4chw8d1l9daazon2tFflGj+seHp412MxuKhD4f4u3QK3mysQ8EQFJWCr
         1fC+8frYsmyG6H/YJ/fBDFmrcMiG5ykADg3SvCqK3dYVpVEZEcYjwtm68C7LVIRPlGSd
         apyw==
X-Gm-Message-State: AOAM5306lvFN/WdGvc8nV/PUOEaOwa3+6J1zWf3jJqJtKpqXMlw14JUA
        ml4YzMyyAs9LaLXrLjI/JnwTXw==
X-Google-Smtp-Source: ABdhPJyurKzta3z2CeRnxFd2iiCVeQi8uEXKlJF0ITFMul63PvHyfT+ViQ4DZznWDHGoSIMfaenzLQ==
X-Received: by 2002:a05:600c:21d1:: with SMTP id x17mr15424695wmj.167.1623055754959;
        Mon, 07 Jun 2021 01:49:14 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id o18sm5415514wrx.59.2021.06.07.01.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 01:49:14 -0700 (PDT)
Date:   Mon, 7 Jun 2021 10:48:55 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 0/3] kvm/arm: New VMID allocator based on asid(2nd
 approach)
Message-ID: <YL3ddwlSOsv16F1g@myrica>
References: <20210506165232.1969-1-shameerali.kolothum.thodi@huawei.com>
 <e62829990c50479292af94c4152011fc@huawei.com>
 <87sg1xzqea.wl-maz@kernel.org>
 <95bb84ffdb0f4db3b64b38cc3b651f90@huawei.com>
 <87lf7ptztg.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf7ptztg.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 04:27:39PM +0100, Marc Zyngier wrote:
> > > Plus, I've found this nugget:
> > > 
> > > <quote
> > > 	max_pinned_vmids = NUM_USER_VMIDS - num_possible_cpus() - 2;
> > > </quote>
> > > 
> > > What is this "- 2"? My hunch is that it should really be "- 1" as VMID
> > > 0 is reserved, and we have no equivalent of KPTI for S2.
> > 
> > I think this is more related to the "pinned vmid" stuff and was borrowed from
> > the asid_update_limit() fn in arch/arm64/mm/context.c. But I missed the
> > comment that explains the reason behind it. It says,
> > 
> > ---x---
> > 	/*
> > 	 * There must always be an ASID available after rollover. Ensure that,
> > 	 * even if all CPUs have a reserved ASID and the maximum number of ASIDs
> > 	 * are pinned, there still is at least one empty slot in the ASID map.
> > 	 */
> > 	max_pinned_asids = num_available_asids - num_possible_cpus() - 2;
> > ---x---
> > 
> > So this is to make sure we will have at least one VMID available
> > after rollover in case we have pinned the max number of VMIDs. I
> > will include that comment to make it clear.
> 
> That doesn't really explain the -2. Or is that that we have one for
> the extra empty slot, and one for the reserved?
> 
> Jean-Philippe?

Yes, -2 is for ASID#0 and the extra empty slot. A comment higher in
asids_update_limit() hints at that, but it could definitely be clearer

        /*
         * Expect allocation after rollover to fail if we don't have at least
         * one more ASID than CPUs. ASID #0 is reserved for init_mm.
         */

Thanks,
Jean
