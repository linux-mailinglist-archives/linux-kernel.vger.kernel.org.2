Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8683CB60F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbhGPK2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhGPK2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:28:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59CAC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:25:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m11-20020a05600c3b0bb0290228f19cb433so7887214wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gv72f1Zxw8oMtdHJCMzdQGldFu+XH7c7kGYSmZfFrzk=;
        b=cxlke7GIxDvqD1gKxCoq2C1Lp5Tz35E4UWT36qAsggGuWVEUweL1XBtG+d3xpYGERK
         qoh3vVjkNyoEw1t4ItlFBssQZCXhat/0pNFude9DvUgL8GVhrfOdHuZH0OlAvM8SQiXL
         q3xfiuYoVXPd2fMys1tlQ0si/nm/WroUq9gwJhjfi2SSrPdpX1SWXtaJzAOZhHfZQzGV
         qyzS8klGFrzPdrDnY+R+babCdHDRb8HWtV7kGrJHlQo0srGaCUCLjAE4uVVPW3nJLE+X
         8u12qrVpb+IFhb5jo9siLR9FdRyyAg+Yn6Rzk5GCJXA5DbraMAdmNpY/IL+pOZf/eVyV
         0H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gv72f1Zxw8oMtdHJCMzdQGldFu+XH7c7kGYSmZfFrzk=;
        b=MgqxHSs01d/4J1xhsygV8yoFgi/xwOT/yCq5FjR+w4jHs3FcU2HWUDM5xyF5H9OX+A
         xKGrNay2wPI2vlezZzJLccYf0F2umezR3btqMIi6V7d3C8Mt7qgHPiyzX5cD0xxxwvLa
         oyqgtnI/SqcXCBY39ALIvCrH8F7xE/2UZVqLs6WjSFLmNbCsJX4kfNnOpQLs8SvoMMKR
         Ff3oRdouo9FcIWYPlgv28xPxBAo/+0D0408Gv0wWcErnybuoI7Z9LEI98jw4TjumR6tQ
         QnagbVFqjYNgKgRHk50QZvkreRmj5SguB1k2kWb0vuglNTLeDqM92E5Y1ETKDR3Jvpuy
         FkPg==
X-Gm-Message-State: AOAM533Lm4uh4mILkUOqKuoKOtUcyI5M32CHYUAH497PebU+trbAUajw
        UfaOf3Vt8B6wXnAVvM8aPnGAzj+idrL3mdSMwVZJUQ==
X-Google-Smtp-Source: ABdhPJwqgykIIpOs6UanDJN8oyvpv264FP9E9qr8yyKgiv2sLURH8qdPb5MMItDl6QObYD+fvpvdV5gswiTO23h0W1o=
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr9928198wma.5.1626431158180;
 Fri, 16 Jul 2021 03:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210707133003.5414-1-mike.leach@linaro.org> <20210712164413.GA1777012@p14s>
 <a80b9a03-01ba-3752-9e6e-ee2d194ba2a1@arm.com>
In-Reply-To: <a80b9a03-01ba-3752-9e6e-ee2d194ba2a1@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 16 Jul 2021 11:25:47 +0100
Message-ID: <CAJ9a7ViieBazkBckF+2Bb0eeQyp14EpUAJ0j_GmU_Kibj9OBMg@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] CoreSight configuration management; ETM strobing
To:     Branislav Rankov <branislav.rankov@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Mathieu,

Below my change notes for the patches changed between v7 and v8 in this set=
.

Regards

Mike

0001, 0003, 0004, 0006, 0007, 0008, 0010 - no change

0002 -
coresight-syscfg.c
    top of file - mutex declaration removed.
    cscfg_add_csdev_cfg()
        Spinlock replaces mutex
    cscfg_load_feat_csdev()
        Spinlock replaces mutex
    cscsg_list_add_csdev()
        Init spinlock
coresight.h
    struct coresight_device {}
        Add spinlock cscfg_csdev_lock alongside the csdev feature and
config lists that it protects.

0005 -
coresight-syscfg.c
    cscfg_csdev_reset_feats()
            Spinlock replaces mutex.

    cscfg_csdev_enable_active_config()
            Spinlock replaces mutex. In enable flag to avoid race with disa=
ble.
    cscfg_csdev_disable_active_config()
            Spinlock replaces mutex. In enable flag to avoid race with enab=
le.


coresight.h
    struct coresight_device {}
        In enable flag introduced to control possible race between
enable and disable. E.g. if we are enabling a config, but a power
event tries to shut down the CPU/ETM causing a disable call. We don=E2=80=
=99t
want to hold the cscfg_csdev_lock spinlock throughout the entire
enable process - especially as the programming call will claim the
internal driver spinlock when writing internal driver data, but we
need to ensure that if there is a condition that permits a disable
call out of normal sequence then we are able to see it and handle it.

0009 -
    KConfig
    add in dependency on CONFIGFS_FS to eliminate problem highlighted
by the kernel bot tests. This had configured coresight as Y, but
configfs as M - meaning link issues for configfs code introduced in
this set.

On Tue, 13 Jul 2021 at 10:43, Branislav Rankov <branislav.rankov@arm.com> w=
rote:
>
> Hi Mathieu,
>
> On 7/12/21 5:44 PM, Mathieu Poirier wrote:
> > Good morning Mike,
> >
> > On Wed, Jul 07, 2021 at 02:29:53PM +0100, Mike Leach wrote:
> >> This patchset introduces initial concepts in CoreSight system
> >> configuration management support. to allow more detailed and complex
> >> programming to be applied to CoreSight systems during trace capture.
> >>
> >> Configurations consist of 2 elements:-
> >> 1) Features - programming combinations for devices, applied to a class=
 of
> >> device on the system (all ETMv4), or individual devices.
> >> 2) Configurations - a set of programmed features used when the named
> >> configuration is selected.
> >>
> >> Features and configurations are declared as a data table, a set of reg=
ister,
> >> resource and parameter requirements. Features and configurations are l=
oaded
> >> into the system by the virtual cs_syscfg device. This then matches fea=
tures
> >> to any registered devices and loads the feature into them.
> >>
> >> Individual device classes that support feature and configuration regis=
ter
> >> with cs_syscfg.
> >>
> >> Once loaded a configuration can be enabled for a specific trace run.
> >> Configurations are registered with the perf cs_etm event as entries in
> >> cs_etm/events. These can be selected on the perf command line as follo=
ws:-
> >>
> >> perf record -e cs_etm/<config_name>/ ...
> >>
> >> This patch set has one pre-loaded configuration and feature.
> >> A named "strobing" feature is provided for ETMv4.
> >> A named "autofdo" configuration is provided. This configuration enable=
s
> >> strobing on any ETM in used.
> >>
> >> Thus the command:
> >> perf record -e cs_etm/autofdo/ ...
> >>
> >> will trace the supplied application while enabling the "autofdo" confi=
guation
> >> on each ETM as it is enabled by perf. This in turn will enable strobin=
g for
> >> the ETM - with default parameters. Parameters can be adjusted using co=
nfigfs.
> >>
> >> The sink used in the trace run will be automatically selected.
> >>
> >> A configuration can supply up to 15 of preset parameter values, which =
will
> >> subsitute in parameter values for any feature used in the configuratio=
n.
> >>
> >> Selection of preset values as follows
> >> perf record -e cs_etm/autofdo,preset=3D1/ ...
> >>
> >> (valid presets 1-N, where N is the number supplied in the configuratio=
n, not
> >> exceeding 15. preset=3D0 is the same as not selecting a preset.)
> >>
> >> Applies to & tested against coresight/next (5.13-rc6 base)
> >>
> >> Changes since v7:
> >>
> >> Fixed kernel test robot issue - config with CORESIGHT=3Dy & CONFIGFS_F=
S=3Dm causes
> >> build error. Altered CORESIGHT config to select CONFIGFS_FS.
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> Replaced mutex use to protect loaded config lists in coresight devices=
 with per
> >> device spinlock to remove issue when disable called in interrupt conte=
xt.
> >> Reported-by: Branislav Rankov <branislav.rankov@arm.com>
> >>
> >
> > Can you indicate which patches have changed so I don't have to review t=
he whole
> > thing again?   It is also common practice to remove the RB tag when pat=
ches
> > have changed enough to mandate another review.  In this case all patche=
s still
> > bare my RB tags.
> >
> > Branislav reported the problem but he is not a recipient.  I would like=
 to have
> > a confirmation from him that this set fixes the problem he observed bef=
ore I
> > start looking at it.
>
> I have tested this series and the issue I reported is fixed.
> >
> > Thanks,
> > Mathieu
> >
> >>
> >> Changes since v6:
> >> Fixed kernel test robot issues-
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> Changes since v5:
> >>
> >> 1) Fix code style issues from auto-build reports, as
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> 2) Update comments to get consistent docs for API functions.
> >> 3) remove unused #define from autofdo example.
> >> 4) fix perf code style issues from patch 4 (Mathieu)
> >> 5) fix configfs code style issues from patch 9. (Mathieu)
> >>
> >> Changes since v4: (based on comments from Matthieu and Suzuki).
> >> No large functional changes - primarily code improvements and naming s=
chema.
> >> 1) Updated entire set to ensure a consistent naming scheme was used fo=
r
> >> variables and struct members that refer to the key objects in the syst=
em.
> >> Suffixes _desc used for all references to feature and configuraion des=
criptors,
> >> suffix _csdev used for all references to load feature and configs in t=
he csdev
> >> instances. (Mathieu & Suzuki).
> >> 2) Dropped the 'configurations' sub dir in cs_etm perf directories as =
superfluous
> >> with the configfs containing the same information. (Mathieu).
> >> 3) Simplified perf handling code (suzuki)
> >> 4) Multiple simplifications and improvements for code readability (Mat=
thieu
> >> and Suzuki)
> >>
> >> Changes since v3: (Primarily based on comments from Matthieu)
> >> 1) Locking mechanisms simplified.
> >> 2) Removed the possibility to enable features independently from
> >> configurations.Only configurations can be enabled now. Simplifies prog=
ramming
> >> logic.
> >> 3) Configuration now uses an activate->enable mechanism. This means th=
at perf
> >> will activate a selected configuration at the start of a session (duri=
ng
> >> setup_aux), and disable at the end of a session (around free_aux)
> >> The active configuration and associated features will be programmed in=
to the
> >> CoreSight device instances when they are enabled. This locks the confi=
guration
> >> into the system while in use. Parameters cannot be altered while this =
is
> >> in place. This mechanism will be extended in future for dynamic load /=
 unload
> >> of configurations to prevent removal while in use.
> >> 4) Removed the custom bus / driver as un-necessary. A single device is
> >> registered to own perf fs elements and configfs.
> >> 5) Various other minor issues addressed.
> >>
> >> Changes since v2:
> >> 1) Added documentation file.
> >> 2) Altered cs_syscfg driver to no longer be coresight_device based, an=
d moved
> >> to its own custom bus to remove it from the main coresight bus. (Mathi=
eu)
> >> 3) Added configfs support to inspect and control loaded configurations=
 and
> >> features. Allows listing of preset values (Yabin Cui)
> >> 4) Dropped sysfs support for adjusting feature parameters on the per d=
evice
> >> basis, in favour of a single point adjustment in configfs that is push=
ed to all
> >> device instances.
> >> 5) Altered how the config and preset command line options are handled =
in perf
> >> and the drivers. (Mathieu and Suzuki).
> >> 6) Fixes for various issues and technical points (Mathieu, Yabin)
> >>
> >> Changes since v1:
> >> 1) Moved preloaded configurations and features out of individual drive=
rs.
> >> 2) Added cs_syscfg driver to manage configurations and features. Indiv=
idual
> >> drivers register with cs_syscfg indicating support for config, and pro=
vide
> >> matching information that the system uses to load features into the dr=
ivers.
> >> This allows individual drivers to be updated on an as needed basis - a=
nd
> >> removes the need to consider devices that cannot benefit from configur=
ation -
> >> static replicators, funnels, tpiu.
> >> 3) Added perf selection of configuarations.
> >> 4) Rebased onto the coresight module loading set.
> >>
> >> To follow in future revisions / sets:-
> >> a) load of additional config and features by loadable module.
> >> b) load of additional config and features by configfs
> >> c) enhanced resource management for ETMv4 and checking features have s=
ufficient
> >> resources to be enabled.
> >> d) ECT and CTI support for configuration and features.
> >>
> >> Mike Leach (10):
> >>   coresight: syscfg: Initial coresight system configuration
> >>   coresight: syscfg: Add registration and feature loading for cs devic=
es
> >>   coresight: config: Add configuration and feature generic functions
> >>   coresight: etm-perf: update to handle configuration selection
> >>   coresight: syscfg: Add API to activate and enable configurations
> >>   coresight: etm-perf: Update to activate selected configuration
> >>   coresight: etm4x: Add complex configuration handlers to etmv4
> >>   coresight: config: Add preloaded configurations
> >>   coresight: syscfg: Add initial configfs support
> >>   Documentation: coresight: Add documentation for CoreSight config
> >>
> >>  .../trace/coresight/coresight-config.rst      | 244 ++++++
> >>  Documentation/trace/coresight/coresight.rst   |  16 +
> >>  drivers/hwtracing/coresight/Kconfig           |   1 +
> >>  drivers/hwtracing/coresight/Makefile          |   7 +-
> >>  .../hwtracing/coresight/coresight-cfg-afdo.c  | 153 ++++
> >>  .../coresight/coresight-cfg-preload.c         |  31 +
> >>  .../coresight/coresight-cfg-preload.h         |  13 +
> >>  .../hwtracing/coresight/coresight-config.c    | 275 ++++++
> >>  .../hwtracing/coresight/coresight-config.h    | 253 ++++++
> >>  drivers/hwtracing/coresight/coresight-core.c  |  12 +-
> >>  .../hwtracing/coresight/coresight-etm-perf.c  | 150 +++-
> >>  .../hwtracing/coresight/coresight-etm-perf.h  |  12 +-
> >>  .../hwtracing/coresight/coresight-etm4x-cfg.c | 182 ++++
> >>  .../hwtracing/coresight/coresight-etm4x-cfg.h |  30 +
> >>  .../coresight/coresight-etm4x-core.c          |  38 +-
> >>  .../coresight/coresight-etm4x-sysfs.c         |   3 +
> >>  .../coresight/coresight-syscfg-configfs.c     | 396 +++++++++
> >>  .../coresight/coresight-syscfg-configfs.h     |  45 +
> >>  .../hwtracing/coresight/coresight-syscfg.c    | 829 +++++++++++++++++=
+
> >>  .../hwtracing/coresight/coresight-syscfg.h    |  81 ++
> >>  include/linux/coresight.h                     |  11 +
> >>  21 files changed, 2746 insertions(+), 36 deletions(-)
> >>  create mode 100644 Documentation/trace/coresight/coresight-config.rst
> >>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-afdo.c
> >>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.=
c
> >>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.=
h
> >>  create mode 100644 drivers/hwtracing/coresight/coresight-config.c
> >>  create mode 100644 drivers/hwtracing/coresight/coresight-config.h
> >>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> >>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.h
> >>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-confi=
gfs.c
> >>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-confi=
gfs.h
> >>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.c
> >>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.h
> >>
> >> --
> >> 2.17.1
> >>
> > _______________________________________________
> > CoreSight mailing list
> > CoreSight@lists.linaro.org
> > https://lists.linaro.org/mailman/listinfo/coresight
> >



--=20
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
