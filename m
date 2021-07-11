Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F38B3C3B57
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 11:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhGKJwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 05:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKJwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 05:52:23 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0243C0613DD;
        Sun, 11 Jul 2021 02:49:36 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id z1so15927056ils.0;
        Sun, 11 Jul 2021 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UifErnrfUevuKx3Ect53Sj6o6SQ8Ql1Ip98jbngKx/Q=;
        b=Etocc65JEwgE3oPOPzaw8lyjNBlDazm7Pgz3RlSWWPvcuik8qianFQDNeEYSEOb/cI
         pgvSIbaj6BSpImOYQpgvbUWVoIFVYqYUCkjnDYw0aKlnKGY/g5sRrNFzyQXlArcOs0E4
         yg6dCFLG0PzNSenDBzHd68nV6KANHVqO8Rw327aYANqXPpEjmUCS6Qs6vFVC/BrBgr/U
         93rqlAUekeoUMT2o7e9kyxMgwYyIbgztjYD/Dbw+hiyoMfLqA9LhQJUdXPneQqm4xS62
         52sUkS8E0NBKiHQznyBqb5iB9/vcG7827Ne8xQ6u1CWEe9GnmUr4KUt8tX9EnoHmey9l
         Grig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UifErnrfUevuKx3Ect53Sj6o6SQ8Ql1Ip98jbngKx/Q=;
        b=rEiNjyVq/YPbVQDMpzvwL9rsy/+7+GyGPbG9VSVJl+mWkKX89GBqXgivndC3CsO/+D
         BbF3WF/8XsASOdmXoyDHxcK2INk1h9tCKRqlGG4tT8zOThS3+hL9M9ngtn/ekG9BedVC
         dUPbmGqhVDw/hNAzIZ8BgwQ0885rzsVpFSWle7ygXtGyjVrjuV5mv0fclwxK//Fqvj+C
         FSkx6d+z/oGzAr6UuHFWDLAGm8BKShFSzlSUEM0pa4geuVg7iILvf5sFomRo9Gr4pyyM
         xd2ZD9QBPqOlIiphTieA0uI1LZZJ2cIDYnZygpy7ItCfoEvrzGFYwBvZ1kZ88B+7TcW9
         ifhA==
X-Gm-Message-State: AOAM533FGMZhK//fFS8iahSgD0L4fBDSutacmbm43VZ2sVGPO+KSitcB
        JfYP4VrtbIJsruumUU+khhuTVrmHo1JY2rWIL3k=
X-Google-Smtp-Source: ABdhPJxOBRUGxdKqaBGkLvufjRBcbGXBCFm2ROKfHSkwy8/UVH1cg3hxNygObyCFb2/1QK3tKvhIjxl6v76Jhx0Id6U=
X-Received: by 2002:a05:6e02:106d:: with SMTP id q13mr11638142ilj.164.1625996975557;
 Sun, 11 Jul 2021 02:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1625471640.git.vilhelm.gray@gmail.com> <834dadaa68af74c703f19f8ddcca5512dd1d177e.1625471640.git.vilhelm.gray@gmail.com>
In-Reply-To: <834dadaa68af74c703f19f8ddcca5512dd1d177e.1625471640.git.vilhelm.gray@gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sun, 11 Jul 2021 15:19:20 +0530
Message-ID: <CACG_h5rzvSKZKtxkRpen_G03+B+uFf9rjpcmFZVqrEqb7dNbbg@mail.gmail.com>
Subject: Re: [PATCH v12 06/17] counter: Internalize sysfs interface code
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        Gwendal Grignou <gwendal@chromium.org>,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 1:49 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> This is a reimplementation of the Generic Counter driver interface.
> There are no modifications to the Counter subsystem userspace interface,
> so existing userspace applications should continue to run seamlessly.
>
> The purpose of this patch is to internalize the sysfs interface code
> among the various counter drivers into a shared module. Counter drivers
> pass and take data natively (i.e. u8, u64, etc.) and the shared counter
> module handles the translation between the sysfs interface and the
> device drivers. This guarantees a standard userspace interface for all
> counter drivers, and helps generalize the Generic Counter driver ABI in
> order to support the Generic Counter chrdev interface (introduced in a
> subsequent patch) without significant changes to the existing counter
> drivers.
>
> Note, Counter device registration is the same as before: drivers
> populate a struct counter_device with components and callbacks, then
> pass the structure to the devm_counter_register function. However,
> what's different now is how the Counter subsystem code handles this
> registration internally.
>
> Whereas before callbacks would interact directly with sysfs data, this
> interaction is now abstracted and instead callbacks interact with native
> C data types. The counter_comp structure forms the basis for Counter
> extensions.
>
> The counter-sysfs.c file contains the code to parse through the
> counter_device structure and register the requested components and
> extensions. Attributes are created and populated based on type, with
> respective translation functions to handle the mapping between sysfs and
> the counter driver callbacks.
>
> The translation performed for each attribute is straightforward: the
> attribute type and data is parsed from the counter_attribute structure,
> the respective counter driver read/write callback is called, and sysfs
> I/O is handled before or after the driver read/write function is called.
>
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> Tested-by: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  MAINTAINERS                             |    1 -
>  drivers/counter/104-quad-8.c            |  449 +++----

For 104-Quad-8,

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>


>  drivers/counter/Makefile                |    1 +
>  drivers/counter/counter-core.c          |  145 +++
>  drivers/counter/counter-sysfs.c         |  846 +++++++++++++
>  drivers/counter/counter-sysfs.h         |   13 +
>  drivers/counter/counter.c               | 1496 -----------------------
>  drivers/counter/ftm-quaddec.c           |   56 +-
>  drivers/counter/intel-qep.c             |  144 +--
>  drivers/counter/interrupt-cnt.c         |   62 +-
>  drivers/counter/microchip-tcb-capture.c |   93 +-
>  drivers/counter/stm32-lptimer-cnt.c     |  162 ++-
>  drivers/counter/stm32-timer-cnt.c       |  147 +--
>  drivers/counter/ti-eqep.c               |  180 +--
>  include/linux/counter.h                 |  658 +++++-----
>  include/linux/counter_enum.h            |   45 -
>  16 files changed, 1920 insertions(+), 2578 deletions(-)
>  create mode 100644 drivers/counter/counter-core.c
>  create mode 100644 drivers/counter/counter-sysfs.c
>  create mode 100644 drivers/counter/counter-sysfs.h
>  delete mode 100644 drivers/counter/counter.c
>  delete mode 100644 include/linux/counter_enum.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9bf553e53f0f..2cac15216ba9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4687,7 +4687,6 @@ F:        Documentation/ABI/testing/sysfs-bus-count=
er
>  F:     Documentation/driver-api/generic-counter.rst
>  F:     drivers/counter/
>  F:     include/linux/counter.h
> -F:     include/linux/counter_enum.h
>
>  CP2615 I2C DRIVER
>  M:     Bence Cs=C3=B3k=C3=A1s <bence98@sch.bme.hu>
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 5283ff128c17..d1161c27c488 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -116,7 +116,7 @@ static int quad8_signal_read(struct counter_device *c=
ounter,
>  }
>
>  static int quad8_count_read(struct counter_device *counter,
> -       struct counter_count *count, unsigned long *val)
> +                           struct counter_count *count, u64 *val)
>  {
>         struct quad8 *const priv =3D counter->priv;
>         const int base_offset =3D priv->base + 2 * count->id;
> @@ -147,7 +147,7 @@ static int quad8_count_read(struct counter_device *co=
unter,
>  }
>
>  static int quad8_count_write(struct counter_device *counter,
> -       struct counter_count *count, unsigned long val)
> +                            struct counter_count *count, u64 val)
>  {
>         struct quad8 *const priv =3D counter->priv;
>         const int base_offset =3D priv->base + 2 * count->id;
> @@ -187,22 +187,16 @@ static int quad8_count_write(struct counter_device =
*counter,
>         return 0;
>  }
>
> -enum quad8_count_function {
> -       QUAD8_COUNT_FUNCTION_PULSE_DIRECTION =3D 0,
> -       QUAD8_COUNT_FUNCTION_QUADRATURE_X1,
> -       QUAD8_COUNT_FUNCTION_QUADRATURE_X2,
> -       QUAD8_COUNT_FUNCTION_QUADRATURE_X4
> -};
> -
>  static const enum counter_function quad8_count_functions_list[] =3D {
> -       [QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] =3D COUNTER_FUNCTION_PULSE=
_DIRECTION,
> -       [QUAD8_COUNT_FUNCTION_QUADRATURE_X1] =3D COUNTER_FUNCTION_QUADRAT=
URE_X1_A,
> -       [QUAD8_COUNT_FUNCTION_QUADRATURE_X2] =3D COUNTER_FUNCTION_QUADRAT=
URE_X2_A,
> -       [QUAD8_COUNT_FUNCTION_QUADRATURE_X4] =3D COUNTER_FUNCTION_QUADRAT=
URE_X4
> +       COUNTER_FUNCTION_PULSE_DIRECTION,
> +       COUNTER_FUNCTION_QUADRATURE_X1_A,
> +       COUNTER_FUNCTION_QUADRATURE_X2_A,
> +       COUNTER_FUNCTION_QUADRATURE_X4,
>  };
>
> -static int quad8_function_get(struct counter_device *counter,
> -       struct counter_count *count, size_t *function)
> +static int quad8_function_read(struct counter_device *counter,
> +                              struct counter_count *count,
> +                              enum counter_function *function)
>  {
>         struct quad8 *const priv =3D counter->priv;
>         const int id =3D count->id;
> @@ -212,25 +206,26 @@ static int quad8_function_get(struct counter_device=
 *counter,
>         if (priv->quadrature_mode[id])
>                 switch (priv->quadrature_scale[id]) {
>                 case 0:
> -                       *function =3D QUAD8_COUNT_FUNCTION_QUADRATURE_X1;
> +                       *function =3D COUNTER_FUNCTION_QUADRATURE_X1_A;
>                         break;
>                 case 1:
> -                       *function =3D QUAD8_COUNT_FUNCTION_QUADRATURE_X2;
> +                       *function =3D COUNTER_FUNCTION_QUADRATURE_X2_A;
>                         break;
>                 case 2:
> -                       *function =3D QUAD8_COUNT_FUNCTION_QUADRATURE_X4;
> +                       *function =3D COUNTER_FUNCTION_QUADRATURE_X4;
>                         break;
>                 }
>         else
> -               *function =3D QUAD8_COUNT_FUNCTION_PULSE_DIRECTION;
> +               *function =3D COUNTER_FUNCTION_PULSE_DIRECTION;
>
>         mutex_unlock(&priv->lock);
>
>         return 0;
>  }
>
> -static int quad8_function_set(struct counter_device *counter,
> -       struct counter_count *count, size_t function)
> +static int quad8_function_write(struct counter_device *counter,
> +                               struct counter_count *count,
> +                               enum counter_function function)
>  {
>         struct quad8 *const priv =3D counter->priv;
>         const int id =3D count->id;
> @@ -246,7 +241,7 @@ static int quad8_function_set(struct counter_device *=
counter,
>         mode_cfg =3D priv->count_mode[id] << 1;
>         idr_cfg =3D priv->index_polarity[id] << 1;
>
> -       if (function =3D=3D QUAD8_COUNT_FUNCTION_PULSE_DIRECTION) {
> +       if (function =3D=3D COUNTER_FUNCTION_PULSE_DIRECTION) {
>                 *quadrature_mode =3D 0;
>
>                 /* Quadrature scaling only available in quadrature mode *=
/
> @@ -262,15 +257,15 @@ static int quad8_function_set(struct counter_device=
 *counter,
>                 *quadrature_mode =3D 1;
>
>                 switch (function) {
> -               case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
> +               case COUNTER_FUNCTION_QUADRATURE_X1_A:
>                         *scale =3D 0;
>                         mode_cfg |=3D QUAD8_CMR_QUADRATURE_X1;
>                         break;
> -               case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
> +               case COUNTER_FUNCTION_QUADRATURE_X2_A:
>                         *scale =3D 1;
>                         mode_cfg |=3D QUAD8_CMR_QUADRATURE_X2;
>                         break;
> -               case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
> +               case COUNTER_FUNCTION_QUADRATURE_X4:
>                         *scale =3D 2;
>                         mode_cfg |=3D QUAD8_CMR_QUADRATURE_X4;
>                         break;
> @@ -289,8 +284,9 @@ static int quad8_function_set(struct counter_device *=
counter,
>         return 0;
>  }
>
> -static void quad8_direction_get(struct counter_device *counter,
> -       struct counter_count *count, enum counter_count_direction *direct=
ion)
> +static int quad8_direction_read(struct counter_device *counter,
> +                               struct counter_count *count,
> +                               enum counter_count_direction *direction)
>  {
>         const struct quad8 *const priv =3D counter->priv;
>         unsigned int ud_flag;
> @@ -301,76 +297,74 @@ static void quad8_direction_get(struct counter_devi=
ce *counter,
>
>         *direction =3D (ud_flag) ? COUNTER_COUNT_DIRECTION_FORWARD :
>                 COUNTER_COUNT_DIRECTION_BACKWARD;
> -}
>
> -enum quad8_synapse_action {
> -       QUAD8_SYNAPSE_ACTION_NONE =3D 0,
> -       QUAD8_SYNAPSE_ACTION_RISING_EDGE,
> -       QUAD8_SYNAPSE_ACTION_FALLING_EDGE,
> -       QUAD8_SYNAPSE_ACTION_BOTH_EDGES
> -};
> +       return 0;
> +}
>
>  static const enum counter_synapse_action quad8_index_actions_list[] =3D =
{
> -       [QUAD8_SYNAPSE_ACTION_NONE] =3D COUNTER_SYNAPSE_ACTION_NONE,
> -       [QUAD8_SYNAPSE_ACTION_RISING_EDGE] =3D COUNTER_SYNAPSE_ACTION_RIS=
ING_EDGE
> +       COUNTER_SYNAPSE_ACTION_NONE,
> +       COUNTER_SYNAPSE_ACTION_RISING_EDGE,
>  };
>
>  static const enum counter_synapse_action quad8_synapse_actions_list[] =
=3D {
> -       [QUAD8_SYNAPSE_ACTION_NONE] =3D COUNTER_SYNAPSE_ACTION_NONE,
> -       [QUAD8_SYNAPSE_ACTION_RISING_EDGE] =3D COUNTER_SYNAPSE_ACTION_RIS=
ING_EDGE,
> -       [QUAD8_SYNAPSE_ACTION_FALLING_EDGE] =3D COUNTER_SYNAPSE_ACTION_FA=
LLING_EDGE,
> -       [QUAD8_SYNAPSE_ACTION_BOTH_EDGES] =3D COUNTER_SYNAPSE_ACTION_BOTH=
_EDGES
> +       COUNTER_SYNAPSE_ACTION_NONE,
> +       COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +       COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> +       COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
>  };
>
> -static int quad8_action_get(struct counter_device *counter,
> -       struct counter_count *count, struct counter_synapse *synapse,
> -       size_t *action)
> +static int quad8_action_read(struct counter_device *counter,
> +                            struct counter_count *count,
> +                            struct counter_synapse *synapse,
> +                            enum counter_synapse_action *action)
>  {
>         struct quad8 *const priv =3D counter->priv;
>         int err;
> -       size_t function =3D 0;
> +       enum counter_function function;
>         const size_t signal_a_id =3D count->synapses[0].signal->id;
>         enum counter_count_direction direction;
>
>         /* Handle Index signals */
>         if (synapse->signal->id >=3D 16) {
>                 if (priv->preset_enable[count->id])
> -                       *action =3D QUAD8_SYNAPSE_ACTION_RISING_EDGE;
> +                       *action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
>                 else
> -                       *action =3D QUAD8_SYNAPSE_ACTION_NONE;
> +                       *action =3D COUNTER_SYNAPSE_ACTION_NONE;
>
>                 return 0;
>         }
>
> -       err =3D quad8_function_get(counter, count, &function);
> +       err =3D quad8_function_read(counter, count, &function);
>         if (err)
>                 return err;
>
>         /* Default action mode */
> -       *action =3D QUAD8_SYNAPSE_ACTION_NONE;
> +       *action =3D COUNTER_SYNAPSE_ACTION_NONE;
>
>         /* Determine action mode based on current count function mode */
>         switch (function) {
> -       case QUAD8_COUNT_FUNCTION_PULSE_DIRECTION:
> +       case COUNTER_FUNCTION_PULSE_DIRECTION:
>                 if (synapse->signal->id =3D=3D signal_a_id)
> -                       *action =3D QUAD8_SYNAPSE_ACTION_RISING_EDGE;
> +                       *action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
>                 return 0;
> -       case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
> +       case COUNTER_FUNCTION_QUADRATURE_X1_A:
>                 if (synapse->signal->id =3D=3D signal_a_id) {
> -                       quad8_direction_get(counter, count, &direction);
> +                       err =3D quad8_direction_read(counter, count, &dir=
ection);
> +                       if (err)
> +                               return err;
>
>                         if (direction =3D=3D COUNTER_COUNT_DIRECTION_FORW=
ARD)
> -                               *action =3D QUAD8_SYNAPSE_ACTION_RISING_E=
DGE;
> +                               *action =3D COUNTER_SYNAPSE_ACTION_RISING=
_EDGE;
>                         else
> -                               *action =3D QUAD8_SYNAPSE_ACTION_FALLING_=
EDGE;
> +                               *action =3D COUNTER_SYNAPSE_ACTION_FALLIN=
G_EDGE;
>                 }
>                 return 0;
> -       case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
> +       case COUNTER_FUNCTION_QUADRATURE_X2_A:
>                 if (synapse->signal->id =3D=3D signal_a_id)
> -                       *action =3D QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
> +                       *action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>                 return 0;
> -       case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
> -               *action =3D QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
> +       case COUNTER_FUNCTION_QUADRATURE_X4:
> +               *action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>                 return 0;
>         default:
>                 /* should never reach this path */
> @@ -382,9 +376,9 @@ static const struct counter_ops quad8_ops =3D {
>         .signal_read =3D quad8_signal_read,
>         .count_read =3D quad8_count_read,
>         .count_write =3D quad8_count_write,
> -       .function_get =3D quad8_function_get,
> -       .function_set =3D quad8_function_set,
> -       .action_get =3D quad8_action_get
> +       .function_read =3D quad8_function_read,
> +       .function_write =3D quad8_function_write,
> +       .action_read =3D quad8_action_read
>  };
>
>  static const char *const quad8_index_polarity_modes[] =3D {
> @@ -393,7 +387,8 @@ static const char *const quad8_index_polarity_modes[]=
 =3D {
>  };
>
>  static int quad8_index_polarity_get(struct counter_device *counter,
> -       struct counter_signal *signal, size_t *index_polarity)
> +                                   struct counter_signal *signal,
> +                                   u32 *index_polarity)
>  {
>         const struct quad8 *const priv =3D counter->priv;
>         const size_t channel_id =3D signal->id - 16;
> @@ -404,7 +399,8 @@ static int quad8_index_polarity_get(struct counter_de=
vice *counter,
>  }
>
>  static int quad8_index_polarity_set(struct counter_device *counter,
> -       struct counter_signal *signal, size_t index_polarity)
> +                                   struct counter_signal *signal,
> +                                   u32 index_polarity)
>  {
>         struct quad8 *const priv =3D counter->priv;
>         const size_t channel_id =3D signal->id - 16;
> @@ -425,20 +421,14 @@ static int quad8_index_polarity_set(struct counter_=
device *counter,
>         return 0;
>  }
>
> -static struct counter_signal_enum_ext quad8_index_pol_enum =3D {
> -       .items =3D quad8_index_polarity_modes,
> -       .num_items =3D ARRAY_SIZE(quad8_index_polarity_modes),
> -       .get =3D quad8_index_polarity_get,
> -       .set =3D quad8_index_polarity_set
> -};
> -
>  static const char *const quad8_synchronous_modes[] =3D {
>         "non-synchronous",
>         "synchronous"
>  };
>
>  static int quad8_synchronous_mode_get(struct counter_device *counter,
> -       struct counter_signal *signal, size_t *synchronous_mode)
> +                                     struct counter_signal *signal,
> +                                     u32 *synchronous_mode)
>  {
>         const struct quad8 *const priv =3D counter->priv;
>         const size_t channel_id =3D signal->id - 16;
> @@ -449,7 +439,8 @@ static int quad8_synchronous_mode_get(struct counter_=
device *counter,
>  }
>
>  static int quad8_synchronous_mode_set(struct counter_device *counter,
> -       struct counter_signal *signal, size_t synchronous_mode)
> +                                     struct counter_signal *signal,
> +                                     u32 synchronous_mode)
>  {
>         struct quad8 *const priv =3D counter->priv;
>         const size_t channel_id =3D signal->id - 16;
> @@ -476,22 +467,18 @@ static int quad8_synchronous_mode_set(struct counte=
r_device *counter,
>         return 0;
>  }
>
> -static struct counter_signal_enum_ext quad8_syn_mode_enum =3D {
> -       .items =3D quad8_synchronous_modes,
> -       .num_items =3D ARRAY_SIZE(quad8_synchronous_modes),
> -       .get =3D quad8_synchronous_mode_get,
> -       .set =3D quad8_synchronous_mode_set
> -};
> -
> -static ssize_t quad8_count_floor_read(struct counter_device *counter,
> -       struct counter_count *count, void *private, char *buf)
> +static int quad8_count_floor_read(struct counter_device *counter,
> +                                 struct counter_count *count, u64 *floor=
)
>  {
>         /* Only a floor of 0 is supported */
> -       return sprintf(buf, "0\n");
> +       *floor =3D 0;
> +
> +       return 0;
>  }
>
> -static int quad8_count_mode_get(struct counter_device *counter,
> -       struct counter_count *count, size_t *cnt_mode)
> +static int quad8_count_mode_read(struct counter_device *counter,
> +                                struct counter_count *count,
> +                                enum counter_count_mode *cnt_mode)
>  {
>         const struct quad8 *const priv =3D counter->priv;
>
> @@ -514,26 +501,28 @@ static int quad8_count_mode_get(struct counter_devi=
ce *counter,
>         return 0;
>  }
>
> -static int quad8_count_mode_set(struct counter_device *counter,
> -       struct counter_count *count, size_t cnt_mode)
> +static int quad8_count_mode_write(struct counter_device *counter,
> +                                 struct counter_count *count,
> +                                 enum counter_count_mode cnt_mode)
>  {
>         struct quad8 *const priv =3D counter->priv;
> +       unsigned int count_mode;
>         unsigned int mode_cfg;
>         const int base_offset =3D priv->base + 2 * count->id + 1;
>
>         /* Map Generic Counter count mode to 104-QUAD-8 count mode */
>         switch (cnt_mode) {
>         case COUNTER_COUNT_MODE_NORMAL:
> -               cnt_mode =3D 0;
> +               count_mode =3D 0;
>                 break;
>         case COUNTER_COUNT_MODE_RANGE_LIMIT:
> -               cnt_mode =3D 1;
> +               count_mode =3D 1;
>                 break;
>         case COUNTER_COUNT_MODE_NON_RECYCLE:
> -               cnt_mode =3D 2;
> +               count_mode =3D 2;
>                 break;
>         case COUNTER_COUNT_MODE_MODULO_N:
> -               cnt_mode =3D 3;
> +               count_mode =3D 3;
>                 break;
>         default:
>                 /* should never reach this path */
> @@ -542,10 +531,10 @@ static int quad8_count_mode_set(struct counter_devi=
ce *counter,
>
>         mutex_lock(&priv->lock);
>
> -       priv->count_mode[count->id] =3D cnt_mode;
> +       priv->count_mode[count->id] =3D count_mode;
>
>         /* Set count mode configuration value */
> -       mode_cfg =3D cnt_mode << 1;
> +       mode_cfg =3D count_mode << 1;
>
>         /* Add quadrature mode configuration */
>         if (priv->quadrature_mode[count->id])
> @@ -559,56 +548,35 @@ static int quad8_count_mode_set(struct counter_devi=
ce *counter,
>         return 0;
>  }
>
> -static struct counter_count_enum_ext quad8_cnt_mode_enum =3D {
> -       .items =3D counter_count_mode_str,
> -       .num_items =3D ARRAY_SIZE(counter_count_mode_str),
> -       .get =3D quad8_count_mode_get,
> -       .set =3D quad8_count_mode_set
> -};
> -
> -static ssize_t quad8_count_direction_read(struct counter_device *counter=
,
> -       struct counter_count *count, void *priv, char *buf)
> -{
> -       enum counter_count_direction dir;
> -
> -       quad8_direction_get(counter, count, &dir);
> -
> -       return sprintf(buf, "%s\n", counter_count_direction_str[dir]);
> -}
> -
> -static ssize_t quad8_count_enable_read(struct counter_device *counter,
> -       struct counter_count *count, void *private, char *buf)
> +static int quad8_count_enable_read(struct counter_device *counter,
> +                                  struct counter_count *count, u8 *enabl=
e)
>  {
>         const struct quad8 *const priv =3D counter->priv;
>
> -       return sprintf(buf, "%u\n", priv->ab_enable[count->id]);
> +       *enable =3D priv->ab_enable[count->id];
> +
> +       return 0;
>  }
>
> -static ssize_t quad8_count_enable_write(struct counter_device *counter,
> -       struct counter_count *count, void *private, const char *buf, size=
_t len)
> +static int quad8_count_enable_write(struct counter_device *counter,
> +                                   struct counter_count *count, u8 enabl=
e)
>  {
>         struct quad8 *const priv =3D counter->priv;
>         const int base_offset =3D priv->base + 2 * count->id;
> -       int err;
> -       bool ab_enable;
>         unsigned int ior_cfg;
>
> -       err =3D kstrtobool(buf, &ab_enable);
> -       if (err)
> -               return err;
> -
>         mutex_lock(&priv->lock);
>
> -       priv->ab_enable[count->id] =3D ab_enable;
> +       priv->ab_enable[count->id] =3D enable;
>
> -       ior_cfg =3D ab_enable | priv->preset_enable[count->id] << 1;
> +       ior_cfg =3D enable | priv->preset_enable[count->id] << 1;
>
>         /* Load I/O control configuration */
>         outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
>
>         mutex_unlock(&priv->lock);
>
> -       return len;
> +       return 0;
>  }
>
>  static const char *const quad8_noise_error_states[] =3D {
> @@ -617,7 +585,7 @@ static const char *const quad8_noise_error_states[] =
=3D {
>  };
>
>  static int quad8_error_noise_get(struct counter_device *counter,
> -       struct counter_count *count, size_t *noise_error)
> +                                struct counter_count *count, u32 *noise_=
error)
>  {
>         const struct quad8 *const priv =3D counter->priv;
>         const int base_offset =3D priv->base + 2 * count->id + 1;
> @@ -627,18 +595,14 @@ static int quad8_error_noise_get(struct counter_dev=
ice *counter,
>         return 0;
>  }
>
> -static struct counter_count_enum_ext quad8_error_noise_enum =3D {
> -       .items =3D quad8_noise_error_states,
> -       .num_items =3D ARRAY_SIZE(quad8_noise_error_states),
> -       .get =3D quad8_error_noise_get
> -};
> -
> -static ssize_t quad8_count_preset_read(struct counter_device *counter,
> -       struct counter_count *count, void *private, char *buf)
> +static int quad8_count_preset_read(struct counter_device *counter,
> +                                  struct counter_count *count, u64 *pres=
et)
>  {
>         const struct quad8 *const priv =3D counter->priv;
>
> -       return sprintf(buf, "%u\n", priv->preset[count->id]);
> +       *preset =3D priv->preset[count->id];
> +
> +       return 0;
>  }
>
>  static void quad8_preset_register_set(struct quad8 *const priv, const in=
t id,
> @@ -657,16 +621,10 @@ static void quad8_preset_register_set(struct quad8 =
*const priv, const int id,
>                 outb(preset >> (8 * i), base_offset);
>  }
>
> -static ssize_t quad8_count_preset_write(struct counter_device *counter,
> -       struct counter_count *count, void *private, const char *buf, size=
_t len)
> +static int quad8_count_preset_write(struct counter_device *counter,
> +                                   struct counter_count *count, u64 pres=
et)
>  {
>         struct quad8 *const priv =3D counter->priv;
> -       unsigned int preset;
> -       int ret;
> -
> -       ret =3D kstrtouint(buf, 0, &preset);
> -       if (ret)
> -               return ret;
>
>         /* Only 24-bit values are supported */
>         if (preset > 0xFFFFFF)
> @@ -678,11 +636,11 @@ static ssize_t quad8_count_preset_write(struct coun=
ter_device *counter,
>
>         mutex_unlock(&priv->lock);
>
> -       return len;
> +       return 0;
>  }
>
> -static ssize_t quad8_count_ceiling_read(struct counter_device *counter,
> -       struct counter_count *count, void *private, char *buf)
> +static int quad8_count_ceiling_read(struct counter_device *counter,
> +                                   struct counter_count *count, u64 *cei=
ling)
>  {
>         struct quad8 *const priv =3D counter->priv;
>
> @@ -692,26 +650,23 @@ static ssize_t quad8_count_ceiling_read(struct coun=
ter_device *counter,
>         switch (priv->count_mode[count->id]) {
>         case 1:
>         case 3:
> -               mutex_unlock(&priv->lock);
> -               return sprintf(buf, "%u\n", priv->preset[count->id]);
> +               *ceiling =3D priv->preset[count->id];
> +               break;
> +       default:
> +               /* By default 0x1FFFFFF (25 bits unsigned) is maximum cou=
nt */
> +               *ceiling =3D 0x1FFFFFF;
> +               break;
>         }
>
>         mutex_unlock(&priv->lock);
>
> -       /* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
> -       return sprintf(buf, "33554431\n");
> +       return 0;
>  }
>
> -static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
> -       struct counter_count *count, void *private, const char *buf, size=
_t len)
> +static int quad8_count_ceiling_write(struct counter_device *counter,
> +                                    struct counter_count *count, u64 cei=
ling)
>  {
>         struct quad8 *const priv =3D counter->priv;
> -       unsigned int ceiling;
> -       int ret;
> -
> -       ret =3D kstrtouint(buf, 0, &ceiling);
> -       if (ret)
> -               return ret;
>
>         /* Only 24-bit values are supported */
>         if (ceiling > 0xFFFFFF)
> @@ -725,7 +680,7 @@ static ssize_t quad8_count_ceiling_write(struct count=
er_device *counter,
>         case 3:
>                 quad8_preset_register_set(priv, count->id, ceiling);
>                 mutex_unlock(&priv->lock);
> -               return len;
> +               return 0;
>         }
>
>         mutex_unlock(&priv->lock);
> @@ -733,27 +688,25 @@ static ssize_t quad8_count_ceiling_write(struct cou=
nter_device *counter,
>         return -EINVAL;
>  }
>
> -static ssize_t quad8_count_preset_enable_read(struct counter_device *cou=
nter,
> -       struct counter_count *count, void *private, char *buf)
> +static int quad8_count_preset_enable_read(struct counter_device *counter=
,
> +                                         struct counter_count *count,
> +                                         u8 *preset_enable)
>  {
>         const struct quad8 *const priv =3D counter->priv;
>
> -       return sprintf(buf, "%u\n", !priv->preset_enable[count->id]);
> +       *preset_enable =3D !priv->preset_enable[count->id];
> +
> +       return 0;
>  }
>
> -static ssize_t quad8_count_preset_enable_write(struct counter_device *co=
unter,
> -       struct counter_count *count, void *private, const char *buf, size=
_t len)
> +static int quad8_count_preset_enable_write(struct counter_device *counte=
r,
> +                                          struct counter_count *count,
> +                                          u8 preset_enable)
>  {
>         struct quad8 *const priv =3D counter->priv;
>         const int base_offset =3D priv->base + 2 * count->id + 1;
> -       bool preset_enable;
> -       int ret;
>         unsigned int ior_cfg;
>
> -       ret =3D kstrtobool(buf, &preset_enable);
> -       if (ret)
> -               return ret;
> -
>         /* Preset enable is active low in Input/Output Control register *=
/
>         preset_enable =3D !preset_enable;
>
> @@ -761,25 +714,24 @@ static ssize_t quad8_count_preset_enable_write(stru=
ct counter_device *counter,
>
>         priv->preset_enable[count->id] =3D preset_enable;
>
> -       ior_cfg =3D priv->ab_enable[count->id] | (unsigned int)preset_ena=
ble << 1;
> +       ior_cfg =3D priv->ab_enable[count->id] | preset_enable << 1;
>
>         /* Load I/O control configuration to Input / Output Control Regis=
ter */
>         outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
>
>         mutex_unlock(&priv->lock);
>
> -       return len;
> +       return 0;
>  }
>
> -static ssize_t quad8_signal_cable_fault_read(struct counter_device *coun=
ter,
> -                                            struct counter_signal *signa=
l,
> -                                            void *private, char *buf)
> +static int quad8_signal_cable_fault_read(struct counter_device *counter,
> +                                        struct counter_signal *signal,
> +                                        u8 *cable_fault)
>  {
>         struct quad8 *const priv =3D counter->priv;
>         const size_t channel_id =3D signal->id / 2;
>         bool disabled;
>         unsigned int status;
> -       unsigned int fault;
>
>         mutex_lock(&priv->lock);
>
> @@ -796,36 +748,31 @@ static ssize_t quad8_signal_cable_fault_read(struct=
 counter_device *counter,
>         mutex_unlock(&priv->lock);
>
>         /* Mask respective channel and invert logic */
> -       fault =3D !(status & BIT(channel_id));
> +       *cable_fault =3D !(status & BIT(channel_id));
>
> -       return sprintf(buf, "%u\n", fault);
> +       return 0;
>  }
>
> -static ssize_t quad8_signal_cable_fault_enable_read(
> -       struct counter_device *counter, struct counter_signal *signal,
> -       void *private, char *buf)
> +static int quad8_signal_cable_fault_enable_read(struct counter_device *c=
ounter,
> +                                               struct counter_signal *si=
gnal,
> +                                               u8 *enable)
>  {
>         const struct quad8 *const priv =3D counter->priv;
>         const size_t channel_id =3D signal->id / 2;
> -       const unsigned int enb =3D !!(priv->cable_fault_enable & BIT(chan=
nel_id));
>
> -       return sprintf(buf, "%u\n", enb);
> +       *enable =3D !!(priv->cable_fault_enable & BIT(channel_id));
> +
> +       return 0;
>  }
>
> -static ssize_t quad8_signal_cable_fault_enable_write(
> -       struct counter_device *counter, struct counter_signal *signal,
> -       void *private, const char *buf, size_t len)
> +static int quad8_signal_cable_fault_enable_write(struct counter_device *=
counter,
> +                                                struct counter_signal *s=
ignal,
> +                                                u8 enable)
>  {
>         struct quad8 *const priv =3D counter->priv;
>         const size_t channel_id =3D signal->id / 2;
> -       bool enable;
> -       int ret;
>         unsigned int cable_fault_enable;
>
> -       ret =3D kstrtobool(buf, &enable);
> -       if (ret)
> -               return ret;
> -
>         mutex_lock(&priv->lock);
>
>         if (enable)
> @@ -840,31 +787,27 @@ static ssize_t quad8_signal_cable_fault_enable_writ=
e(
>
>         mutex_unlock(&priv->lock);
>
> -       return len;
> +       return 0;
>  }
>
> -static ssize_t quad8_signal_fck_prescaler_read(struct counter_device *co=
unter,
> -       struct counter_signal *signal, void *private, char *buf)
> +static int quad8_signal_fck_prescaler_read(struct counter_device *counte=
r,
> +                                          struct counter_signal *signal,
> +                                          u8 *prescaler)
>  {
>         const struct quad8 *const priv =3D counter->priv;
> -       const size_t channel_id =3D signal->id / 2;
>
> -       return sprintf(buf, "%u\n", priv->fck_prescaler[channel_id]);
> +       *prescaler =3D priv->fck_prescaler[signal->id / 2];
> +
> +       return 0;
>  }
>
> -static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *c=
ounter,
> -       struct counter_signal *signal, void *private, const char *buf,
> -       size_t len)
> +static int quad8_signal_fck_prescaler_write(struct counter_device *count=
er,
> +                                           struct counter_signal *signal=
,
> +                                           u8 prescaler)
>  {
>         struct quad8 *const priv =3D counter->priv;
>         const size_t channel_id =3D signal->id / 2;
>         const int base_offset =3D priv->base + 2 * channel_id;
> -       u8 prescaler;
> -       int ret;
> -
> -       ret =3D kstrtou8(buf, 0, &prescaler);
> -       if (ret)
> -               return ret;
>
>         mutex_lock(&priv->lock);
>
> @@ -880,31 +823,30 @@ static ssize_t quad8_signal_fck_prescaler_write(str=
uct counter_device *counter,
>
>         mutex_unlock(&priv->lock);
>
> -       return len;
> +       return 0;
>  }
>
> -static const struct counter_signal_ext quad8_signal_ext[] =3D {
> -       {
> -               .name =3D "cable_fault",
> -               .read =3D quad8_signal_cable_fault_read
> -       },
> -       {
> -               .name =3D "cable_fault_enable",
> -               .read =3D quad8_signal_cable_fault_enable_read,
> -               .write =3D quad8_signal_cable_fault_enable_write
> -       },
> -       {
> -               .name =3D "filter_clock_prescaler",
> -               .read =3D quad8_signal_fck_prescaler_read,
> -               .write =3D quad8_signal_fck_prescaler_write
> -       }
> +static struct counter_comp quad8_signal_ext[] =3D {
> +       COUNTER_COMP_SIGNAL_BOOL("cable_fault", quad8_signal_cable_fault_=
read,
> +                                NULL),
> +       COUNTER_COMP_SIGNAL_BOOL("cable_fault_enable",
> +                                quad8_signal_cable_fault_enable_read,
> +                                quad8_signal_cable_fault_enable_write),
> +       COUNTER_COMP_SIGNAL_U8("filter_clock_prescaler",
> +                              quad8_signal_fck_prescaler_read,
> +                              quad8_signal_fck_prescaler_write)
>  };
>
> -static const struct counter_signal_ext quad8_index_ext[] =3D {
> -       COUNTER_SIGNAL_ENUM("index_polarity", &quad8_index_pol_enum),
> -       COUNTER_SIGNAL_ENUM_AVAILABLE("index_polarity", &quad8_index_pol_=
enum),
> -       COUNTER_SIGNAL_ENUM("synchronous_mode", &quad8_syn_mode_enum),
> -       COUNTER_SIGNAL_ENUM_AVAILABLE("synchronous_mode", &quad8_syn_mode=
_enum)
> +static DEFINE_COUNTER_ENUM(quad8_index_pol_enum, quad8_index_polarity_mo=
des);
> +static DEFINE_COUNTER_ENUM(quad8_synch_mode_enum, quad8_synchronous_mode=
s);
> +
> +static struct counter_comp quad8_index_ext[] =3D {
> +       COUNTER_COMP_SIGNAL_ENUM("index_polarity", quad8_index_polarity_g=
et,
> +                                quad8_index_polarity_set,
> +                                quad8_index_pol_enum),
> +       COUNTER_COMP_SIGNAL_ENUM("synchronous_mode", quad8_synchronous_mo=
de_get,
> +                                quad8_synchronous_mode_set,
> +                                quad8_synch_mode_enum),
>  };
>
>  #define QUAD8_QUAD_SIGNAL(_id, _name) {                \
> @@ -973,39 +915,30 @@ static struct counter_synapse quad8_count_synapses[=
][3] =3D {
>         QUAD8_COUNT_SYNAPSES(6), QUAD8_COUNT_SYNAPSES(7)
>  };
>
> -static const struct counter_count_ext quad8_count_ext[] =3D {
> -       {
> -               .name =3D "ceiling",
> -               .read =3D quad8_count_ceiling_read,
> -               .write =3D quad8_count_ceiling_write
> -       },
> -       {
> -               .name =3D "floor",
> -               .read =3D quad8_count_floor_read
> -       },
> -       COUNTER_COUNT_ENUM("count_mode", &quad8_cnt_mode_enum),
> -       COUNTER_COUNT_ENUM_AVAILABLE("count_mode", &quad8_cnt_mode_enum),
> -       {
> -               .name =3D "direction",
> -               .read =3D quad8_count_direction_read
> -       },
> -       {
> -               .name =3D "enable",
> -               .read =3D quad8_count_enable_read,
> -               .write =3D quad8_count_enable_write
> -       },
> -       COUNTER_COUNT_ENUM("error_noise", &quad8_error_noise_enum),
> -       COUNTER_COUNT_ENUM_AVAILABLE("error_noise", &quad8_error_noise_en=
um),
> -       {
> -               .name =3D "preset",
> -               .read =3D quad8_count_preset_read,
> -               .write =3D quad8_count_preset_write
> -       },
> -       {
> -               .name =3D "preset_enable",
> -               .read =3D quad8_count_preset_enable_read,
> -               .write =3D quad8_count_preset_enable_write
> -       }
> +static const enum counter_count_mode quad8_cnt_modes[] =3D {
> +       COUNTER_COUNT_MODE_NORMAL,
> +       COUNTER_COUNT_MODE_RANGE_LIMIT,
> +       COUNTER_COUNT_MODE_NON_RECYCLE,
> +       COUNTER_COUNT_MODE_MODULO_N,
> +};
> +
> +static DEFINE_COUNTER_AVAILABLE(quad8_count_mode_available, quad8_cnt_mo=
des);
> +
> +static DEFINE_COUNTER_ENUM(quad8_error_noise_enum, quad8_noise_error_sta=
tes);
> +
> +static struct counter_comp quad8_count_ext[] =3D {
> +       COUNTER_COMP_CEILING(quad8_count_ceiling_read,
> +                            quad8_count_ceiling_write),
> +       COUNTER_COMP_FLOOR(quad8_count_floor_read, NULL),
> +       COUNTER_COMP_COUNT_MODE(quad8_count_mode_read, quad8_count_mode_w=
rite,
> +                               quad8_count_mode_available),
> +       COUNTER_COMP_DIRECTION(quad8_direction_read),
> +       COUNTER_COMP_ENABLE(quad8_count_enable_read, quad8_count_enable_w=
rite),
> +       COUNTER_COMP_COUNT_ENUM("error_noise", quad8_error_noise_get, NUL=
L,
> +                               quad8_error_noise_enum),
> +       COUNTER_COMP_PRESET(quad8_count_preset_read, quad8_count_preset_w=
rite),
> +       COUNTER_COMP_PRESET_ENABLE(quad8_count_preset_enable_read,
> +                                  quad8_count_preset_enable_write),
>  };
>
>  #define QUAD8_COUNT(_id, _cntname) {                                   \
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 19742e6f5e3e..1ab7e087fdc2 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -4,6 +4,7 @@
>  #
>
>  obj-$(CONFIG_COUNTER) +=3D counter.o
> +counter-y :=3D counter-core.o counter-sysfs.o
>
>  obj-$(CONFIG_104_QUAD_8)       +=3D 104-quad-8.o
>  obj-$(CONFIG_INTERRUPT_CNT)            +=3D interrupt-cnt.o
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-cor=
e.c
> new file mode 100644
> index 000000000000..15f735ef296e
> --- /dev/null
> +++ b/drivers/counter/counter-core.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic Counter interface
> + * Copyright (C) 2020 William Breathitt Gray
> + */
> +#include <linux/counter.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/gfp.h>
> +#include <linux/idr.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +
> +#include "counter-sysfs.h"
> +
> +/* Provides a unique ID for each counter device */
> +static DEFINE_IDA(counter_ida);
> +
> +static void counter_device_release(struct device *dev)
> +{
> +       struct counter_device *const counter =3D dev_get_drvdata(dev);
> +
> +       counter_chrdev_remove(counter);
> +       ida_free(&counter_ida, dev->id);
> +}
> +
> +static struct device_type counter_device_type =3D {
> +       .name =3D "counter_device",
> +       .release =3D counter_device_release,
> +};
> +
> +static struct bus_type counter_bus_type =3D {
> +       .name =3D "counter",
> +       .dev_name =3D "counter",
> +};
> +
> +/**
> + * counter_register - register Counter to the system
> + * @counter:   pointer to Counter to register
> + *
> + * This function registers a Counter to the system. A sysfs "counter" di=
rectory
> + * will be created and populated with sysfs attributes correlating with =
the
> + * Counter Signals, Synapses, and Counts respectively.
> + */
> +int counter_register(struct counter_device *const counter)
> +{
> +       struct device *const dev =3D &counter->dev;
> +       int id;
> +       int err;
> +
> +       /* Acquire unique ID */
> +       id =3D ida_alloc(&counter_ida, GFP_KERNEL);
> +       if (id < 0)
> +               return id;
> +
> +       /* Configure device structure for Counter */
> +       dev->id =3D id;
> +       dev->type =3D &counter_device_type;
> +       dev->bus =3D &counter_bus_type;
> +       if (counter->parent) {
> +               dev->parent =3D counter->parent;
> +               dev->of_node =3D counter->parent->of_node;
> +       }
> +       device_initialize(dev);
> +       dev_set_drvdata(dev, counter);
> +
> +       /* Add Counter sysfs attributes */
> +       err =3D counter_sysfs_add(counter);
> +       if (err < 0)
> +               goto err_free_id;
> +
> +       /* Add device to system */
> +       err =3D device_add(dev);
> +       if (err < 0)
> +               goto err_free_id;
> +
> +       return 0;
> +
> +err_free_id:
> +       put_device(dev);
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(counter_register);
> +
> +/**
> + * counter_unregister - unregister Counter from the system
> + * @counter:   pointer to Counter to unregister
> + *
> + * The Counter is unregistered from the system.
> + */
> +void counter_unregister(struct counter_device *const counter)
> +{
> +       if (!counter)
> +               return;
> +
> +       device_unregister(&counter->dev);
> +}
> +EXPORT_SYMBOL_GPL(counter_unregister);
> +
> +static void devm_counter_release(void *counter)
> +{
> +       counter_unregister(counter);
> +}
> +
> +/**
> + * devm_counter_register - Resource-managed counter_register
> + * @dev:       device to allocate counter_device for
> + * @counter:   pointer to Counter to register
> + *
> + * Managed counter_register. The Counter registered with this function i=
s
> + * automatically unregistered on driver detach. This function calls
> + * counter_register internally. Refer to that function for more informat=
ion.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int devm_counter_register(struct device *dev,
> +                         struct counter_device *const counter)
> +{
> +       int err;
> +
> +       err =3D counter_register(counter);
> +       if (err < 0)
> +               return err;
> +
> +       return devm_add_action_or_reset(dev, devm_counter_release, counte=
r);
> +}
> +EXPORT_SYMBOL_GPL(devm_counter_register);
> +
> +static int __init counter_init(void)
> +{
> +       return bus_register(&counter_bus_type);
> +}
> +
> +static void __exit counter_exit(void)
> +{
> +       bus_unregister(&counter_bus_type);
> +}
> +
> +subsys_initcall(counter_init);
> +module_exit(counter_exit);
> +
> +MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
> +MODULE_DESCRIPTION("Generic Counter interface");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sy=
sfs.c
> new file mode 100644
> index 000000000000..07588130600a
> --- /dev/null
> +++ b/drivers/counter/counter-sysfs.c
> @@ -0,0 +1,846 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic Counter sysfs interface
> + * Copyright (C) 2020 William Breathitt Gray
> + */
> +#include <linux/counter.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gfp.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#include "counter-sysfs.h"
> +
> +/**
> + * struct counter_attribute - Counter sysfs attribute
> + * @dev_attr:  device attribute for sysfs
> + * @l:         node to add Counter attribute to attribute group list
> + * @comp:      Counter component callbacks and data
> + * @scope:     Counter scope of the attribute
> + * @parent:    pointer to the parent component
> + */
> +struct counter_attribute {
> +       struct device_attribute dev_attr;
> +       struct list_head l;
> +
> +       struct counter_comp comp;
> +       enum counter_scope scope;
> +       void *parent;
> +};
> +
> +#define to_counter_attribute(_dev_attr) \
> +       container_of(_dev_attr, struct counter_attribute, dev_attr)
> +
> +/**
> + * struct counter_attribute_group - container for attribute group
> + * @name:      name of the attribute group
> + * @attr_list: list to keep track of created attributes
> + * @num_attr:  number of attributes
> + */
> +struct counter_attribute_group {
> +       const char *name;
> +       struct list_head attr_list;
> +       size_t num_attr;
> +};
> +
> +static const char *const counter_function_str[] =3D {
> +       [COUNTER_FUNCTION_INCREASE] =3D "increase",
> +       [COUNTER_FUNCTION_DECREASE] =3D "decrease",
> +       [COUNTER_FUNCTION_PULSE_DIRECTION] =3D "pulse-direction",
> +       [COUNTER_FUNCTION_QUADRATURE_X1_A] =3D "quadrature x1 a",
> +       [COUNTER_FUNCTION_QUADRATURE_X1_B] =3D "quadrature x1 b",
> +       [COUNTER_FUNCTION_QUADRATURE_X2_A] =3D "quadrature x2 a",
> +       [COUNTER_FUNCTION_QUADRATURE_X2_B] =3D "quadrature x2 b",
> +       [COUNTER_FUNCTION_QUADRATURE_X4] =3D "quadrature x4"
> +};
> +
> +static const char *const counter_signal_value_str[] =3D {
> +       [COUNTER_SIGNAL_LEVEL_LOW] =3D "low",
> +       [COUNTER_SIGNAL_LEVEL_HIGH] =3D "high"
> +};
> +
> +static const char *const counter_synapse_action_str[] =3D {
> +       [COUNTER_SYNAPSE_ACTION_NONE] =3D "none",
> +       [COUNTER_SYNAPSE_ACTION_RISING_EDGE] =3D "rising edge",
> +       [COUNTER_SYNAPSE_ACTION_FALLING_EDGE] =3D "falling edge",
> +       [COUNTER_SYNAPSE_ACTION_BOTH_EDGES] =3D "both edges"
> +};
> +
> +static const char *const counter_count_direction_str[] =3D {
> +       [COUNTER_COUNT_DIRECTION_FORWARD] =3D "forward",
> +       [COUNTER_COUNT_DIRECTION_BACKWARD] =3D "backward"
> +};
> +
> +static const char *const counter_count_mode_str[] =3D {
> +       [COUNTER_COUNT_MODE_NORMAL] =3D "normal",
> +       [COUNTER_COUNT_MODE_RANGE_LIMIT] =3D "range limit",
> +       [COUNTER_COUNT_MODE_NON_RECYCLE] =3D "non-recycle",
> +       [COUNTER_COUNT_MODE_MODULO_N] =3D "modulo-n"
> +};
> +
> +static ssize_t counter_comp_u8_show(struct device *dev,
> +                                   struct device_attribute *attr, char *=
buf)
> +{
> +       const struct counter_attribute *const a =3D to_counter_attribute(=
attr);
> +       struct counter_device *const counter =3D dev_get_drvdata(dev);
> +       int err;
> +       u8 data =3D 0;
> +
> +       switch (a->scope) {
> +       case COUNTER_SCOPE_DEVICE:
> +               err =3D a->comp.device_u8_read(counter, &data);
> +               break;
> +       case COUNTER_SCOPE_SIGNAL:
> +               err =3D a->comp.signal_u8_read(counter, a->parent, &data)=
;
> +               break;
> +       case COUNTER_SCOPE_COUNT:
> +               err =3D a->comp.count_u8_read(counter, a->parent, &data);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +       if (err < 0)
> +               return err;
> +
> +       if (a->comp.type =3D=3D COUNTER_COMP_BOOL)
> +               data =3D !!data;
> +
> +       return sprintf(buf, "%u\n", (unsigned int)data);
> +}
> +
> +static ssize_t counter_comp_u8_store(struct device *dev,
> +                                    struct device_attribute *attr,
> +                                    const char *buf, size_t len)
> +{
> +       const struct counter_attribute *const a =3D to_counter_attribute(=
attr);
> +       struct counter_device *const counter =3D dev_get_drvdata(dev);
> +       int err;
> +       bool bool_data =3D 0;
> +       u8 data =3D 0;
> +
> +       if (a->comp.type =3D=3D COUNTER_COMP_BOOL) {
> +               err =3D kstrtobool(buf, &bool_data);
> +               data =3D bool_data;
> +       } else
> +               err =3D kstrtou8(buf, 0, &data);
> +       if (err < 0)
> +               return err;
> +
> +       switch (a->scope) {
> +       case COUNTER_SCOPE_DEVICE:
> +               err =3D a->comp.device_u8_write(counter, data);
> +               break;
> +       case COUNTER_SCOPE_SIGNAL:
> +               err =3D a->comp.signal_u8_write(counter, a->parent, data)=
;
> +               break;
> +       case COUNTER_SCOPE_COUNT:
> +               err =3D a->comp.count_u8_write(counter, a->parent, data);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +       if (err < 0)
> +               return err;
> +
> +       return len;
> +}
> +
> +static ssize_t counter_comp_u32_show(struct device *dev,
> +                                    struct device_attribute *attr, char =
*buf)
> +{
> +       const struct counter_attribute *const a =3D to_counter_attribute(=
attr);
> +       struct counter_device *const counter =3D dev_get_drvdata(dev);
> +       const struct counter_available *const avail =3D a->comp.priv;
> +       int err;
> +       u32 data =3D 0;
> +
> +       switch (a->scope) {
> +       case COUNTER_SCOPE_DEVICE:
> +               err =3D a->comp.device_u32_read(counter, &data);
> +               break;
> +       case COUNTER_SCOPE_SIGNAL:
> +               err =3D a->comp.signal_u32_read(counter, a->parent, &data=
);
> +               break;
> +       case COUNTER_SCOPE_COUNT:
> +               if (a->comp.type =3D=3D COUNTER_COMP_SYNAPSE_ACTION)
> +                       err =3D a->comp.action_read(counter, a->parent,
> +                                                 a->comp.priv, &data);
> +               else
> +                       err =3D a->comp.count_u32_read(counter, a->parent=
, &data);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +       if (err < 0)
> +               return err;
> +
> +       switch (a->comp.type) {
> +       case COUNTER_COMP_FUNCTION:
> +               return sysfs_emit(buf, "%s\n", counter_function_str[data]=
);
> +       case COUNTER_COMP_SIGNAL_LEVEL:
> +               return sysfs_emit(buf, "%s\n", counter_signal_value_str[d=
ata]);
> +       case COUNTER_COMP_SYNAPSE_ACTION:
> +               return sysfs_emit(buf, "%s\n", counter_synapse_action_str=
[data]);
> +       case COUNTER_COMP_ENUM:
> +               return sysfs_emit(buf, "%s\n", avail->strs[data]);
> +       case COUNTER_COMP_COUNT_DIRECTION:
> +               return sysfs_emit(buf, "%s\n", counter_count_direction_st=
r[data]);
> +       case COUNTER_COMP_COUNT_MODE:
> +               return sysfs_emit(buf, "%s\n", counter_count_mode_str[dat=
a]);
> +       default:
> +               return sprintf(buf, "%u\n", (unsigned int)data);
> +       }
> +}
> +
> +static int counter_find_enum(u32 *const enum_item, const u32 *const enum=
s,
> +                            const size_t num_enums, const char *const bu=
f,
> +                            const char *const string_array[])
> +{
> +       size_t index;
> +
> +       for (index =3D 0; index < num_enums; index++) {
> +               *enum_item =3D enums[index];
> +               if (sysfs_streq(buf, string_array[*enum_item]))
> +                       return 0;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static ssize_t counter_comp_u32_store(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     const char *buf, size_t len)
> +{
> +       const struct counter_attribute *const a =3D to_counter_attribute(=
attr);
> +       struct counter_device *const counter =3D dev_get_drvdata(dev);
> +       struct counter_count *const count =3D a->parent;
> +       struct counter_synapse *const synapse =3D a->comp.priv;
> +       const struct counter_available *const avail =3D a->comp.priv;
> +       int err;
> +       u32 data =3D 0;
> +
> +       switch (a->comp.type) {
> +       case COUNTER_COMP_FUNCTION:
> +               err =3D counter_find_enum(&data, count->functions_list,
> +                                       count->num_functions, buf,
> +                                       counter_function_str);
> +               break;
> +       case COUNTER_COMP_SYNAPSE_ACTION:
> +               err =3D counter_find_enum(&data, synapse->actions_list,
> +                                       synapse->num_actions, buf,
> +                                       counter_synapse_action_str);
> +               break;
> +       case COUNTER_COMP_ENUM:
> +               err =3D __sysfs_match_string(avail->strs, avail->num_item=
s, buf);
> +               data =3D err;
> +               break;
> +       case COUNTER_COMP_COUNT_MODE:
> +               err =3D counter_find_enum(&data, avail->enums, avail->num=
_items,
> +                                       buf, counter_count_mode_str);
> +               break;
> +       default:
> +               err =3D kstrtou32(buf, 0, &data);
> +               break;
> +       }
> +       if (err < 0)
> +               return err;
> +
> +       switch (a->scope) {
> +       case COUNTER_SCOPE_DEVICE:
> +               err =3D a->comp.device_u32_write(counter, data);
> +               break;
> +       case COUNTER_SCOPE_SIGNAL:
> +               err =3D a->comp.signal_u32_write(counter, a->parent, data=
);
> +               break;
> +       case COUNTER_SCOPE_COUNT:
> +               if (a->comp.type =3D=3D COUNTER_COMP_SYNAPSE_ACTION)
> +                       err =3D a->comp.action_write(counter, count, syna=
pse,
> +                                                  data);
> +               else
> +                       err =3D a->comp.count_u32_write(counter, count, d=
ata);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +       if (err < 0)
> +               return err;
> +
> +       return len;
> +}
> +
> +static ssize_t counter_comp_u64_show(struct device *dev,
> +                                    struct device_attribute *attr, char =
*buf)
> +{
> +       const struct counter_attribute *const a =3D to_counter_attribute(=
attr);
> +       struct counter_device *const counter =3D dev_get_drvdata(dev);
> +       int err;
> +       u64 data =3D 0;
> +
> +       switch (a->scope) {
> +       case COUNTER_SCOPE_DEVICE:
> +               err =3D a->comp.device_u64_read(counter, &data);
> +               break;
> +       case COUNTER_SCOPE_SIGNAL:
> +               err =3D a->comp.signal_u64_read(counter, a->parent, &data=
);
> +               break;
> +       case COUNTER_SCOPE_COUNT:
> +               err =3D a->comp.count_u64_read(counter, a->parent, &data)=
;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +       if (err < 0)
> +               return err;
> +
> +       return sprintf(buf, "%llu\n", (unsigned long long)data);
> +}
> +
> +static ssize_t counter_comp_u64_store(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     const char *buf, size_t len)
> +{
> +       const struct counter_attribute *const a =3D to_counter_attribute(=
attr);
> +       struct counter_device *const counter =3D dev_get_drvdata(dev);
> +       int err;
> +       u64 data =3D 0;
> +
> +       err =3D kstrtou64(buf, 0, &data);
> +       if (err < 0)
> +               return err;
> +
> +       switch (a->scope) {
> +       case COUNTER_SCOPE_DEVICE:
> +               err =3D a->comp.device_u64_write(counter, data);
> +               break;
> +       case COUNTER_SCOPE_SIGNAL:
> +               err =3D a->comp.signal_u64_write(counter, a->parent, data=
);
> +               break;
> +       case COUNTER_SCOPE_COUNT:
> +               err =3D a->comp.count_u64_write(counter, a->parent, data)=
;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +       if (err < 0)
> +               return err;
> +
> +       return len;
> +}
> +
> +static ssize_t enums_available_show(const u32 *const enums,
> +                                   const size_t num_enums,
> +                                   const char *const strs[], char *buf)
> +{
> +       size_t len =3D 0;
> +       size_t index;
> +
> +       for (index =3D 0; index < num_enums; index++)
> +               len +=3D sysfs_emit_at(buf, len, "%s\n", strs[enums[index=
]]);
> +
> +       return len;
> +}
> +
> +static ssize_t strs_available_show(const struct counter_available *const=
 avail,
> +                                  char *buf)
> +{
> +       size_t len =3D 0;
> +       size_t index;
> +
> +       for (index =3D 0; index < avail->num_items; index++)
> +               len +=3D sysfs_emit_at(buf, len, "%s\n", avail->strs[inde=
x]);
> +
> +       return len;
> +}
> +
> +static ssize_t counter_comp_available_show(struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          char *buf)
> +{
> +       const struct counter_attribute *const a =3D to_counter_attribute(=
attr);
> +       const struct counter_count *const count =3D a->parent;
> +       const struct counter_synapse *const synapse =3D a->comp.priv;
> +       const struct counter_available *const avail =3D a->comp.priv;
> +
> +       switch (a->comp.type) {
> +       case COUNTER_COMP_FUNCTION:
> +               return enums_available_show(count->functions_list,
> +                                           count->num_functions,
> +                                           counter_function_str, buf);
> +       case COUNTER_COMP_SYNAPSE_ACTION:
> +               return enums_available_show(synapse->actions_list,
> +                                           synapse->num_actions,
> +                                           counter_synapse_action_str, b=
uf);
> +       case COUNTER_COMP_ENUM:
> +               return strs_available_show(avail, buf);
> +       case COUNTER_COMP_COUNT_MODE:
> +               return enums_available_show(avail->enums, avail->num_item=
s,
> +                                           counter_count_mode_str, buf);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int counter_avail_attr_create(struct device *const dev,
> +       struct counter_attribute_group *const group,
> +       const struct counter_comp *const comp, void *const parent)
> +{
> +       struct counter_attribute *counter_attr;
> +       struct device_attribute *dev_attr;
> +
> +       /* Allocate Counter attribute */
> +       counter_attr =3D devm_kzalloc(dev, sizeof(*counter_attr), GFP_KER=
NEL);
> +       if (!counter_attr)
> +               return -ENOMEM;
> +
> +       /* Configure Counter attribute */
> +       counter_attr->comp.type =3D comp->type;
> +       counter_attr->comp.priv =3D comp->priv;
> +       counter_attr->parent =3D parent;
> +
> +       /* Initialize sysfs attribute */
> +       dev_attr =3D &counter_attr->dev_attr;
> +       sysfs_attr_init(&dev_attr->attr);
> +
> +       /* Configure device attribute */
> +       dev_attr->attr.name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_avail=
able",
> +                                            comp->name);
> +       if (!dev_attr->attr.name)
> +               return -ENOMEM;
> +       dev_attr->attr.mode =3D 0444;
> +       dev_attr->show =3D counter_comp_available_show;
> +
> +       /* Store list node */
> +       list_add(&counter_attr->l, &group->attr_list);
> +       group->num_attr++;
> +
> +       return 0;
> +}
> +
> +static int counter_attr_create(struct device *const dev,
> +                              struct counter_attribute_group *const grou=
p,
> +                              const struct counter_comp *const comp,
> +                              const enum counter_scope scope,
> +                              void *const parent)
> +{
> +       struct counter_attribute *counter_attr;
> +       struct device_attribute *dev_attr;
> +
> +       /* Allocate Counter attribute */
> +       counter_attr =3D devm_kzalloc(dev, sizeof(*counter_attr), GFP_KER=
NEL);
> +       if (!counter_attr)
> +               return -ENOMEM;
> +
> +       /* Configure Counter attribute */
> +       counter_attr->comp =3D *comp;
> +       counter_attr->scope =3D scope;
> +       counter_attr->parent =3D parent;
> +
> +       /* Configure device attribute */
> +       dev_attr =3D &counter_attr->dev_attr;
> +       sysfs_attr_init(&dev_attr->attr);
> +       dev_attr->attr.name =3D comp->name;
> +       switch (comp->type) {
> +       case COUNTER_COMP_U8:
> +       case COUNTER_COMP_BOOL:
> +               if (comp->device_u8_read) {
> +                       dev_attr->attr.mode |=3D 0444;
> +                       dev_attr->show =3D counter_comp_u8_show;
> +               }
> +               if (comp->device_u8_write) {
> +                       dev_attr->attr.mode |=3D 0200;
> +                       dev_attr->store =3D counter_comp_u8_store;
> +               }
> +               break;
> +       case COUNTER_COMP_SIGNAL_LEVEL:
> +       case COUNTER_COMP_FUNCTION:
> +       case COUNTER_COMP_SYNAPSE_ACTION:
> +       case COUNTER_COMP_ENUM:
> +       case COUNTER_COMP_COUNT_DIRECTION:
> +       case COUNTER_COMP_COUNT_MODE:
> +               if (comp->device_u32_read) {
> +                       dev_attr->attr.mode |=3D 0444;
> +                       dev_attr->show =3D counter_comp_u32_show;
> +               }
> +               if (comp->device_u32_write) {
> +                       dev_attr->attr.mode |=3D 0200;
> +                       dev_attr->store =3D counter_comp_u32_store;
> +               }
> +               break;
> +       case COUNTER_COMP_U64:
> +               if (comp->device_u64_read) {
> +                       dev_attr->attr.mode |=3D 0444;
> +                       dev_attr->show =3D counter_comp_u64_show;
> +               }
> +               if (comp->device_u64_write) {
> +                       dev_attr->attr.mode |=3D 0200;
> +                       dev_attr->store =3D counter_comp_u64_store;
> +               }
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       /* Store list node */
> +       list_add(&counter_attr->l, &group->attr_list);
> +       group->num_attr++;
> +
> +       /* Create "*_available" attribute if needed */
> +       switch (comp->type) {
> +       case COUNTER_COMP_FUNCTION:
> +       case COUNTER_COMP_SYNAPSE_ACTION:
> +       case COUNTER_COMP_ENUM:
> +       case COUNTER_COMP_COUNT_MODE:
> +               return counter_avail_attr_create(dev, group, comp, parent=
);
> +       default:
> +               return 0;
> +       }
> +}
> +
> +static ssize_t counter_comp_name_show(struct device *dev,
> +                                     struct device_attribute *attr, char=
 *buf)
> +{
> +       return sysfs_emit(buf, "%s\n", to_counter_attribute(attr)->comp.n=
ame);
> +}
> +
> +static int counter_name_attr_create(struct device *const dev,
> +                                   struct counter_attribute_group *const=
 group,
> +                                   const char *const name)
> +{
> +       struct counter_attribute *counter_attr;
> +
> +       /* Allocate Counter attribute */
> +       counter_attr =3D devm_kzalloc(dev, sizeof(*counter_attr), GFP_KER=
NEL);
> +       if (!counter_attr)
> +               return -ENOMEM;
> +
> +       /* Configure Counter attribute */
> +       counter_attr->comp.name =3D name;
> +
> +       /* Configure device attribute */
> +       sysfs_attr_init(&counter_attr->dev_attr.attr);
> +       counter_attr->dev_attr.attr.name =3D "name";
> +       counter_attr->dev_attr.attr.mode =3D 0444;
> +       counter_attr->dev_attr.show =3D counter_comp_name_show;
> +
> +       /* Store list node */
> +       list_add(&counter_attr->l, &group->attr_list);
> +       group->num_attr++;
> +
> +       return 0;
> +}
> +
> +static struct counter_comp counter_signal_comp =3D {
> +       .type =3D COUNTER_COMP_SIGNAL_LEVEL,
> +       .name =3D "signal",
> +};
> +
> +static int counter_signal_attrs_create(struct counter_device *const coun=
ter,
> +       struct counter_attribute_group *const group,
> +       struct counter_signal *const signal)
> +{
> +       const enum counter_scope scope =3D COUNTER_SCOPE_SIGNAL;
> +       struct device *const dev =3D &counter->dev;
> +       int err;
> +       struct counter_comp comp;
> +       size_t i;
> +
> +       /* Create main Signal attribute */
> +       comp =3D counter_signal_comp;
> +       comp.signal_u32_read =3D counter->ops->signal_read;
> +       err =3D counter_attr_create(dev, group, &comp, scope, signal);
> +       if (err < 0)
> +               return err;
> +
> +       /* Create Signal name attribute */
> +       err =3D counter_name_attr_create(dev, group, signal->name);
> +       if (err < 0)
> +               return err;
> +
> +       /* Create an attribute for each extension */
> +       for (i =3D 0; i < signal->num_ext; i++) {
> +               err =3D counter_attr_create(dev, group, signal->ext + i, =
scope,
> +                                         signal);
> +               if (err < 0)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int counter_sysfs_signals_add(struct counter_device *const counte=
r,
> +       struct counter_attribute_group *const groups)
> +{
> +       size_t i;
> +       int err;
> +
> +       /* Add each Signal */
> +       for (i =3D 0; i < counter->num_signals; i++) {
> +               /* Generate Signal attribute directory name */
> +               groups[i].name =3D devm_kasprintf(&counter->dev, GFP_KERN=
EL,
> +                                               "signal%zu", i);
> +               if (!groups[i].name)
> +                       return -ENOMEM;
> +
> +               /* Create all attributes associated with Signal */
> +               err =3D counter_signal_attrs_create(counter, groups + i,
> +                                                 counter->signals + i);
> +               if (err < 0)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int counter_sysfs_synapses_add(struct counter_device *const count=
er,
> +       struct counter_attribute_group *const group,
> +       struct counter_count *const count)
> +{
> +       size_t i;
> +
> +       /* Add each Synapse */
> +       for (i =3D 0; i < count->num_synapses; i++) {
> +               struct device *const dev =3D &counter->dev;
> +               struct counter_synapse *synapse;
> +               size_t id;
> +               struct counter_comp comp;
> +               int err;
> +
> +               synapse =3D count->synapses + i;
> +
> +               /* Generate Synapse action name */
> +               id =3D synapse->signal - counter->signals;
> +               comp.name =3D devm_kasprintf(dev, GFP_KERNEL, "signal%zu_=
action",
> +                                          id);
> +               if (!comp.name)
> +                       return -ENOMEM;
> +
> +               /* Create action attribute */
> +               comp.type =3D COUNTER_COMP_SYNAPSE_ACTION;
> +               comp.action_read =3D counter->ops->action_read;
> +               comp.action_write =3D counter->ops->action_write;
> +               comp.priv =3D synapse;
> +               err =3D counter_attr_create(dev, group, &comp,
> +                                         COUNTER_SCOPE_COUNT, count);
> +               if (err < 0)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static struct counter_comp counter_count_comp =3D
> +       COUNTER_COMP_COUNT_U64("count", NULL, NULL);
> +
> +static struct counter_comp counter_function_comp =3D {
> +       .type =3D COUNTER_COMP_FUNCTION,
> +       .name =3D "function",
> +};
> +
> +static int counter_count_attrs_create(struct counter_device *const count=
er,
> +       struct counter_attribute_group *const group,
> +       struct counter_count *const count)
> +{
> +       const enum counter_scope scope =3D COUNTER_SCOPE_COUNT;
> +       struct device *const dev =3D &counter->dev;
> +       int err;
> +       struct counter_comp comp;
> +       size_t i;
> +
> +       /* Create main Count attribute */
> +       comp =3D counter_count_comp;
> +       comp.count_u64_read =3D counter->ops->count_read;
> +       comp.count_u64_write =3D counter->ops->count_write;
> +       err =3D counter_attr_create(dev, group, &comp, scope, count);
> +       if (err < 0)
> +               return err;
> +
> +       /* Create Count name attribute */
> +       err =3D counter_name_attr_create(dev, group, count->name);
> +       if (err < 0)
> +               return err;
> +
> +       /* Create Count function attribute */
> +       comp =3D counter_function_comp;
> +       comp.count_u32_read =3D counter->ops->function_read;
> +       comp.count_u32_write =3D counter->ops->function_write;
> +       err =3D counter_attr_create(dev, group, &comp, scope, count);
> +       if (err < 0)
> +               return err;
> +
> +       /* Create an attribute for each extension */
> +       for (i =3D 0; i < count->num_ext; i++) {
> +               err =3D counter_attr_create(dev, group, count->ext + i, s=
cope,
> +                                         count);
> +               if (err < 0)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int counter_sysfs_counts_add(struct counter_device *const counter=
,
> +       struct counter_attribute_group *const groups)
> +{
> +       size_t i;
> +       struct counter_count *count;
> +       int err;
> +
> +       /* Add each Count */
> +       for (i =3D 0; i < counter->num_counts; i++) {
> +               count =3D counter->counts + i;
> +
> +               /* Generate Count attribute directory name */
> +               groups[i].name =3D devm_kasprintf(&counter->dev, GFP_KERN=
EL,
> +                                               "count%zu", i);
> +               if (!groups[i].name)
> +                       return -ENOMEM;
> +
> +               /* Add sysfs attributes of the Synapses */
> +               err =3D counter_sysfs_synapses_add(counter, groups + i, c=
ount);
> +               if (err < 0)
> +                       return err;
> +
> +               /* Create all attributes associated with Count */
> +               err =3D counter_count_attrs_create(counter, groups + i, c=
ount);
> +               if (err < 0)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int counter_num_signals_read(struct counter_device *counter, u8 *=
val)
> +{
> +       *val =3D counter->num_signals;
> +       return 0;
> +}
> +
> +static int counter_num_counts_read(struct counter_device *counter, u8 *v=
al)
> +{
> +       *val =3D counter->num_counts;
> +       return 0;
> +}
> +
> +static struct counter_comp counter_num_signals_comp =3D
> +       COUNTER_COMP_DEVICE_U8("num_signals", counter_num_signals_read, N=
ULL);
> +
> +static struct counter_comp counter_num_counts_comp =3D
> +       COUNTER_COMP_DEVICE_U8("num_counts", counter_num_counts_read, NUL=
L);
> +
> +static int counter_sysfs_attr_add(struct counter_device *const counter,
> +                                 struct counter_attribute_group *group)
> +{
> +       const enum counter_scope scope =3D COUNTER_SCOPE_DEVICE;
> +       struct device *const dev =3D &counter->dev;
> +       int err;
> +       size_t i;
> +
> +       /* Add Signals sysfs attributes */
> +       err =3D counter_sysfs_signals_add(counter, group);
> +       if (err < 0)
> +               return err;
> +       group +=3D counter->num_signals;
> +
> +       /* Add Counts sysfs attributes */
> +       err =3D counter_sysfs_counts_add(counter, group);
> +       if (err < 0)
> +               return err;
> +       group +=3D counter->num_counts;
> +
> +       /* Create name attribute */
> +       err =3D counter_name_attr_create(dev, group, counter->name);
> +       if (err < 0)
> +               return err;
> +
> +       /* Create num_signals attribute */
> +       err =3D counter_attr_create(dev, group, &counter_num_signals_comp=
, scope,
> +                                 NULL);
> +       if (err < 0)
> +               return err;
> +
> +       /* Create num_counts attribute */
> +       err =3D counter_attr_create(dev, group, &counter_num_counts_comp,=
 scope,
> +                                 NULL);
> +       if (err < 0)
> +               return err;
> +
> +       /* Create an attribute for each extension */
> +       for (i =3D 0; i < counter->num_ext; i++) {
> +               err =3D counter_attr_create(dev, group, counter->ext + i,=
 scope,
> +                                         NULL);
> +               if (err < 0)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * counter_sysfs_add - Adds Counter sysfs attributes to the device struc=
ture
> + * @counter:   Pointer to the Counter device structure
> + *
> + * Counter sysfs attributes are created and added to the respective devi=
ce
> + * structure for later registration to the system. Resource-managed memo=
ry
> + * allocation is performed by this function, and this memory should be f=
reed
> + * when no longer needed (automatically by a device_unregister call, or
> + * manually by a devres_release_all call).
> + */
> +int counter_sysfs_add(struct counter_device *const counter)
> +{
> +       struct device *const dev =3D &counter->dev;
> +       const size_t num_groups =3D counter->num_signals + counter->num_c=
ounts + 1;
> +       struct counter_attribute_group *groups;
> +       size_t i, j;
> +       int err;
> +       struct attribute_group *group;
> +       struct counter_attribute *p;
> +
> +       /* Allocate space for attribute groups (signals, counts, and ext)=
 */
> +       groups =3D devm_kcalloc(dev, num_groups, sizeof(*groups), GFP_KER=
NEL);
> +       if (!groups)
> +               return -ENOMEM;
> +
> +       /* Initialize attribute lists */
> +       for (i =3D 0; i < num_groups; i++)
> +               INIT_LIST_HEAD(&groups[i].attr_list);
> +
> +       /* Add Counter device sysfs attributes */
> +       err =3D counter_sysfs_attr_add(counter, groups);
> +       if (err < 0)
> +               return err;
> +
> +       /* Allocate attribute groups for association with device */
> +       dev->groups =3D devm_kcalloc(dev, num_groups + 1, sizeof(*dev->gr=
oups),
> +                                  GFP_KERNEL);
> +       if (!dev->groups)
> +               return -ENOMEM;
> +
> +       /* Prepare each group of attributes for association */
> +       for (i =3D 0; i < num_groups; i++) {
> +               /* Allocate space for attribute group */
> +               group =3D devm_kzalloc(dev, sizeof(*group), GFP_KERNEL);
> +               if (!group)
> +                       return -ENOMEM;
> +               group->name =3D groups[i].name;
> +
> +               /* Allocate space for attribute pointers */
> +               group->attrs =3D devm_kcalloc(dev, groups[i].num_attr + 1=
,
> +                                           sizeof(*group->attrs), GFP_KE=
RNEL);
> +               if (!group->attrs)
> +                       return -ENOMEM;
> +
> +               /* Add attribute pointers to attribute group */
> +               j =3D 0;
> +               list_for_each_entry(p, &groups[i].attr_list, l)
> +                       group->attrs[j++] =3D &p->dev_attr.attr;
> +
> +               /* Associate attribute group */
> +               dev->groups[i] =3D group;
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/counter/counter-sysfs.h b/drivers/counter/counter-sy=
sfs.h
> new file mode 100644
> index 000000000000..14fe566aca0e
> --- /dev/null
> +++ b/drivers/counter/counter-sysfs.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Counter sysfs interface
> + * Copyright (C) 2020 William Breathitt Gray
> + */
> +#ifndef _COUNTER_SYSFS_H_
> +#define _COUNTER_SYSFS_H_
> +
> +#include <linux/counter.h>
> +
> +int counter_sysfs_add(struct counter_device *const counter);
> +
> +#endif /* _COUNTER_SYSFS_H_ */
> diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
> deleted file mode 100644
> index de921e8a3f72..000000000000
> --- a/drivers/counter/counter.c
> +++ /dev/null
> @@ -1,1496 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Generic Counter interface
> - * Copyright (C) 2018 William Breathitt Gray
> - */
> -#include <linux/counter.h>
> -#include <linux/device.h>
> -#include <linux/err.h>
> -#include <linux/export.h>
> -#include <linux/fs.h>
> -#include <linux/gfp.h>
> -#include <linux/idr.h>
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/list.h>
> -#include <linux/module.h>
> -#include <linux/printk.h>
> -#include <linux/slab.h>
> -#include <linux/string.h>
> -#include <linux/sysfs.h>
> -#include <linux/types.h>
> -
> -const char *const counter_count_direction_str[2] =3D {
> -       [COUNTER_COUNT_DIRECTION_FORWARD] =3D "forward",
> -       [COUNTER_COUNT_DIRECTION_BACKWARD] =3D "backward"
> -};
> -EXPORT_SYMBOL_GPL(counter_count_direction_str);
> -
> -const char *const counter_count_mode_str[4] =3D {
> -       [COUNTER_COUNT_MODE_NORMAL] =3D "normal",
> -       [COUNTER_COUNT_MODE_RANGE_LIMIT] =3D "range limit",
> -       [COUNTER_COUNT_MODE_NON_RECYCLE] =3D "non-recycle",
> -       [COUNTER_COUNT_MODE_MODULO_N] =3D "modulo-n"
> -};
> -EXPORT_SYMBOL_GPL(counter_count_mode_str);
> -
> -ssize_t counter_signal_enum_read(struct counter_device *counter,
> -                                struct counter_signal *signal, void *pri=
v,
> -                                char *buf)
> -{
> -       const struct counter_signal_enum_ext *const e =3D priv;
> -       int err;
> -       size_t index;
> -
> -       if (!e->get)
> -               return -EINVAL;
> -
> -       err =3D e->get(counter, signal, &index);
> -       if (err)
> -               return err;
> -
> -       if (index >=3D e->num_items)
> -               return -EINVAL;
> -
> -       return sprintf(buf, "%s\n", e->items[index]);
> -}
> -EXPORT_SYMBOL_GPL(counter_signal_enum_read);
> -
> -ssize_t counter_signal_enum_write(struct counter_device *counter,
> -                                 struct counter_signal *signal, void *pr=
iv,
> -                                 const char *buf, size_t len)
> -{
> -       const struct counter_signal_enum_ext *const e =3D priv;
> -       ssize_t index;
> -       int err;
> -
> -       if (!e->set)
> -               return -EINVAL;
> -
> -       index =3D __sysfs_match_string(e->items, e->num_items, buf);
> -       if (index < 0)
> -               return index;
> -
> -       err =3D e->set(counter, signal, index);
> -       if (err)
> -               return err;
> -
> -       return len;
> -}
> -EXPORT_SYMBOL_GPL(counter_signal_enum_write);
> -
> -ssize_t counter_signal_enum_available_read(struct counter_device *counte=
r,
> -                                          struct counter_signal *signal,
> -                                          void *priv, char *buf)
> -{
> -       const struct counter_signal_enum_ext *const e =3D priv;
> -       size_t i;
> -       size_t len =3D 0;
> -
> -       if (!e->num_items)
> -               return 0;
> -
> -       for (i =3D 0; i < e->num_items; i++)
> -               len +=3D sprintf(buf + len, "%s\n", e->items[i]);
> -
> -       return len;
> -}
> -EXPORT_SYMBOL_GPL(counter_signal_enum_available_read);
> -
> -ssize_t counter_count_enum_read(struct counter_device *counter,
> -                               struct counter_count *count, void *priv,
> -                               char *buf)
> -{
> -       const struct counter_count_enum_ext *const e =3D priv;
> -       int err;
> -       size_t index;
> -
> -       if (!e->get)
> -               return -EINVAL;
> -
> -       err =3D e->get(counter, count, &index);
> -       if (err)
> -               return err;
> -
> -       if (index >=3D e->num_items)
> -               return -EINVAL;
> -
> -       return sprintf(buf, "%s\n", e->items[index]);
> -}
> -EXPORT_SYMBOL_GPL(counter_count_enum_read);
> -
> -ssize_t counter_count_enum_write(struct counter_device *counter,
> -                                struct counter_count *count, void *priv,
> -                                const char *buf, size_t len)
> -{
> -       const struct counter_count_enum_ext *const e =3D priv;
> -       ssize_t index;
> -       int err;
> -
> -       if (!e->set)
> -               return -EINVAL;
> -
> -       index =3D __sysfs_match_string(e->items, e->num_items, buf);
> -       if (index < 0)
> -               return index;
> -
> -       err =3D e->set(counter, count, index);
> -       if (err)
> -               return err;
> -
> -       return len;
> -}
> -EXPORT_SYMBOL_GPL(counter_count_enum_write);
> -
> -ssize_t counter_count_enum_available_read(struct counter_device *counter=
,
> -                                         struct counter_count *count,
> -                                         void *priv, char *buf)
> -{
> -       const struct counter_count_enum_ext *const e =3D priv;
> -       size_t i;
> -       size_t len =3D 0;
> -
> -       if (!e->num_items)
> -               return 0;
> -
> -       for (i =3D 0; i < e->num_items; i++)
> -               len +=3D sprintf(buf + len, "%s\n", e->items[i]);
> -
> -       return len;
> -}
> -EXPORT_SYMBOL_GPL(counter_count_enum_available_read);
> -
> -ssize_t counter_device_enum_read(struct counter_device *counter, void *p=
riv,
> -                                char *buf)
> -{
> -       const struct counter_device_enum_ext *const e =3D priv;
> -       int err;
> -       size_t index;
> -
> -       if (!e->get)
> -               return -EINVAL;
> -
> -       err =3D e->get(counter, &index);
> -       if (err)
> -               return err;
> -
> -       if (index >=3D e->num_items)
> -               return -EINVAL;
> -
> -       return sprintf(buf, "%s\n", e->items[index]);
> -}
> -EXPORT_SYMBOL_GPL(counter_device_enum_read);
> -
> -ssize_t counter_device_enum_write(struct counter_device *counter, void *=
priv,
> -                                 const char *buf, size_t len)
> -{
> -       const struct counter_device_enum_ext *const e =3D priv;
> -       ssize_t index;
> -       int err;
> -
> -       if (!e->set)
> -               return -EINVAL;
> -
> -       index =3D __sysfs_match_string(e->items, e->num_items, buf);
> -       if (index < 0)
> -               return index;
> -
> -       err =3D e->set(counter, index);
> -       if (err)
> -               return err;
> -
> -       return len;
> -}
> -EXPORT_SYMBOL_GPL(counter_device_enum_write);
> -
> -ssize_t counter_device_enum_available_read(struct counter_device *counte=
r,
> -                                          void *priv, char *buf)
> -{
> -       const struct counter_device_enum_ext *const e =3D priv;
> -       size_t i;
> -       size_t len =3D 0;
> -
> -       if (!e->num_items)
> -               return 0;
> -
> -       for (i =3D 0; i < e->num_items; i++)
> -               len +=3D sprintf(buf + len, "%s\n", e->items[i]);
> -
> -       return len;
> -}
> -EXPORT_SYMBOL_GPL(counter_device_enum_available_read);
> -
> -struct counter_attr_parm {
> -       struct counter_device_attr_group *group;
> -       const char *prefix;
> -       const char *name;
> -       ssize_t (*show)(struct device *dev, struct device_attribute *attr=
,
> -                       char *buf);
> -       ssize_t (*store)(struct device *dev, struct device_attribute *att=
r,
> -                        const char *buf, size_t len);
> -       void *component;
> -};
> -
> -struct counter_device_attr {
> -       struct device_attribute dev_attr;
> -       struct list_head l;
> -       void *component;
> -};
> -
> -static int counter_attribute_create(const struct counter_attr_parm *cons=
t parm)
> -{
> -       struct counter_device_attr *counter_attr;
> -       struct device_attribute *dev_attr;
> -       int err;
> -       struct list_head *const attr_list =3D &parm->group->attr_list;
> -
> -       /* Allocate a Counter device attribute */
> -       counter_attr =3D kzalloc(sizeof(*counter_attr), GFP_KERNEL);
> -       if (!counter_attr)
> -               return -ENOMEM;
> -       dev_attr =3D &counter_attr->dev_attr;
> -
> -       sysfs_attr_init(&dev_attr->attr);
> -
> -       /* Configure device attribute */
> -       dev_attr->attr.name =3D kasprintf(GFP_KERNEL, "%s%s", parm->prefi=
x,
> -                                       parm->name);
> -       if (!dev_attr->attr.name) {
> -               err =3D -ENOMEM;
> -               goto err_free_counter_attr;
> -       }
> -       if (parm->show) {
> -               dev_attr->attr.mode |=3D 0444;
> -               dev_attr->show =3D parm->show;
> -       }
> -       if (parm->store) {
> -               dev_attr->attr.mode |=3D 0200;
> -               dev_attr->store =3D parm->store;
> -       }
> -
> -       /* Store associated Counter component with attribute */
> -       counter_attr->component =3D parm->component;
> -
> -       /* Keep track of the attribute for later cleanup */
> -       list_add(&counter_attr->l, attr_list);
> -       parm->group->num_attr++;
> -
> -       return 0;
> -
> -err_free_counter_attr:
> -       kfree(counter_attr);
> -       return err;
> -}
> -
> -#define to_counter_attr(_dev_attr) \
> -       container_of(_dev_attr, struct counter_device_attr, dev_attr)
> -
> -struct counter_signal_unit {
> -       struct counter_signal *signal;
> -};
> -
> -static const char *const counter_signal_level_str[] =3D {
> -       [COUNTER_SIGNAL_LEVEL_LOW] =3D "low",
> -       [COUNTER_SIGNAL_LEVEL_HIGH] =3D "high"
> -};
> -
> -static ssize_t counter_signal_show(struct device *dev,
> -                                  struct device_attribute *attr, char *b=
uf)
> -{
> -       struct counter_device *const counter =3D dev_get_drvdata(dev);
> -       const struct counter_device_attr *const devattr =3D to_counter_at=
tr(attr);
> -       const struct counter_signal_unit *const component =3D devattr->co=
mponent;
> -       struct counter_signal *const signal =3D component->signal;
> -       int err;
> -       enum counter_signal_level level;
> -
> -       err =3D counter->ops->signal_read(counter, signal, &level);
> -       if (err)
> -               return err;
> -
> -       return sprintf(buf, "%s\n", counter_signal_level_str[level]);
> -}
> -
> -struct counter_name_unit {
> -       const char *name;
> -};
> -
> -static ssize_t counter_device_attr_name_show(struct device *dev,
> -                                            struct device_attribute *att=
r,
> -                                            char *buf)
> -{
> -       const struct counter_name_unit *const comp =3D to_counter_attr(at=
tr)->component;
> -
> -       return sprintf(buf, "%s\n", comp->name);
> -}
> -
> -static int counter_name_attribute_create(
> -       struct counter_device_attr_group *const group,
> -       const char *const name)
> -{
> -       struct counter_name_unit *name_comp;
> -       struct counter_attr_parm parm;
> -       int err;
> -
> -       /* Skip if no name */
> -       if (!name)
> -               return 0;
> -
> -       /* Allocate name attribute component */
> -       name_comp =3D kmalloc(sizeof(*name_comp), GFP_KERNEL);
> -       if (!name_comp)
> -               return -ENOMEM;
> -       name_comp->name =3D name;
> -
> -       /* Allocate Signal name attribute */
> -       parm.group =3D group;
> -       parm.prefix =3D "";
> -       parm.name =3D "name";
> -       parm.show =3D counter_device_attr_name_show;
> -       parm.store =3D NULL;
> -       parm.component =3D name_comp;
> -       err =3D counter_attribute_create(&parm);
> -       if (err)
> -               goto err_free_name_comp;
> -
> -       return 0;
> -
> -err_free_name_comp:
> -       kfree(name_comp);
> -       return err;
> -}
> -
> -struct counter_signal_ext_unit {
> -       struct counter_signal *signal;
> -       const struct counter_signal_ext *ext;
> -};
> -
> -static ssize_t counter_signal_ext_show(struct device *dev,
> -                                      struct device_attribute *attr, cha=
r *buf)
> -{
> -       const struct counter_device_attr *const devattr =3D to_counter_at=
tr(attr);
> -       const struct counter_signal_ext_unit *const comp =3D devattr->com=
ponent;
> -       const struct counter_signal_ext *const ext =3D comp->ext;
> -
> -       return ext->read(dev_get_drvdata(dev), comp->signal, ext->priv, b=
uf);
> -}
> -
> -static ssize_t counter_signal_ext_store(struct device *dev,
> -                                       struct device_attribute *attr,
> -                                       const char *buf, size_t len)
> -{
> -       const struct counter_device_attr *const devattr =3D to_counter_at=
tr(attr);
> -       const struct counter_signal_ext_unit *const comp =3D devattr->com=
ponent;
> -       const struct counter_signal_ext *const ext =3D comp->ext;
> -
> -       return ext->write(dev_get_drvdata(dev), comp->signal, ext->priv, =
buf,
> -               len);
> -}
> -
> -static void counter_device_attr_list_free(struct list_head *attr_list)
> -{
> -       struct counter_device_attr *p, *n;
> -
> -       list_for_each_entry_safe(p, n, attr_list, l) {
> -               /* free attribute name and associated component memory */
> -               kfree(p->dev_attr.attr.name);
> -               kfree(p->component);
> -               list_del(&p->l);
> -               kfree(p);
> -       }
> -}
> -
> -static int counter_signal_ext_register(
> -       struct counter_device_attr_group *const group,
> -       struct counter_signal *const signal)
> -{
> -       const size_t num_ext =3D signal->num_ext;
> -       size_t i;
> -       const struct counter_signal_ext *ext;
> -       struct counter_signal_ext_unit *signal_ext_comp;
> -       struct counter_attr_parm parm;
> -       int err;
> -
> -       /* Create an attribute for each extension */
> -       for (i =3D 0 ; i < num_ext; i++) {
> -               ext =3D signal->ext + i;
> -
> -               /* Allocate signal_ext attribute component */
> -               signal_ext_comp =3D kmalloc(sizeof(*signal_ext_comp), GFP=
_KERNEL);
> -               if (!signal_ext_comp) {
> -                       err =3D -ENOMEM;
> -                       goto err_free_attr_list;
> -               }
> -               signal_ext_comp->signal =3D signal;
> -               signal_ext_comp->ext =3D ext;
> -
> -               /* Allocate a Counter device attribute */
> -               parm.group =3D group;
> -               parm.prefix =3D "";
> -               parm.name =3D ext->name;
> -               parm.show =3D (ext->read) ? counter_signal_ext_show : NUL=
L;
> -               parm.store =3D (ext->write) ? counter_signal_ext_store : =
NULL;
> -               parm.component =3D signal_ext_comp;
> -               err =3D counter_attribute_create(&parm);
> -               if (err) {
> -                       kfree(signal_ext_comp);
> -                       goto err_free_attr_list;
> -               }
> -       }
> -
> -       return 0;
> -
> -err_free_attr_list:
> -       counter_device_attr_list_free(&group->attr_list);
> -       return err;
> -}
> -
> -static int counter_signal_attributes_create(
> -       struct counter_device_attr_group *const group,
> -       const struct counter_device *const counter,
> -       struct counter_signal *const signal)
> -{
> -       struct counter_signal_unit *signal_comp;
> -       struct counter_attr_parm parm;
> -       int err;
> -
> -       /* Allocate Signal attribute component */
> -       signal_comp =3D kmalloc(sizeof(*signal_comp), GFP_KERNEL);
> -       if (!signal_comp)
> -               return -ENOMEM;
> -       signal_comp->signal =3D signal;
> -
> -       /* Create main Signal attribute */
> -       parm.group =3D group;
> -       parm.prefix =3D "";
> -       parm.name =3D "signal";
> -       parm.show =3D (counter->ops->signal_read) ? counter_signal_show :=
 NULL;
> -       parm.store =3D NULL;
> -       parm.component =3D signal_comp;
> -       err =3D counter_attribute_create(&parm);
> -       if (err) {
> -               kfree(signal_comp);
> -               return err;
> -       }
> -
> -       /* Create Signal name attribute */
> -       err =3D counter_name_attribute_create(group, signal->name);
> -       if (err)
> -               goto err_free_attr_list;
> -
> -       /* Register Signal extension attributes */
> -       err =3D counter_signal_ext_register(group, signal);
> -       if (err)
> -               goto err_free_attr_list;
> -
> -       return 0;
> -
> -err_free_attr_list:
> -       counter_device_attr_list_free(&group->attr_list);
> -       return err;
> -}
> -
> -static int counter_signals_register(
> -       struct counter_device_attr_group *const groups_list,
> -       const struct counter_device *const counter)
> -{
> -       const size_t num_signals =3D counter->num_signals;
> -       size_t i;
> -       struct counter_signal *signal;
> -       const char *name;
> -       int err;
> -
> -       /* Register each Signal */
> -       for (i =3D 0; i < num_signals; i++) {
> -               signal =3D counter->signals + i;
> -
> -               /* Generate Signal attribute directory name */
> -               name =3D kasprintf(GFP_KERNEL, "signal%d", signal->id);
> -               if (!name) {
> -                       err =3D -ENOMEM;
> -                       goto err_free_attr_groups;
> -               }
> -               groups_list[i].attr_group.name =3D name;
> -
> -               /* Create all attributes associated with Signal */
> -               err =3D counter_signal_attributes_create(groups_list + i,=
 counter,
> -                                                      signal);
> -               if (err)
> -                       goto err_free_attr_groups;
> -       }
> -
> -       return 0;
> -
> -err_free_attr_groups:
> -       do {
> -               kfree(groups_list[i].attr_group.name);
> -               counter_device_attr_list_free(&groups_list[i].attr_list);
> -       } while (i--);
> -       return err;
> -}
> -
> -static const char *const counter_synapse_action_str[] =3D {
> -       [COUNTER_SYNAPSE_ACTION_NONE] =3D "none",
> -       [COUNTER_SYNAPSE_ACTION_RISING_EDGE] =3D "rising edge",
> -       [COUNTER_SYNAPSE_ACTION_FALLING_EDGE] =3D "falling edge",
> -       [COUNTER_SYNAPSE_ACTION_BOTH_EDGES] =3D "both edges"
> -};
> -
> -struct counter_action_unit {
> -       struct counter_synapse *synapse;
> -       struct counter_count *count;
> -};
> -
> -static ssize_t counter_action_show(struct device *dev,
> -                                  struct device_attribute *attr, char *b=
uf)
> -{
> -       const struct counter_device_attr *const devattr =3D to_counter_at=
tr(attr);
> -       int err;
> -       struct counter_device *const counter =3D dev_get_drvdata(dev);
> -       const struct counter_action_unit *const component =3D devattr->co=
mponent;
> -       struct counter_count *const count =3D component->count;
> -       struct counter_synapse *const synapse =3D component->synapse;
> -       size_t action_index;
> -       enum counter_synapse_action action;
> -
> -       err =3D counter->ops->action_get(counter, count, synapse, &action=
_index);
> -       if (err)
> -               return err;
> -
> -       synapse->action =3D action_index;
> -
> -       action =3D synapse->actions_list[action_index];
> -       return sprintf(buf, "%s\n", counter_synapse_action_str[action]);
> -}
> -
> -static ssize_t counter_action_store(struct device *dev,
> -                                   struct device_attribute *attr,
> -                                   const char *buf, size_t len)
> -{
> -       const struct counter_device_attr *const devattr =3D to_counter_at=
tr(attr);
> -       const struct counter_action_unit *const component =3D devattr->co=
mponent;
> -       struct counter_synapse *const synapse =3D component->synapse;
> -       size_t action_index;
> -       const size_t num_actions =3D synapse->num_actions;
> -       enum counter_synapse_action action;
> -       int err;
> -       struct counter_device *const counter =3D dev_get_drvdata(dev);
> -       struct counter_count *const count =3D component->count;
> -
> -       /* Find requested action mode */
> -       for (action_index =3D 0; action_index < num_actions; action_index=
++) {
> -               action =3D synapse->actions_list[action_index];
> -               if (sysfs_streq(buf, counter_synapse_action_str[action]))
> -                       break;
> -       }
> -       /* If requested action mode not found */
> -       if (action_index >=3D num_actions)
> -               return -EINVAL;
> -
> -       err =3D counter->ops->action_set(counter, count, synapse, action_=
index);
> -       if (err)
> -               return err;
> -
> -       synapse->action =3D action_index;
> -
> -       return len;
> -}
> -
> -struct counter_action_avail_unit {
> -       const enum counter_synapse_action *actions_list;
> -       size_t num_actions;
> -};
> -
> -static ssize_t counter_synapse_action_available_show(struct device *dev,
> -       struct device_attribute *attr, char *buf)
> -{
> -       const struct counter_device_attr *const devattr =3D to_counter_at=
tr(attr);
> -       const struct counter_action_avail_unit *const component =3D devat=
tr->component;
> -       size_t i;
> -       enum counter_synapse_action action;
> -       ssize_t len =3D 0;
> -
> -       for (i =3D 0; i < component->num_actions; i++) {
> -               action =3D component->actions_list[i];
> -               len +=3D sprintf(buf + len, "%s\n",
> -                              counter_synapse_action_str[action]);
> -       }
> -
> -       return len;
> -}
> -
> -static int counter_synapses_register(
> -       struct counter_device_attr_group *const group,
> -       const struct counter_device *const counter,
> -       struct counter_count *const count, const char *const count_attr_n=
ame)
> -{
> -       size_t i;
> -       struct counter_synapse *synapse;
> -       const char *prefix;
> -       struct counter_action_unit *action_comp;
> -       struct counter_attr_parm parm;
> -       int err;
> -       struct counter_action_avail_unit *avail_comp;
> -
> -       /* Register each Synapse */
> -       for (i =3D 0; i < count->num_synapses; i++) {
> -               synapse =3D count->synapses + i;
> -
> -               /* Generate attribute prefix */
> -               prefix =3D kasprintf(GFP_KERNEL, "signal%d_",
> -                                  synapse->signal->id);
> -               if (!prefix) {
> -                       err =3D -ENOMEM;
> -                       goto err_free_attr_list;
> -               }
> -
> -               /* Allocate action attribute component */
> -               action_comp =3D kmalloc(sizeof(*action_comp), GFP_KERNEL)=
;
> -               if (!action_comp) {
> -                       err =3D -ENOMEM;
> -                       goto err_free_prefix;
> -               }
> -               action_comp->synapse =3D synapse;
> -               action_comp->count =3D count;
> -
> -               /* Create action attribute */
> -               parm.group =3D group;
> -               parm.prefix =3D prefix;
> -               parm.name =3D "action";
> -               parm.show =3D (counter->ops->action_get) ? counter_action=
_show : NULL;
> -               parm.store =3D (counter->ops->action_set) ? counter_actio=
n_store : NULL;
> -               parm.component =3D action_comp;
> -               err =3D counter_attribute_create(&parm);
> -               if (err) {
> -                       kfree(action_comp);
> -                       goto err_free_prefix;
> -               }
> -
> -               /* Allocate action available attribute component */
> -               avail_comp =3D kmalloc(sizeof(*avail_comp), GFP_KERNEL);
> -               if (!avail_comp) {
> -                       err =3D -ENOMEM;
> -                       goto err_free_prefix;
> -               }
> -               avail_comp->actions_list =3D synapse->actions_list;
> -               avail_comp->num_actions =3D synapse->num_actions;
> -
> -               /* Create action_available attribute */
> -               parm.group =3D group;
> -               parm.prefix =3D prefix;
> -               parm.name =3D "action_available";
> -               parm.show =3D counter_synapse_action_available_show;
> -               parm.store =3D NULL;
> -               parm.component =3D avail_comp;
> -               err =3D counter_attribute_create(&parm);
> -               if (err) {
> -                       kfree(avail_comp);
> -                       goto err_free_prefix;
> -               }
> -
> -               kfree(prefix);
> -       }
> -
> -       return 0;
> -
> -err_free_prefix:
> -       kfree(prefix);
> -err_free_attr_list:
> -       counter_device_attr_list_free(&group->attr_list);
> -       return err;
> -}
> -
> -struct counter_count_unit {
> -       struct counter_count *count;
> -};
> -
> -static ssize_t counter_count_show(struct device *dev,
> -                                 struct device_attribute *attr,
> -                                 char *buf)
> -{
> -       struct counter_device *const counter =3D dev_get_drvdata(dev);
> -       const struct counter_device_attr *const devattr =3D to_counter_at=
tr(attr);
> -       const struct counter_count_unit *const component =3D devattr->com=
ponent;
> -       struct counter_count *const count =3D component->count;
> -       int err;
> -       unsigned long val;
> -
> -       err =3D counter->ops->count_read(counter, count, &val);
> -       if (err)
> -               return err;
> -
> -       return sprintf(buf, "%lu\n", val);
> -}
> -
> -static ssize_t counter_count_store(struct device *dev,
> -                                  struct device_attribute *attr,
> -                                  const char *buf, size_t len)
> -{
> -       struct counter_device *const counter =3D dev_get_drvdata(dev);
> -       const struct counter_device_attr *const devattr =3D to_counter_at=
tr(attr);
> -       const struct counter_count_unit *const component =3D devattr->com=
ponent;
> -       struct counter_count *const count =3D component->count;
> -       int err;
> -       unsigned long val;
> -
> -       err =3D kstrtoul(buf, 0, &val);
> -       if (err)
> -               return err;
> -
> -       err =3D counter->ops->count_write(counter, count, val);
> -       if (err)
> -               return err;
> -
> -       return len;
> -}
> -
> -static const char *const counter_function_str[] =3D {
> -       [COUNTER_FUNCTION_INCREASE] =3D "increase",
> -       [COUNTER_FUNCTION_DECREASE] =3D "decrease",
> -       [COUNTER_FUNCTION_PULSE_DIRECTION] =3D "pulse-direction",
> -       [COUNTER_FUNCTION_QUADRATURE_X1_A] =3D "quadrature x1 a",
> -       [COUNTER_FUNCTION_QUADRATURE_X1_B] =3D "quadrature x1 b",
> -       [COUNTER_FUNCTION_QUADRATURE_X2_A] =3D "quadrature x2 a",
> -       [COUNTER_FUNCTION_QUADRATURE_X2_B] =3D "quadrature x2 b",
> -       [COUNTER_FUNCTION_QUADRATURE_X4] =3D "quadrature x4"
> -};
> -
> -static ssize_t counter_function_show(struct device *dev,
> -                                    struct device_attribute *attr, char =
*buf)
> -{
> -       int err;
> -       struct counter_device *const counter =3D dev_get_drvdata(dev);
> -       const struct counter_device_attr *const devattr =3D to_counter_at=
tr(attr);
> -       const struct counter_count_unit *const component =3D devattr->com=
ponent;
> -       struct counter_count *const count =3D component->count;
> -       size_t func_index;
> -       enum counter_function function;
> -
> -       err =3D counter->ops->function_get(counter, count, &func_index);
> -       if (err)
> -               return err;
> -
> -       count->function =3D func_index;
> -
> -       function =3D count->functions_list[func_index];
> -       return sprintf(buf, "%s\n", counter_function_str[function]);
> -}
> -
> -static ssize_t counter_function_store(struct device *dev,
> -                                     struct device_attribute *attr,
> -                                     const char *buf, size_t len)
> -{
> -       const struct counter_device_attr *const devattr =3D to_counter_at=
tr(attr);
> -       const struct counter_count_unit *const component =3D devattr->com=
ponent;
> -       struct counter_count *const count =3D component->count;
> -       const size_t num_functions =3D count->num_functions;
> -       size_t func_index;
> -       enum counter_function function;
> -       int err;
> -       struct counter_device *const counter =3D dev_get_drvdata(dev);
> -
> -       /* Find requested Count function mode */
> -       for (func_index =3D 0; func_index < num_functions; func_index++) =
{
> -               function =3D count->functions_list[func_index];
> -               if (sysfs_streq(buf, counter_function_str[function]))
> -                       break;
> -       }
> -       /* Return error if requested Count function mode not found */
> -       if (func_index >=3D num_functions)
> -               return -EINVAL;
> -
> -       err =3D counter->ops->function_set(counter, count, func_index);
> -       if (err)
> -               return err;
> -
> -       count->function =3D func_index;
> -
> -       return len;
> -}
> -
> -struct counter_count_ext_unit {
> -       struct counter_count *count;
> -       const struct counter_count_ext *ext;
> -};
> -
> -static ssize_t counter_count_ext_show(struct device *dev,
> -                                     struct device_attribute *attr, char=
 *buf)
> -{
> -       const struct counter_device_attr *const devattr =3D to_counter_at=
tr(attr);
> -       const struct counter_count_ext_unit *const comp =3D devattr->comp=
onent;
> -       const struct counter_count_ext *const ext =3D comp->ext;
> -
> -       return ext->read(dev_get_drvdata(dev), comp->count, ext->priv, bu=
f);
> -}
> -
> -static ssize_t counter_count_ext_store(struct device *dev,
> -                                      struct device_attribute *attr,
> -                                      const char *buf, size_t len)
> -{
> -       const struct counter_device_attr *const devattr =3D to_counter_at=
tr(attr);
> -       const struct counter_count_ext_unit *const comp =3D devattr->comp=
onent;
> -       const struct counter_count_ext *const ext =3D comp->ext;
> -
> -       return ext->write(dev_get_drvdata(dev), comp->count, ext->priv, b=
uf,
> -               len);
> -}
> -
> -static int counter_count_ext_register(
> -       struct counter_device_attr_group *const group,
> -       struct counter_count *const count)
> -{
> -       size_t i;
> -       const struct counter_count_ext *ext;
> -       struct counter_count_ext_unit *count_ext_comp;
> -       struct counter_attr_parm parm;
> -       int err;
> -
> -       /* Create an attribute for each extension */
> -       for (i =3D 0 ; i < count->num_ext; i++) {
> -               ext =3D count->ext + i;
> -
> -               /* Allocate count_ext attribute component */
> -               count_ext_comp =3D kmalloc(sizeof(*count_ext_comp), GFP_K=
ERNEL);
> -               if (!count_ext_comp) {
> -                       err =3D -ENOMEM;
> -                       goto err_free_attr_list;
> -               }
> -               count_ext_comp->count =3D count;
> -               count_ext_comp->ext =3D ext;
> -
> -               /* Allocate count_ext attribute */
> -               parm.group =3D group;
> -               parm.prefix =3D "";
> -               parm.name =3D ext->name;
> -               parm.show =3D (ext->read) ? counter_count_ext_show : NULL=
;
> -               parm.store =3D (ext->write) ? counter_count_ext_store : N=
ULL;
> -               parm.component =3D count_ext_comp;
> -               err =3D counter_attribute_create(&parm);
> -               if (err) {
> -                       kfree(count_ext_comp);
> -                       goto err_free_attr_list;
> -               }
> -       }
> -
> -       return 0;
> -
> -err_free_attr_list:
> -       counter_device_attr_list_free(&group->attr_list);
> -       return err;
> -}
> -
> -struct counter_func_avail_unit {
> -       const enum counter_function *functions_list;
> -       size_t num_functions;
> -};
> -
> -static ssize_t counter_function_available_show(struct device *dev,
> -       struct device_attribute *attr, char *buf)
> -{
> -       const struct counter_device_attr *const devattr =3D to_counter_at=
tr(attr);
> -       const struct counter_func_avail_unit *const component =3D devattr=
->component;
> -       const enum counter_function *const func_list =3D component->funct=
ions_list;
> -       const size_t num_functions =3D component->num_functions;
> -       size_t i;
> -       enum counter_function function;
> -       ssize_t len =3D 0;
> -
> -       for (i =3D 0; i < num_functions; i++) {
> -               function =3D func_list[i];
> -               len +=3D sprintf(buf + len, "%s\n",
> -                              counter_function_str[function]);
> -       }
> -
> -       return len;
> -}
> -
> -static int counter_count_attributes_create(
> -       struct counter_device_attr_group *const group,
> -       const struct counter_device *const counter,
> -       struct counter_count *const count)
> -{
> -       struct counter_count_unit *count_comp;
> -       struct counter_attr_parm parm;
> -       int err;
> -       struct counter_count_unit *func_comp;
> -       struct counter_func_avail_unit *avail_comp;
> -
> -       /* Allocate count attribute component */
> -       count_comp =3D kmalloc(sizeof(*count_comp), GFP_KERNEL);
> -       if (!count_comp)
> -               return -ENOMEM;
> -       count_comp->count =3D count;
> -
> -       /* Create main Count attribute */
> -       parm.group =3D group;
> -       parm.prefix =3D "";
> -       parm.name =3D "count";
> -       parm.show =3D (counter->ops->count_read) ? counter_count_show : N=
ULL;
> -       parm.store =3D (counter->ops->count_write) ? counter_count_store =
: NULL;
> -       parm.component =3D count_comp;
> -       err =3D counter_attribute_create(&parm);
> -       if (err) {
> -               kfree(count_comp);
> -               return err;
> -       }
> -
> -       /* Allocate function attribute component */
> -       func_comp =3D kmalloc(sizeof(*func_comp), GFP_KERNEL);
> -       if (!func_comp) {
> -               err =3D -ENOMEM;
> -               goto err_free_attr_list;
> -       }
> -       func_comp->count =3D count;
> -
> -       /* Create Count function attribute */
> -       parm.group =3D group;
> -       parm.prefix =3D "";
> -       parm.name =3D "function";
> -       parm.show =3D (counter->ops->function_get) ? counter_function_sho=
w : NULL;
> -       parm.store =3D (counter->ops->function_set) ? counter_function_st=
ore : NULL;
> -       parm.component =3D func_comp;
> -       err =3D counter_attribute_create(&parm);
> -       if (err) {
> -               kfree(func_comp);
> -               goto err_free_attr_list;
> -       }
> -
> -       /* Allocate function available attribute component */
> -       avail_comp =3D kmalloc(sizeof(*avail_comp), GFP_KERNEL);
> -       if (!avail_comp) {
> -               err =3D -ENOMEM;
> -               goto err_free_attr_list;
> -       }
> -       avail_comp->functions_list =3D count->functions_list;
> -       avail_comp->num_functions =3D count->num_functions;
> -
> -       /* Create Count function_available attribute */
> -       parm.group =3D group;
> -       parm.prefix =3D "";
> -       parm.name =3D "function_available";
> -       parm.show =3D counter_function_available_show;
> -       parm.store =3D NULL;
> -       parm.component =3D avail_comp;
> -       err =3D counter_attribute_create(&parm);
> -       if (err) {
> -               kfree(avail_comp);
> -               goto err_free_attr_list;
> -       }
> -
> -       /* Create Count name attribute */
> -       err =3D counter_name_attribute_create(group, count->name);
> -       if (err)
> -               goto err_free_attr_list;
> -
> -       /* Register Count extension attributes */
> -       err =3D counter_count_ext_register(group, count);
> -       if (err)
> -               goto err_free_attr_list;
> -
> -       return 0;
> -
> -err_free_attr_list:
> -       counter_device_attr_list_free(&group->attr_list);
> -       return err;
> -}
> -
> -static int counter_counts_register(
> -       struct counter_device_attr_group *const groups_list,
> -       const struct counter_device *const counter)
> -{
> -       size_t i;
> -       struct counter_count *count;
> -       const char *name;
> -       int err;
> -
> -       /* Register each Count */
> -       for (i =3D 0; i < counter->num_counts; i++) {
> -               count =3D counter->counts + i;
> -
> -               /* Generate Count attribute directory name */
> -               name =3D kasprintf(GFP_KERNEL, "count%d", count->id);
> -               if (!name) {
> -                       err =3D -ENOMEM;
> -                       goto err_free_attr_groups;
> -               }
> -               groups_list[i].attr_group.name =3D name;
> -
> -               /* Register the Synapses associated with each Count */
> -               err =3D counter_synapses_register(groups_list + i, counte=
r, count,
> -                                               name);
> -               if (err)
> -                       goto err_free_attr_groups;
> -
> -               /* Create all attributes associated with Count */
> -               err =3D counter_count_attributes_create(groups_list + i, =
counter,
> -                                                     count);
> -               if (err)
> -                       goto err_free_attr_groups;
> -       }
> -
> -       return 0;
> -
> -err_free_attr_groups:
> -       do {
> -               kfree(groups_list[i].attr_group.name);
> -               counter_device_attr_list_free(&groups_list[i].attr_list);
> -       } while (i--);
> -       return err;
> -}
> -
> -struct counter_size_unit {
> -       size_t size;
> -};
> -
> -static ssize_t counter_device_attr_size_show(struct device *dev,
> -                                            struct device_attribute *att=
r,
> -                                            char *buf)
> -{
> -       const struct counter_size_unit *const comp =3D to_counter_attr(at=
tr)->component;
> -
> -       return sprintf(buf, "%zu\n", comp->size);
> -}
> -
> -static int counter_size_attribute_create(
> -       struct counter_device_attr_group *const group,
> -       const size_t size, const char *const name)
> -{
> -       struct counter_size_unit *size_comp;
> -       struct counter_attr_parm parm;
> -       int err;
> -
> -       /* Allocate size attribute component */
> -       size_comp =3D kmalloc(sizeof(*size_comp), GFP_KERNEL);
> -       if (!size_comp)
> -               return -ENOMEM;
> -       size_comp->size =3D size;
> -
> -       parm.group =3D group;
> -       parm.prefix =3D "";
> -       parm.name =3D name;
> -       parm.show =3D counter_device_attr_size_show;
> -       parm.store =3D NULL;
> -       parm.component =3D size_comp;
> -       err =3D counter_attribute_create(&parm);
> -       if (err)
> -               goto err_free_size_comp;
> -
> -       return 0;
> -
> -err_free_size_comp:
> -       kfree(size_comp);
> -       return err;
> -}
> -
> -struct counter_ext_unit {
> -       const struct counter_device_ext *ext;
> -};
> -
> -static ssize_t counter_device_ext_show(struct device *dev,
> -                                      struct device_attribute *attr, cha=
r *buf)
> -{
> -       const struct counter_device_attr *const devattr =3D to_counter_at=
tr(attr);
> -       const struct counter_ext_unit *const component =3D devattr->compo=
nent;
> -       const struct counter_device_ext *const ext =3D component->ext;
> -
> -       return ext->read(dev_get_drvdata(dev), ext->priv, buf);
> -}
> -
> -static ssize_t counter_device_ext_store(struct device *dev,
> -                                       struct device_attribute *attr,
> -                                       const char *buf, size_t len)
> -{
> -       const struct counter_device_attr *const devattr =3D to_counter_at=
tr(attr);
> -       const struct counter_ext_unit *const component =3D devattr->compo=
nent;
> -       const struct counter_device_ext *const ext =3D component->ext;
> -
> -       return ext->write(dev_get_drvdata(dev), ext->priv, buf, len);
> -}
> -
> -static int counter_device_ext_register(
> -       struct counter_device_attr_group *const group,
> -       struct counter_device *const counter)
> -{
> -       size_t i;
> -       struct counter_ext_unit *ext_comp;
> -       struct counter_attr_parm parm;
> -       int err;
> -
> -       /* Create an attribute for each extension */
> -       for (i =3D 0 ; i < counter->num_ext; i++) {
> -               /* Allocate extension attribute component */
> -               ext_comp =3D kmalloc(sizeof(*ext_comp), GFP_KERNEL);
> -               if (!ext_comp) {
> -                       err =3D -ENOMEM;
> -                       goto err_free_attr_list;
> -               }
> -
> -               ext_comp->ext =3D counter->ext + i;
> -
> -               /* Allocate extension attribute */
> -               parm.group =3D group;
> -               parm.prefix =3D "";
> -               parm.name =3D counter->ext[i].name;
> -               parm.show =3D (counter->ext[i].read) ? counter_device_ext=
_show : NULL;
> -               parm.store =3D (counter->ext[i].write) ? counter_device_e=
xt_store : NULL;
> -               parm.component =3D ext_comp;
> -               err =3D counter_attribute_create(&parm);
> -               if (err) {
> -                       kfree(ext_comp);
> -                       goto err_free_attr_list;
> -               }
> -       }
> -
> -       return 0;
> -
> -err_free_attr_list:
> -       counter_device_attr_list_free(&group->attr_list);
> -       return err;
> -}
> -
> -static int counter_global_attr_register(
> -       struct counter_device_attr_group *const group,
> -       struct counter_device *const counter)
> -{
> -       int err;
> -
> -       /* Create name attribute */
> -       err =3D counter_name_attribute_create(group, counter->name);
> -       if (err)
> -               return err;
> -
> -       /* Create num_counts attribute */
> -       err =3D counter_size_attribute_create(group, counter->num_counts,
> -                                           "num_counts");
> -       if (err)
> -               goto err_free_attr_list;
> -
> -       /* Create num_signals attribute */
> -       err =3D counter_size_attribute_create(group, counter->num_signals=
,
> -                                           "num_signals");
> -       if (err)
> -               goto err_free_attr_list;
> -
> -       /* Register Counter device extension attributes */
> -       err =3D counter_device_ext_register(group, counter);
> -       if (err)
> -               goto err_free_attr_list;
> -
> -       return 0;
> -
> -err_free_attr_list:
> -       counter_device_attr_list_free(&group->attr_list);
> -       return err;
> -}
> -
> -static void counter_device_groups_list_free(
> -       struct counter_device_attr_group *const groups_list,
> -       const size_t num_groups)
> -{
> -       struct counter_device_attr_group *group;
> -       size_t i;
> -
> -       /* loop through all attribute groups (signals, counts, global, et=
c.) */
> -       for (i =3D 0; i < num_groups; i++) {
> -               group =3D groups_list + i;
> -
> -               /* free all attribute group and associated attributes mem=
ory */
> -               kfree(group->attr_group.name);
> -               kfree(group->attr_group.attrs);
> -               counter_device_attr_list_free(&group->attr_list);
> -       }
> -
> -       kfree(groups_list);
> -}
> -
> -static int counter_device_groups_list_prepare(
> -       struct counter_device *const counter)
> -{
> -       const size_t total_num_groups =3D
> -               counter->num_signals + counter->num_counts + 1;
> -       struct counter_device_attr_group *groups_list;
> -       size_t i;
> -       int err;
> -       size_t num_groups =3D 0;
> -
> -       /* Allocate space for attribute groups (signals, counts, and ext)=
 */
> -       groups_list =3D kcalloc(total_num_groups, sizeof(*groups_list),
> -                             GFP_KERNEL);
> -       if (!groups_list)
> -               return -ENOMEM;
> -
> -       /* Initialize attribute lists */
> -       for (i =3D 0; i < total_num_groups; i++)
> -               INIT_LIST_HEAD(&groups_list[i].attr_list);
> -
> -       /* Register Signals */
> -       err =3D counter_signals_register(groups_list, counter);
> -       if (err)
> -               goto err_free_groups_list;
> -       num_groups +=3D counter->num_signals;
> -
> -       /* Register Counts and respective Synapses */
> -       err =3D counter_counts_register(groups_list + num_groups, counter=
);
> -       if (err)
> -               goto err_free_groups_list;
> -       num_groups +=3D counter->num_counts;
> -
> -       /* Register Counter global attributes */
> -       err =3D counter_global_attr_register(groups_list + num_groups, co=
unter);
> -       if (err)
> -               goto err_free_groups_list;
> -       num_groups++;
> -
> -       /* Store groups_list in device_state */
> -       counter->device_state->groups_list =3D groups_list;
> -       counter->device_state->num_groups =3D num_groups;
> -
> -       return 0;
> -
> -err_free_groups_list:
> -       counter_device_groups_list_free(groups_list, num_groups);
> -       return err;
> -}
> -
> -static int counter_device_groups_prepare(
> -       struct counter_device_state *const device_state)
> -{
> -       size_t i, j;
> -       struct counter_device_attr_group *group;
> -       int err;
> -       struct counter_device_attr *p;
> -
> -       /* Allocate attribute groups for association with device */
> -       device_state->groups =3D kcalloc(device_state->num_groups + 1,
> -                                      sizeof(*device_state->groups),
> -                                      GFP_KERNEL);
> -       if (!device_state->groups)
> -               return -ENOMEM;
> -
> -       /* Prepare each group of attributes for association */
> -       for (i =3D 0; i < device_state->num_groups; i++) {
> -               group =3D device_state->groups_list + i;
> -
> -               /* Allocate space for attribute pointers in attribute gro=
up */
> -               group->attr_group.attrs =3D kcalloc(group->num_attr + 1,
> -                       sizeof(*group->attr_group.attrs), GFP_KERNEL);
> -               if (!group->attr_group.attrs) {
> -                       err =3D -ENOMEM;
> -                       goto err_free_groups;
> -               }
> -
> -               /* Add attribute pointers to attribute group */
> -               j =3D 0;
> -               list_for_each_entry(p, &group->attr_list, l)
> -                       group->attr_group.attrs[j++] =3D &p->dev_attr.att=
r;
> -
> -               /* Group attributes in attribute group */
> -               device_state->groups[i] =3D &group->attr_group;
> -       }
> -       /* Associate attributes with device */
> -       device_state->dev.groups =3D device_state->groups;
> -
> -       return 0;
> -
> -err_free_groups:
> -       do {
> -               group =3D device_state->groups_list + i;
> -               kfree(group->attr_group.attrs);
> -               group->attr_group.attrs =3D NULL;
> -       } while (i--);
> -       kfree(device_state->groups);
> -       return err;
> -}
> -
> -/* Provides a unique ID for each counter device */
> -static DEFINE_IDA(counter_ida);
> -
> -static void counter_device_release(struct device *dev)
> -{
> -       struct counter_device *const counter =3D dev_get_drvdata(dev);
> -       struct counter_device_state *const device_state =3D counter->devi=
ce_state;
> -
> -       kfree(device_state->groups);
> -       counter_device_groups_list_free(device_state->groups_list,
> -                                       device_state->num_groups);
> -       ida_simple_remove(&counter_ida, device_state->id);
> -       kfree(device_state);
> -}
> -
> -static struct device_type counter_device_type =3D {
> -       .name =3D "counter_device",
> -       .release =3D counter_device_release
> -};
> -
> -static struct bus_type counter_bus_type =3D {
> -       .name =3D "counter"
> -};
> -
> -/**
> - * counter_register - register Counter to the system
> - * @counter:   pointer to Counter to register
> - *
> - * This function registers a Counter to the system. A sysfs "counter" di=
rectory
> - * will be created and populated with sysfs attributes correlating with =
the
> - * Counter Signals, Synapses, and Counts respectively.
> - */
> -int counter_register(struct counter_device *const counter)
> -{
> -       struct counter_device_state *device_state;
> -       int err;
> -
> -       /* Allocate internal state container for Counter device */
> -       device_state =3D kzalloc(sizeof(*device_state), GFP_KERNEL);
> -       if (!device_state)
> -               return -ENOMEM;
> -       counter->device_state =3D device_state;
> -
> -       /* Acquire unique ID */
> -       device_state->id =3D ida_simple_get(&counter_ida, 0, 0, GFP_KERNE=
L);
> -       if (device_state->id < 0) {
> -               err =3D device_state->id;
> -               goto err_free_device_state;
> -       }
> -
> -       /* Configure device structure for Counter */
> -       device_state->dev.type =3D &counter_device_type;
> -       device_state->dev.bus =3D &counter_bus_type;
> -       if (counter->parent) {
> -               device_state->dev.parent =3D counter->parent;
> -               device_state->dev.of_node =3D counter->parent->of_node;
> -       }
> -       dev_set_name(&device_state->dev, "counter%d", device_state->id);
> -       device_initialize(&device_state->dev);
> -       dev_set_drvdata(&device_state->dev, counter);
> -
> -       /* Prepare device attributes */
> -       err =3D counter_device_groups_list_prepare(counter);
> -       if (err)
> -               goto err_free_id;
> -
> -       /* Organize device attributes to groups and match to device */
> -       err =3D counter_device_groups_prepare(device_state);
> -       if (err)
> -               goto err_free_groups_list;
> -
> -       /* Add device to system */
> -       err =3D device_add(&device_state->dev);
> -       if (err)
> -               goto err_free_groups;
> -
> -       return 0;
> -
> -err_free_groups:
> -       kfree(device_state->groups);
> -err_free_groups_list:
> -       counter_device_groups_list_free(device_state->groups_list,
> -                                       device_state->num_groups);
> -err_free_id:
> -       ida_simple_remove(&counter_ida, device_state->id);
> -err_free_device_state:
> -       kfree(device_state);
> -       return err;
> -}
> -EXPORT_SYMBOL_GPL(counter_register);
> -
> -/**
> - * counter_unregister - unregister Counter from the system
> - * @counter:   pointer to Counter to unregister
> - *
> - * The Counter is unregistered from the system; all allocated memory is =
freed.
> - */
> -void counter_unregister(struct counter_device *const counter)
> -{
> -       if (counter)
> -               device_del(&counter->device_state->dev);
> -}
> -EXPORT_SYMBOL_GPL(counter_unregister);
> -
> -static void devm_counter_unreg(struct device *dev, void *res)
> -{
> -       counter_unregister(*(struct counter_device **)res);
> -}
> -
> -/**
> - * devm_counter_register - Resource-managed counter_register
> - * @dev:       device to allocate counter_device for
> - * @counter:   pointer to Counter to register
> - *
> - * Managed counter_register. The Counter registered with this function i=
s
> - * automatically unregistered on driver detach. This function calls
> - * counter_register internally. Refer to that function for more informat=
ion.
> - *
> - * If an Counter registered with this function needs to be unregistered
> - * separately, devm_counter_unregister must be used.
> - *
> - * RETURNS:
> - * 0 on success, negative error number on failure.
> - */
> -int devm_counter_register(struct device *dev,
> -                         struct counter_device *const counter)
> -{
> -       struct counter_device **ptr;
> -       int ret;
> -
> -       ptr =3D devres_alloc(devm_counter_unreg, sizeof(*ptr), GFP_KERNEL=
);
> -       if (!ptr)
> -               return -ENOMEM;
> -
> -       ret =3D counter_register(counter);
> -       if (!ret) {
> -               *ptr =3D counter;
> -               devres_add(dev, ptr);
> -       } else {
> -               devres_free(ptr);
> -       }
> -
> -       return ret;
> -}
> -EXPORT_SYMBOL_GPL(devm_counter_register);
> -
> -static int devm_counter_match(struct device *dev, void *res, void *data)
> -{
> -       struct counter_device **r =3D res;
> -
> -       if (!r || !*r) {
> -               WARN_ON(!r || !*r);
> -               return 0;
> -       }
> -
> -       return *r =3D=3D data;
> -}
> -
> -/**
> - * devm_counter_unregister - Resource-managed counter_unregister
> - * @dev:       device this counter_device belongs to
> - * @counter:   pointer to Counter associated with the device
> - *
> - * Unregister Counter registered with devm_counter_register.
> - */
> -void devm_counter_unregister(struct device *dev,
> -                            struct counter_device *const counter)
> -{
> -       int rc;
> -
> -       rc =3D devres_release(dev, devm_counter_unreg, devm_counter_match=
,
> -                           counter);
> -       WARN_ON(rc);
> -}
> -EXPORT_SYMBOL_GPL(devm_counter_unregister);
> -
> -static int __init counter_init(void)
> -{
> -       return bus_register(&counter_bus_type);
> -}
> -
> -static void __exit counter_exit(void)
> -{
> -       bus_unregister(&counter_bus_type);
> -}
> -
> -subsys_initcall(counter_init);
> -module_exit(counter_exit);
> -
> -MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
> -MODULE_DESCRIPTION("Generic Counter interface");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.=
c
> index 53c15f84909b..092a806a46d8 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -14,6 +14,7 @@
>  #include <linux/mutex.h>
>  #include <linux/counter.h>
>  #include <linux/bitfield.h>
> +#include <linux/types.h>
>
>  #define FTM_FIELD_UPDATE(ftm, offset, mask, val)                       \
>         ({                                                              \
> @@ -115,8 +116,7 @@ static void ftm_quaddec_disable(void *ftm)
>  }
>
>  static int ftm_quaddec_get_prescaler(struct counter_device *counter,
> -                                    struct counter_count *count,
> -                                    size_t *cnt_mode)
> +                                    struct counter_count *count, u32 *cn=
t_mode)
>  {
>         struct ftm_quaddec *ftm =3D counter->priv;
>         uint32_t scflags;
> @@ -129,8 +129,7 @@ static int ftm_quaddec_get_prescaler(struct counter_d=
evice *counter,
>  }
>
>  static int ftm_quaddec_set_prescaler(struct counter_device *counter,
> -                                    struct counter_count *count,
> -                                    size_t cnt_mode)
> +                                    struct counter_count *count, u32 cnt=
_mode)
>  {
>         struct ftm_quaddec *ftm =3D counter->priv;
>
> @@ -151,33 +150,21 @@ static const char * const ftm_quaddec_prescaler[] =
=3D {
>         "1", "2", "4", "8", "16", "32", "64", "128"
>  };
>
> -static struct counter_count_enum_ext ftm_quaddec_prescaler_enum =3D {
> -       .items =3D ftm_quaddec_prescaler,
> -       .num_items =3D ARRAY_SIZE(ftm_quaddec_prescaler),
> -       .get =3D ftm_quaddec_get_prescaler,
> -       .set =3D ftm_quaddec_set_prescaler
> -};
> -
> -enum ftm_quaddec_synapse_action {
> -       FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES,
> -};
> -
>  static const enum counter_synapse_action ftm_quaddec_synapse_actions[] =
=3D {
> -       [FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES] =3D
>         COUNTER_SYNAPSE_ACTION_BOTH_EDGES
>  };
>
>  enum ftm_quaddec_count_function {
> -       FTM_QUADDEC_COUNT_ENCODER_MODE_1,
> +       FTM_QUADDEC_COUNT_ENCODER_MODE_1 =3D COUNTER_FUNCTION_QUADRATURE_=
X4,
>  };
>
>  static const enum counter_function ftm_quaddec_count_functions[] =3D {
> -       [FTM_QUADDEC_COUNT_ENCODER_MODE_1] =3D COUNTER_FUNCTION_QUADRATUR=
E_X4
> +       FTM_QUADDEC_COUNT_ENCODER_MODE_1
>  };
>
>  static int ftm_quaddec_count_read(struct counter_device *counter,
>                                   struct counter_count *count,
> -                                 unsigned long *val)
> +                                 u64 *val)
>  {
>         struct ftm_quaddec *const ftm =3D counter->priv;
>         uint32_t cntval;
> @@ -191,7 +178,7 @@ static int ftm_quaddec_count_read(struct counter_devi=
ce *counter,
>
>  static int ftm_quaddec_count_write(struct counter_device *counter,
>                                    struct counter_count *count,
> -                                  const unsigned long val)
> +                                  const u64 val)
>  {
>         struct ftm_quaddec *const ftm =3D counter->priv;
>
> @@ -205,21 +192,21 @@ static int ftm_quaddec_count_write(struct counter_d=
evice *counter,
>         return 0;
>  }
>
> -static int ftm_quaddec_count_function_get(struct counter_device *counter=
,
> -                                         struct counter_count *count,
> -                                         size_t *function)
> +static int ftm_quaddec_count_function_read(struct counter_device *counte=
r,
> +                                          struct counter_count *count,
> +                                          enum counter_function *functio=
n)
>  {
>         *function =3D FTM_QUADDEC_COUNT_ENCODER_MODE_1;
>
>         return 0;
>  }
>
> -static int ftm_quaddec_action_get(struct counter_device *counter,
> -                                 struct counter_count *count,
> -                                 struct counter_synapse *synapse,
> -                                 size_t *action)
> +static int ftm_quaddec_action_read(struct counter_device *counter,
> +                                  struct counter_count *count,
> +                                  struct counter_synapse *synapse,
> +                                  enum counter_synapse_action *action)
>  {
> -       *action =3D FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES;
> +       *action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>
>         return 0;
>  }
> @@ -227,8 +214,8 @@ static int ftm_quaddec_action_get(struct counter_devi=
ce *counter,
>  static const struct counter_ops ftm_quaddec_cnt_ops =3D {
>         .count_read =3D ftm_quaddec_count_read,
>         .count_write =3D ftm_quaddec_count_write,
> -       .function_get =3D ftm_quaddec_count_function_get,
> -       .action_get =3D ftm_quaddec_action_get,
> +       .function_read =3D ftm_quaddec_count_function_read,
> +       .action_read =3D ftm_quaddec_action_read,
>  };
>
>  static struct counter_signal ftm_quaddec_signals[] =3D {
> @@ -255,9 +242,12 @@ static struct counter_synapse ftm_quaddec_count_syna=
pses[] =3D {
>         }
>  };
>
> -static const struct counter_count_ext ftm_quaddec_count_ext[] =3D {
> -       COUNTER_COUNT_ENUM("prescaler", &ftm_quaddec_prescaler_enum),
> -       COUNTER_COUNT_ENUM_AVAILABLE("prescaler", &ftm_quaddec_prescaler_=
enum),
> +static DEFINE_COUNTER_ENUM(ftm_quaddec_prescaler_enum, ftm_quaddec_presc=
aler);
> +
> +static struct counter_comp ftm_quaddec_count_ext[] =3D {
> +       COUNTER_COMP_COUNT_ENUM("prescaler", ftm_quaddec_get_prescaler,
> +                               ftm_quaddec_set_prescaler,
> +                               ftm_quaddec_prescaler_enum),
>  };
>
>  static struct counter_count ftm_quaddec_counts =3D {
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> index f4be9d78c84c..ec056f31fa55 100644
> --- a/drivers/counter/intel-qep.c
> +++ b/drivers/counter/intel-qep.c
> @@ -63,13 +63,6 @@
>
>  #define INTEL_QEP_CLK_PERIOD_NS                10
>
> -#define INTEL_QEP_COUNTER_EXT_RW(_name)                                \
> -{                                                              \
> -       .name =3D #_name,                                         \
> -       .read =3D _name##_read,                                   \
> -       .write =3D _name##_write,                                 \
> -}
> -
>  struct intel_qep {
>         struct counter_device counter;
>         struct mutex lock;
> @@ -115,8 +108,7 @@ static void intel_qep_init(struct intel_qep *qep)
>  }
>
>  static int intel_qep_count_read(struct counter_device *counter,
> -                               struct counter_count *count,
> -                               unsigned long *val)
> +                               struct counter_count *count, u64 *val)
>  {
>         struct intel_qep *const qep =3D counter->priv;
>
> @@ -131,11 +123,11 @@ static const enum counter_function intel_qep_count_=
functions[] =3D {
>         COUNTER_FUNCTION_QUADRATURE_X4,
>  };
>
> -static int intel_qep_function_get(struct counter_device *counter,
> -                                 struct counter_count *count,
> -                                 size_t *function)
> +static int intel_qep_function_read(struct counter_device *counter,
> +                                  struct counter_count *count,
> +                                  enum counter_function *function)
>  {
> -       *function =3D 0;
> +       *function =3D COUNTER_FUNCTION_QUADRATURE_X4;
>
>         return 0;
>  }
> @@ -144,19 +136,19 @@ static const enum counter_synapse_action intel_qep_=
synapse_actions[] =3D {
>         COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
>  };
>
> -static int intel_qep_action_get(struct counter_device *counter,
> -                               struct counter_count *count,
> -                               struct counter_synapse *synapse,
> -                               size_t *action)
> +static int intel_qep_action_read(struct counter_device *counter,
> +                                struct counter_count *count,
> +                                struct counter_synapse *synapse,
> +                                enum counter_synapse_action *action)
>  {
> -       *action =3D 0;
> +       *action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>         return 0;
>  }
>
>  static const struct counter_ops intel_qep_counter_ops =3D {
>         .count_read =3D intel_qep_count_read,
> -       .function_get =3D intel_qep_function_get,
> -       .action_get =3D intel_qep_action_get,
> +       .function_read =3D intel_qep_function_read,
> +       .action_read =3D intel_qep_action_read,
>  };
>
>  #define INTEL_QEP_SIGNAL(_id, _name) {                         \
> @@ -182,31 +174,27 @@ static struct counter_synapse intel_qep_count_synap=
ses[] =3D {
>         INTEL_QEP_SYNAPSE(2),
>  };
>
> -static ssize_t ceiling_read(struct counter_device *counter,
> -                           struct counter_count *count,
> -                           void *priv, char *buf)
> +static int intel_qep_ceiling_read(struct counter_device *counter,
> +                                 struct counter_count *count, u64 *ceili=
ng)
>  {
>         struct intel_qep *qep =3D counter->priv;
> -       u32 reg;
>
>         pm_runtime_get_sync(qep->dev);
> -       reg =3D intel_qep_readl(qep, INTEL_QEPMAX);
> +       *ceiling =3D intel_qep_readl(qep, INTEL_QEPMAX);
>         pm_runtime_put(qep->dev);
>
> -       return sysfs_emit(buf, "%u\n", reg);
> +       return 0;
>  }
>
> -static ssize_t ceiling_write(struct counter_device *counter,
> -                            struct counter_count *count,
> -                            void *priv, const char *buf, size_t len)
> +static int intel_qep_ceiling_write(struct counter_device *counter,
> +                                  struct counter_count *count, u64 max)
>  {
>         struct intel_qep *qep =3D counter->priv;
> -       u32 max;
> -       int ret;
> +       int ret =3D 0;
>
> -       ret =3D kstrtou32(buf, 0, &max);
> -       if (ret < 0)
> -               return ret;
> +       /* Intel QEP ceiling configuration only supports 32-bit values */
> +       if (max !=3D (u32)max)
> +               return -ERANGE;
>
>         mutex_lock(&qep->lock);
>         if (qep->enabled) {
> @@ -217,34 +205,28 @@ static ssize_t ceiling_write(struct counter_device =
*counter,
>         pm_runtime_get_sync(qep->dev);
>         intel_qep_writel(qep, INTEL_QEPMAX, max);
>         pm_runtime_put(qep->dev);
> -       ret =3D len;
>
>  out:
>         mutex_unlock(&qep->lock);
>         return ret;
>  }
>
> -static ssize_t enable_read(struct counter_device *counter,
> -                          struct counter_count *count,
> -                          void *priv, char *buf)
> +static int intel_qep_enable_read(struct counter_device *counter,
> +                                struct counter_count *count, u8 *enable)
>  {
>         struct intel_qep *qep =3D counter->priv;
>
> -       return sysfs_emit(buf, "%u\n", qep->enabled);
> +       *enable =3D qep->enabled;
> +
> +       return 0;
>  }
>
> -static ssize_t enable_write(struct counter_device *counter,
> -                           struct counter_count *count,
> -                           void *priv, const char *buf, size_t len)
> +static int intel_qep_enable_write(struct counter_device *counter,
> +                                 struct counter_count *count, u8 val)
>  {
>         struct intel_qep *qep =3D counter->priv;
>         u32 reg;
> -       bool val, changed;
> -       int ret;
> -
> -       ret =3D kstrtobool(buf, &val);
> -       if (ret)
> -               return ret;
> +       bool changed;
>
>         mutex_lock(&qep->lock);
>         changed =3D val ^ qep->enabled;
> @@ -268,12 +250,12 @@ static ssize_t enable_write(struct counter_device *=
counter,
>
>  out:
>         mutex_unlock(&qep->lock);
> -       return len;
> +       return 0;
>  }
>
> -static ssize_t spike_filter_ns_read(struct counter_device *counter,
> -                                   struct counter_count *count,
> -                                   void *priv, char *buf)
> +static int intel_qep_spike_filter_ns_read(struct counter_device *counter=
,
> +                                         struct counter_count *count,
> +                                         u64 *length)
>  {
>         struct intel_qep *qep =3D counter->priv;
>         u32 reg;
> @@ -282,26 +264,24 @@ static ssize_t spike_filter_ns_read(struct counter_=
device *counter,
>         reg =3D intel_qep_readl(qep, INTEL_QEPCON);
>         if (!(reg & INTEL_QEPCON_FLT_EN)) {
>                 pm_runtime_put(qep->dev);
> -               return sysfs_emit(buf, "0\n");
> +               return 0;
>         }
>         reg =3D INTEL_QEPFLT_MAX_COUNT(intel_qep_readl(qep, INTEL_QEPFLT)=
);
>         pm_runtime_put(qep->dev);
>
> -       return sysfs_emit(buf, "%u\n", (reg + 2) * INTEL_QEP_CLK_PERIOD_N=
S);
> +       *length =3D (reg + 2) * INTEL_QEP_CLK_PERIOD_NS;
> +
> +       return 0;
>  }
>
> -static ssize_t spike_filter_ns_write(struct counter_device *counter,
> -                                    struct counter_count *count,
> -                                    void *priv, const char *buf, size_t =
len)
> +static int intel_qep_spike_filter_ns_write(struct counter_device *counte=
r,
> +                                          struct counter_count *count,
> +                                          u64 length)
>  {
>         struct intel_qep *qep =3D counter->priv;
> -       u32 reg, length;
> +       u32 reg;
>         bool enable;
> -       int ret;
> -
> -       ret =3D kstrtou32(buf, 0, &length);
> -       if (ret < 0)
> -               return ret;
> +       int ret =3D 0;
>
>         /*
>          * Spike filter length is (MAX_COUNT + 2) clock periods.
> @@ -337,16 +317,15 @@ static ssize_t spike_filter_ns_write(struct counter=
_device *counter,
>         intel_qep_writel(qep, INTEL_QEPFLT, length);
>         intel_qep_writel(qep, INTEL_QEPCON, reg);
>         pm_runtime_put(qep->dev);
> -       ret =3D len;
>
>  out:
>         mutex_unlock(&qep->lock);
>         return ret;
>  }
>
> -static ssize_t preset_enable_read(struct counter_device *counter,
> -                                 struct counter_count *count,
> -                                 void *priv, char *buf)
> +static int intel_qep_preset_enable_read(struct counter_device *counter,
> +                                       struct counter_count *count,
> +                                       u8 *preset_enable)
>  {
>         struct intel_qep *qep =3D counter->priv;
>         u32 reg;
> @@ -354,21 +333,18 @@ static ssize_t preset_enable_read(struct counter_de=
vice *counter,
>         pm_runtime_get_sync(qep->dev);
>         reg =3D intel_qep_readl(qep, INTEL_QEPCON);
>         pm_runtime_put(qep->dev);
> -       return sysfs_emit(buf, "%u\n", !(reg & INTEL_QEPCON_COUNT_RST_MOD=
E));
> +
> +       *preset_enable =3D !(reg & INTEL_QEPCON_COUNT_RST_MODE);
> +
> +       return 0;
>  }
>
> -static ssize_t preset_enable_write(struct counter_device *counter,
> -                                  struct counter_count *count,
> -                                  void *priv, const char *buf, size_t le=
n)
> +static int intel_qep_preset_enable_write(struct counter_device *counter,
> +                                        struct counter_count *count, u8 =
val)
>  {
>         struct intel_qep *qep =3D counter->priv;
>         u32 reg;
> -       bool val;
> -       int ret;
> -
> -       ret =3D kstrtobool(buf, &val);
> -       if (ret)
> -               return ret;
> +       int ret =3D 0;
>
>         mutex_lock(&qep->lock);
>         if (qep->enabled) {
> @@ -385,7 +361,6 @@ static ssize_t preset_enable_write(struct counter_dev=
ice *counter,
>
>         intel_qep_writel(qep, INTEL_QEPCON, reg);
>         pm_runtime_put(qep->dev);
> -       ret =3D len;
>
>  out:
>         mutex_unlock(&qep->lock);
> @@ -393,11 +368,14 @@ static ssize_t preset_enable_write(struct counter_d=
evice *counter,
>         return ret;
>  }
>
> -static const struct counter_count_ext intel_qep_count_ext[] =3D {
> -       INTEL_QEP_COUNTER_EXT_RW(ceiling),
> -       INTEL_QEP_COUNTER_EXT_RW(enable),
> -       INTEL_QEP_COUNTER_EXT_RW(spike_filter_ns),
> -       INTEL_QEP_COUNTER_EXT_RW(preset_enable)
> +static struct counter_comp intel_qep_count_ext[] =3D {
> +       COUNTER_COMP_ENABLE(intel_qep_enable_read, intel_qep_enable_write=
),
> +       COUNTER_COMP_CEILING(intel_qep_ceiling_read, intel_qep_ceiling_wr=
ite),
> +       COUNTER_COMP_PRESET_ENABLE(intel_qep_preset_enable_read,
> +                                  intel_qep_preset_enable_write),
> +       COUNTER_COMP_COUNT_U64("spike_filter_ns",
> +                              intel_qep_spike_filter_ns_read,
> +                              intel_qep_spike_filter_ns_write),
>  };
>
>  static struct counter_count intel_qep_counter_count[] =3D {
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-=
cnt.c
> index 1de4243db488..8514a87fcbee 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -10,6 +10,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/types.h>
>
>  #define INTERRUPT_CNT_NAME "interrupt-cnt"
>
> @@ -33,30 +34,23 @@ static irqreturn_t interrupt_cnt_isr(int irq, void *d=
ev_id)
>         return IRQ_HANDLED;
>  }
>
> -static ssize_t interrupt_cnt_enable_read(struct counter_device *counter,
> -                                        struct counter_count *count,
> -                                        void *private, char *buf)
> +static int interrupt_cnt_enable_read(struct counter_device *counter,
> +                                    struct counter_count *count, u8 *ena=
ble)
>  {
>         struct interrupt_cnt_priv *priv =3D counter->priv;
>
> -       return sysfs_emit(buf, "%d\n", priv->enabled);
> +       *enable =3D priv->enabled;
> +
> +       return 0;
>  }
>
> -static ssize_t interrupt_cnt_enable_write(struct counter_device *counter=
,
> -                                         struct counter_count *count,
> -                                         void *private, const char *buf,
> -                                         size_t len)
> +static int interrupt_cnt_enable_write(struct counter_device *counter,
> +                                     struct counter_count *count, u8 ena=
ble)
>  {
>         struct interrupt_cnt_priv *priv =3D counter->priv;
> -       bool enable;
> -       ssize_t ret;
> -
> -       ret =3D kstrtobool(buf, &enable);
> -       if (ret)
> -               return ret;
>
>         if (priv->enabled =3D=3D enable)
> -               return len;
> +               return 0;
>
>         if (enable) {
>                 priv->enabled =3D true;
> @@ -66,33 +60,30 @@ static ssize_t interrupt_cnt_enable_write(struct coun=
ter_device *counter,
>                 priv->enabled =3D false;
>         }
>
> -       return len;
> +       return 0;
>  }
>
> -static const struct counter_count_ext interrupt_cnt_ext[] =3D {
> -       {
> -               .name =3D "enable",
> -               .read =3D interrupt_cnt_enable_read,
> -               .write =3D interrupt_cnt_enable_write,
> -       },
> +static struct counter_comp interrupt_cnt_ext[] =3D {
> +       COUNTER_COMP_ENABLE(interrupt_cnt_enable_read,
> +                           interrupt_cnt_enable_write),
>  };
>
>  static const enum counter_synapse_action interrupt_cnt_synapse_actions[]=
 =3D {
>         COUNTER_SYNAPSE_ACTION_RISING_EDGE,
>  };
>
> -static int interrupt_cnt_action_get(struct counter_device *counter,
> -                                   struct counter_count *count,
> -                                   struct counter_synapse *synapse,
> -                                   size_t *action)
> +static int interrupt_cnt_action_read(struct counter_device *counter,
> +                                    struct counter_count *count,
> +                                    struct counter_synapse *synapse,
> +                                    enum counter_synapse_action *action)
>  {
> -       *action =3D 0;
> +       *action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
>
>         return 0;
>  }
>
>  static int interrupt_cnt_read(struct counter_device *counter,
> -                             struct counter_count *count, unsigned long =
*val)
> +                             struct counter_count *count, u64 *val)
>  {
>         struct interrupt_cnt_priv *priv =3D counter->priv;
>
> @@ -102,8 +93,7 @@ static int interrupt_cnt_read(struct counter_device *c=
ounter,
>  }
>
>  static int interrupt_cnt_write(struct counter_device *counter,
> -                              struct counter_count *count,
> -                              const unsigned long val)
> +                              struct counter_count *count, const u64 val=
)
>  {
>         struct interrupt_cnt_priv *priv =3D counter->priv;
>
> @@ -119,11 +109,11 @@ static const enum counter_function interrupt_cnt_fu=
nctions[] =3D {
>         COUNTER_FUNCTION_INCREASE,
>  };
>
> -static int interrupt_cnt_function_get(struct counter_device *counter,
> -                                     struct counter_count *count,
> -                                     size_t *function)
> +static int interrupt_cnt_function_read(struct counter_device *counter,
> +                                      struct counter_count *count,
> +                                      enum counter_function *function)
>  {
> -       *function =3D 0;
> +       *function =3D COUNTER_FUNCTION_INCREASE;
>
>         return 0;
>  }
> @@ -148,10 +138,10 @@ static int interrupt_cnt_signal_read(struct counter=
_device *counter,
>  }
>
>  static const struct counter_ops interrupt_cnt_ops =3D {
> -       .action_get =3D interrupt_cnt_action_get,
> +       .action_read =3D interrupt_cnt_action_read,
>         .count_read =3D interrupt_cnt_read,
>         .count_write =3D interrupt_cnt_write,
> -       .function_get =3D interrupt_cnt_function_get,
> +       .function_read =3D interrupt_cnt_function_read,
>         .signal_read  =3D interrupt_cnt_signal_read,
>  };
>
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/mi=
crochip-tcb-capture.c
> index 4c57d43e7d66..79e0c84a3b81 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -32,28 +32,16 @@ struct mchp_tc_data {
>         bool trig_inverted;
>  };
>
> -enum mchp_tc_count_function {
> -       MCHP_TC_FUNCTION_INCREASE,
> -       MCHP_TC_FUNCTION_QUADRATURE,
> -};
> -
> -static const enum counter_count_function mchp_tc_count_functions[] =3D {
> -       [MCHP_TC_FUNCTION_INCREASE] =3D COUNTER_FUNCTION_INCREASE,
> -       [MCHP_TC_FUNCTION_QUADRATURE] =3D COUNTER_FUNCTION_QUADRATURE_X4,
> -};
> -
> -enum mchp_tc_synapse_action {
> -       MCHP_TC_SYNAPSE_ACTION_NONE =3D 0,
> -       MCHP_TC_SYNAPSE_ACTION_RISING_EDGE,
> -       MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE,
> -       MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE
> +static const enum counter_function mchp_tc_count_functions[] =3D {
> +       COUNTER_FUNCTION_INCREASE,
> +       COUNTER_FUNCTION_QUADRATURE_X4,
>  };
>
>  static const enum counter_synapse_action mchp_tc_synapse_actions[] =3D {
> -       [MCHP_TC_SYNAPSE_ACTION_NONE] =3D COUNTER_SYNAPSE_ACTION_NONE,
> -       [MCHP_TC_SYNAPSE_ACTION_RISING_EDGE] =3D COUNTER_SYNAPSE_ACTION_R=
ISING_EDGE,
> -       [MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE] =3D COUNTER_SYNAPSE_ACTION_=
FALLING_EDGE,
> -       [MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE] =3D COUNTER_SYNAPSE_ACTION_BOT=
H_EDGES,
> +       COUNTER_SYNAPSE_ACTION_NONE,
> +       COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +       COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> +       COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
>  };
>
>  static struct counter_signal mchp_tc_count_signals[] =3D {
> @@ -80,23 +68,23 @@ static struct counter_synapse mchp_tc_count_synapses[=
] =3D {
>         }
>  };
>
> -static int mchp_tc_count_function_get(struct counter_device *counter,
> -                                     struct counter_count *count,
> -                                     size_t *function)
> +static int mchp_tc_count_function_read(struct counter_device *counter,
> +                                      struct counter_count *count,
> +                                      enum counter_function *function)
>  {
>         struct mchp_tc_data *const priv =3D counter->priv;
>
>         if (priv->qdec_mode)
> -               *function =3D MCHP_TC_FUNCTION_QUADRATURE;
> +               *function =3D COUNTER_FUNCTION_QUADRATURE_X4;
>         else
> -               *function =3D MCHP_TC_FUNCTION_INCREASE;
> +               *function =3D COUNTER_FUNCTION_INCREASE;
>
>         return 0;
>  }
>
> -static int mchp_tc_count_function_set(struct counter_device *counter,
> -                                     struct counter_count *count,
> -                                     size_t function)
> +static int mchp_tc_count_function_write(struct counter_device *counter,
> +                                       struct counter_count *count,
> +                                       enum counter_function function)
>  {
>         struct mchp_tc_data *const priv =3D counter->priv;
>         u32 bmr, cmr;
> @@ -108,7 +96,7 @@ static int mchp_tc_count_function_set(struct counter_d=
evice *counter,
>         cmr &=3D ~ATMEL_TC_WAVE;
>
>         switch (function) {
> -       case MCHP_TC_FUNCTION_INCREASE:
> +       case COUNTER_FUNCTION_INCREASE:
>                 priv->qdec_mode =3D 0;
>                 /* Set highest rate based on whether soc has gclk or not =
*/
>                 bmr &=3D ~(ATMEL_TC_QDEN | ATMEL_TC_POSEN);
> @@ -120,7 +108,7 @@ static int mchp_tc_count_function_set(struct counter_=
device *counter,
>                 cmr |=3D  ATMEL_TC_CMR_MASK;
>                 cmr &=3D ~(ATMEL_TC_ABETRG | ATMEL_TC_XC0);
>                 break;
> -       case MCHP_TC_FUNCTION_QUADRATURE:
> +       case COUNTER_FUNCTION_QUADRATURE_X4:
>                 if (!priv->tc_cfg->has_qdec)
>                         return -EINVAL;
>                 /* In QDEC mode settings both channels 0 and 1 are requir=
ed */
> @@ -176,10 +164,10 @@ static int mchp_tc_count_signal_read(struct counter=
_device *counter,
>         return 0;
>  }
>
> -static int mchp_tc_count_action_get(struct counter_device *counter,
> -                                   struct counter_count *count,
> -                                   struct counter_synapse *synapse,
> -                                   size_t *action)
> +static int mchp_tc_count_action_read(struct counter_device *counter,
> +                                    struct counter_count *count,
> +                                    struct counter_synapse *synapse,
> +                                    enum counter_synapse_action *action)
>  {
>         struct mchp_tc_data *const priv =3D counter->priv;
>         u32 cmr;
> @@ -188,26 +176,26 @@ static int mchp_tc_count_action_get(struct counter_=
device *counter,
>
>         switch (cmr & ATMEL_TC_ETRGEDG) {
>         default:
> -               *action =3D MCHP_TC_SYNAPSE_ACTION_NONE;
> +               *action =3D COUNTER_SYNAPSE_ACTION_NONE;
>                 break;
>         case ATMEL_TC_ETRGEDG_RISING:
> -               *action =3D MCHP_TC_SYNAPSE_ACTION_RISING_EDGE;
> +               *action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
>                 break;
>         case ATMEL_TC_ETRGEDG_FALLING:
> -               *action =3D MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE;
> +               *action =3D COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
>                 break;
>         case ATMEL_TC_ETRGEDG_BOTH:
> -               *action =3D MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE;
> +               *action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>                 break;
>         }
>
>         return 0;
>  }
>
> -static int mchp_tc_count_action_set(struct counter_device *counter,
> -                                   struct counter_count *count,
> -                                   struct counter_synapse *synapse,
> -                                   size_t action)
> +static int mchp_tc_count_action_write(struct counter_device *counter,
> +                                     struct counter_count *count,
> +                                     struct counter_synapse *synapse,
> +                                     enum counter_synapse_action action)
>  {
>         struct mchp_tc_data *const priv =3D counter->priv;
>         u32 edge =3D ATMEL_TC_ETRGEDG_NONE;
> @@ -217,16 +205,16 @@ static int mchp_tc_count_action_set(struct counter_=
device *counter,
>                 return -EINVAL;
>
>         switch (action) {
> -       case MCHP_TC_SYNAPSE_ACTION_NONE:
> +       case COUNTER_SYNAPSE_ACTION_NONE:
>                 edge =3D ATMEL_TC_ETRGEDG_NONE;
>                 break;
> -       case MCHP_TC_SYNAPSE_ACTION_RISING_EDGE:
> +       case COUNTER_SYNAPSE_ACTION_RISING_EDGE:
>                 edge =3D ATMEL_TC_ETRGEDG_RISING;
>                 break;
> -       case MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE:
> +       case COUNTER_SYNAPSE_ACTION_FALLING_EDGE:
>                 edge =3D ATMEL_TC_ETRGEDG_FALLING;
>                 break;
> -       case MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE:
> +       case COUNTER_SYNAPSE_ACTION_BOTH_EDGES:
>                 edge =3D ATMEL_TC_ETRGEDG_BOTH;
>                 break;
>         default:
> @@ -240,8 +228,7 @@ static int mchp_tc_count_action_set(struct counter_de=
vice *counter,
>  }
>
>  static int mchp_tc_count_read(struct counter_device *counter,
> -                             struct counter_count *count,
> -                             unsigned long *val)
> +                             struct counter_count *count, u64 *val)
>  {
>         struct mchp_tc_data *const priv =3D counter->priv;
>         u32 cnt;
> @@ -264,12 +251,12 @@ static struct counter_count mchp_tc_counts[] =3D {
>  };
>
>  static const struct counter_ops mchp_tc_ops =3D {
> -       .signal_read  =3D mchp_tc_count_signal_read,
> -       .count_read   =3D mchp_tc_count_read,
> -       .function_get =3D mchp_tc_count_function_get,
> -       .function_set =3D mchp_tc_count_function_set,
> -       .action_get   =3D mchp_tc_count_action_get,
> -       .action_set   =3D mchp_tc_count_action_set
> +       .signal_read    =3D mchp_tc_count_signal_read,
> +       .count_read     =3D mchp_tc_count_read,
> +       .function_read  =3D mchp_tc_count_function_read,
> +       .function_write =3D mchp_tc_count_function_write,
> +       .action_read    =3D mchp_tc_count_action_read,
> +       .action_write   =3D mchp_tc_count_action_write
>  };
>
>  static const struct atmel_tcb_config tcb_rm9200_config =3D {
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-=
lptimer-cnt.c
> index 13656957c45f..aef78a4217b5 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/types.h>
>
>  struct stm32_lptim_cnt {
>         struct counter_device counter;
> @@ -130,32 +131,46 @@ static int stm32_lptim_setup(struct stm32_lptim_cnt=
 *priv, int enable)
>   * +---------+----------+----------+---------+----------+---------+
>   */
>  enum stm32_lptim_cnt_function {
> -       STM32_LPTIM_COUNTER_INCREASE,
> -       STM32_LPTIM_ENCODER_BOTH_EDGE,
> +       STM32_LPTIM_COUNTER_INCREASE =3D COUNTER_FUNCTION_INCREASE,
> +       STM32_LPTIM_ENCODER_BOTH_EDGE =3D COUNTER_FUNCTION_QUADRATURE_X4,
>  };
>
>  static const enum counter_function stm32_lptim_cnt_functions[] =3D {
> -       [STM32_LPTIM_COUNTER_INCREASE] =3D COUNTER_FUNCTION_INCREASE,
> -       [STM32_LPTIM_ENCODER_BOTH_EDGE] =3D COUNTER_FUNCTION_QUADRATURE_X=
4,
> +       STM32_LPTIM_COUNTER_INCREASE,
> +       STM32_LPTIM_ENCODER_BOTH_EDGE,
>  };
>
>  enum stm32_lptim_synapse_action {
> +       /* Index must match with stm32_lptim_cnt_polarity[] (priv->polari=
ty) */
>         STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE,
>         STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE,
>         STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES,
>         STM32_LPTIM_SYNAPSE_ACTION_NONE,
>  };
>
> -static const enum counter_synapse_action stm32_lptim_cnt_synapse_actions=
[] =3D {
> -       /* Index must match with stm32_lptim_cnt_polarity[] (priv->polari=
ty) */
> +static const enum stm32_lptim_synapse_action stm32_lptim_c2l_actions_map=
[] =3D {
> +       [COUNTER_SYNAPSE_ACTION_RISING_EDGE] =3D STM32_LPTIM_SYNAPSE_ACTI=
ON_RISING_EDGE,
> +       [COUNTER_SYNAPSE_ACTION_FALLING_EDGE] =3D STM32_LPTIM_SYNAPSE_ACT=
ION_FALLING_EDGE,
> +       [COUNTER_SYNAPSE_ACTION_BOTH_EDGES] =3D STM32_LPTIM_SYNAPSE_ACTIO=
N_BOTH_EDGES,
> +       [COUNTER_SYNAPSE_ACTION_NONE] =3D STM32_LPTIM_SYNAPSE_ACTION_NONE=
,
> +};
> +
> +static const enum counter_synapse_action stm32_lptim_l2c_actions_map[] =
=3D {
>         [STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE] =3D COUNTER_SYNAPSE_ACTI=
ON_RISING_EDGE,
>         [STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE] =3D COUNTER_SYNAPSE_ACT=
ION_FALLING_EDGE,
>         [STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES] =3D COUNTER_SYNAPSE_ACTIO=
N_BOTH_EDGES,
>         [STM32_LPTIM_SYNAPSE_ACTION_NONE] =3D COUNTER_SYNAPSE_ACTION_NONE=
,
>  };
>
> +static const enum counter_synapse_action stm32_lptim_cnt_synapse_actions=
[] =3D {
> +       COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +       COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> +       COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +       COUNTER_SYNAPSE_ACTION_NONE,
> +};
> +
>  static int stm32_lptim_cnt_read(struct counter_device *counter,
> -                               struct counter_count *count, unsigned lon=
g *val)
> +                               struct counter_count *count, u64 *val)
>  {
>         struct stm32_lptim_cnt *const priv =3D counter->priv;
>         u32 cnt;
> @@ -170,9 +185,9 @@ static int stm32_lptim_cnt_read(struct counter_device=
 *counter,
>         return 0;
>  }
>
> -static int stm32_lptim_cnt_function_get(struct counter_device *counter,
> -                                       struct counter_count *count,
> -                                       size_t *function)
> +static int stm32_lptim_cnt_function_read(struct counter_device *counter,
> +                                        struct counter_count *count,
> +                                        enum counter_function *function)
>  {
>         struct stm32_lptim_cnt *const priv =3D counter->priv;
>
> @@ -189,9 +204,9 @@ static int stm32_lptim_cnt_function_get(struct counte=
r_device *counter,
>         return -EINVAL;
>  }
>
> -static int stm32_lptim_cnt_function_set(struct counter_device *counter,
> -                                       struct counter_count *count,
> -                                       size_t function)
> +static int stm32_lptim_cnt_function_write(struct counter_device *counter=
,
> +                                         struct counter_count *count,
> +                                         enum counter_function function)
>  {
>         struct stm32_lptim_cnt *const priv =3D counter->priv;
>
> @@ -212,9 +227,9 @@ static int stm32_lptim_cnt_function_set(struct counte=
r_device *counter,
>         }
>  }
>
> -static ssize_t stm32_lptim_cnt_enable_read(struct counter_device *counte=
r,
> -                                          struct counter_count *count,
> -                                          void *private, char *buf)
> +static int stm32_lptim_cnt_enable_read(struct counter_device *counter,
> +                                      struct counter_count *count,
> +                                      u8 *enable)
>  {
>         struct stm32_lptim_cnt *const priv =3D counter->priv;
>         int ret;
> @@ -223,22 +238,18 @@ static ssize_t stm32_lptim_cnt_enable_read(struct c=
ounter_device *counter,
>         if (ret < 0)
>                 return ret;
>
> -       return scnprintf(buf, PAGE_SIZE, "%u\n", ret);
> +       *enable =3D ret;
> +
> +       return 0;
>  }
>
> -static ssize_t stm32_lptim_cnt_enable_write(struct counter_device *count=
er,
> -                                           struct counter_count *count,
> -                                           void *private,
> -                                           const char *buf, size_t len)
> +static int stm32_lptim_cnt_enable_write(struct counter_device *counter,
> +                                       struct counter_count *count,
> +                                       u8 enable)
>  {
>         struct stm32_lptim_cnt *const priv =3D counter->priv;
> -       bool enable;
>         int ret;
>
> -       ret =3D kstrtobool(buf, &enable);
> -       if (ret)
> -               return ret;
> -
>         /* Check nobody uses the timer, or already disabled/enabled */
>         ret =3D stm32_lptim_is_enabled(priv);
>         if ((ret < 0) || (!ret && !enable))
> @@ -254,65 +265,54 @@ static ssize_t stm32_lptim_cnt_enable_write(struct =
counter_device *counter,
>         if (ret)
>                 return ret;
>
> -       return len;
> +       return 0;
>  }
>
> -static ssize_t stm32_lptim_cnt_ceiling_read(struct counter_device *count=
er,
> -                                           struct counter_count *count,
> -                                           void *private, char *buf)
> +static int stm32_lptim_cnt_ceiling_read(struct counter_device *counter,
> +                                       struct counter_count *count,
> +                                       u64 *ceiling)
>  {
>         struct stm32_lptim_cnt *const priv =3D counter->priv;
>
> -       return snprintf(buf, PAGE_SIZE, "%u\n", priv->ceiling);
> +       *ceiling =3D priv->ceiling;
> +
> +       return 0;
>  }
>
> -static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *coun=
ter,
> -                                            struct counter_count *count,
> -                                            void *private,
> -                                            const char *buf, size_t len)
> +static int stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
> +                                        struct counter_count *count,
> +                                        u64 ceiling)
>  {
>         struct stm32_lptim_cnt *const priv =3D counter->priv;
> -       unsigned int ceiling;
> -       int ret;
>
>         if (stm32_lptim_is_enabled(priv))
>                 return -EBUSY;
>
> -       ret =3D kstrtouint(buf, 0, &ceiling);
> -       if (ret)
> -               return ret;
> -
>         if (ceiling > STM32_LPTIM_MAX_ARR)
>                 return -ERANGE;
>
>         priv->ceiling =3D ceiling;
>
> -       return len;
> +       return 0;
>  }
>
> -static const struct counter_count_ext stm32_lptim_cnt_ext[] =3D {
> -       {
> -               .name =3D "enable",
> -               .read =3D stm32_lptim_cnt_enable_read,
> -               .write =3D stm32_lptim_cnt_enable_write
> -       },
> -       {
> -               .name =3D "ceiling",
> -               .read =3D stm32_lptim_cnt_ceiling_read,
> -               .write =3D stm32_lptim_cnt_ceiling_write
> -       },
> +static struct counter_comp stm32_lptim_cnt_ext[] =3D {
> +       COUNTER_COMP_ENABLE(stm32_lptim_cnt_enable_read,
> +                           stm32_lptim_cnt_enable_write),
> +       COUNTER_COMP_CEILING(stm32_lptim_cnt_ceiling_read,
> +                            stm32_lptim_cnt_ceiling_write),
>  };
>
> -static int stm32_lptim_cnt_action_get(struct counter_device *counter,
> -                                     struct counter_count *count,
> -                                     struct counter_synapse *synapse,
> -                                     size_t *action)
> +static int stm32_lptim_cnt_action_read(struct counter_device *counter,
> +                                      struct counter_count *count,
> +                                      struct counter_synapse *synapse,
> +                                      enum counter_synapse_action *actio=
n)
>  {
>         struct stm32_lptim_cnt *const priv =3D counter->priv;
> -       size_t function;
> +       enum counter_function function;
>         int err;
>
> -       err =3D stm32_lptim_cnt_function_get(counter, count, &function);
> +       err =3D stm32_lptim_cnt_function_read(counter, count, &function);
>         if (err)
>                 return err;
>
> @@ -320,12 +320,12 @@ static int stm32_lptim_cnt_action_get(struct counte=
r_device *counter,
>         case STM32_LPTIM_COUNTER_INCREASE:
>                 /* LP Timer acts as up-counter on input 1 */
>                 if (synapse->signal->id =3D=3D count->synapses[0].signal-=
>id)
> -                       *action =3D priv->polarity;
> +                       *action =3D stm32_lptim_l2c_actions_map[priv->pol=
arity];
>                 else
> -                       *action =3D STM32_LPTIM_SYNAPSE_ACTION_NONE;
> +                       *action =3D COUNTER_SYNAPSE_ACTION_NONE;
>                 return 0;
>         case STM32_LPTIM_ENCODER_BOTH_EDGE:
> -               *action =3D priv->polarity;
> +               *action =3D stm32_lptim_l2c_actions_map[priv->polarity];
>                 return 0;
>         default:
>                 /* should never reach this path */
> @@ -333,43 +333,39 @@ static int stm32_lptim_cnt_action_get(struct counte=
r_device *counter,
>         }
>  }
>
> -static int stm32_lptim_cnt_action_set(struct counter_device *counter,
> -                                     struct counter_count *count,
> -                                     struct counter_synapse *synapse,
> -                                     size_t action)
> +static int stm32_lptim_cnt_action_write(struct counter_device *counter,
> +                                       struct counter_count *count,
> +                                       struct counter_synapse *synapse,
> +                                       enum counter_synapse_action actio=
n)
>  {
>         struct stm32_lptim_cnt *const priv =3D counter->priv;
> -       size_t function;
> +       enum counter_function function;
>         int err;
>
>         if (stm32_lptim_is_enabled(priv))
>                 return -EBUSY;
>
> -       err =3D stm32_lptim_cnt_function_get(counter, count, &function);
> +       err =3D stm32_lptim_cnt_function_read(counter, count, &function);
>         if (err)
>                 return err;
>
>         /* only set polarity when in counter mode (on input 1) */
> -       if (function =3D=3D STM32_LPTIM_COUNTER_INCREASE
> -           && synapse->signal->id =3D=3D count->synapses[0].signal->id) =
{
> -               switch (action) {
> -               case STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE:
> -               case STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE:
> -               case STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES:
> -                       priv->polarity =3D action;
> -                       return 0;
> -               }
> -       }
> +       if ((enum stm32_lptim_cnt_function)function !=3D STM32_LPTIM_COUN=
TER_INCREASE
> +           || synapse->signal->id !=3D count->synapses[0].signal->id
> +           || action =3D=3D COUNTER_SYNAPSE_ACTION_NONE)
> +               return -EINVAL;
>
> -       return -EINVAL;
> +       priv->polarity =3D stm32_lptim_c2l_actions_map[action];
> +
> +       return 0;
>  }
>
>  static const struct counter_ops stm32_lptim_cnt_ops =3D {
>         .count_read =3D stm32_lptim_cnt_read,
> -       .function_get =3D stm32_lptim_cnt_function_get,
> -       .function_set =3D stm32_lptim_cnt_function_set,
> -       .action_get =3D stm32_lptim_cnt_action_get,
> -       .action_set =3D stm32_lptim_cnt_action_set,
> +       .function_read =3D stm32_lptim_cnt_function_read,
> +       .function_write =3D stm32_lptim_cnt_function_write,
> +       .action_read =3D stm32_lptim_cnt_action_read,
> +       .action_write =3D stm32_lptim_cnt_action_write,
>  };
>
>  static struct counter_signal stm32_lptim_cnt_signals[] =3D {
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-ti=
mer-cnt.c
> index 3fb0debd7425..c690b76e5dab 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/types.h>
>
>  #define TIM_CCMR_CCXS  (BIT(8) | BIT(0))
>  #define TIM_CCMR_MASK  (TIM_CCMR_CC1S | TIM_CCMR_CC2S | \
> @@ -44,21 +45,21 @@ struct stm32_timer_cnt {
>   * @STM32_COUNT_ENCODER_MODE_3: counts on both TI1FP1 and TI2FP2 edges
>   */
>  enum stm32_count_function {
> +       STM32_COUNT_SLAVE_MODE_DISABLED =3D COUNTER_FUNCTION_INCREASE,
> +       STM32_COUNT_ENCODER_MODE_1 =3D COUNTER_FUNCTION_QUADRATURE_X2_A,
> +       STM32_COUNT_ENCODER_MODE_2 =3D COUNTER_FUNCTION_QUADRATURE_X2_B,
> +       STM32_COUNT_ENCODER_MODE_3 =3D COUNTER_FUNCTION_QUADRATURE_X4,
> +};
> +
> +static const enum counter_function stm32_count_functions[] =3D {
>         STM32_COUNT_SLAVE_MODE_DISABLED,
>         STM32_COUNT_ENCODER_MODE_1,
>         STM32_COUNT_ENCODER_MODE_2,
>         STM32_COUNT_ENCODER_MODE_3,
>  };
>
> -static const enum counter_function stm32_count_functions[] =3D {
> -       [STM32_COUNT_SLAVE_MODE_DISABLED] =3D COUNTER_FUNCTION_INCREASE,
> -       [STM32_COUNT_ENCODER_MODE_1] =3D COUNTER_FUNCTION_QUADRATURE_X2_A=
,
> -       [STM32_COUNT_ENCODER_MODE_2] =3D COUNTER_FUNCTION_QUADRATURE_X2_B=
,
> -       [STM32_COUNT_ENCODER_MODE_3] =3D COUNTER_FUNCTION_QUADRATURE_X4,
> -};
> -
>  static int stm32_count_read(struct counter_device *counter,
> -                           struct counter_count *count, unsigned long *v=
al)
> +                           struct counter_count *count, u64 *val)
>  {
>         struct stm32_timer_cnt *const priv =3D counter->priv;
>         u32 cnt;
> @@ -70,8 +71,7 @@ static int stm32_count_read(struct counter_device *coun=
ter,
>  }
>
>  static int stm32_count_write(struct counter_device *counter,
> -                            struct counter_count *count,
> -                            const unsigned long val)
> +                            struct counter_count *count, const u64 val)
>  {
>         struct stm32_timer_cnt *const priv =3D counter->priv;
>         u32 ceiling;
> @@ -83,9 +83,9 @@ static int stm32_count_write(struct counter_device *cou=
nter,
>         return regmap_write(priv->regmap, TIM_CNT, val);
>  }
>
> -static int stm32_count_function_get(struct counter_device *counter,
> -                                   struct counter_count *count,
> -                                   size_t *function)
> +static int stm32_count_function_read(struct counter_device *counter,
> +                                    struct counter_count *count,
> +                                    enum counter_function *function)
>  {
>         struct stm32_timer_cnt *const priv =3D counter->priv;
>         u32 smcr;
> @@ -110,9 +110,9 @@ static int stm32_count_function_get(struct counter_de=
vice *counter,
>         }
>  }
>
> -static int stm32_count_function_set(struct counter_device *counter,
> -                                   struct counter_count *count,
> -                                   size_t function)
> +static int stm32_count_function_write(struct counter_device *counter,
> +                                     struct counter_count *count,
> +                                     enum counter_function function)
>  {
>         struct stm32_timer_cnt *const priv =3D counter->priv;
>         u32 cr1, sms;
> @@ -150,44 +150,37 @@ static int stm32_count_function_set(struct counter_=
device *counter,
>         return 0;
>  }
>
> -static ssize_t stm32_count_direction_read(struct counter_device *counter=
,
> +static int stm32_count_direction_read(struct counter_device *counter,
>                                       struct counter_count *count,
> -                                     void *private, char *buf)
> +                                     enum counter_count_direction *direc=
tion)
>  {
>         struct stm32_timer_cnt *const priv =3D counter->priv;
> -       const char *direction;
>         u32 cr1;
>
>         regmap_read(priv->regmap, TIM_CR1, &cr1);
> -       direction =3D (cr1 & TIM_CR1_DIR) ? "backward" : "forward";
> +       *direction =3D (cr1 & TIM_CR1_DIR) ? COUNTER_COUNT_DIRECTION_BACK=
WARD :
> +               COUNTER_COUNT_DIRECTION_FORWARD;
>
> -       return scnprintf(buf, PAGE_SIZE, "%s\n", direction);
> +       return 0;
>  }
>
> -static ssize_t stm32_count_ceiling_read(struct counter_device *counter,
> -                                       struct counter_count *count,
> -                                       void *private, char *buf)
> +static int stm32_count_ceiling_read(struct counter_device *counter,
> +                                   struct counter_count *count, u64 *cei=
ling)
>  {
>         struct stm32_timer_cnt *const priv =3D counter->priv;
>         u32 arr;
>
>         regmap_read(priv->regmap, TIM_ARR, &arr);
>
> -       return snprintf(buf, PAGE_SIZE, "%u\n", arr);
> +       *ceiling =3D arr;
> +
> +       return 0;
>  }
>
> -static ssize_t stm32_count_ceiling_write(struct counter_device *counter,
> -                                        struct counter_count *count,
> -                                        void *private,
> -                                        const char *buf, size_t len)
> +static int stm32_count_ceiling_write(struct counter_device *counter,
> +                                    struct counter_count *count, u64 cei=
ling)
>  {
>         struct stm32_timer_cnt *const priv =3D counter->priv;
> -       unsigned int ceiling;
> -       int ret;
> -
> -       ret =3D kstrtouint(buf, 0, &ceiling);
> -       if (ret)
> -               return ret;
>
>         if (ceiling > priv->max_arr)
>                 return -ERANGE;
> @@ -196,34 +189,27 @@ static ssize_t stm32_count_ceiling_write(struct cou=
nter_device *counter,
>         regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
>         regmap_write(priv->regmap, TIM_ARR, ceiling);
>
> -       return len;
> +       return 0;
>  }
>
> -static ssize_t stm32_count_enable_read(struct counter_device *counter,
> -                                      struct counter_count *count,
> -                                      void *private, char *buf)
> +static int stm32_count_enable_read(struct counter_device *counter,
> +                                  struct counter_count *count, u8 *enabl=
e)
>  {
>         struct stm32_timer_cnt *const priv =3D counter->priv;
>         u32 cr1;
>
>         regmap_read(priv->regmap, TIM_CR1, &cr1);
>
> -       return scnprintf(buf, PAGE_SIZE, "%d\n", (bool)(cr1 & TIM_CR1_CEN=
));
> +       *enable =3D cr1 & TIM_CR1_CEN;
> +
> +       return 0;
>  }
>
> -static ssize_t stm32_count_enable_write(struct counter_device *counter,
> -                                       struct counter_count *count,
> -                                       void *private,
> -                                       const char *buf, size_t len)
> +static int stm32_count_enable_write(struct counter_device *counter,
> +                                   struct counter_count *count, u8 enabl=
e)
>  {
>         struct stm32_timer_cnt *const priv =3D counter->priv;
> -       int err;
>         u32 cr1;
> -       bool enable;
> -
> -       err =3D kstrtobool(buf, &enable);
> -       if (err)
> -               return err;
>
>         if (enable) {
>                 regmap_read(priv->regmap, TIM_CR1, &cr1);
> @@ -242,70 +228,55 @@ static ssize_t stm32_count_enable_write(struct coun=
ter_device *counter,
>         /* Keep enabled state to properly handle low power states */
>         priv->enabled =3D enable;
>
> -       return len;
> +       return 0;
>  }
>
> -static const struct counter_count_ext stm32_count_ext[] =3D {
> -       {
> -               .name =3D "direction",
> -               .read =3D stm32_count_direction_read,
> -       },
> -       {
> -               .name =3D "enable",
> -               .read =3D stm32_count_enable_read,
> -               .write =3D stm32_count_enable_write
> -       },
> -       {
> -               .name =3D "ceiling",
> -               .read =3D stm32_count_ceiling_read,
> -               .write =3D stm32_count_ceiling_write
> -       },
> -};
> -
> -enum stm32_synapse_action {
> -       STM32_SYNAPSE_ACTION_NONE,
> -       STM32_SYNAPSE_ACTION_BOTH_EDGES
> +static struct counter_comp stm32_count_ext[] =3D {
> +       COUNTER_COMP_DIRECTION(stm32_count_direction_read),
> +       COUNTER_COMP_ENABLE(stm32_count_enable_read, stm32_count_enable_w=
rite),
> +       COUNTER_COMP_CEILING(stm32_count_ceiling_read,
> +                            stm32_count_ceiling_write),
>  };
>
>  static const enum counter_synapse_action stm32_synapse_actions[] =3D {
> -       [STM32_SYNAPSE_ACTION_NONE] =3D COUNTER_SYNAPSE_ACTION_NONE,
> -       [STM32_SYNAPSE_ACTION_BOTH_EDGES] =3D COUNTER_SYNAPSE_ACTION_BOTH=
_EDGES
> +       COUNTER_SYNAPSE_ACTION_NONE,
> +       COUNTER_SYNAPSE_ACTION_BOTH_EDGES
>  };
>
> -static int stm32_action_get(struct counter_device *counter,
> -                           struct counter_count *count,
> -                           struct counter_synapse *synapse,
> -                           size_t *action)
> +static int stm32_action_read(struct counter_device *counter,
> +                            struct counter_count *count,
> +                            struct counter_synapse *synapse,
> +                            enum counter_synapse_action *action)
>  {
> -       size_t function;
> +       enum counter_function function;
>         int err;
>
> -       err =3D stm32_count_function_get(counter, count, &function);
> +       err =3D stm32_count_function_read(counter, count, &function);
>         if (err)
>                 return err;
>
>         switch (function) {
>         case STM32_COUNT_SLAVE_MODE_DISABLED:
>                 /* counts on internal clock when CEN=3D1 */
> -               *action =3D STM32_SYNAPSE_ACTION_NONE;
> +               *action =3D COUNTER_SYNAPSE_ACTION_NONE;
>                 return 0;
>         case STM32_COUNT_ENCODER_MODE_1:
>                 /* counts up/down on TI1FP1 edge depending on TI2FP2 leve=
l */
>                 if (synapse->signal->id =3D=3D count->synapses[0].signal-=
>id)
> -                       *action =3D STM32_SYNAPSE_ACTION_BOTH_EDGES;
> +                       *action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>                 else
> -                       *action =3D STM32_SYNAPSE_ACTION_NONE;
> +                       *action =3D COUNTER_SYNAPSE_ACTION_NONE;
>                 return 0;
>         case STM32_COUNT_ENCODER_MODE_2:
>                 /* counts up/down on TI2FP2 edge depending on TI1FP1 leve=
l */
>                 if (synapse->signal->id =3D=3D count->synapses[1].signal-=
>id)
> -                       *action =3D STM32_SYNAPSE_ACTION_BOTH_EDGES;
> +                       *action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>                 else
> -                       *action =3D STM32_SYNAPSE_ACTION_NONE;
> +                       *action =3D COUNTER_SYNAPSE_ACTION_NONE;
>                 return 0;
>         case STM32_COUNT_ENCODER_MODE_3:
>                 /* counts up/down on both TI1FP1 and TI2FP2 edges */
> -               *action =3D STM32_SYNAPSE_ACTION_BOTH_EDGES;
> +               *action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>                 return 0;
>         default:
>                 return -EINVAL;
> @@ -315,9 +286,9 @@ static int stm32_action_get(struct counter_device *co=
unter,
>  static const struct counter_ops stm32_timer_cnt_ops =3D {
>         .count_read =3D stm32_count_read,
>         .count_write =3D stm32_count_write,
> -       .function_get =3D stm32_count_function_get,
> -       .function_set =3D stm32_count_function_set,
> -       .action_get =3D stm32_action_get,
> +       .function_read =3D stm32_count_function_read,
> +       .function_write =3D stm32_count_function_write,
> +       .action_read =3D stm32_action_read,
>  };
>
>  static struct counter_signal stm32_signals[] =3D {
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 94fe58bb3eab..09817c953f9a 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/types.h>
>
>  /* 32-bit registers */
>  #define QPOSCNT                0x0
> @@ -73,19 +74,13 @@ enum {
>  };
>
>  /* Position Counter Input Modes */
> -enum {
> +enum ti_eqep_count_func {
>         TI_EQEP_COUNT_FUNC_QUAD_COUNT,
>         TI_EQEP_COUNT_FUNC_DIR_COUNT,
>         TI_EQEP_COUNT_FUNC_UP_COUNT,
>         TI_EQEP_COUNT_FUNC_DOWN_COUNT,
>  };
>
> -enum {
> -       TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES,
> -       TI_EQEP_SYNAPSE_ACTION_RISING_EDGE,
> -       TI_EQEP_SYNAPSE_ACTION_NONE,
> -};
> -
>  struct ti_eqep_cnt {
>         struct counter_device counter;
>         struct regmap *regmap32;
> @@ -93,7 +88,7 @@ struct ti_eqep_cnt {
>  };
>
>  static int ti_eqep_count_read(struct counter_device *counter,
> -                             struct counter_count *count, unsigned long =
*val)
> +                             struct counter_count *count, u64 *val)
>  {
>         struct ti_eqep_cnt *priv =3D counter->priv;
>         u32 cnt;
> @@ -105,7 +100,7 @@ static int ti_eqep_count_read(struct counter_device *=
counter,
>  }
>
>  static int ti_eqep_count_write(struct counter_device *counter,
> -                              struct counter_count *count, unsigned long=
 val)
> +                              struct counter_count *count, u64 val)
>  {
>         struct ti_eqep_cnt *priv =3D counter->priv;
>         u32 max;
> @@ -117,64 +112,100 @@ static int ti_eqep_count_write(struct counter_devi=
ce *counter,
>         return regmap_write(priv->regmap32, QPOSCNT, val);
>  }
>
> -static int ti_eqep_function_get(struct counter_device *counter,
> -                               struct counter_count *count, size_t *func=
tion)
> +static int ti_eqep_function_read(struct counter_device *counter,
> +                                struct counter_count *count,
> +                                enum counter_function *function)
>  {
>         struct ti_eqep_cnt *priv =3D counter->priv;
>         u32 qdecctl;
>
>         regmap_read(priv->regmap16, QDECCTL, &qdecctl);
> -       *function =3D (qdecctl & QDECCTL_QSRC) >> QDECCTL_QSRC_SHIFT;
> +
> +       switch ((qdecctl & QDECCTL_QSRC) >> QDECCTL_QSRC_SHIFT) {
> +       case TI_EQEP_COUNT_FUNC_QUAD_COUNT:
> +               *function =3D COUNTER_FUNCTION_QUADRATURE_X4;
> +               break;
> +       case TI_EQEP_COUNT_FUNC_DIR_COUNT:
> +               *function =3D COUNTER_FUNCTION_PULSE_DIRECTION;
> +               break;
> +       case TI_EQEP_COUNT_FUNC_UP_COUNT:
> +               *function =3D COUNTER_FUNCTION_INCREASE;
> +               break;
> +       case TI_EQEP_COUNT_FUNC_DOWN_COUNT:
> +               *function =3D COUNTER_FUNCTION_DECREASE;
> +               break;
> +       }
>
>         return 0;
>  }
>
> -static int ti_eqep_function_set(struct counter_device *counter,
> -                               struct counter_count *count, size_t funct=
ion)
> +static int ti_eqep_function_write(struct counter_device *counter,
> +                                 struct counter_count *count,
> +                                 enum counter_function function)
>  {
>         struct ti_eqep_cnt *priv =3D counter->priv;
> +       enum ti_eqep_count_func qsrc;
> +
> +       switch (function) {
> +       case COUNTER_FUNCTION_QUADRATURE_X4:
> +               qsrc =3D TI_EQEP_COUNT_FUNC_QUAD_COUNT;
> +               break;
> +       case COUNTER_FUNCTION_PULSE_DIRECTION:
> +               qsrc =3D TI_EQEP_COUNT_FUNC_DIR_COUNT;
> +               break;
> +       case COUNTER_FUNCTION_INCREASE:
> +               qsrc =3D TI_EQEP_COUNT_FUNC_UP_COUNT;
> +               break;
> +       case COUNTER_FUNCTION_DECREASE:
> +               qsrc =3D TI_EQEP_COUNT_FUNC_DOWN_COUNT;
> +               break;
> +       default:
> +               /* should never reach this path */
> +               return -EINVAL;
> +       }
>
>         return regmap_write_bits(priv->regmap16, QDECCTL, QDECCTL_QSRC,
> -                                function << QDECCTL_QSRC_SHIFT);
> +                                qsrc << QDECCTL_QSRC_SHIFT);
>  }
>
> -static int ti_eqep_action_get(struct counter_device *counter,
> -                             struct counter_count *count,
> -                             struct counter_synapse *synapse, size_t *ac=
tion)
> +static int ti_eqep_action_read(struct counter_device *counter,
> +                              struct counter_count *count,
> +                              struct counter_synapse *synapse,
> +                              enum counter_synapse_action *action)
>  {
>         struct ti_eqep_cnt *priv =3D counter->priv;
> -       size_t function;
> +       enum counter_function function;
>         u32 qdecctl;
>         int err;
>
> -       err =3D ti_eqep_function_get(counter, count, &function);
> +       err =3D ti_eqep_function_read(counter, count, &function);
>         if (err)
>                 return err;
>
>         switch (function) {
> -       case TI_EQEP_COUNT_FUNC_QUAD_COUNT:
> +       case COUNTER_FUNCTION_QUADRATURE_X4:
>                 /* In quadrature mode, the rising and falling edge of bot=
h
>                  * QEPA and QEPB trigger QCLK.
>                  */
> -               *action =3D TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
> +               *action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>                 return 0;
> -       case TI_EQEP_COUNT_FUNC_DIR_COUNT:
> +       case COUNTER_FUNCTION_PULSE_DIRECTION:
>                 /* In direction-count mode only rising edge of QEPA is co=
unted
>                  * and QEPB gives direction.
>                  */
>                 switch (synapse->signal->id) {
>                 case TI_EQEP_SIGNAL_QEPA:
> -                       *action =3D TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
> +                       *action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
>                         return 0;
>                 case TI_EQEP_SIGNAL_QEPB:
> -                       *action =3D TI_EQEP_SYNAPSE_ACTION_NONE;
> +                       *action =3D COUNTER_SYNAPSE_ACTION_NONE;
>                         return 0;
>                 default:
>                         /* should never reach this path */
>                         return -EINVAL;
>                 }
> -       case TI_EQEP_COUNT_FUNC_UP_COUNT:
> -       case TI_EQEP_COUNT_FUNC_DOWN_COUNT:
> +       case COUNTER_FUNCTION_INCREASE:
> +       case COUNTER_FUNCTION_DECREASE:
>                 /* In up/down-count modes only QEPA is counted and QEPB i=
s not
>                  * used.
>                  */
> @@ -185,12 +216,12 @@ static int ti_eqep_action_get(struct counter_device=
 *counter,
>                                 return err;
>
>                         if (qdecctl & QDECCTL_XCR)
> -                               *action =3D TI_EQEP_SYNAPSE_ACTION_BOTH_E=
DGES;
> +                               *action =3D COUNTER_SYNAPSE_ACTION_BOTH_E=
DGES;
>                         else
> -                               *action =3D TI_EQEP_SYNAPSE_ACTION_RISING=
_EDGE;
> +                               *action =3D COUNTER_SYNAPSE_ACTION_RISING=
_EDGE;
>                         return 0;
>                 case TI_EQEP_SIGNAL_QEPB:
> -                       *action =3D TI_EQEP_SYNAPSE_ACTION_NONE;
> +                       *action =3D COUNTER_SYNAPSE_ACTION_NONE;
>                         return 0;
>                 default:
>                         /* should never reach this path */
> @@ -205,82 +236,67 @@ static int ti_eqep_action_get(struct counter_device=
 *counter,
>  static const struct counter_ops ti_eqep_counter_ops =3D {
>         .count_read     =3D ti_eqep_count_read,
>         .count_write    =3D ti_eqep_count_write,
> -       .function_get   =3D ti_eqep_function_get,
> -       .function_set   =3D ti_eqep_function_set,
> -       .action_get     =3D ti_eqep_action_get,
> +       .function_read  =3D ti_eqep_function_read,
> +       .function_write =3D ti_eqep_function_write,
> +       .action_read    =3D ti_eqep_action_read,
>  };
>
> -static ssize_t ti_eqep_position_ceiling_read(struct counter_device *coun=
ter,
> -                                            struct counter_count *count,
> -                                            void *ext_priv, char *buf)
> +static int ti_eqep_position_ceiling_read(struct counter_device *counter,
> +                                        struct counter_count *count,
> +                                        u64 *ceiling)
>  {
>         struct ti_eqep_cnt *priv =3D counter->priv;
>         u32 qposmax;
>
>         regmap_read(priv->regmap32, QPOSMAX, &qposmax);
>
> -       return sprintf(buf, "%u\n", qposmax);
> +       *ceiling =3D qposmax;
> +
> +       return 0;
>  }
>
> -static ssize_t ti_eqep_position_ceiling_write(struct counter_device *cou=
nter,
> -                                             struct counter_count *count=
,
> -                                             void *ext_priv, const char =
*buf,
> -                                             size_t len)
> +static int ti_eqep_position_ceiling_write(struct counter_device *counter=
,
> +                                         struct counter_count *count,
> +                                         u64 ceiling)
>  {
>         struct ti_eqep_cnt *priv =3D counter->priv;
> -       int err;
> -       u32 res;
>
> -       err =3D kstrtouint(buf, 0, &res);
> -       if (err < 0)
> -               return err;
> +       if (ceiling !=3D (u32)ceiling)
> +               return -ERANGE;
>
> -       regmap_write(priv->regmap32, QPOSMAX, res);
> +       regmap_write(priv->regmap32, QPOSMAX, ceiling);
>
> -       return len;
> +       return 0;
>  }
>
> -static ssize_t ti_eqep_position_enable_read(struct counter_device *count=
er,
> -                                           struct counter_count *count,
> -                                           void *ext_priv, char *buf)
> +static int ti_eqep_position_enable_read(struct counter_device *counter,
> +                                       struct counter_count *count, u8 *=
enable)
>  {
>         struct ti_eqep_cnt *priv =3D counter->priv;
>         u32 qepctl;
>
>         regmap_read(priv->regmap16, QEPCTL, &qepctl);
>
> -       return sprintf(buf, "%u\n", !!(qepctl & QEPCTL_PHEN));
> +       *enable =3D !!(qepctl & QEPCTL_PHEN);
> +
> +       return 0;
>  }
>
> -static ssize_t ti_eqep_position_enable_write(struct counter_device *coun=
ter,
> -                                            struct counter_count *count,
> -                                            void *ext_priv, const char *=
buf,
> -                                            size_t len)
> +static int ti_eqep_position_enable_write(struct counter_device *counter,
> +                                        struct counter_count *count, u8 =
enable)
>  {
>         struct ti_eqep_cnt *priv =3D counter->priv;
> -       int err;
> -       bool res;
> -
> -       err =3D kstrtobool(buf, &res);
> -       if (err < 0)
> -               return err;
>
> -       regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, res ? -1 :=
 0);
> +       regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, enable ? -=
1 : 0);
>
> -       return len;
> +       return 0;
>  }
>
> -static struct counter_count_ext ti_eqep_position_ext[] =3D {
> -       {
> -               .name   =3D "ceiling",
> -               .read   =3D ti_eqep_position_ceiling_read,
> -               .write  =3D ti_eqep_position_ceiling_write,
> -       },
> -       {
> -               .name   =3D "enable",
> -               .read   =3D ti_eqep_position_enable_read,
> -               .write  =3D ti_eqep_position_enable_write,
> -       },
> +static struct counter_comp ti_eqep_position_ext[] =3D {
> +       COUNTER_COMP_CEILING(ti_eqep_position_ceiling_read,
> +                            ti_eqep_position_ceiling_write),
> +       COUNTER_COMP_ENABLE(ti_eqep_position_enable_read,
> +                           ti_eqep_position_enable_write),
>  };
>
>  static struct counter_signal ti_eqep_signals[] =3D {
> @@ -295,16 +311,16 @@ static struct counter_signal ti_eqep_signals[] =3D =
{
>  };
>
>  static const enum counter_function ti_eqep_position_functions[] =3D {
> -       [TI_EQEP_COUNT_FUNC_QUAD_COUNT] =3D COUNTER_FUNCTION_QUADRATURE_X=
4,
> -       [TI_EQEP_COUNT_FUNC_DIR_COUNT]  =3D COUNTER_FUNCTION_PULSE_DIRECT=
ION,
> -       [TI_EQEP_COUNT_FUNC_UP_COUNT]   =3D COUNTER_FUNCTION_INCREASE,
> -       [TI_EQEP_COUNT_FUNC_DOWN_COUNT] =3D COUNTER_FUNCTION_DECREASE,
> +       COUNTER_FUNCTION_QUADRATURE_X4,
> +       COUNTER_FUNCTION_PULSE_DIRECTION,
> +       COUNTER_FUNCTION_INCREASE,
> +       COUNTER_FUNCTION_DECREASE,
>  };
>
>  static const enum counter_synapse_action ti_eqep_position_synapse_action=
s[] =3D {
> -       [TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES]     =3D COUNTER_SYNAPSE_ACTIO=
N_BOTH_EDGES,
> -       [TI_EQEP_SYNAPSE_ACTION_RISING_EDGE]    =3D COUNTER_SYNAPSE_ACTIO=
N_RISING_EDGE,
> -       [TI_EQEP_SYNAPSE_ACTION_NONE]           =3D COUNTER_SYNAPSE_ACTIO=
N_NONE,
> +       COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +       COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +       COUNTER_SYNAPSE_ACTION_NONE,
>  };
>
>  static struct counter_synapse ti_eqep_position_synapses[] =3D {
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index d16ce2819b48..b69277f5c4c5 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -6,42 +6,184 @@
>  #ifndef _COUNTER_H_
>  #define _COUNTER_H_
>
> -#include <linux/counter_enum.h>
>  #include <linux/device.h>
> +#include <linux/kernel.h>
>  #include <linux/types.h>
>
> +struct counter_device;
> +struct counter_count;
> +struct counter_synapse;
> +struct counter_signal;
> +
> +enum counter_comp_type {
> +       COUNTER_COMP_U8,
> +       COUNTER_COMP_U64,
> +       COUNTER_COMP_BOOL,
> +       COUNTER_COMP_SIGNAL_LEVEL,
> +       COUNTER_COMP_FUNCTION,
> +       COUNTER_COMP_SYNAPSE_ACTION,
> +       COUNTER_COMP_ENUM,
> +       COUNTER_COMP_COUNT_DIRECTION,
> +       COUNTER_COMP_COUNT_MODE,
> +};
> +
> +enum counter_scope {
> +       COUNTER_SCOPE_DEVICE,
> +       COUNTER_SCOPE_SIGNAL,
> +       COUNTER_SCOPE_COUNT,
> +};
> +
>  enum counter_count_direction {
> -       COUNTER_COUNT_DIRECTION_FORWARD =3D 0,
> -       COUNTER_COUNT_DIRECTION_BACKWARD
> +       COUNTER_COUNT_DIRECTION_FORWARD,
> +       COUNTER_COUNT_DIRECTION_BACKWARD,
>  };
> -extern const char *const counter_count_direction_str[2];
>
>  enum counter_count_mode {
> -       COUNTER_COUNT_MODE_NORMAL =3D 0,
> +       COUNTER_COUNT_MODE_NORMAL,
>         COUNTER_COUNT_MODE_RANGE_LIMIT,
>         COUNTER_COUNT_MODE_NON_RECYCLE,
> -       COUNTER_COUNT_MODE_MODULO_N
> +       COUNTER_COUNT_MODE_MODULO_N,
>  };
> -extern const char *const counter_count_mode_str[4];
>
> -struct counter_device;
> -struct counter_signal;
> +enum counter_function {
> +       COUNTER_FUNCTION_INCREASE,
> +       COUNTER_FUNCTION_DECREASE,
> +       COUNTER_FUNCTION_PULSE_DIRECTION,
> +       COUNTER_FUNCTION_QUADRATURE_X1_A,
> +       COUNTER_FUNCTION_QUADRATURE_X1_B,
> +       COUNTER_FUNCTION_QUADRATURE_X2_A,
> +       COUNTER_FUNCTION_QUADRATURE_X2_B,
> +       COUNTER_FUNCTION_QUADRATURE_X4,
> +};
> +
> +enum counter_signal_level {
> +       COUNTER_SIGNAL_LEVEL_LOW,
> +       COUNTER_SIGNAL_LEVEL_HIGH,
> +};
> +
> +enum counter_synapse_action {
> +       COUNTER_SYNAPSE_ACTION_NONE,
> +       COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +       COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> +       COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +};
>
>  /**
> - * struct counter_signal_ext - Counter Signal extensions
> - * @name:      attribute name
> - * @read:      read callback for this attribute; may be NULL
> - * @write:     write callback for this attribute; may be NULL
> - * @priv:      data private to the driver
> + * struct counter_comp - Counter component node
> + * @type:              Counter component data type
> + * @name:              device-specific component name
> + * @priv:              component-relevant data
> + * @action_read                Synapse action mode read callback. The re=
ad value of the
> + *                     respective Synapse action mode should be passed b=
ack via
> + *                     the action parameter.
> + * @device_u8_read     Device u8 component read callback. The read value=
 of the
> + *                     respective Device u8 component should be passed b=
ack via
> + *                     the val parameter.
> + * @count_u8_read      Count u8 component read callback. The read value =
of the
> + *                     respective Count u8 component should be passed ba=
ck via
> + *                     the val parameter.
> + * @signal_u8_read     Signal u8 component read callback. The read value=
 of the
> + *                     respective Signal u8 component should be passed b=
ack via
> + *                     the val parameter.
> + * @device_u32_read    Device u32 component read callback. The read valu=
e of
> + *                     the respective De
