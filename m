Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA235D296
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 23:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbhDLVZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 17:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhDLVZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 17:25:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97DDC061574;
        Mon, 12 Apr 2021 14:24:52 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id b17so10390204pgh.7;
        Mon, 12 Apr 2021 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPYHn6SoT76CwnEfuJiXdLvt5dm5XY4Tt5lyyt5vt4w=;
        b=qV/IEh+ZvH3L1nnBL9wgx3VQicsPPp6Esz78OZOadwMl9cgeUrFS9HYfFL6dwFQaie
         MhdHJRqGhWCJuRl7lqzIogbJpkW8goXzXFf01FiieZiisCFaizq8PjAUNjkHEFIy5DD2
         OO7nDu7r29beu7k+qnWiT2DREcXunKYwt2osM90t+NvmYmw/ZmRzdU8yRqlaNRIO2Bm+
         0Kukge5SSPEZnavngl4G59g4+ZaXIXI4YY48JHw2zycGZvHlsEXsW/Pu61J7T+5r9t3L
         JBY06h58EdEs4V/IPQI4MTXO9A9YPeNTAuoiZPwmjqgY0e79XolJZwT4DzeBgTElY0Mo
         285Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPYHn6SoT76CwnEfuJiXdLvt5dm5XY4Tt5lyyt5vt4w=;
        b=goR0Bkm/fBhH/N0Bt8kndxfum7XaKjbP1EH+yelryNmcGfRifIYYbmqMUCxUqLqYKY
         lVDOyhYs5bzXS3JZ2AlSthrw3joUjtDWMNR60hylfHsaQHIQkz7DzMbOXCV1JDRwuNW2
         nMTXndTmgq0hBtLcyr+7h4rDjvkfpoVXMZ/YxA7BGSuNkWdtbNR9c8HuNqNRcBfAi3u+
         njh/E/vf+jRBgb+XGzEdBBkHlaSoA45aiM42h7LfJZqyxrpQOZEVS0ng8pvZ26ZpqeKW
         E9H2bWhreQmTtRpCeCRE/f5AXvdIi/ERjW+H/re1/W6qBO1pd1Y2ZAA29HpB/RCVqZmt
         sp6g==
X-Gm-Message-State: AOAM532zy4q+1KaagVoh7RcCW2QassjIMlLNjB4kuZy8W/KRv19h03lV
        KcukrIxKD5N1v4T7s0k6/iknY4bxTm/21QZ/sGA=
X-Google-Smtp-Source: ABdhPJyF5y7spTxqV3x57uu/69DBsM/7qBumstsLy8e5p46pfBx/40I9Dj8ryjWQPvK8CyBIHlPjKiEPhBtFYXJWN2s=
X-Received: by 2002:a63:d815:: with SMTP id b21mr28907903pgh.217.1618262692310;
 Mon, 12 Apr 2021 14:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-5-mgross@linux.intel.com> <20210305210140.GA622142@robh.at.kernel.org>
 <20210308202008.GA138795@linux.intel.com>
In-Reply-To: <20210308202008.GA138795@linux.intel.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 12 Apr 2021 16:24:41 -0500
Message-ID: <CABb+yY3kRj2F1ao9A1_+ve5dZm0Q=tThJyu-cVo-cqMjZ+uQ2g@mail.gmail.com>
Subject: Re: [PATCH v6 04/34] dt-bindings: Add bindings for Keem Bay IPC driver
To:     mgross@linux.intel.com
Cc:     Rob Herring <robh@kernel.org>, markgross@kernel.org,
        "arnd@arndb.de" <arnd@arndb.de>, bp@suse.de, damien.lemoal@wdc.com,
        dragan.cvetic@xilinx.com, Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Devicetree List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 2:20 PM mark gross <mgross@linux.intel.com> wrote:
>
> On Fri, Mar 05, 2021 at 03:01:40PM -0600, Rob Herring wrote:
> > On Fri, Feb 12, 2021 at 02:22:34PM -0800, mgross@linux.intel.com wrote:
> > > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > >
> > > Add DT binding documentation for the Intel Keem Bay IPC driver, which
> >
> > Bindings are for h/w blocks, not drivers. From a binding perspective, I
> > don't really care what the driver architecture for some OS looks like. I
> > continue to not understand what this h/w looks like. A block diagram
> > would help as would understanding what blocks have multiple clients
> > (mailboxes and xlink in particular).
> I'm working to gather this info.
>
Do I pick the mailbox related patches (and which ones exactly) ?

thanks.
