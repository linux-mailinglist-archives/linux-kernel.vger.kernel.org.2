Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B863A35BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhFJVTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhFJVTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:19:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 127CA61362;
        Thu, 10 Jun 2021 21:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623359875;
        bh=TZASBs5ttKwmAEXd6umsa6OMowA86BPv4+SxUpI013I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PDLjnHnlWdhMt3FrnQJOa9VHc/VTXXjG39qs3KmjNG6HnpZAVbWFzTO3dFIQNfYWz
         qyOpI89RI0AIICZNrJO+dJGjxLevX1pAEcTrJbNHIDiYJgVDTKol8ZMM7DZd9JUUjZ
         ql6lP70PfsnQGR8K0CXpW8g1XP4isBPNiTlV82yfGsIei2+fJ2ePS5NnxTBsI6SyMG
         J2mCPGkPKKdG7vmaStdhBBcgLFEfNnH7U8ZvncFpfEeySSekwdXQgwbiH/7DQvaJu7
         SPGkcCgtF2zbnOlHfTRHOxPnVOJPgV14uu1Nr5emXv3yuxIOt+syoIAQwv6ZD1ZOr7
         7r2xFIH8KyYzg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210610071758.1560592-1-sean@geanix.com>
References: <20210610071758.1560592-1-sean@geanix.com>
Subject: Re: [PATCH] clk: fix possible circular locking in clk_notifier_register()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Sean Nyekjaer <sean@geanix.com>
Date:   Thu, 10 Jun 2021 14:17:53 -0700
Message-ID: <162335987382.9598.2377065226236202544@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sean Nyekjaer (2021-06-10 00:17:57)
> Allocating memory with prepare_lock mutex held makes lockdep unhappy
> when memory pressure makes the system do fs_reclaim on eg. rawnand using
> clk.
>=20
> Push the allocation outside the lock.
>=20
> [  462.466020] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  462.472211] WARNING: possible circular locking dependency detected
> [  462.478406] 4.19.128-00489-gffc0949c2231 #2 Not tainted

4.19 is quite old. Is it happening in mainline? I suppose so given that
the allocation is still under the prepare lock?

> [  462.483641] ------------------------------------------------------
> [  462.489831] kswapd0/22 is trying to acquire lock:
> [  462.494553] 882c9532 (&c->commit_sem){++++}, at: make_reservation+0x68=
/0x41c
> [  462.501638]
> [  462.501638] but task is already holding lock:
> [  462.507483] 11f3c233 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/=
0x48
> [  462.514388]
> [  462.514388] which lock already depends on the new lock.
> [  462.514388]
> [  462.522579]
> [  462.522579] the existing dependency chain (in reverse order) is:
> [  462.530073]
> [  462.530073] -> #4 (fs_reclaim){+.+.}:
> [  462.535242]        fs_reclaim_acquire+0x78/0x88
> [  462.539792]        kmem_cache_alloc_trace+0x34/0x2e8
> [  462.544775]        clk_notifier_register+0x84/0xfc
> [  462.549586]        i2c_imx_probe+0x23c/0x678
> [  462.553872]        platform_drv_probe+0x50/0xa0
> [  462.558419]        really_probe+0x2b8/0x3d8
> [  462.562617]        driver_probe_device+0x64/0x16c
> [  462.567334]        __driver_attach+0x120/0x144
> [  462.571795]        bus_for_each_dev+0x7c/0xc4
> [  462.576166]        driver_attach+0x20/0x28
> [  462.580276]        bus_add_driver+0x174/0x208
> [  462.584646]        driver_register+0x90/0x120
> [  462.589016]        __platform_driver_register+0x38/0x4c
> [  462.594260]        i2c_adap_imx_init+0x18/0x20
> [  462.598721]        do_one_initcall+0x8c/0x32c
> [  462.603096]        kernel_init_freeable+0x300/0x3e4
> [  462.607993]        kernel_init+0x10/0x114
> [  462.612016]        ret_from_fork+0x14/0x20
> [  462.616124]          (null)
> [  462.618928]
> [  462.618928] -> #3 (prepare_lock){+.+.}:
> [  462.624270]        __mutex_lock+0x60/0x8dc
> [  462.628381]        mutex_lock_nested+0x24/0x2c
> [  462.632843]        clk_prepare_lock+0x44/0xec
> [  462.637216]        clk_unprepare+0x24/0x34
> [  462.641327]        gpmi_disable_clk+0x2c/0x3c
> [  462.645697]        gpmi_select_chip+0x84/0xa4
> [  462.650071]        nand_read_oob+0x748/0x7b8
> [  462.654358]        part_read_oob+0x40/0x78
> [  462.658466]        mtd_read+0x10c/0x13c
> [  462.662318]        ubi_io_read+0xc8/0x354
> [  462.666342]        ubi_eba_read_leb+0xc8/0x544
> [  462.670798]        ubi_eba_read_leb_sg+0x70/0x170
> [  462.675514]        ubi_leb_read_sg+0x7c/0xbc
> [  462.679799]        ubiblock_do_work+0xcc/0x118
> [  462.684260]        process_one_work+0x2a4/0x744
> [  462.688805]        worker_thread+0x5c/0x554
> [  462.693004]        kthread+0x120/0x160
> [  462.696767]        ret_from_fork+0x14/0x20
> [  462.700874]          (null)
> [  462.703676]
> [  462.703676] -> #2 (&le->mutex){++++}:
> [  462.708842]        down_read+0x3c/0x80
> [  462.712608]        ubi_eba_read_leb+0x4c/0x544
> [  462.717065]        ubi_leb_read+0x7c/0xbc
> [  462.721089]        ubifs_leb_read+0x34/0x80
> [  462.725288]        ubifs_read_nnode+0x194/0x208
> [  462.729831]        ubifs_lpt_lookup_dirty+0x1e0/0x294
> [  462.734899]        ubifs_replay_journal+0x48/0x15a8
> [  462.739789]        ubifs_mount+0x104c/0x15f0
> [  462.744074]        mount_fs+0x1c/0xb8
> [  462.747753]        vfs_kern_mount.part.0+0x58/0x148
> [  462.752648]        do_mount+0x6a4/0xec8
> [  462.756499]        ksys_mount+0x90/0xbc
> [  462.760349]        sys_mount+0x1c/0x24
> [  462.764108]        ret_fast_syscall+0x0/0x28
> [  462.768390]        0xbebcbb38
> [  462.771367]
> [  462.771367] -> #1 (&c->lp_mutex){+.+.}:
> [  462.776705]        __mutex_lock+0x60/0x8dc
> [  462.780818]        mutex_lock_nested+0x24/0x2c
> [  462.785277]        ubifs_gc_start_commit+0x28/0x32c
> [  462.790170]        do_commit+0x1cc/0x7e4
> [  462.794105]        ubifs_run_commit+0x98/0xd0
> [  462.798476]        grab_empty_leb+0x60/0x98
> [  462.802674]        ubifs_rcvry_gc_commit+0x10c/0x1d8
> [  462.807651]        ubifs_mount+0x1308/0x15f0
> [  462.811934]        mount_fs+0x1c/0xb8
> [  462.815610]        vfs_kern_mount.part.0+0x58/0x148
> [  462.820503]        do_mount+0x6a4/0xec8
> [  462.824353]        ksys_mount+0x90/0xbc
> [  462.828201]        sys_mount+0x1c/0x24
> [  462.831962]        ret_fast_syscall+0x0/0x28
> [  462.836243]        0xbebcbb38
> [  462.839220]
> [  462.839220] -> #0 (&c->commit_sem){++++}:
> [  462.844733]        lock_acquire+0xd4/0x1f8
> [  462.848845]        down_read+0x3c/0x80
> [  462.852608]        make_reservation+0x68/0x41c
> [  462.857064]        ubifs_jnl_write_data+0x134/0x2b8
> [  462.861955]        do_writepage+0x88/0x210
> [  462.866063]        ubifs_writepage+0x1b8/0x274
> [  462.870522]        shrink_page_list+0x800/0xf68
> [  462.875065]        shrink_inactive_list+0x1b4/0x4f0
> [  462.879956]        shrink_node+0x44c/0x9c0
> [  462.884063]        kswapd+0x3f8/0x928
> [  462.887741]        kthread+0x120/0x160
> [  462.891504]        ret_from_fork+0x14/0x20
> [  462.895609]          (null)
> [  462.898412]
> [  462.898412] other info that might help us debug this:
> [  462.898412]
> [  462.906428] Chain exists of:
> [  462.906428]   &c->commit_sem --> prepare_lock --> fs_reclaim
> [  462.906428]
> [  462.916455]  Possible unsafe locking scenario:
> [  462.916455]
> [  462.922384]        CPU0                    CPU1
> [  462.926923]        ----                    ----
> [  462.931459]   lock(fs_reclaim);
> [  462.934613]                                lock(prepare_lock);
> [  462.940458]                                lock(fs_reclaim);
> [  462.946127]   lock(&c->commit_sem);
> [  462.949628]
> [  462.949628]  *** DEADLOCK ***
> [  462.949628]
> [  462.955563] 1 lock held by kswapd0/22:
> [  462.959322]  #0: 11f3c233 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire=
+0x0/0x48

Please consider removing the timestamps on the log. Otherwise I will do
it myself next time.

>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/clk/clk.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 65508eb89ec9..c32b71b08ccb 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4340,17 +4340,20 @@ int clk_notifier_register(struct clk *clk, struct=
 notifier_block *nb)
>         if (!clk || !nb)
>                 return -EINVAL;
> =20
> +       /* allocate new clk_notifier */
> +       cn =3D kzalloc(sizeof(*cn), GFP_KERNEL);
> +       if (!cn)
> +               goto out;
> +
>         clk_prepare_lock();
> =20
>         /* search the list of notifiers for this clk */
>         list_for_each_entry(cn, &clk_notifier_list, node)

Isn't this going to overwrite 'cn'?

> -               if (cn->clk =3D=3D clk)
> +               if (cn->clk =3D=3D clk) {
> +                       /* if clk is in the notifier list, free new clk_n=
otifier */
> +                       kfree(cn);

Ideally we also kfree() outside the lock.

>                         goto found;
> -
> -       /* if clk wasn't in the notifier list, allocate new clk_notifier =
*/
> -       cn =3D kzalloc(sizeof(*cn), GFP_KERNEL);
> -       if (!cn)
> -               goto out;
> +               }
> =20
>         cn->clk =3D clk;
>         srcu_init_notifier_head(&cn->notifier_head);
> @@ -4362,9 +4365,9 @@ int clk_notifier_register(struct clk *clk, struct n=
otifier_block *nb)
> =20
>         clk->core->notifier_count++;
> =20
> -out:
>         clk_prepare_unlock();
> =20
> +out:
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(clk_notifier_register);
>=20

How about this totally untested patch?

----8<----

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e2ec1b745243..dac53dbedff1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4334,29 +4334,27 @@ void __clk_put(struct clk *clk)
  */
 int clk_notifier_register(struct clk *clk, struct notifier_block *nb)
 {
-	struct clk_notifier *cn;
-	int ret =3D -ENOMEM;
+	struct clk_notifier *cn, *new_cn;
+	int ret;
=20
 	if (!clk || !nb)
 		return -EINVAL;
=20
-	clk_prepare_lock();
+	new_cn =3D kzalloc(sizeof(*new_cn), GFP_KERNEL);
+	if (!new_cn)
+		return -ENOMEM;
=20
+	clk_prepare_lock();
 	/* search the list of notifiers for this clk */
 	list_for_each_entry(cn, &clk_notifier_list, node)
 		if (cn->clk =3D=3D clk)
 			goto found;
=20
-	/* if clk wasn't in the notifier list, allocate new clk_notifier */
-	cn =3D kzalloc(sizeof(*cn), GFP_KERNEL);
-	if (!cn)
-		goto out;
-
+	/* if clk wasn't in the notifier list, use new clk_notifier */
+	cn =3D new_cn;
 	cn->clk =3D clk;
 	srcu_init_notifier_head(&cn->notifier_head);
-
 	list_add(&cn->node, &clk_notifier_list);
-
 found:
 	ret =3D srcu_notifier_chain_register(&cn->notifier_head, nb);
=20
@@ -4365,6 +4363,10 @@ int clk_notifier_register(struct clk *clk, struct no=
tifier_block *nb)
 out:
 	clk_prepare_unlock();
=20
+	/* Did we reuse an existing notifier? If so, free the new one */
+	if (cn !=3D new_cn)
+		kfree(new_cn);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_notifier_register);
