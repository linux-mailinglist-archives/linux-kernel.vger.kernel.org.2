Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F41F3C258A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 16:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhGIOIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 10:08:07 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:38376 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhGIOIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 10:08:06 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 88C9CB236BD;
        Fri,  9 Jul 2021 16:05:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1625839520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fv6mXtwsNLV8Z6mne/QVVhVuclAr1lGpvUhLHeEpHIw=;
        b=FAV8uEoQgOrWeHmEturnWZdI3JxhmsU4qKLyH31j0wZ5qjpsXEhKM1wKSB2m9eTtgAkEMW
        D8gp4Z5DWz+xJILRARllgrsT5Ig6PfnbCrwcxmmjpRVK7btk2jo3JKbmFwg9zlC6wtlEBP
        WMAxB8d+T+x1QG1+KEX+2Xuufo7tu38=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] igb: fix netpoll exit with traffic
Date:   Fri, 09 Jul 2021 16:05:18 +0200
Message-ID: <1682283.zdkM9JWR0q@spock>
In-Reply-To: <20210508102630.rytwqgkn7ariwru6@spock.localdomain>
References: <20210507023001.2621951-1-jesse.brandeburg@intel.com> <20210508102630.rytwqgkn7ariwru6@spock.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sobota 8. kv=C4=9Btna 2021 12:26:36 CEST Oleksandr Natalenko wrote:
> Hello.
>=20
> On Thu, May 06, 2021 at 07:30:01PM -0700, Jesse Brandeburg wrote:
> > Oleksandr brought a bug report where netpoll causes trace messages in
> > the log on igb.
> >=20
> > [22038.710800] ------------[ cut here ]------------
> > [22038.710801] igb_poll+0x0/0x1440 [igb] exceeded budget in poll
> > [22038.710802] WARNING: CPU: 12 PID: 40362 at net/core/netpoll.c:155
> > netpoll_poll_dev+0x18a/0x1a0
> >=20
> > After some discussion and debug from the list, it was deemed that the
> > right thing to do is initialize the clean_complete variable to false
> > when the "netpoll mode" of passing a zero budget is used.
> >=20
> > This logic should be sane and not risky because the only time budget
> > should be zero on entry is netpoll.  Change includes a small refactor
> > of local variable assignments to clean up the look.
> >=20
> > Fixes: 16eb8815c235 ("igb: Refactor clean_rx_irq to reduce overhead and
> > improve performance") Reported-by: Oleksandr Natalenko
> > <oleksandr@natalenko.name>
> > Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
> > Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> > ---
> >=20
> > Compile tested ONLY, but functionally it should be exactly the same for
> > all cases except when budget is zero on entry, which will hopefully fix
> > the bug.
> >=20
> > Sending this through intel-wired-lan with Alex's ACK.
> > ---
> >=20
> >  drivers/net/ethernet/intel/igb/igb_main.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> > b/drivers/net/ethernet/intel/igb/igb_main.c index
> > 0cd37ad81b4e..b0a9bed14071 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -7991,12 +7991,16 @@ static void igb_ring_irq_enable(struct
> > igb_q_vector *q_vector)>=20
> >   **/
> > =20
> >  static int igb_poll(struct napi_struct *napi, int budget)
> >  {
> >=20
> > -	struct igb_q_vector *q_vector =3D container_of(napi,
> > -						     struct igb_q_vector,
> > -						     napi);
> > -	bool clean_complete =3D true;
> > +	struct igb_q_vector *q_vector;
> > +	bool clean_complete;
> >=20
> >  	int work_done =3D 0;
> >=20
> > +	/* if budget is zero, we have a special case for netconsole, so
> > +	 * make sure to set clean_complete to false in that case.
> > +	 */
> > +	clean_complete =3D !!budget;
> > +
> > +	q_vector =3D container_of(napi, struct igb_q_vector, napi);
> >=20
> >  #ifdef CONFIG_IGB_DCA
> > =20
> >  	if (q_vector->adapter->flags & IGB_FLAG_DCA_ENABLED)
> >  =09
> >  		igb_update_dca(q_vector);
>=20
> This didn't fix the issue neither for me, nor for another person from
> the kernel bugzilla [1].
>=20
> The same printout still happens:
>=20
> ```
> May 07 20:26:55 spock kernel: igb_poll+0x0/0x1440 [igb] exceeded budget in
> poll May 07 20:26:55 spock kernel: WARNING: CPU: 13 PID: 12285 at
> net/core/netpoll.c:154 netpoll_poll_dev+0x18a/0x1a0 =E2=80=A6
> May 07 20:26:55 spock kernel: Call Trace:
> May 07 20:26:55 spock kernel:  netpoll_send_skb+0x1a0/0x260
> May 07 20:26:55 spock kernel:  write_msg+0xe5/0x100 [netconsole]
> May 07 20:26:55 spock kernel:  console_unlock+0x42f/0x720
> May 07 20:26:55 spock kernel:  suspend_devices_and_enter+0x2ac/0x7f0
> May 07 20:26:55 spock kernel:  pm_suspend.cold+0x321/0x36c
> May 07 20:26:55 spock kernel:  state_store+0xa6/0x140
> May 07 20:26:55 spock kernel:  kernfs_fop_write_iter+0x124/0x1b0
> May 07 20:26:55 spock kernel:  new_sync_write+0x16a/0x200
> May 07 20:26:55 spock kernel:  vfs_write+0x223/0x2e0
> May 07 20:26:55 spock kernel:  __x64_sys_write+0x6d/0xf0
> ```
>=20
> Probably, your patch is still fine, but another idea is desperately
> needed :).
>=20
> Thanks.
>=20
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D212573

Gentle ping. IIUC, the patch was not picked up anyway, but maybe there's=20
another idea?

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


