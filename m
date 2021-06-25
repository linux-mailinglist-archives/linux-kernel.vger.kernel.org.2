Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B513B4A9C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 00:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhFYWjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 18:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229776AbhFYWjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 18:39:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F03161606;
        Fri, 25 Jun 2021 22:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624660651;
        bh=UDmebdVAymNlAe+OW5HvCKCPX1qgMcGjn/2lHdDAUDY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=McnPO14oDIS1t0moCyryR+ZZ4oBrIFy2d7d6WxephmDW1QYJTzbtAn6GLHdJW7xiZ
         MbJvtBuFRmyFY38GEjIV436d84dxsQAOtM1WubTMTUQ1rog9voQLWSGoqml0amrp4c
         bYKI39IwELB3d1wKh6oQg5xLrHuGqgdr2zC3i/qfePLb+pbR43raAdaBY+yvfPCG+B
         nPD9fAmGFt1suPfluccTK6f1GqrA1eKhImxRWx3fdhkvwfsIyaaFhZsAzRWG18rY/A
         y45QL1DJvtGhLfSbVMSQQp9BpGWYgws6C+ZhCuACRNM/2jg6fZeCCcY/0Mbw2pTRKh
         gvuSxww6ElwJw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210407034456.516204-3-saravanak@google.com>
References: <20210407034456.516204-1-saravanak@google.com> <20210407034456.516204-3-saravanak@google.com>
Subject: Re: [PATCH v1 2/2] clk: Add support for sync_state()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Saravana Kannan <saravanak@google.com>
Date:   Fri, 25 Jun 2021 15:37:30 -0700
Message-ID: <162466065014.3259633.8331957079895473498@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late review. This patch got lost during the merge window.

Quoting Saravana Kannan (2021-04-06 20:44:55)
> Clocks can be turned on (by the hardware, bootloader, etc) upon a
> reset/boot of a hardware platform. These "boot clocks" could be clocking
> devices that are active before the kernel starts running. For example,
> clocks needed for the interconnects, UART console, display, CPUs, DDR,
> etc.
>=20
> When a boot clock is used by more than one consumer or multiple boot
> clocks share a parent clock, the boot clock (or the common parent) can
> be turned off when the first consumer probes. This can crash the device

probes and calls clk_disable{,_unprepare}().

> or cause poor user experience.
>=20
> Fix this by explicitly enabling the boot clocks during clock
> registration and then removing the enable vote when the clock provider
> device gets its sync_state() callback. Since sync_state() callback comes
> only when all the consumers of a device (not a specific clock) have
> probed, this ensures the boot clocks are kept on at least until all
> their consumers have had a chance to vote on them (in their respective

s/vote/enable/

> probe functions).
>=20
> Also, if a clock provider is loaded as a module and it has some boot
> clocks, they get turned off only when a consumer explicitly turns them
> off. So clocks that are boot clocks and are unused never get turned off

Is this more like "After this change boot clocks that are unused get
turned off"?

> because the logic to turn off unused clocks has already run during
> late_initcall_sync(). Adding sync_state() support also makes sure these
> unused boot clocks are turned off once all the consumers have probed.
>=20
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/clk/clk.c            | 84 +++++++++++++++++++++++++++++++++++-
>  include/linux/clk-provider.h |  1 +
>  2 files changed, 84 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d6301a3351f2..cd07f4d1254c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -72,6 +72,8 @@ struct clk_core {
>         unsigned long           flags;
>         bool                    orphan;
>         bool                    rpm_enabled;
> +       bool                    need_sync;
> +       bool                    boot_enabled;

Nothing wrong with this patch but we really should document struct
clk_core!

>         unsigned int            enable_count;
>         unsigned int            prepare_count;
>         unsigned int            protect_count;
> @@ -1215,6 +1217,15 @@ static void __init clk_unprepare_unused_subtree(st=
ruct clk_core *core)
>         hlist_for_each_entry(child, &core->children, child_node)
>                 clk_unprepare_unused_subtree(child);
> =20
> +       /*
> +        * Orphan clocks might still not have their state held if one of =
their
> +        * ancestors hasn't been registered yet. We don't want to turn off
> +        * these orphan clocks now as they will be turned off later when =
their
> +        * device gets a sync_state() call.
> +        */
> +       if (dev_has_sync_state(core->dev))
> +               return;
> +
>         if (core->prepare_count)
>                 return;
> =20
> @@ -1246,6 +1257,15 @@ static void __init clk_disable_unused_subtree(stru=
ct clk_core *core)
>         hlist_for_each_entry(child, &core->children, child_node)
>                 clk_disable_unused_subtree(child);
> =20
> +       /*
> +        * Orphan clocks might still not have their state held if one of =
their
> +        * ancestors hasn't been registered yet. We don't want to turn off
> +        * these orphan clocks now as they will be turned off later when =
their
> +        * device gets a sync_state() call.
> +        */
> +       if (dev_has_sync_state(core->dev))

Do we need to inject this logic here? Maybe it would be better to up the
prepare/enable count (by two?) at clk registration time if
dev_has_sync_state() and the clk is a boot clk. Then the unused logic
wouldn't need to change and it could still decrement the count. Or we
could set the flag CLK_IGNORE_UNUSED if dev_has_sync_state and then we
know it doesn't run the disable unused logic. With the flag we could
increment by one instead of two.

Thinking some more about it, if we reuse the prepare/enable count then
we allow clk consumers to decrement the count during boot more than the
number of times they incremented it. That would be bad, and quite
annoying to debug. Ideally we prevent that somehow but then I wonder if
keeping the clk enabled throughout boot is correct. What do we do if
drivers really need to turn off the clk during their driver probe
because they can't have the clk on during a hardware reset? If we bump
up the count at registration time they won't be able to do that, unless
they somehow know that the clk is on at boot and then disable the proper
amount.

> +               return;
> +
>         if (core->flags & CLK_OPS_PARENT_ENABLE)
>                 clk_core_prepare_enable(core->parent);
> =20
> @@ -1319,6 +1339,38 @@ static int __init clk_disable_unused(void)
>  }
>  late_initcall_sync(clk_disable_unused);
> =20
> +static void clk_unprepare_disable_dev_subtree(struct clk_core *core,
> +                                             struct device *dev)

const dev?

> +{
> +       struct clk_core *child;
> +
> +       lockdep_assert_held(&prepare_lock);
> +
> +       hlist_for_each_entry(child, &core->children, child_node)
> +               clk_unprepare_disable_dev_subtree(child, dev);
> +
> +       if (core->dev !=3D dev || !core->need_sync)
> +               return;
> +
> +       clk_core_disable_unprepare(core);

Maybe invert the logic

	if (core->dev =3D=3D dev && core->need_sync)
		clk_core_disable_unprepare(core);

Also, this is recursing the tree down to the leaves and then back up to
the root. Is there any way we can traverse the tree once, preferably not
recursively? I always worry that the stack is eaten up by clk traversal
logic.

> +}
> +
> +void clk_sync_state(struct device *dev)

Please add some kernel doc on this exported function.

> +{
> +       struct clk_core *core;
> +
> +       clk_prepare_lock();
> +
> +       hlist_for_each_entry(core, &clk_root_list, child_node)
> +               clk_unprepare_disable_dev_subtree(core, dev);
> +
> +       hlist_for_each_entry(core, &clk_orphan_list, child_node)
> +               clk_unprepare_disable_dev_subtree(core, dev);
> +
> +       clk_prepare_unlock();
> +}
> +EXPORT_SYMBOL_GPL(clk_sync_state);
> +
>  static int clk_core_determine_round_nolock(struct clk_core *core,
>                                            struct clk_rate_request *req)
>  {
> @@ -1725,6 +1777,30 @@ int clk_hw_get_parent_index(struct clk_hw *hw)
>  }
>  EXPORT_SYMBOL_GPL(clk_hw_get_parent_index);
> =20
> +static void clk_core_hold_state(struct clk_core *core)
> +{
> +       if (core->need_sync || !core->boot_enabled)
> +               return;
> +
> +       if (core->orphan || !dev_has_sync_state(core->dev))
> +               return;
> +
> +       core->need_sync =3D !clk_core_prepare_enable(core);
> +}
> +
> +static void __clk_core_update_orphan_hold_state(struct clk_core *core)
> +{
> +       struct clk_core *child;
> +
> +       if (core->orphan)
> +               return;
> +
> +       clk_core_hold_state(core);
> +
> +       hlist_for_each_entry(child, &core->children, child_node)
> +               __clk_core_update_orphan_hold_state(child);
> +}

If I understand correctly, we're special casing orphans to know if we
should carry over 'need_sync'? Maybe it would be better to propagate
'boot_enabled' and/or 'need_sync' to any parent clks when adopting a
clk? See the orphan logic in clk_reparent(). I suspect we need to do
this sort of stuff in there instead of duplicating the logic here.

> +
>  /*
>   * Update the orphan status of @core and all its children.
>   */
> @@ -3392,6 +3468,7 @@ static void clk_core_reparent_orphans_nolock(void)
>                         __clk_set_parent_after(orphan, parent, NULL);
>                         __clk_recalc_accuracies(orphan);
>                         __clk_recalc_rates(orphan, 0);
> +                       __clk_core_update_orphan_hold_state(orphan);
>                 }
>         }
>  }
> @@ -3550,6 +3627,8 @@ static int __clk_core_init(struct clk_core *core)
>                 rate =3D 0;
>         core->rate =3D core->req_rate =3D rate;
> =20
> +       core->boot_enabled =3D clk_core_is_enabled(core);
> +
>         /*
>          * Enable CLK_IS_CRITICAL clocks so newly added critical clocks
>          * don't get accidentally disabled when walking the orphan tree a=
nd
> @@ -3572,6 +3651,7 @@ static int __clk_core_init(struct clk_core *core)
>                 }
>         }
> =20
> +       clk_core_hold_state(core);
>         clk_core_reparent_orphans_nolock();
> =20
> =20
> @@ -3837,8 +3917,10 @@ __clk_register(struct device *dev, struct device_n=
ode *np, struct clk_hw *hw)
>                 core->rpm_enabled =3D true;
>         core->dev =3D dev;
>         core->of_node =3D np;
> -       if (dev && dev->driver)
> +       if (dev && dev->driver) {
>                 core->owner =3D dev->driver->owner;
> +               dev_set_drv_sync_state(dev, clk_sync_state);

How do we know that the driver isn't going to want to hook the sync
state callback itself? I suppose this is OK because if the driver wanted
to do something special for sync_state they would have set the pointer
already and dev_set_drv_sync_state() doesn't allow it to be overwritten
here?

One last thing, what do we do about clk providers that never use a
struct device? Is there a 'sync_state' callback for fwnode or DT only
clk providers? We have quite a few of those right now and while this
patch may incentivize those clk providers to move over to a struct
device, some of the clks can't be registered with a device because
they're needed before the device framework is ready, e.g. irqchip and
clocksource/clockevent drivers.

> +       }
>         core->hw =3D hw;
>         core->flags =3D init->flags;
>         core->num_parents =3D init->num_parents;
