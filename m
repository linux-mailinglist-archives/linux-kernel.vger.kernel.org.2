Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6A536621A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 00:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbhDTWPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 18:15:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:27632 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233769AbhDTWPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 18:15:32 -0400
IronPort-SDR: urnx51ylNsxiLYT+yC3ToWfOpS4hgEN7ko+MwJoCw+FAlq7FCKdgFW95YnLa/I27QSqPtCiKa+
 OoWwvrc308MQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="175708010"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="175708010"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 15:15:00 -0700
IronPort-SDR: h5wDSolB1w+ZMJoTm6jNfO5q3L+qDyiVW84omVYgSbY2LgKuXFDX2IA3Vuwgji24q2OG3eziGe
 E8uVwYIQ74TA==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="617134670"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 15:14:59 -0700
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 9CBBB6363;
        Tue, 20 Apr 2021 15:14:59 -0700 (PDT)
Date:   Tue, 20 Apr 2021 15:14:59 -0700
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
Message-ID: <20210420221459.GA108315@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-5-mgross@linux.intel.com>
 <20210305210140.GA622142@robh.at.kernel.org>
 <20210308202008.GA138795@linux.intel.com>
 <CABb+yY3kRj2F1ao9A1_+ve5dZm0Q=tThJyu-cVo-cqMjZ+uQ2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY3kRj2F1ao9A1_+ve5dZm0Q=tThJyu-cVo-cqMjZ+uQ2g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 04:24:41PM -0500, Jassi Brar wrote:
> On Mon, Mar 8, 2021 at 2:20 PM mark gross <mgross@linux.intel.com> wrote:
> >
> > On Fri, Mar 05, 2021 at 03:01:40PM -0600, Rob Herring wrote:
> > > On Fri, Feb 12, 2021 at 02:22:34PM -0800, mgross@linux.intel.com wrote:
> > > > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > >
> > > > Add DT binding documentation for the Intel Keem Bay IPC driver, which
> > >
> > > Bindings are for h/w blocks, not drivers. From a binding perspective, I
> > > don't really care what the driver architecture for some OS looks like. I
> > > continue to not understand what this h/w looks like. A block diagram
> > > would help as would understanding what blocks have multiple clients
> > > (mailboxes and xlink in particular).
> > I'm working to gather this info.
> >
> Do I pick the mailbox related patches (and which ones exactly) ?

v6-0002-dt-bindings-mailbox-Add-Intel-VPU-IPC-mailbox-bin.patch
and 
v6-0003-mailbox-vpu-ipc-mailbox-Add-support-for-Intel-VPU.patch

--mark

