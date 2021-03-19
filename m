Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C263417B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhCSIrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbhCSIqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:46:51 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0169C06174A;
        Fri, 19 Mar 2021 01:46:51 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso7820762otq.3;
        Fri, 19 Mar 2021 01:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nlniv6NhjsX22J8Q1FhSg42awk/KHioL1/VS4RfBXc=;
        b=EBBKPk5/oWfch+5vb4X5lTZDAvqrabwKM/DR8s8xYJJs8B0bEwI9A2TbLFgiQbuPVL
         uh9XcfPp0yObv9mIqDxuQhJgFKz8m+Bboc3pPNSERFV4EL8IGco2mLPm/A+GTm28W248
         JIqF1FikLnBdIQV1DtgVS98gyxuC1zhEU+smszAMhEd+mdfHNIpqVLOGD7rmKAGkyyi4
         7olmgkJn6O9CkQLFAFP8+Y0JiKjtSIJDD5dinqeedtb7BztuNrQDSiwTJedH2WszQcV9
         D4X0z+AMs9hicptJSRoHatiW3WlQ329B18y5u/7nBcrD/m4cN+oaYb9gGOzlVZUt2Zkz
         183w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nlniv6NhjsX22J8Q1FhSg42awk/KHioL1/VS4RfBXc=;
        b=n7lhlB8BvV4BC+ygH9Py3SSRejvif6BK/2n53bLJ2aIBfgU6gs/qF3aiQsDRdvZPbO
         HVafMbHETzVHhV2hsg9loSWUTqFJgsoEItoPCpon3N5wym/19pKCamvt1eHaJ2Ge9ueV
         en0spW0XM8SK2VCIAhmDbVWB7EjpoGxZ60teLtrTqn6sFcq37YU3qrovB4lA/QF2aWDQ
         4NAdaHBUH7PRNrvXcDfTMCZElz1PJK4G90pk16ZFKUoiqlVdgb/54xI/1/wHHx3zP2Pc
         5/Z1Y/TiMobbQOhpONyYr8cwLnBz5I4dopfLMdicmSkw7Fd7XBIB21OHtZmfIyiIOP6Y
         dvmA==
X-Gm-Message-State: AOAM533WZu+U3Fc4S7dMufxe59BRUA2YxrEqErxWqWDCGYRGSC4SZyR8
        m506ABtsAnJ+vZCnsiv/7mi0yoya4drrMezSuXC83ITOOFSWgw==
X-Google-Smtp-Source: ABdhPJyDbMzCjB684c2K90H8QTTyo/y47GPwAG/TI8SPIje3RrYh0GEdkIkLrgR7Fgy0lZRuZLpeSjPWfRxXle8bOns=
X-Received: by 2002:a05:6830:8f:: with SMTP id a15mr211558oto.299.1616143611072;
 Fri, 19 Mar 2021 01:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201209094916.17383-1-zong.li@sifive.com> <87v99qyjaz.fsf@igel.home>
 <CANXhq0oLxFK1431WmTj5HRO5k_omYkQZCBTG+HORTk9=W_XyNg@mail.gmail.com> <CANXhq0p90Cgha_zLzxamK9mxmVPn3effh_cZq_CTLrcAkKZg2Q@mail.gmail.com>
In-Reply-To: <CANXhq0p90Cgha_zLzxamK9mxmVPn3effh_cZq_CTLrcAkKZg2Q@mail.gmail.com>
From:   Yixun Lan <yixun.lan@gmail.com>
Date:   Fri, 19 Mar 2021 08:44:00 +0000
Message-ID: <CALecT5iX+Taf=uKy_RoyC9f9BjeSSVgSwF-8U-51N=0PbXwZyw@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] clk: add driver for the SiFive FU740
To:     Zong Li <zong.li@sifive.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Pragnesh Patel <pragnesh.patel@openfive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Zong, Andreas:

On Fri, Mar 19, 2021 at 8:21 AM Zong Li <zong.li@sifive.com> wrote:
>
> On Thu, Mar 18, 2021 at 10:07 AM Zong Li <zong.li@sifive.com> wrote:
> >
> > On Wed, Mar 17, 2021 at 3:45 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
> > >
> > > On Dez 09 2020, Zong Li wrote:
> > >
> > > > Add a driver for the SiFive FU740 PRCI IP block, which handles more
> > > > clocks than FU540. These patches also refactor the original
> > > > implementation by spliting the dependent-code of fu540 and fu740
> > > > respectively.
> > >
> > > That breaks ethernet on the fu540.
> > >
> >
> > I would check that, thanks for the report.
> >
>
> Hi Andreas,
>
> Could you please point me out how to test the ethernet from your side?
> I had tried to quick test by using iperf and wget, the ethernet seems
> to work fine to me.
>
I will give it a shot during this weekend, since I'm facing the same issue..

Yixun Lan
