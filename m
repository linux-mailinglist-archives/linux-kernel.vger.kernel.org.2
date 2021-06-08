Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A706339EF03
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhFHG4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:56:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:49866 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhFHG4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:56:02 -0400
IronPort-SDR: vMW+UB9Ue7wEWTDXi5Yp5feF8nm2PW8OlB6A97Tqc3uj03GNN9cbh0PDnZLGB49eAmBQ2av7BK
 D2N1/HfUk5mg==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265935166"
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="scan'208";a="265935166"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 23:54:09 -0700
IronPort-SDR: maRWrmr4eAl9j4yK/dNJ7RZrD+zeMCLt6Sj/28SnCBQ/6FdHVbeu6IuxAg+5lZG/4rlqqaRFPr
 T0xbo63sVbKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="scan'208";a="552162586"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Jun 2021 23:54:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 08 Jun 2021 09:54:07 +0300
Date:   Tue, 8 Jun 2021 09:54:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benjamin Berg <bberg@redhat.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] usb: typec: ucsi: Polling the alt modes and PDOs
Message-ID: <YL8UD+nlBSSQGIMO@kuha.fi.intel.com>
References: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
 <4a76d2152f016b58298bec16aa2003a6ec55f8a8.camel@redhat.com>
 <YL8RPiVsEFOM9PBo@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL8RPiVsEFOM9PBo@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 09:42:09AM +0300, Heikki Krogerus wrote:
> On Mon, Jun 07, 2021 at 10:09:58PM +0200, Benjamin Berg wrote:
> > Hi Heikki,
> > 
> > On Mon, 2021-06-07 at 16:14 +0300, Heikki Krogerus wrote:
> > > This is the RFC series I promised [1].
> > 
> > Cool.
> > 
> > > I'm sorry it took this long to prepare these. I had to concentrate on
> > > other task for a while.
> > > 
> > > Let me know if you still see any problems.
> > 
> > Hmm, I am not sure this got better. I applied the patchset on top of of
> > the 5.12.9 Fedora 34 kernel. On the machine in question (X1 Carbon 8),
> > I see the online state getting stuck at 1 occasionally. This can happen
> > for example when quickly plugging and unplugging a USB-C charger.
> 
> Please check does the partner device get removed. What do you have
> under /sys/class/typec after that happens?

Oh yes. Could you also share the trace output when that happens?

        cd /sys/kernel/debug/tracing
        echo 1 > events/ucsi/enable
        # now reproduce the issue
        cat trace > ucsi.trace

thanks,

-- 
heikki
