Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FB83D194A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhGUUyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGUUyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:54:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D4EC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 14:35:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso1771654wmm.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 14:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mpjoKT9Sz0S0pfBQmSHj3fO1iKImE3q5PZnvwUtpk60=;
        b=tqKlhbtGb9hm5dMrJQCb7MIsXMYncjIns2l9nx4oQaXySAxyQBQf52qtGmuAm0QOWC
         fYLa1wG6EVcpUyxtevybFFuLX8i5fXSU+u+ICCf9Yj8T6s//YWC0zfLBZ3acFuMJrE0G
         EwdIOq65AXmb7c0NEAyUlqq4D6v40YoWzcpW8JKcJzW4Cq4MXtA2mBDLmYc0d8QE4wB2
         tNLE7gq95f5t+HHARNE00ZwqOLeUSQMmd0Fk0JCfrLcju1SwknrooU7sNeKevViLkhy3
         3ZbHtrrxe+n8MuLoqHTOOsTmJgXbqxNkg59RQt9MKfN1I/cCpLvW1VINOWf5x5Z236UN
         IjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mpjoKT9Sz0S0pfBQmSHj3fO1iKImE3q5PZnvwUtpk60=;
        b=Qab+YKZ6tmKvh/6jTjw5cPfQUEsR277PxaMi7tJiM5xdYHETRx+ntd0fa9ZpRq83ME
         C7d2flq8s8tlVK7+cJeT/lPfy/WWUhP4VHlcdDzB7LpDdAktuMm/sSkeHMuIXQodCXhO
         X9SRALi/c3n4Zau9wfXBVuzL9h/RP/mkOAEYtsZ2LSu7I7treKdHI7ZqL/GUIgKjshyY
         ub7R+q3OyFTDniqQyHpQJFFFBZYmyXc8rAhZNiJJaXAQtq2KDL+4diYteRtUztBuKsXp
         kN+OP2ZaEUxriQ9ZLxlItJAiB89O+OgDqRyU73uLjrQqO9CIYKK/Gs7ZJ6S8uDL2z3Ib
         wFEw==
X-Gm-Message-State: AOAM532AL60oUrHPXEjkCk8d5L58Q49ps9un9qpEj2TLrKwSbBUSZFpJ
        XzvKH3JlyA0pJ454wM5MbrAF/dGAFNU3ck8ChdhBkw==
X-Google-Smtp-Source: ABdhPJylg+kaKhwzDjm6T10dMS2vrUTNXbyaV9PoDuqdmcVulI+8ZTQyZrOQCPrPUp1Ru10wKT4CCdnmeEAJ3srtbWA=
X-Received: by 2002:a05:600c:21d7:: with SMTP id x23mr39135695wmj.98.1626903310702;
 Wed, 21 Jul 2021 14:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210707133003.5414-1-mike.leach@linaro.org> <20210712164413.GA1777012@p14s>
 <a80b9a03-01ba-3752-9e6e-ee2d194ba2a1@arm.com> <CAJ9a7ViieBazkBckF+2Bb0eeQyp14EpUAJ0j_GmU_Kibj9OBMg@mail.gmail.com>
 <20210721174417.GB2377909@p14s>
In-Reply-To: <20210721174417.GB2377909@p14s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 21 Jul 2021 22:35:00 +0100
Message-ID: <CAJ9a7Vi9v=tk8YRj13k6pSxuMs1cKk2JgwtffE1ubqTjexLkhg@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] CoreSight configuration management; ETM strobing
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Branislav Rankov <branislav.rankov@arm.com>,
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

On Wed, 21 Jul 2021 at 18:44, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Fri, Jul 16, 2021 at 11:25:47AM +0100, Mike Leach wrote:
> > HI Mathieu,
> >
> > Below my change notes for the patches changed between v7 and v8 in this=
 set.
> >
> > Regards
> >
> > Mike
> >
> > 0001, 0003, 0004, 0006, 0007, 0008, 0010 - no change
> >
> > 0002 -
> > coresight-syscfg.c
> >     top of file - mutex declaration removed.
> >     cscfg_add_csdev_cfg()
> >         Spinlock replaces mutex
> >     cscfg_load_feat_csdev()
> >         Spinlock replaces mutex
> >     cscsg_list_add_csdev()
> >         Init spinlock
> > coresight.h
> >     struct coresight_device {}
> >         Add spinlock cscfg_csdev_lock alongside the csdev feature and
> > config lists that it protects.
> >
> > 0005 -
> > coresight-syscfg.c
> >     cscfg_csdev_reset_feats()
> >             Spinlock replaces mutex.
> >
> >     cscfg_csdev_enable_active_config()
> >             Spinlock replaces mutex. In enable flag to avoid race with =
disable.
> >     cscfg_csdev_disable_active_config()
> >             Spinlock replaces mutex. In enable flag to avoid race with =
enable.
> >
>
> I'm good with the changes made to the above two patches.
>
> >
> > coresight.h
> >     struct coresight_device {}
> >         In enable flag introduced to control possible race between
> > enable and disable. E.g. if we are enabling a config, but a power
> > event tries to shut down the CPU/ETM causing a disable call. We don=E2=
=80=99t
> > want to hold the cscfg_csdev_lock spinlock throughout the entire
> > enable process - especially as the programming call will claim the
> > internal driver spinlock when writing internal driver data, but we
> > need to ensure that if there is a condition that permits a disable
> > call out of normal sequence then we are able to see it and handle it.
> >
>
> Here I'm assuming the enable and disable calls you are referring to are
> cscfg_csdev_enable_active_config() and cscfg_csdev_disable_active_config(=
).
>

Yes.

> From the above paragraph I understand that a call to cscfg_csdev_enable_c=
onfig()
> can be interrupted at any time when the CPU is shutting down, which can o=
nly
> happen when operating from sysfs.
>

I was concerned about possible power management issues too - though
thinking about it we shouldn't be powering down a PE if we are about
to start tracing on it!

Truth is, I split the spinlock claims in
cscfg_csdev_enable_active_config() to follow the general kernel
guidance to hold them for the minimum amount of time needed, and then
could not convince myself that it was impossible for
cscfg_csdev_disable_active_config() to be called part way through.

> With the above in mind and looking at the implementation in patch 05, if =
the
> code gets interrupted right after cscfg_csdev_enable_config(), function
> cscfg_csdev_disable_config() in cscfg_csdev_disable_active_config() won't=
 be
> called.
>
> In function cscfg_csdev_enable_active_config(), could it be possible to s=
et
> csdev->active_cscfg_ctxt instead of csdev->cscfg_in_enable?  If
> cscfg_csdev_enable_config() gets interrupted then function
> cscfg_csdev_disable_config() can be called.  At that point disabling a fe=
ature
> that hasn't been enabled shouldn't do anything.
>

The concern is that the disable functionality is responsible for
copying back values that might have changed during the operation of
the config - e.g. counters in strobing are restarted at the value they
last had if the routine is restarted on the same ETM at a later time
in the perf session. So if the enable never occurred / errored - we
want to avoid copying what would be an unknown value back. So the
safest way is to only copy back if we succeeded in setting in the
first place - even ETM was never actually started.

Currently we only set csdev->active_cscfg_ctxt after the call to do
the actual register programming (call to cscfg_csdev_enable_config())
has succeeded, which was fine using the mutex, but gives us the
problem with the split spinlocks.
So csdev->cscfg_in_enable prevents disable path from copying back an
potentially invalid value.

Regards

Mike


> Thanks,
> Mathieu
>
> > 0009 -
> >     KConfig
> >     add in dependency on CONFIGFS_FS to eliminate problem highlighted
> > by the kernel bot tests. This had configured coresight as Y, but
> > configfs as M - meaning link issues for configfs code introduced in
> > this set.
> >
> > On Tue, 13 Jul 2021 at 10:43, Branislav Rankov <branislav.rankov@arm.co=
m> wrote:
> > >
> > > Hi Mathieu,
> > >
> > > On 7/12/21 5:44 PM, Mathieu Poirier wrote:
> > > > Good morning Mike,
> > > >
> > > > On Wed, Jul 07, 2021 at 02:29:53PM +0100, Mike Leach wrote:
> > > >> This patchset introduces initial concepts in CoreSight system
> > > >> configuration management support. to allow more detailed and compl=
ex
> > > >> programming to be applied to CoreSight systems during trace captur=
e.
> > > >>
> > > >> Configurations consist of 2 elements:-
> > > >> 1) Features - programming combinations for devices, applied to a c=
lass of
> > > >> device on the system (all ETMv4), or individual devices.
> > > >> 2) Configurations - a set of programmed features used when the nam=
ed
> > > >> configuration is selected.
> > > >>
> > > >> Features and configurations are declared as a data table, a set of=
 register,
> > > >> resource and parameter requirements. Features and configurations a=
re loaded
> > > >> into the system by the virtual cs_syscfg device. This then matches=
 features
> > > >> to any registered devices and loads the feature into them.
> > > >>
> > > >> Individual device classes that support feature and configuration r=
egister
> > > >> with cs_syscfg.
> > > >>
> > > >> Once loaded a configuration can be enabled for a specific trace ru=
n.
> > > >> Configurations are registered with the perf cs_etm event as entrie=
s in
> > > >> cs_etm/events. These can be selected on the perf command line as f=
ollows:-
> > > >>
> > > >> perf record -e cs_etm/<config_name>/ ...
> > > >>
> > > >> This patch set has one pre-loaded configuration and feature.
> > > >> A named "strobing" feature is provided for ETMv4.
> > > >> A named "autofdo" configuration is provided. This configuration en=
ables
> > > >> strobing on any ETM in used.
> > > >>
> > > >> Thus the command:
> > > >> perf record -e cs_etm/autofdo/ ...
> > > >>
> > > >> will trace the supplied application while enabling the "autofdo" c=
onfiguation
> > > >> on each ETM as it is enabled by perf. This in turn will enable str=
obing for
> > > >> the ETM - with default parameters. Parameters can be adjusted usin=
g configfs.
> > > >>
> > > >> The sink used in the trace run will be automatically selected.
> > > >>
> > > >> A configuration can supply up to 15 of preset parameter values, wh=
ich will
> > > >> subsitute in parameter values for any feature used in the configur=
ation.
> > > >>
> > > >> Selection of preset values as follows
> > > >> perf record -e cs_etm/autofdo,preset=3D1/ ...
> > > >>
> > > >> (valid presets 1-N, where N is the number supplied in the configur=
ation, not
> > > >> exceeding 15. preset=3D0 is the same as not selecting a preset.)
> > > >>
> > > >> Applies to & tested against coresight/next (5.13-rc6 base)
> > > >>
> > > >> Changes since v7:
> > > >>
> > > >> Fixed kernel test robot issue - config with CORESIGHT=3Dy & CONFIG=
FS_FS=3Dm causes
> > > >> build error. Altered CORESIGHT config to select CONFIGFS_FS.
> > > >> Reported-by: kernel test robot <lkp@intel.com>
> > > >>
> > > >> Replaced mutex use to protect loaded config lists in coresight dev=
ices with per
> > > >> device spinlock to remove issue when disable called in interrupt c=
ontext.
> > > >> Reported-by: Branislav Rankov <branislav.rankov@arm.com>
> > > >>
> > > >
> > > > Can you indicate which patches have changed so I don't have to revi=
ew the whole
> > > > thing again?   It is also common practice to remove the RB tag when=
 patches
> > > > have changed enough to mandate another review.  In this case all pa=
tches still
> > > > bare my RB tags.
> > > >
> > > > Branislav reported the problem but he is not a recipient.  I would =
like to have
> > > > a confirmation from him that this set fixes the problem he observed=
 before I
> > > > start looking at it.
> > >
> > > I have tested this series and the issue I reported is fixed.
> > > >
> > > > Thanks,
> > > > Mathieu
> > > >
> > > >>
> > > >> Changes since v6:
> > > >> Fixed kernel test robot issues-
> > > >> Reported-by: kernel test robot <lkp@intel.com>
> > > >>
> > > >> Changes since v5:
> > > >>
> > > >> 1) Fix code style issues from auto-build reports, as
> > > >> Reported-by: kernel test robot <lkp@intel.com>
> > > >> 2) Update comments to get consistent docs for API functions.
> > > >> 3) remove unused #define from autofdo example.
> > > >> 4) fix perf code style issues from patch 4 (Mathieu)
> > > >> 5) fix configfs code style issues from patch 9. (Mathieu)
> > > >>
> > > >> Changes since v4: (based on comments from Matthieu and Suzuki).
> > > >> No large functional changes - primarily code improvements and nami=
ng schema.
> > > >> 1) Updated entire set to ensure a consistent naming scheme was use=
d for
> > > >> variables and struct members that refer to the key objects in the =
system.
> > > >> Suffixes _desc used for all references to feature and configuraion=
 descriptors,
> > > >> suffix _csdev used for all references to load feature and configs =
in the csdev
> > > >> instances. (Mathieu & Suzuki).
> > > >> 2) Dropped the 'configurations' sub dir in cs_etm perf directories=
 as superfluous
> > > >> with the configfs containing the same information. (Mathieu).
> > > >> 3) Simplified perf handling code (suzuki)
> > > >> 4) Multiple simplifications and improvements for code readability =
(Matthieu
> > > >> and Suzuki)
> > > >>
> > > >> Changes since v3: (Primarily based on comments from Matthieu)
> > > >> 1) Locking mechanisms simplified.
> > > >> 2) Removed the possibility to enable features independently from
> > > >> configurations.Only configurations can be enabled now. Simplifies =
programming
> > > >> logic.
> > > >> 3) Configuration now uses an activate->enable mechanism. This mean=
s that perf
> > > >> will activate a selected configuration at the start of a session (=
during
> > > >> setup_aux), and disable at the end of a session (around free_aux)
> > > >> The active configuration and associated features will be programme=
d into the
> > > >> CoreSight device instances when they are enabled. This locks the c=
onfiguration
> > > >> into the system while in use. Parameters cannot be altered while t=
his is
> > > >> in place. This mechanism will be extended in future for dynamic lo=
ad / unload
> > > >> of configurations to prevent removal while in use.
> > > >> 4) Removed the custom bus / driver as un-necessary. A single devic=
e is
> > > >> registered to own perf fs elements and configfs.
> > > >> 5) Various other minor issues addressed.
> > > >>
> > > >> Changes since v2:
> > > >> 1) Added documentation file.
> > > >> 2) Altered cs_syscfg driver to no longer be coresight_device based=
, and moved
> > > >> to its own custom bus to remove it from the main coresight bus. (M=
athieu)
> > > >> 3) Added configfs support to inspect and control loaded configurat=
ions and
> > > >> features. Allows listing of preset values (Yabin Cui)
> > > >> 4) Dropped sysfs support for adjusting feature parameters on the p=
er device
> > > >> basis, in favour of a single point adjustment in configfs that is =
pushed to all
> > > >> device instances.
> > > >> 5) Altered how the config and preset command line options are hand=
led in perf
> > > >> and the drivers. (Mathieu and Suzuki).
> > > >> 6) Fixes for various issues and technical points (Mathieu, Yabin)
> > > >>
> > > >> Changes since v1:
> > > >> 1) Moved preloaded configurations and features out of individual d=
rivers.
> > > >> 2) Added cs_syscfg driver to manage configurations and features. I=
ndividual
> > > >> drivers register with cs_syscfg indicating support for config, and=
 provide
> > > >> matching information that the system uses to load features into th=
e drivers.
> > > >> This allows individual drivers to be updated on an as needed basis=
 - and
> > > >> removes the need to consider devices that cannot benefit from conf=
iguration -
> > > >> static replicators, funnels, tpiu.
> > > >> 3) Added perf selection of configuarations.
> > > >> 4) Rebased onto the coresight module loading set.
> > > >>
> > > >> To follow in future revisions / sets:-
> > > >> a) load of additional config and features by loadable module.
> > > >> b) load of additional config and features by configfs
> > > >> c) enhanced resource management for ETMv4 and checking features ha=
ve sufficient
> > > >> resources to be enabled.
> > > >> d) ECT and CTI support for configuration and features.
> > > >>
> > > >> Mike Leach (10):
> > > >>   coresight: syscfg: Initial coresight system configuration
> > > >>   coresight: syscfg: Add registration and feature loading for cs d=
evices
> > > >>   coresight: config: Add configuration and feature generic functio=
ns
> > > >>   coresight: etm-perf: update to handle configuration selection
> > > >>   coresight: syscfg: Add API to activate and enable configurations
> > > >>   coresight: etm-perf: Update to activate selected configuration
> > > >>   coresight: etm4x: Add complex configuration handlers to etmv4
> > > >>   coresight: config: Add preloaded configurations
> > > >>   coresight: syscfg: Add initial configfs support
> > > >>   Documentation: coresight: Add documentation for CoreSight config
> > > >>
> > > >>  .../trace/coresight/coresight-config.rst      | 244 ++++++
> > > >>  Documentation/trace/coresight/coresight.rst   |  16 +
> > > >>  drivers/hwtracing/coresight/Kconfig           |   1 +
> > > >>  drivers/hwtracing/coresight/Makefile          |   7 +-
> > > >>  .../hwtracing/coresight/coresight-cfg-afdo.c  | 153 ++++
> > > >>  .../coresight/coresight-cfg-preload.c         |  31 +
> > > >>  .../coresight/coresight-cfg-preload.h         |  13 +
> > > >>  .../hwtracing/coresight/coresight-config.c    | 275 ++++++
> > > >>  .../hwtracing/coresight/coresight-config.h    | 253 ++++++
> > > >>  drivers/hwtracing/coresight/coresight-core.c  |  12 +-
> > > >>  .../hwtracing/coresight/coresight-etm-perf.c  | 150 +++-
> > > >>  .../hwtracing/coresight/coresight-etm-perf.h  |  12 +-
> > > >>  .../hwtracing/coresight/coresight-etm4x-cfg.c | 182 ++++
> > > >>  .../hwtracing/coresight/coresight-etm4x-cfg.h |  30 +
> > > >>  .../coresight/coresight-etm4x-core.c          |  38 +-
> > > >>  .../coresight/coresight-etm4x-sysfs.c         |   3 +
> > > >>  .../coresight/coresight-syscfg-configfs.c     | 396 +++++++++
> > > >>  .../coresight/coresight-syscfg-configfs.h     |  45 +
> > > >>  .../hwtracing/coresight/coresight-syscfg.c    | 829 +++++++++++++=
+++++
> > > >>  .../hwtracing/coresight/coresight-syscfg.h    |  81 ++
> > > >>  include/linux/coresight.h                     |  11 +
> > > >>  21 files changed, 2746 insertions(+), 36 deletions(-)
> > > >>  create mode 100644 Documentation/trace/coresight/coresight-config=
.rst
> > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-afdo=
.c
> > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-prel=
oad.c
> > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-prel=
oad.h
> > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-config.c
> > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-config.h
> > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cf=
g.c
> > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cf=
g.h
> > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-c=
onfigfs.c
> > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-c=
onfigfs.h
> > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.c
> > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.h
> > > >>
> > > >> --
> > > >> 2.17.1
> > > >>
> > > > _______________________________________________
> > > > CoreSight mailing list
> > > > CoreSight@lists.linaro.org
> > > > https://lists.linaro.org/mailman/listinfo/coresight
> > > >
> >
> >
> >
> > --
> > Mike Leach
> > Principal Engineer, ARM Ltd.
> > Manchester Design Centre. UK



--=20
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
