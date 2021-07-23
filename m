Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D14F3D3BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 16:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbhGWODd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 10:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbhGWODc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:03:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15B5C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 07:44:04 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l11-20020a7bc34b0000b029021f84fcaf75so3672956wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RhH+fSoJ7y6HJzcHf0g5keWYOYJcH/wQAxxkWujR00g=;
        b=ETGJCZ9ZW2tzMtSVIO/sgzSnIuwqfIx7AAPKb0Un0TsokdQuQs5AhguGhjn8uaeA3I
         1xL6jadRxA09RyBLFlrdkPBjL4EGSxvi2/XC068c52TeL3Y7iVmRaP8IBF5VzNF9P6qQ
         2MRckfWdwKJ1vFyNoNTrvpgl/XDXUP7n7CDoIg3hS3NZWCyF4dnUz7j032EE9CH11G+Y
         jG2NB+7JcjpQxbQ4r/WDFG590ul6Cvxs4lg8u2Z45J9LXlN81nfFKxugc0/+oK2Kl0qH
         1fXj6Mk5HTElhyxHOAn5MTZmQS2YRz0+8Ljz7Ni0JQCnfe3Q/DcsqqFkG+t37j7F8vUA
         1BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RhH+fSoJ7y6HJzcHf0g5keWYOYJcH/wQAxxkWujR00g=;
        b=S+fsjUkGsm/fJieXuVcr1ZAkaUnSc2gh8bRQfqdCNvSV1pQ+OR+SnFy4Au9tLUsElf
         axw+Kw51wl2iL9/VpQTc6gJKuP/TGVqe+/JTBvKUZKwaksFV9ahb3oqpyf8H6kwiFzrf
         VmNxTH5ye4HeRShJMQepvBjQHgk+ZIVqWblvCK/0qkxgOnCpl5V4T8H472qWoA/bGa1a
         KPv4OvO7qaVIvoOfauC2rv1Vw0K5suH/5fHTTvilll+sVZ6OOBkAnPoppmmuB+1njmQ5
         nzmuE+Z2Zq781STcC8l274yW+T/B7rn5mIGOltv7wvcimkVYSDgOi1z9oBLDbTGD8gYJ
         iFHg==
X-Gm-Message-State: AOAM5318uxiAfbstxbgCI10jcBnV2i6vjakqK4zSO1+sOtqJCO2gbnw9
        69yfx1ERG5w4GwHdCHyYYyGQWqszab0LvBeuBeNr2Q==
X-Google-Smtp-Source: ABdhPJyDgh0EejDkv/VHoEXCIGbXeI1IwFGu6LTnc+YWJtz4wJDrFSVEPIteDaKfYnV+G/pBtne9PPUSC8nkxNUKHA4=
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr14793736wmi.131.1627051443024;
 Fri, 23 Jul 2021 07:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210707133003.5414-1-mike.leach@linaro.org> <20210712164413.GA1777012@p14s>
 <a80b9a03-01ba-3752-9e6e-ee2d194ba2a1@arm.com> <CAJ9a7ViieBazkBckF+2Bb0eeQyp14EpUAJ0j_GmU_Kibj9OBMg@mail.gmail.com>
 <20210721174417.GB2377909@p14s> <CAJ9a7Vi9v=tk8YRj13k6pSxuMs1cKk2JgwtffE1ubqTjexLkhg@mail.gmail.com>
 <20210722161736.GA2443981@p14s>
In-Reply-To: <20210722161736.GA2443981@p14s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 23 Jul 2021 15:43:52 +0100
Message-ID: <CAJ9a7VgN5T73bNyaQs9_g+GyCxQdpB=4r0WKmqEXs8eEFP310g@mail.gmail.com>
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

On Thu, 22 Jul 2021 at 17:17, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Wed, Jul 21, 2021 at 10:35:00PM +0100, Mike Leach wrote:
> > HI Mathieu,
> >
> > On Wed, 21 Jul 2021 at 18:44, Mathieu Poirier
> > <mathieu.poirier@linaro.org> wrote:
> > >
> > > On Fri, Jul 16, 2021 at 11:25:47AM +0100, Mike Leach wrote:
> > > > HI Mathieu,
> > > >
> > > > Below my change notes for the patches changed between v7 and v8 in =
this set.
> > > >
> > > > Regards
> > > >
> > > > Mike
> > > >
> > > > 0001, 0003, 0004, 0006, 0007, 0008, 0010 - no change
> > > >
> > > > 0002 -
> > > > coresight-syscfg.c
> > > >     top of file - mutex declaration removed.
> > > >     cscfg_add_csdev_cfg()
> > > >         Spinlock replaces mutex
> > > >     cscfg_load_feat_csdev()
> > > >         Spinlock replaces mutex
> > > >     cscsg_list_add_csdev()
> > > >         Init spinlock
> > > > coresight.h
> > > >     struct coresight_device {}
> > > >         Add spinlock cscfg_csdev_lock alongside the csdev feature a=
nd
> > > > config lists that it protects.
> > > >
> > > > 0005 -
> > > > coresight-syscfg.c
> > > >     cscfg_csdev_reset_feats()
> > > >             Spinlock replaces mutex.
> > > >
> > > >     cscfg_csdev_enable_active_config()
> > > >             Spinlock replaces mutex. In enable flag to avoid race w=
ith disable.
> > > >     cscfg_csdev_disable_active_config()
> > > >             Spinlock replaces mutex. In enable flag to avoid race w=
ith enable.
> > > >
> > >
> > > I'm good with the changes made to the above two patches.
> > >
> > > >
> > > > coresight.h
> > > >     struct coresight_device {}
> > > >         In enable flag introduced to control possible race between
> > > > enable and disable. E.g. if we are enabling a config, but a power
> > > > event tries to shut down the CPU/ETM causing a disable call. We don=
=E2=80=99t
> > > > want to hold the cscfg_csdev_lock spinlock throughout the entire
> > > > enable process - especially as the programming call will claim the
> > > > internal driver spinlock when writing internal driver data, but we
> > > > need to ensure that if there is a condition that permits a disable
> > > > call out of normal sequence then we are able to see it and handle i=
t.
> > > >
> > >
> > > Here I'm assuming the enable and disable calls you are referring to a=
re
> > > cscfg_csdev_enable_active_config() and cscfg_csdev_disable_active_con=
fig().
> > >
> >
> > Yes.
> >
> > > From the above paragraph I understand that a call to cscfg_csdev_enab=
le_config()
> > > can be interrupted at any time when the CPU is shutting down, which c=
an only
> > > happen when operating from sysfs.
> > >
> >
> > I was concerned about possible power management issues too - though
> > thinking about it we shouldn't be powering down a PE if we are about
> > to start tracing on it!
>
> You are correct if we are operating from the perf interface.  In sysfs yo=
u get
> no guarantees, anything can happen.
>
> >
> > Truth is, I split the spinlock claims in
> > cscfg_csdev_enable_active_config() to follow the general kernel
> > guidance to hold them for the minimum amount of time needed, and then
> > could not convince myself that it was impossible for
> > cscfg_csdev_disable_active_config() to be called part way through.
> >
> > > With the above in mind and looking at the implementation in patch 05,=
 if the
> > > code gets interrupted right after cscfg_csdev_enable_config(), functi=
on
> > > cscfg_csdev_disable_config() in cscfg_csdev_disable_active_config() w=
on't be
> > > called.
> > >
> > > In function cscfg_csdev_enable_active_config(), could it be possible =
to set
> > > csdev->active_cscfg_ctxt instead of csdev->cscfg_in_enable?  If
> > > cscfg_csdev_enable_config() gets interrupted then function
> > > cscfg_csdev_disable_config() can be called.  At that point disabling =
a feature
> > > that hasn't been enabled shouldn't do anything.
> > >
> >
> > The concern is that the disable functionality is responsible for
> > copying back values that might have changed during the operation of
> > the config - e.g. counters in strobing are restarted at the value they
> > last had if the routine is restarted on the same ETM at a later time
> > in the perf session. So if the enable never occurred / errored - we
> > want to avoid copying what would be an unknown value back. So the
> > safest way is to only copy back if we succeeded in setting in the
> > first place - even ETM was never actually started.
> >
> > Currently we only set csdev->active_cscfg_ctxt after the call to do
> > the actual register programming (call to cscfg_csdev_enable_config())
> > has succeeded, which was fine using the mutex, but gives us the
> > problem with the split spinlocks.
> > So csdev->cscfg_in_enable prevents disable path from copying back an
> > potentially invalid value.
>
> I see the problem about potentially copying back invalid alues.  I sugges=
t to:
>
> 1) use spin_lock_irqsave() in cscfg_set_on_enable() and cscfg_save_on_dis=
able(),
> that way the critical section in there is never preempted.
>

Agreed.


> 2) introduce cscfg_feature_csdev::enabled to keep track of which feature =
has
> been enabled, and set that flag when the lock is held in cscfg_set_on_ena=
ble().
>

This does no solve the key issue which is that the configuration -
which can consist of multiple features - must be all programmed to be
correctly enabled. Having per feature enables complicates matters more
than is needed.
There is currently an enable flag on cscfg_config_csdev - which can be
brought into the scope of the cscfg_csdev_enable_active_config() /
cscfg_csdev_disable_active_config() spinlocks
to do what is needed.

I've dropped the In_enable flag, and use cscfg_config_csdev::enabled &
csdev->active_cscfg_ctxt to ensure the ordering is handled correctly.

Regards

Mike

> Hopefully that will work.  A generous helping of comments will also go a =
long
> way.
>
> >
> > Regards
> >
> > Mike
> >
> >
> > > Thanks,
> > > Mathieu
> > >
> > > > 0009 -
> > > >     KConfig
> > > >     add in dependency on CONFIGFS_FS to eliminate problem highlight=
ed
> > > > by the kernel bot tests. This had configured coresight as Y, but
> > > > configfs as M - meaning link issues for configfs code introduced in
> > > > this set.
> > > >
> > > > On Tue, 13 Jul 2021 at 10:43, Branislav Rankov <branislav.rankov@ar=
m.com> wrote:
> > > > >
> > > > > Hi Mathieu,
> > > > >
> > > > > On 7/12/21 5:44 PM, Mathieu Poirier wrote:
> > > > > > Good morning Mike,
> > > > > >
> > > > > > On Wed, Jul 07, 2021 at 02:29:53PM +0100, Mike Leach wrote:
> > > > > >> This patchset introduces initial concepts in CoreSight system
> > > > > >> configuration management support. to allow more detailed and c=
omplex
> > > > > >> programming to be applied to CoreSight systems during trace ca=
pture.
> > > > > >>
> > > > > >> Configurations consist of 2 elements:-
> > > > > >> 1) Features - programming combinations for devices, applied to=
 a class of
> > > > > >> device on the system (all ETMv4), or individual devices.
> > > > > >> 2) Configurations - a set of programmed features used when the=
 named
> > > > > >> configuration is selected.
> > > > > >>
> > > > > >> Features and configurations are declared as a data table, a se=
t of register,
> > > > > >> resource and parameter requirements. Features and configuratio=
ns are loaded
> > > > > >> into the system by the virtual cs_syscfg device. This then mat=
ches features
> > > > > >> to any registered devices and loads the feature into them.
> > > > > >>
> > > > > >> Individual device classes that support feature and configurati=
on register
> > > > > >> with cs_syscfg.
> > > > > >>
> > > > > >> Once loaded a configuration can be enabled for a specific trac=
e run.
> > > > > >> Configurations are registered with the perf cs_etm event as en=
tries in
> > > > > >> cs_etm/events. These can be selected on the perf command line =
as follows:-
> > > > > >>
> > > > > >> perf record -e cs_etm/<config_name>/ ...
> > > > > >>
> > > > > >> This patch set has one pre-loaded configuration and feature.
> > > > > >> A named "strobing" feature is provided for ETMv4.
> > > > > >> A named "autofdo" configuration is provided. This configuratio=
n enables
> > > > > >> strobing on any ETM in used.
> > > > > >>
> > > > > >> Thus the command:
> > > > > >> perf record -e cs_etm/autofdo/ ...
> > > > > >>
> > > > > >> will trace the supplied application while enabling the "autofd=
o" configuation
> > > > > >> on each ETM as it is enabled by perf. This in turn will enable=
 strobing for
> > > > > >> the ETM - with default parameters. Parameters can be adjusted =
using configfs.
> > > > > >>
> > > > > >> The sink used in the trace run will be automatically selected.
> > > > > >>
> > > > > >> A configuration can supply up to 15 of preset parameter values=
, which will
> > > > > >> subsitute in parameter values for any feature used in the conf=
iguration.
> > > > > >>
> > > > > >> Selection of preset values as follows
> > > > > >> perf record -e cs_etm/autofdo,preset=3D1/ ...
> > > > > >>
> > > > > >> (valid presets 1-N, where N is the number supplied in the conf=
iguration, not
> > > > > >> exceeding 15. preset=3D0 is the same as not selecting a preset=
.)
> > > > > >>
> > > > > >> Applies to & tested against coresight/next (5.13-rc6 base)
> > > > > >>
> > > > > >> Changes since v7:
> > > > > >>
> > > > > >> Fixed kernel test robot issue - config with CORESIGHT=3Dy & CO=
NFIGFS_FS=3Dm causes
> > > > > >> build error. Altered CORESIGHT config to select CONFIGFS_FS.
> > > > > >> Reported-by: kernel test robot <lkp@intel.com>
> > > > > >>
> > > > > >> Replaced mutex use to protect loaded config lists in coresight=
 devices with per
> > > > > >> device spinlock to remove issue when disable called in interru=
pt context.
> > > > > >> Reported-by: Branislav Rankov <branislav.rankov@arm.com>
> > > > > >>
> > > > > >
> > > > > > Can you indicate which patches have changed so I don't have to =
review the whole
> > > > > > thing again?   It is also common practice to remove the RB tag =
when patches
> > > > > > have changed enough to mandate another review.  In this case al=
l patches still
> > > > > > bare my RB tags.
> > > > > >
> > > > > > Branislav reported the problem but he is not a recipient.  I wo=
uld like to have
> > > > > > a confirmation from him that this set fixes the problem he obse=
rved before I
> > > > > > start looking at it.
> > > > >
> > > > > I have tested this series and the issue I reported is fixed.
> > > > > >
> > > > > > Thanks,
> > > > > > Mathieu
> > > > > >
> > > > > >>
> > > > > >> Changes since v6:
> > > > > >> Fixed kernel test robot issues-
> > > > > >> Reported-by: kernel test robot <lkp@intel.com>
> > > > > >>
> > > > > >> Changes since v5:
> > > > > >>
> > > > > >> 1) Fix code style issues from auto-build reports, as
> > > > > >> Reported-by: kernel test robot <lkp@intel.com>
> > > > > >> 2) Update comments to get consistent docs for API functions.
> > > > > >> 3) remove unused #define from autofdo example.
> > > > > >> 4) fix perf code style issues from patch 4 (Mathieu)
> > > > > >> 5) fix configfs code style issues from patch 9. (Mathieu)
> > > > > >>
> > > > > >> Changes since v4: (based on comments from Matthieu and Suzuki)=
.
> > > > > >> No large functional changes - primarily code improvements and =
naming schema.
> > > > > >> 1) Updated entire set to ensure a consistent naming scheme was=
 used for
> > > > > >> variables and struct members that refer to the key objects in =
the system.
> > > > > >> Suffixes _desc used for all references to feature and configur=
aion descriptors,
> > > > > >> suffix _csdev used for all references to load feature and conf=
igs in the csdev
> > > > > >> instances. (Mathieu & Suzuki).
> > > > > >> 2) Dropped the 'configurations' sub dir in cs_etm perf directo=
ries as superfluous
> > > > > >> with the configfs containing the same information. (Mathieu).
> > > > > >> 3) Simplified perf handling code (suzuki)
> > > > > >> 4) Multiple simplifications and improvements for code readabil=
ity (Matthieu
> > > > > >> and Suzuki)
> > > > > >>
> > > > > >> Changes since v3: (Primarily based on comments from Matthieu)
> > > > > >> 1) Locking mechanisms simplified.
> > > > > >> 2) Removed the possibility to enable features independently fr=
om
> > > > > >> configurations.Only configurations can be enabled now. Simplif=
ies programming
> > > > > >> logic.
> > > > > >> 3) Configuration now uses an activate->enable mechanism. This =
means that perf
> > > > > >> will activate a selected configuration at the start of a sessi=
on (during
> > > > > >> setup_aux), and disable at the end of a session (around free_a=
ux)
> > > > > >> The active configuration and associated features will be progr=
ammed into the
> > > > > >> CoreSight device instances when they are enabled. This locks t=
he configuration
> > > > > >> into the system while in use. Parameters cannot be altered whi=
le this is
> > > > > >> in place. This mechanism will be extended in future for dynami=
c load / unload
> > > > > >> of configurations to prevent removal while in use.
> > > > > >> 4) Removed the custom bus / driver as un-necessary. A single d=
evice is
> > > > > >> registered to own perf fs elements and configfs.
> > > > > >> 5) Various other minor issues addressed.
> > > > > >>
> > > > > >> Changes since v2:
> > > > > >> 1) Added documentation file.
> > > > > >> 2) Altered cs_syscfg driver to no longer be coresight_device b=
ased, and moved
> > > > > >> to its own custom bus to remove it from the main coresight bus=
. (Mathieu)
> > > > > >> 3) Added configfs support to inspect and control loaded config=
urations and
> > > > > >> features. Allows listing of preset values (Yabin Cui)
> > > > > >> 4) Dropped sysfs support for adjusting feature parameters on t=
he per device
> > > > > >> basis, in favour of a single point adjustment in configfs that=
 is pushed to all
> > > > > >> device instances.
> > > > > >> 5) Altered how the config and preset command line options are =
handled in perf
> > > > > >> and the drivers. (Mathieu and Suzuki).
> > > > > >> 6) Fixes for various issues and technical points (Mathieu, Yab=
in)
> > > > > >>
> > > > > >> Changes since v1:
> > > > > >> 1) Moved preloaded configurations and features out of individu=
al drivers.
> > > > > >> 2) Added cs_syscfg driver to manage configurations and feature=
s. Individual
> > > > > >> drivers register with cs_syscfg indicating support for config,=
 and provide
> > > > > >> matching information that the system uses to load features int=
o the drivers.
> > > > > >> This allows individual drivers to be updated on an as needed b=
asis - and
> > > > > >> removes the need to consider devices that cannot benefit from =
configuration -
> > > > > >> static replicators, funnels, tpiu.
> > > > > >> 3) Added perf selection of configuarations.
> > > > > >> 4) Rebased onto the coresight module loading set.
> > > > > >>
> > > > > >> To follow in future revisions / sets:-
> > > > > >> a) load of additional config and features by loadable module.
> > > > > >> b) load of additional config and features by configfs
> > > > > >> c) enhanced resource management for ETMv4 and checking feature=
s have sufficient
> > > > > >> resources to be enabled.
> > > > > >> d) ECT and CTI support for configuration and features.
> > > > > >>
> > > > > >> Mike Leach (10):
> > > > > >>   coresight: syscfg: Initial coresight system configuration
> > > > > >>   coresight: syscfg: Add registration and feature loading for =
cs devices
> > > > > >>   coresight: config: Add configuration and feature generic fun=
ctions
> > > > > >>   coresight: etm-perf: update to handle configuration selectio=
n
> > > > > >>   coresight: syscfg: Add API to activate and enable configurat=
ions
> > > > > >>   coresight: etm-perf: Update to activate selected configurati=
on
> > > > > >>   coresight: etm4x: Add complex configuration handlers to etmv=
4
> > > > > >>   coresight: config: Add preloaded configurations
> > > > > >>   coresight: syscfg: Add initial configfs support
> > > > > >>   Documentation: coresight: Add documentation for CoreSight co=
nfig
> > > > > >>
> > > > > >>  .../trace/coresight/coresight-config.rst      | 244 ++++++
> > > > > >>  Documentation/trace/coresight/coresight.rst   |  16 +
> > > > > >>  drivers/hwtracing/coresight/Kconfig           |   1 +
> > > > > >>  drivers/hwtracing/coresight/Makefile          |   7 +-
> > > > > >>  .../hwtracing/coresight/coresight-cfg-afdo.c  | 153 ++++
> > > > > >>  .../coresight/coresight-cfg-preload.c         |  31 +
> > > > > >>  .../coresight/coresight-cfg-preload.h         |  13 +
> > > > > >>  .../hwtracing/coresight/coresight-config.c    | 275 ++++++
> > > > > >>  .../hwtracing/coresight/coresight-config.h    | 253 ++++++
> > > > > >>  drivers/hwtracing/coresight/coresight-core.c  |  12 +-
> > > > > >>  .../hwtracing/coresight/coresight-etm-perf.c  | 150 +++-
> > > > > >>  .../hwtracing/coresight/coresight-etm-perf.h  |  12 +-
> > > > > >>  .../hwtracing/coresight/coresight-etm4x-cfg.c | 182 ++++
> > > > > >>  .../hwtracing/coresight/coresight-etm4x-cfg.h |  30 +
> > > > > >>  .../coresight/coresight-etm4x-core.c          |  38 +-
> > > > > >>  .../coresight/coresight-etm4x-sysfs.c         |   3 +
> > > > > >>  .../coresight/coresight-syscfg-configfs.c     | 396 +++++++++
> > > > > >>  .../coresight/coresight-syscfg-configfs.h     |  45 +
> > > > > >>  .../hwtracing/coresight/coresight-syscfg.c    | 829 +++++++++=
+++++++++
> > > > > >>  .../hwtracing/coresight/coresight-syscfg.h    |  81 ++
> > > > > >>  include/linux/coresight.h                     |  11 +
> > > > > >>  21 files changed, 2746 insertions(+), 36 deletions(-)
> > > > > >>  create mode 100644 Documentation/trace/coresight/coresight-co=
nfig.rst
> > > > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-=
afdo.c
> > > > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-=
preload.c
> > > > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-=
preload.h
> > > > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-conf=
ig.c
> > > > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-conf=
ig.h
> > > > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4=
x-cfg.c
> > > > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4=
x-cfg.h
> > > > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-sysc=
fg-configfs.c
> > > > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-sysc=
fg-configfs.h
> > > > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-sysc=
fg.c
> > > > > >>  create mode 100644 drivers/hwtracing/coresight/coresight-sysc=
fg.h
> > > > > >>
> > > > > >> --
> > > > > >> 2.17.1
> > > > > >>
> > > > > > _______________________________________________
> > > > > > CoreSight mailing list
> > > > > > CoreSight@lists.linaro.org
> > > > > > https://lists.linaro.org/mailman/listinfo/coresight
> > > > > >
> > > >
> > > >
> > > >
> > > > --
> > > > Mike Leach
> > > > Principal Engineer, ARM Ltd.
> > > > Manchester Design Centre. UK
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
