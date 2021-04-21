Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C29366D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbhDUN42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:56:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:12825 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242991AbhDUN4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:56:17 -0400
IronPort-SDR: /z5Uds6EhP9vAgs3m6iBsqqSG/IwSo0pz3bbuN7bpMSaZdy/edwh4CWm086F3Dg2ahfMnL6TF/
 OtnFjntsGLAg==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="195813564"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="195813564"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 06:55:44 -0700
IronPort-SDR: a0O7fup/fNWapIQUoQDd4Us1kG2YhvXRSlca7TFcVhV5ftYCHn7OaIP3lFVgBiOzDREuQTNjey
 nVUytfM/VGGw==
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="445941924"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 06:55:43 -0700
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id ECA1B6363;
        Wed, 21 Apr 2021 06:55:42 -0700 (PDT)
Date:   Wed, 21 Apr 2021 06:55:42 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     mgross@linux.intel.com, Rob Herring <robh@kernel.org>,
        markgross@kernel.org, "arnd@arndb.de" <arnd@arndb.de>, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Devicetree List <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 04/34] dt-bindings: Add bindings for Keem Bay IPC
 driver
Message-ID: <20210421135542.GB108315@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-5-mgross@linux.intel.com>
 <20210305210140.GA622142@robh.at.kernel.org>
 <20210308202008.GA138795@linux.intel.com>
 <CABb+yY3kRj2F1ao9A1_+ve5dZm0Q=tThJyu-cVo-cqMjZ+uQ2g@mail.gmail.com>
 <20210420221459.GA108315@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420221459.GA108315@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 03:14:59PM -0700, mark gross wrote:
> On Mon, Apr 12, 2021 at 04:24:41PM -0500, Jassi Brar wrote:
> > On Mon, Mar 8, 2021 at 2:20 PM mark gross <mgross@linux.intel.com> wrote:
> > >
> > > On Fri, Mar 05, 2021 at 03:01:40PM -0600, Rob Herring wrote:
> > > > On Fri, Feb 12, 2021 at 02:22:34PM -0800, mgross@linux.intel.com wrote:
> > > > > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > > >
> > > > > Add DT binding documentation for the Intel Keem Bay IPC driver, which
> > > >
> > > > Bindings are for h/w blocks, not drivers. From a binding perspective, I
> > > > don't really care what the driver architecture for some OS looks like. I
> > > > continue to not understand what this h/w looks like. A block diagram
> > > > would help as would understanding what blocks have multiple clients
> > > > (mailboxes and xlink in particular).
> > > I'm working to gather this info.
> > >
> > Do I pick the mailbox related patches (and which ones exactly) ?
> 
> v6-0002-dt-bindings-mailbox-Add-Intel-VPU-IPC-mailbox-bin.patch
> and 
> v6-0003-mailbox-vpu-ipc-mailbox-Add-support-for-Intel-VPU.patch
>
Sorry for the confusion and delay.  It seems there are some internal requests
to change the name of this part of the VPU driver stack to avoid possible future
namespace collisions.

We will rename the vpu-ipc-mailbox with something more specific to KMB on the
next posting.  That looks like will have to be against v5.13-rc1 at this point.
Sigh.

Thanks,

--mark
