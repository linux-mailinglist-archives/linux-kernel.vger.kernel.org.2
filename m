Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE0D33DCAC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbhCPSiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbhCPSh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:37:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FE6C06174A;
        Tue, 16 Mar 2021 11:37:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dx17so73915410ejb.2;
        Tue, 16 Mar 2021 11:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YKhM0XlAMOLzACqYYkiuA73dVilEbBHwLHGpYjZZuLA=;
        b=LMwP2wyE/NPvLsJ8SINLONbIhkEUHlaQEZLTZykYVn0JYGGzcjfHvWsuRGO4IMYKwj
         NBW5x249A3uyCyf1PGfYId+o1cj5q+YVEY7K819nBVYgrY7NEBj4EI0Z64vw5f8A0Brb
         kkHyXyjx+YCo3gdp1MpbYab1bH2uLnwUSSEKhu+hv//uoTPYfR6Akq2ZuTRNSXROfrZs
         Glxouse4umV8swnd/4knJlh6g4XG9JrETLK1X81Ix8CusVuN1aUyGGRjWeQCwiUVPuAc
         9x0+fNib/uHpqm4D67n1hTE2WnMK1YaxsnDXLPZVm1+7rDAz76BA8F8VSpB07DBxtzDX
         aU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YKhM0XlAMOLzACqYYkiuA73dVilEbBHwLHGpYjZZuLA=;
        b=nj8jpW6ArGyZhZpyCBjypaniW1FgZJwrFlxrXpy1gCjhHDKV7OmU4Nwx5odUtpO7YH
         EySTFFULaY+EotDg5kUNR9ZjiwLRCCJ6xa/vzCTPonsWMRtzBOaM1UkMeMM8kPzgjVKT
         siNUaaU+wUNQFiEnFmoeFjN+JFigiE/jIUABED88SfOeLhd3u8gDs8hFc8asnNFxW5Oc
         VmBqcuJNdBQSjar4mhhnhzTZfnn/wKx5WjKxqLKkla1bccsHqjdo0GiS+v+pf6FVzto7
         tnb9L+RkP4JGYNeHCC5j7vwLhxyNeti/lvTznt1X16Zprn0oNqL2XDPsRTAxlgrwEZwF
         KMGg==
X-Gm-Message-State: AOAM5338usnsbypen40UqvhbOm4YHz2cPKi8lzdvTUEPvP6DQplNaNdr
        nHcZkVLg0CGr+oigEsFW8Ln49pMZkhI=
X-Google-Smtp-Source: ABdhPJxE3Bx8oGOnSfAhjX7BzEscKYYvdLAVXmnu+5BzLmusb25sZLXK+EijAXmBWgIBd3RdtLLQjQ==
X-Received: by 2002:a17:906:ef2:: with SMTP id x18mr31817161eji.323.1615919876457;
        Tue, 16 Mar 2021 11:37:56 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id g11sm7412527edw.37.2021.03.16.11.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:37:55 -0700 (PDT)
Date:   Tue, 16 Mar 2021 20:37:53 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/6] clk: actions: Fix bisp_factor_table based clocks on
 Owl S500 SoC
Message-ID: <20210316183753.GC1111731@BV030612LT>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
 <13576ddb604a9097603d95cd2605275c20fb2f56.1615221459.git.cristian.ciocaltea@gmail.com>
 <20210316041739.GC1798@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316041739.GC1798@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 09:47:39AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 08, 2021 at 07:18:28PM +0200, Cristian Ciocaltea wrote:
> > The following clocks of the Actions Semi Owl S500 SoC have been defined
> > to use a shared clock factor table 'bisp_factor_table[]': DE[1-2], VCE,
> > VDE, BISP, SENSOR[0-1]
> > 
> > There are several issues involved in this approach:
> > 
> > * 'bisp_factor_table[]' describes the configuration of a regular 8-rates
> >   divider, so its usage is redundant. Additionally, judging by the BISP
> >   clock context, it is incomplete since it maps only 8 out of 12
> >   possible entries.
> > 
> > * The clocks mentioned above are not identical in terms of the available
> >   rates, therefore cannot rely on the same factor table. Specifically,
> >   BISP and SENSOR* are standard 12-rate dividers so their configuration
> >   should rely on a proper clock div table, while VCE and VDE require a
> >   factor table that is a actually a subset of the one needed for DE[1-2]
> >   clocks.
> > 
> > Let's fix this by implementing the following:
> > 
> > * Add new factor tables 'de_factor_table' and 'hde_factor_table' to
> >   properly handle DE[1-2], VCE and VDE clocks.
> > 
> > * Add a common div table 'std12rate_div_table' for BISP and SENSOR[0-1]
> >   clocks converted to OWL_COMP_DIV.
> > 
> > * Drop the now unused 'bisp_factor_table[]'.
> > 
> 
> Nice!
> 
> > Additionally, since SENSOR[0-1] are not gated, unset the OWL_GATE_HW
> > configuration and drop the CLK_IGNORE_UNUSED flag in their definitions.
> > 
> 
> No. You should not screen the functionality exposed by the hw, that's what the
> purpose of these CLK_ flags.

I'm not sure I get this, or maybe I wasn't clear enough with my
explanation regarding the changes to SENSOR clocks: they are not gated
in hardware, hence the statement 'OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0)' 
was invalid and I replaced it with '{ 0 }'.

Additionally, I assumed the 'CLK_IGNORE_UNUSED' flag makes sense only
for the gated clocks. Do I miss something?

> Other than that, this patch looks good to me.

Thanks,
Cristi

[...]
