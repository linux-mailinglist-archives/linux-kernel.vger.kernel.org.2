Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE2439D910
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhFGJvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:51:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:25209 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhFGJu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:50:59 -0400
IronPort-SDR: Ns6ajJIjS0FFDZaLfcF5xdKHdkP5VqmaAhkrn/vwlPq+9f+x+ouCFkQQDGkp8aYI4+PzQjnUte
 iXGAHVBLey+w==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="191701338"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="191701338"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 02:49:08 -0700
IronPort-SDR: /DDeSmzHEeVlnfExAoUBsyqug8slfVvyhlHy+ZS3qofr5uZ25vujAuZDMufEdUxYz3dQSfW2S2
 G79u34FBygQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="551822369"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Jun 2021 02:49:06 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 07 Jun 2021 12:49:05 +0300
Date:   Mon, 7 Jun 2021 12:49:05 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] usb: typec: intel_pmc_mux: Put fwnode in error
 case during ->probe()
Message-ID: <YL3rkZd/2giR+Qok@kuha.fi.intel.com>
References: <20210606200911.32076-1-andy.shevchenko@gmail.com>
 <YL3lomK79iIuE13f@kuha.fi.intel.com>
 <CAHp75Ve5Kq4Wn0f2AxcyK3gP8Qs1s5fWvyVDjAyToqMpA5Humg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve5Kq4Wn0f2AxcyK3gP8Qs1s5fWvyVDjAyToqMpA5Humg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 12:29:53PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 7, 2021 at 12:23 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> > On Sun, Jun 06, 2021 at 11:09:09PM +0300, Andy Shevchenko wrote:
> > > device_get_next_child_node() bumps a reference counting of a returned variable.
> 
> ...
> 
> > >  err_remove_ports:
> > > +     fwnode_handle_put(fwnode);
> >
> > Wouldn't it be more clear to do that in the condition that jumps to
> > this lable?
> 
> In this case it doesn't matter. As a general pattern, no, because this
> will help to keep this in mind in complex error handling ladders. That
> said, I prefer my variant unless there is a strong opinion to move it
> into the conditional.

Now it looks like you are releasing the mux device fwnode instead of a
port fwnode because everything else related to the ports is destroyed
in below loop. That's too confusing.

Just handle it inside the condition, and the whole thing becomes
clear.

> > >       for (i = 0; i < pmc->num_ports; i++) {
> > >               typec_switch_unregister(pmc->port[i].typec_sw);
> > >               typec_mux_unregister(pmc->port[i].typec_mux);

-- 
heikki
