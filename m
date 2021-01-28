Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36943080B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhA1VoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:44:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:19637 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231518AbhA1VoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:44:16 -0500
IronPort-SDR: T4YLh/pPbsKU/JthR6iCZSnBxEqiqrPpCTgwgQ+7II+t2VvToybRuavpnnzNhK6YF1wtaCEMjb
 bOqh65xzKpXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="159491972"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="159491972"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 13:42:24 -0800
IronPort-SDR: 3ehf94+IEdgQKZpuhrwd3EjvC56IZt65jJBEpJGBH7jWKPKway5hvvmHqFUygW8tAkKqNwTrZS
 2GgUbE5Dt/+A==
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="351924899"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 13:42:23 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 53BB46365;
        Thu, 28 Jan 2021 13:42:23 -0800 (PST)
Date:   Thu, 28 Jan 2021 13:42:23 -0800
From:   mark gross <mgross@linux.intel.com>
To:     "Gross, Mark" <mark.gross@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>
Subject: Re: [PATCH v3 02/34] dt-bindings: mailbox: Add Intel VPU IPC mailbox
 bindings
Message-ID: <20210128214223.GD71197@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210126054036.61587-1-mgross@linux.intel.com>
 <20210126054036.61587-3-mgross@linux.intel.com>
 <CAL_Jsq+h9gaZuqKRyh2UqRq5FvBGEoeBLn=xF+K8Zu8Cn9norQ@mail.gmail.com>
 <MWHPR11MB16792D061568C6FA30FA9B908EBC9@MWHPR11MB1679.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB16792D061568C6FA30FA9B908EBC9@MWHPR11MB1679.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 02:47:15PM +0000, Gross, Mark wrote:
> 
> 
> > -----Original Message-----
> > From: Rob Herring <robh+dt@kernel.org>
> > Sent: Tuesday, January 26, 2021 5:45 AM
> > To: Mark Gross <mgross@linux.intel.com>
> > Cc: markgross@kernel.org; Arnd Bergmann <arnd@arndb.de>; Borislav Petkov
> > <bp@suse.de>; Damien Le Moal <damien.lemoal@wdc.com>; Dragan Cvetic
> > <dragan.cvetic@xilinx.com>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; Jonathan Corbet <corbet@lwn.net>; Palmer
> > Dabbelt <palmerdabbelt@google.com>; Paul Walmsley
> > <paul.walmsley@sifive.com>; Peng Fan <peng.fan@nxp.com>; Shawn Guo
> > <shawnguo@kernel.org>; Jassi Brar <jassisinghbrar@gmail.com>; linux-
> > kernel@vger.kernel.org; Alessandrelli, Daniele
> > <daniele.alessandrelli@intel.com>
> > Subject: Re: [PATCH v3 02/34] dt-bindings: mailbox: Add Intel VPU IPC mailbox
> > bindings
> > 
> > On Mon, Jan 25, 2021 at 11:40 PM <mgross@linux.intel.com> wrote:
> > >
> > > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > >
> > > Add bindings for the Intel VPU IPC mailbox driver.
> > 
> > Sigh. DT list please so it's in my queue and automated checks run.
> I'm sorry about that.  
> Quick question, should I include the DT-list on just the patches with DT yaml or all of the series as its got DT content?

Fixed. 

--mark

> 
> --mark
> 
> 
> > 
> > > Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > ---
> > >  .../mailbox/intel,vpu-ipc-mailbox.yaml        | 69 +++++++++++++++++++
> > >  MAINTAINERS                                   |  6 ++
> > >  2 files changed, 75 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
> > > b/Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
