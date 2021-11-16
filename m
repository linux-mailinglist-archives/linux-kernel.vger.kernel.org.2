Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487704532E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 14:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbhKPNeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 08:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhKPNeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:34:09 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED65C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 05:31:12 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m27so28870008lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 05:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6w8VaI/PiDfTYegVO1oWxg3pmOTSJ6mZB11N7Q/L87U=;
        b=Zfe3n+PLtCgjPHseWmFl7HS0YSUYTWQMyGsCyeGsUSY2Blxc4iLjokDgzeiYMPnyVO
         aq1xkXQpf4KvOxptDQUuqpwa+G3Sxkr/lDcUnnQGm7guRckXwLyW9PihhZ6Wz2pef+fo
         WbZbLnuiPcK3MCOb5k1e/2KIGaG1SfW/6UQrWjd/fnaMEHfzlZQTUa1dNGE1FzPnI3gm
         EPHdvt9IDdAsoBAmaBCugKLiEUaycdBwH9nWZY391VggybGpJNU2wdk4bN6mK8qsal+4
         0cYTaKzWIlRZmrBngUk1deGsvwoMMEhgWyCRjMcBbhHTy8AsNR8k6Gzyti/ThlOsPRm1
         bBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6w8VaI/PiDfTYegVO1oWxg3pmOTSJ6mZB11N7Q/L87U=;
        b=H306x7o69WnH+Y1/BnFS+O/2QyWLbGCpZqudRPkjcGn2V+9+nES2zpWuLMAWPQ0gjG
         T++PH0nafeYuls4EoF4NngO1Zl5OsH9TsTC5ucw7ztY9IOt3wVsnaEPGzrWpUdlpiVJG
         7lvUWjiJdggRcAoObRPnZ3ZKfU+u0RigPHfbsvxmTIxJL5V/mZOLccsxxkofShvgESXg
         gq2qfKsP2VBLpYvA0tpa+X/CFxu6hxs/U7tMqGBSkuoHENNAvr6foTrgNs7Z8zTmsOve
         Xkqkcol02osF6WVYsOBsx8w7VEvztFXC8GPBYo4OD9dMFr1WIHJekLvYz8A78BqTqbRb
         JIvw==
X-Gm-Message-State: AOAM531Mly+2kBQlz3T/ATttVa+BHoxvWXCvAOxiEVIBnjgUN7zC0+b4
        3CcjrW/Mh+IfkQ5Y81un8XkbmdDs7EdwBXZOh0li24vuluM=
X-Google-Smtp-Source: ABdhPJyHryvttWooT/QxextSBvEcn54hqeWVVtoJq0GPtDdTkvjxRMCrcySwIcz642RdbvjAagZyJR6GXYM9EU0mDSY=
X-Received: by 2002:a05:6512:2350:: with SMTP id p16mr6576462lfu.117.1637069470279;
 Tue, 16 Nov 2021 05:31:10 -0800 (PST)
MIME-Version: 1.0
References: <202111120534.jZEya5QR-lkp@intel.com> <CA+_ehUyjDVdEe=64WbBihqSQrHeKSHx_8C3pcHctgvWy4dvnJQ@mail.gmail.com>
 <20211116063058.GH27562@kadam>
In-Reply-To: <20211116063058.GH27562@kadam>
From:   Ansuel Smith <ansuelsmth@gmail.com>
Date:   Tue, 16 Nov 2021 14:30:59 +0100
Message-ID: <CA+_ehUwbUYc6GBGx1VFfqknWrFTk=Xm7NmMUhbyxMSBE4KdnjQ@mail.gmail.com>
Subject: Re: drivers/net/dsa/qca8k.c:944 qca8k_parse_port_config() error:
 testing array offset 'cpu_port_index' after use.
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Nov 15, 2021 at 07:08:30PM +0100, Ansuel Smith wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> > > head:   debe436e77c72fcee804fb867f275e6d31aa999c
> > > commit: 5654ec78dd7e64b1e04777b24007344329e6a63b net: dsa: qca8k: rework rgmii delay logic and scan for cpu port 6
> > > config: i386-randconfig-m021-20211025 (attached as .config)
> > > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > >
> >
> > This should already be fixed by 06dd34a628ae5b6a839b757e746de165d6789ca8
> > Can you confirm this?
> >
>
> No, it doesn't fix the problem.  The check is either useless and should
> be removed or there is an out of bounds bug.  Checking for an out of
> bounds *after* you've already written to the memory is *never* useful.
>
> regards,
> dan carpenter
>

Again sorry if I insist and I'm 99% missing something.
There was an out of bounds bug.
It was fixed by 06dd34a628ae5b6a839b757e746de165d6789ca8 by
starting the counter to -1.
The extra check is useless, yes.

> > > smatch warnings:
> > > drivers/net/dsa/qca8k.c:944 qca8k_parse_port_config() error: testing array offset 'cpu_port_index' after use.
> > >
> > > vim +/cpu_port_index +944 drivers/net/dsa/qca8k.c
> > >
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   934  static int
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   935  qca8k_parse_port_config(struct qca8k_priv *priv)
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   936  {
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   937    int port, cpu_port_index = 0, ret;
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   938    struct device_node *port_dn;
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   939    phy_interface_t mode;
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   940    struct dsa_port *dp;
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   941    u32 delay;
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   942
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   943    /* We have 2 CPU port. Check them */
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14  @944    for (port = 0; port < QCA8K_NUM_PORTS && cpu_port_index < QCA8K_NUM_CPU_PORTS; port++) {
> > >                                                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > Assume cpu_port_index = QCA8K_NUM_CPU_PORTS - 1;
> > >
> > >
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   945            /* Skip every other port */
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   946            if (port != 0 && port != 6)
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   947                    continue;
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   948
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   949            dp = dsa_to_port(priv->ds, port);
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   950            port_dn = dp->dn;
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   951            cpu_port_index++;
> > >                                                         ^^^^^^^^^^^^^^^^^
> > > cpu_port_index is now out of bounds.
> > >
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   952
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   953            if (!of_device_is_available(port_dn))
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   954                    continue;
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   955
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   956            ret = of_get_phy_mode(port_dn, &mode);
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   957            if (ret)
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   958                    continue;
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   959
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   960            switch (mode) {
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   961            case PHY_INTERFACE_MODE_RGMII:
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   962            case PHY_INTERFACE_MODE_RGMII_ID:
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   963            case PHY_INTERFACE_MODE_RGMII_TXID:
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   964            case PHY_INTERFACE_MODE_RGMII_RXID:
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   965                    delay = 0;
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   966
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   967                    if (!of_property_read_u32(port_dn, "tx-internal-delay-ps", &delay))
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   968                            /* Switch regs accept value in ns, convert ps to ns */
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   969                            delay = delay / 1000;
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   970                    else if (mode == PHY_INTERFACE_MODE_RGMII_ID ||
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   971                             mode == PHY_INTERFACE_MODE_RGMII_TXID)
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   972                            delay = 1;
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   973
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   974                    if (delay > QCA8K_MAX_DELAY) {
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   975                            dev_err(priv->dev, "rgmii tx delay is limited to a max value of 3ns, setting to the max value");
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   976                            delay = 3;
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   977                    }
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   978
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   979                    priv->rgmii_tx_delay[cpu_port_index] = delay;
> > >                                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > Out of bounds
> > >
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   980
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   981                    delay = 0;
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   982
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   983                    if (!of_property_read_u32(port_dn, "rx-internal-delay-ps", &delay))
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   984                            /* Switch regs accept value in ns, convert ps to ns */
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   985                            delay = delay / 1000;
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   986                    else if (mode == PHY_INTERFACE_MODE_RGMII_ID ||
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   987                             mode == PHY_INTERFACE_MODE_RGMII_RXID)
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   988                            delay = 2;
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   989
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   990                    if (delay > QCA8K_MAX_DELAY) {
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   991                            dev_err(priv->dev, "rgmii rx delay is limited to a max value of 3ns, setting to the max value");
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   992                            delay = 3;
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   993                    }
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   994
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   995                    priv->rgmii_rx_delay[cpu_port_index] = delay;
> > >                                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > Out of bounds
> > >
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   996
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   997                    break;
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14   998            case PHY_INTERFACE_MODE_SGMII:
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14   999                    if (of_property_read_bool(port_dn, "qca,sgmii-txclk-falling-edge"))
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1000                            priv->sgmii_tx_clk_falling_edge = true;
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1001
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1002                    if (of_property_read_bool(port_dn, "qca,sgmii-rxclk-falling-edge"))
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1003                            priv->sgmii_rx_clk_falling_edge = true;
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14  1004
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14  1005                    break;
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14  1006            default:
> > > 5654ec78dd7e64 Ansuel Smith 2021-10-14  1007                    continue;
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1008            }
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1009    }
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1010
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1011    return 0;
> > > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1012  }
> > >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > >
