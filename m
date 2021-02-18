Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8331F273
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhBRWmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:42:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:30060 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhBRWl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:41:59 -0500
IronPort-SDR: 2LxtBTzaanOxnVzxYi2Csj7Cc6oj1qNMr5XflbzPlG5oEO1cXthnuee5pdR3WnbdqLkJPF1WNq
 rFwoyciTjHxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="183795632"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="183795632"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 14:40:13 -0800
IronPort-SDR: mc6JN6ROJoj+0dVv6lfqxO01dy5p7T3HGwym7aEtBvygoS4w2OEMQ4EO/hU9ECxoi4tXeuKh+D
 6u/4wXmx7U8g==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="386263740"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 14:40:12 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 8F77E6365;
        Thu, 18 Feb 2021 14:40:12 -0800 (PST)
Date:   Thu, 18 Feb 2021 14:40:12 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "bp@suse.de" <bp@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 03/34] mailbox: vpu-ipc-mailbox: Add support for Intel
 VPU IPC mailbox
Message-ID: <20210218224011.GA134379@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-4-mgross@linux.intel.com>
 <CABb+yY1MLxArMY7g7HY06Tn5aABwpmUuXN9KddHZpW-_Mmu2iA@mail.gmail.com>
 <ffc9713e441389d19e7221ad4d16b938fa412361.camel@intel.com>
 <CABb+yY2kxCjHqbBbgcPShyMA-xtcJEpzGXxqnjDAoufhidX-LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY2kxCjHqbBbgcPShyMA-xtcJEpzGXxqnjDAoufhidX-LQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 03:09:55PM -0600, Jassi Brar wrote:
> On Thu, Feb 18, 2021 at 6:02 AM Alessandrelli, Daniele
> <daniele.alessandrelli@intel.com> wrote:
> >
> > Hi Jassi,
> >
> > Thank you very much for your feedback.
> >
> > On Sun, 2021-02-14 at 22:54 -0600, Jassi Brar wrote:
> > > IIUIC, maybe the solution is simpler .... What if we set txdone_poll.
> > > Always return success in send_data(). And check if we overflew the
> > > fifo in last_tx_done(). If we did overflow, try to rewrite the data
> > > and check again. Return true, if not overflew this time, otherwise
> > > return false so that mailbox api can ask us to try again in next
> > > last_tx_done(). This way we can do away with the tasklet and, more
> > > importantly, avoid send_data() failures and retries on clients' part.
> >
> > That's a clever solution to avoid the tasklet. The only issue for us is
> > the automatic TX retry from the controller. I understand that's
> > generally a desirable feature, but in our case we'd like the client to
> > have full control on re-transmission attempts.
> >
> > That's because some of our data is time-sensitive. For instance, when
> > we process frames from a video stream we prefer dropping a frame rather
> > than re-transmitting it and delaying the processing of the rest.
> >
> > Now, I understand that the client can set the 'tx_block' and 'tx_tout'
> > channel fields to specify how long it wishes to wait, but the problem
> > is that our (single) channel is shared between multiple applications
> > having different timing requirements. That's why we prefer to let
> > applications deal we re-transmissions.
> >
> > Given the above, do you think it's reasonable to leave the
> > implementation as it is now?
> > (from initial analysis, the tasklet doesn't seem to affect the
> > performance of our use cases significantly, so we are fine with it)
> >
> Yup. It is intel specific so, hopefully, we don't have to deal with
> other vendors trying to support their use cases.
> Are you targeting the next merge window or this one?
>

Its a bit late for the v5.12 merge window for most of the code in this patchset
at this point but, if you feel like getting this inital bit in that would be
great.

I'm hoping we can get the rest of this series into linux-next after RC1.

--mark
