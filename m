Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA70366D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243311AbhDUOGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243275AbhDUOGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:06:35 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20587C06174A;
        Wed, 21 Apr 2021 07:06:02 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id b17so29930495pgh.7;
        Wed, 21 Apr 2021 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExrGjDL8gxPpKOFeTQiPc8ffz5iZclXedQ5tO1PTOYg=;
        b=aC5A1sf37OefTbJlqH1QyvwaGZ6nX+ntixNNI5eAEM6ULplsp5dQkyIOiZmGMFwVwO
         iAOk/qYy1/A58AsOI9MsUD09ZlYh+tN9NUaOLqlWfNbSQmfrHLKXSP4QjfsFovXnFwou
         wfZTOR4dcKsYsLQ8im2gw65PKgADTQ0LM7GE05fe1KgVTY0EFwLAYgsg27oZ23YXVTEk
         ealN1TbcW7hFpGiuzzH4Zimn2Vdbu7eEXMKtRS/gkInCPm1Fc34O40hyZoN4bdqHG6RU
         nzsvILKn3am2aRvB8/c0P3vLuF7T5OpMGwZmIYQh8UZDn9dqwxV2czh+4K6QamFowppo
         U2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExrGjDL8gxPpKOFeTQiPc8ffz5iZclXedQ5tO1PTOYg=;
        b=HBYyUDRgxWtfcLz4aPNahffhtqHrPxU06g30Xr0CDQsCTmYYa4F611K+Rh/lRMvETX
         Sw2MqQBS3m8vsjbdVSC1b+lZ9ZTQPisgSkRLCowjSIsfXkxeuyYXX90lLf7FkOVHEbt6
         l73Piisigo9C6Qbrj+dnRtXVnBw2WtxJAXAvefvVhrK2TkHO4q2fidf4rw8YZ63g7s3d
         WV75S7ZWo8TmtD9gYM+ZY+Boa8O38J55+MTbJLowq3XqtD5zEV8d+8wbavjfULjBPJYr
         aCF4zBtD5aA7dgAiHjNOcNmkxE67AXq3SlGy5evWwLAN22Or5iGkAjBAbLcTXT6Iy4KV
         wY8w==
X-Gm-Message-State: AOAM530Tc+0qdGBusLqljOu+rkLWvDdqzKLmazAVA2YiKkCyx+bf1vVf
        QlzXQr1umfpZsEd83r7p1smLoprTX998oCH28DE=
X-Google-Smtp-Source: ABdhPJy+v5E3xERXKn2uHLsoPgtkCr9aSICbwVbN3UB0xJQkOTj9TOKzgem/PRiV3O+0DJ0Wt5KL2wC3Tz5uMj/XzRs=
X-Received: by 2002:a17:90a:ea83:: with SMTP id h3mr5159674pjz.180.1619013961677;
 Wed, 21 Apr 2021 07:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-5-mgross@linux.intel.com> <20210305210140.GA622142@robh.at.kernel.org>
 <20210308202008.GA138795@linux.intel.com> <CABb+yY3kRj2F1ao9A1_+ve5dZm0Q=tThJyu-cVo-cqMjZ+uQ2g@mail.gmail.com>
 <20210420221459.GA108315@linux.intel.com> <20210421135542.GB108315@linux.intel.com>
In-Reply-To: <20210421135542.GB108315@linux.intel.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 21 Apr 2021 09:05:51 -0500
Message-ID: <CABb+yY3F+kyvGGXN5feVPBqhuBn9L4Qr9ZhCDFotkjKFzKVofw@mail.gmail.com>
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

On Wed, Apr 21, 2021 at 8:55 AM mark gross <mgross@linux.intel.com> wrote:
>
> On Tue, Apr 20, 2021 at 03:14:59PM -0700, mark gross wrote:
> > On Mon, Apr 12, 2021 at 04:24:41PM -0500, Jassi Brar wrote:
> > > On Mon, Mar 8, 2021 at 2:20 PM mark gross <mgross@linux.intel.com> wrote:
> > > >
> > > > On Fri, Mar 05, 2021 at 03:01:40PM -0600, Rob Herring wrote:
> > > > > On Fri, Feb 12, 2021 at 02:22:34PM -0800, mgross@linux.intel.com wrote:
> > > > > > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > > > >
> > > > > > Add DT binding documentation for the Intel Keem Bay IPC driver, which
> > > > >
> > > > > Bindings are for h/w blocks, not drivers. From a binding perspective, I
> > > > > don't really care what the driver architecture for some OS looks like. I
> > > > > continue to not understand what this h/w looks like. A block diagram
> > > > > would help as would understanding what blocks have multiple clients
> > > > > (mailboxes and xlink in particular).
> > > > I'm working to gather this info.
> > > >
> > > Do I pick the mailbox related patches (and which ones exactly) ?
> >
> > v6-0002-dt-bindings-mailbox-Add-Intel-VPU-IPC-mailbox-bin.patch
> > and
> > v6-0003-mailbox-vpu-ipc-mailbox-Add-support-for-Intel-VPU.patch
> >
> Sorry for the confusion and delay.  It seems there are some internal requests
> to change the name of this part of the VPU driver stack to avoid possible future
> namespace collisions.
>
> We will rename the vpu-ipc-mailbox with something more specific to KMB on the
> next posting.  That looks like will have to be against v5.13-rc1 at this point.
> Sigh.
>
Ok, I will dequeue the patches.

-j
