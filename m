Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCDD3D3530
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhGWGm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhGWGm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:42:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6140EC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:23:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m1so986196pjv.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dccwzm0JUzZfAJpe+VU8zCtj99qVQ/WnWSS+WqLNfXc=;
        b=cJCXGMp8MI+6mMbvnEnN7tpaXHLuE5vChILj5btQ3jW/cK0Zpgduooa5G13HjLtbmC
         ehUUr7sBMeXBIV2NdtIGfXLn8G2munVGIT+CKukcHagjnB8pAE8Jo0lYqjThD9jwaziN
         moSL5g86ag5nAublBJb8iVC7YvfFB+Ig9U5uxRB/OWCe4sN4Ux01X0RLyXS9iKsOyw4z
         /uvEJ2q///1dY6Q8L+fbDAy+6aveoLMLZIM697/bJ1RaN75OjLfYtGYXJg5xFiLXWdMH
         E4lkJffCLsyxS2ecp8UsskwUTnl9tgqGEwdQb5Thr3JoJYuIzs4tzPmo9+1YRsHMpib0
         34Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dccwzm0JUzZfAJpe+VU8zCtj99qVQ/WnWSS+WqLNfXc=;
        b=e6+JZwUqFH31FIwV6qQbyQ7mwWZHI9VATKQMQSt5U+qfDXC68YqCYC2YBsJ/l5y0FW
         yZ8frBge06EZxnCdA5yWIMFIk4Y8rRabguyM1r8+ho8AmVYo4Tx9pOHCgLI9OBj+vVy0
         5cen5duh/0zT2Y3up0eWb7IYObqu+3RWWJwTYiCNaSdCZ21Q6/rlAQ3Y3HUuhrDaxf63
         OC0QVE5/AcUTCCQDq+jsuW2E9Iqfto/gghMFNXlMn0Ngm5OAaHrBKxrBR+N5yxYurvob
         NsiUWZLyg9FO1R1o7Mn2tNzazg9HGPc2PqTkFusX71PYvei/kWZcKyAv47t0MaUW/Mth
         fMFg==
X-Gm-Message-State: AOAM5322eLOBgEBahxl65ltiw7QSu8g8c+DXGggo8nATbuUjRwnBLuPt
        Kfi9jKAd0ix0Zbv7K2iU3A9usw==
X-Google-Smtp-Source: ABdhPJzNtFnnoe4/UhTqBiAsl2EgKRySlzbbMT3VPGBJcvrUM/u8D8/ITGSWh9WufLdYvuhu0nrlHw==
X-Received: by 2002:a63:78d:: with SMTP id 135mr3678920pgh.116.1627025009837;
        Fri, 23 Jul 2021 00:23:29 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id x26sm33678743pfj.71.2021.07.23.00.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 00:23:29 -0700 (PDT)
Date:   Fri, 23 Jul 2021 15:23:22 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 11/11] perf auxtrace: Add
 compat_auxtrace_mmap__{read_head|write_tail}
Message-ID: <20210723072322.GG179035@leoy-ThinkPad-X240s>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-12-leo.yan@linaro.org>
 <20210712144410.GE22278@shell.armlinux.org.uk>
 <20210713154602.GD748506@leoy-ThinkPad-X240s>
 <20210713161441.GK22278@shell.armlinux.org.uk>
 <20210713181301.GE13181@arm.com>
 <20210714084015.GM22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714084015.GM22278@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 09:40:15AM +0100, Russell King (Oracle) wrote:
> On Tue, Jul 13, 2021 at 07:13:02PM +0100, Catalin Marinas wrote:
> > We could try to clarify E2.2.1 to simply state that naturally aligned
> > LDRD/STRD are single-copy atomic without any subsequent statement on the
> > translation table.
> 
> I think that clarification would be most helpful. Thanks.

Thanks for the suggestion and confirmation, Russell & Catalin.

If so, I will implement the weak functions for
compat_auxtrace_mmap__{read_head|write_tail}; and write the arm/arm64
specific functions with using LDRD/STRD instructions.

For better patches organization, I will use a separate patch set for
enabling the compat functions (in particular patches 10, 11/11) in
the next spin.

Thanks,
Leo
