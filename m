Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D8332D527
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbhCDOUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhCDOT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:19:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B2BC061761
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 06:19:17 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v15so27855181wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 06:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcrepl095O1T5uPVPW1UlwuPUh4tOV7IL4VgezFFYGM=;
        b=QdqJWT4+CdOdKxVTiBGBTKDbMPueWTyFVLyqq+GxSK2rBvyVMRDbwGmkKePbcoMV7v
         uhl4g+40jjZAZJykXpCAd737EioUC1kkZx6PfCuVXQhCeRgSROazyPWeqEuP6usydJZZ
         hxWFQB+I3f9D0t13+4IuskgUXWW3fACERKpuofoviTMfezRA6xNVx49OyqW8RSlZ9vCD
         QItr3DCMiSmQ3c7k8BB9SGsHSqpzg2uPjx35T7d02uB+tfqEJt8YNdRE/nnHmJiI1+7a
         9Rd6wL9b/MUzs+k3yR+gyMaTWe0GD0kDDV2dTcRkVq8RHBvtzAzc4fQKmHQtPyJak3kU
         AV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcrepl095O1T5uPVPW1UlwuPUh4tOV7IL4VgezFFYGM=;
        b=Ih3f1IlCinGVNGZ3ocOf5ceSmxXvGVuKBFtz+1HJlWM8xIxEjM5W098PQkovqHbzcT
         T9ahsQ9Rs35snYji0Mq+7kf7XHDqZhRm64lg42+z4Bt7Y4JrNJr8JN7T3dmw8CUuTH/q
         v1Ku4WWUm5A1S9199n4QROk/Fykbd6ShkXEPvuzPDLpl6jq9HBxeXHetCEDsiUZvlHVn
         cmrOuYGlPgDtVp+wWSkTWFV0yJxIR/OhyNAr6AoZuU0V622/AHwhw3DOGAXD8w903L8F
         V6Qvqz9eF0Dvnq14EjxQMBVggExBTRb/uyayOwIMTIbUYai+mZH8LsarLO+qOI1IJ8/x
         Mjjg==
X-Gm-Message-State: AOAM531uc1NZ2Xz6RHCT8wFNxePw8Cwo88Xkzue+EhVYHMaoZvJyk6wx
        /j0sLjFGUT02I9YwUcUDCYrv0F91qWVte3iH3BDDnA==
X-Google-Smtp-Source: ABdhPJzTm758EQPAFku3tISz1Mdj62knd7fKxFGdYNxPAQRZjekYAEsvstopWXUfQkCitpohlFSRR/cqauwOEB+OLWk=
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr4230174wrw.178.1614867556509;
 Thu, 04 Mar 2021 06:19:16 -0800 (PST)
MIME-Version: 1.0
References: <20210128170936.9222-1-mike.leach@linaro.org> <20210128170936.9222-5-mike.leach@linaro.org>
 <641a0d20-bf3d-24e2-8402-d99de9117584@arm.com>
In-Reply-To: <641a0d20-bf3d-24e2-8402-d99de9117584@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 4 Mar 2021 14:19:05 +0000
Message-ID: <CAJ9a7Vi5dTJTNRNC36UEwAeCayd_HF9jN8rXSggRF_4cPZ1NrA@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] coresight: etm-perf: update to handle
 configuration selection
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Yabin Cui <yabinc@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Thu, 4 Mar 2021 at 12:13, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 1/28/21 5:09 PM, Mike Leach wrote:
> > Loaded coresight configurations are registered in the cs_etm\cs_config sub
> > directory. This extends the etm-perf code to handle these registrations,
> > and the cs_syscfg driver to perform the registration on load.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >   .../hwtracing/coresight/coresight-config.h    |   5 +-
> >   .../hwtracing/coresight/coresight-etm-perf.c  | 164 +++++++++++++++---
> >   .../hwtracing/coresight/coresight-etm-perf.h  |   8 +
> >   .../hwtracing/coresight/coresight-syscfg.c    |  13 +-
> >   4 files changed, 166 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> > index 9d66e0071f38..98380b496046 100644
> > --- a/drivers/hwtracing/coresight/coresight-config.h
> > +++ b/drivers/hwtracing/coresight/coresight-config.h
> > @@ -154,7 +154,8 @@ struct cscfg_config_feat_ref {
> >    * @nr_presets:     Number of sets of presets supplied by this configuration.
> >    * @nr_total_params: Sum of all parameters declared by used features
> >    * @presets:        Array of preset values.
> > - *
> > + * @id_ea:   Extended attribute for perf configid value
> > + * @event_ea:        Extended attribute for perf event value
> >    */
> >   struct cscfg_config_desc {
> >       const char *name;
> > @@ -165,6 +166,8 @@ struct cscfg_config_desc {
> >       int nr_presets;
> >       int nr_total_params;
> >       const u64 *presets; /* nr_presets * nr_total_params */
> > +     struct dev_ext_attribute *id_ea;
> > +     struct dev_ext_attribute *event_ea;
> >   };
> >
> >   /**
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index a608081bd446..e270bb1e0f7d 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -18,8 +18,10 @@
> >   #include <linux/types.h>
> >   #include <linux/workqueue.h>
> >
> > +#include "coresight-config.h"
> >   #include "coresight-etm-perf.h"
> >   #include "coresight-priv.h"
> > +#include "coresight-syscfg.h"
> >
> >   static struct pmu etm_pmu;
> >   static bool etm_perf_up;
> > @@ -32,8 +34,13 @@ PMU_FORMAT_ATTR(cycacc,            "config:" __stringify(ETM_OPT_CYCACC));
> >   PMU_FORMAT_ATTR(contextid,  "config:" __stringify(ETM_OPT_CTXTID));
> >   PMU_FORMAT_ATTR(timestamp,  "config:" __stringify(ETM_OPT_TS));
> >   PMU_FORMAT_ATTR(retstack,   "config:" __stringify(ETM_OPT_RETSTK));
> > +/* preset - if sink ID is used as a configuration selector */
> > +PMU_FORMAT_ATTR(preset,              "config:0-3");
> >   /* Sink ID - same for all ETMs */
> >   PMU_FORMAT_ATTR(sinkid,             "config2:0-31");
> > +/* config ID - set if a system configuration is selected */
> > +PMU_FORMAT_ATTR(configid,    "config2:32-63");
> > +
> >
> >   static struct attribute *etm_config_formats_attr[] = {
> >       &format_attr_cycacc.attr,
> > @@ -41,6 +48,8 @@ static struct attribute *etm_config_formats_attr[] = {
> >       &format_attr_timestamp.attr,
> >       &format_attr_retstack.attr,
> >       &format_attr_sinkid.attr,
> > +     &format_attr_preset.attr,
> > +     &format_attr_configid.attr,
> >       NULL,
> >   };
> >
> > @@ -58,9 +67,29 @@ static const struct attribute_group etm_pmu_sinks_group = {
> >       .attrs  = etm_config_sinks_attr,
> >   };
> >
> > +static struct attribute *etm_config_cscfg_attr[] = {
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group etm_pmu_cscfg_group = {
> > +     .name   = "configurations",
> > +     .attrs  = etm_config_cscfg_attr,
> > +};
> > +
> > +static struct attribute *etm_config_events_attr[] = {
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group etm_pmu_events_group = {
> > +     .name   = "events",
> > +     .attrs  = etm_config_events_attr,
> > +};
> > +
> >   static const struct attribute_group *etm_pmu_attr_groups[] = {
> >       &etm_pmu_format_group,
> >       &etm_pmu_sinks_group,
> > +     &etm_pmu_cscfg_group,
> > +     &etm_pmu_events_group,
> >       NULL,
> >   };
> >
> > @@ -219,7 +248,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> >       INIT_WORK(&event_data->work, free_event_data);
> >
> >       /* First get the selected sink from user space. */
> > -     if (event->attr.config2) {
> > +     if (event->attr.config2 & GENMASK_ULL(31, 0)) {
> >               id = (u32)event->attr.config2;
> >               sink = coresight_get_sink_by_id(id);
> >       }
> > @@ -537,21 +566,17 @@ static ssize_t etm_perf_sink_name_show(struct device *dev,
> >       return scnprintf(buf, PAGE_SIZE, "0x%lx\n", (unsigned long)(ea->var));
> >   }
> >
> > -int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> > +int etm_perf_add_symlink_group(struct device *dev,
> > +                            struct dev_ext_attribute **ext_attr,
> > +                            const char *name,
> > +                            const char *group_name)
>
> Couple of nits:
>
> This could be:
>
> struct dev_ext_attribute *
> etm_perf_add_to_group_hashed(struct device *dev,
>                              const char *group,
>                              const char *name)
> {
> }
>
>
> This could return the ea on success avoiding the **ext_attr as argument.
> Also the name of the function indicates what it does.
>

OK - I'll look at this.

>
> >   {
> > -     int ret;
> > +     struct dev_ext_attribute *ea;
> >       unsigned long hash;
> > -     const char *name;
> > +     int ret;
> >       struct device *pmu_dev = etm_pmu.dev;
> > -     struct device *dev = &csdev->dev;
> > -     struct dev_ext_attribute *ea;
> >
> > -     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> > -         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> > -             return -EINVAL;
> > -
> > -     if (csdev->ea != NULL)
> > -             return -EINVAL;
> > +     *ext_attr = NULL;
> >
> >       if (!etm_perf_up)
> >               return -EPROBE_DEFER;
> > @@ -560,7 +585,6 @@ int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> >       if (!ea)
> >               return -ENOMEM;
> >
> > -     name = dev_name(dev);
> >       /* See function coresight_get_sink_by_id() to know where this is used */
> >       hash = hashlen_hash(hashlen_string(NULL, name));
> >
> > @@ -574,31 +598,127 @@ int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> >       ea->var = (unsigned long *)hash;
> >
> >       ret = sysfs_add_file_to_group(&pmu_dev->kobj,
> > -                                   &ea->attr.attr, "sinks");
> > -
> > +                                   &ea->attr.attr, group_name);
> >       if (!ret)
> > -             csdev->ea = ea;
> > -
> > +             *ext_attr = ea;
> >       return ret;
>
>
>
>
>
> >   }
> >
> > -void etm_perf_del_symlink_sink(struct coresight_device *csdev)
> > +int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> > +{
> > +     const char *name;
> > +     struct device *dev = &csdev->dev;
> > +
> > +     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> > +         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> > +             return -EINVAL;
> > +
> > +     if (csdev->ea != NULL)
> > +             return -EINVAL;
> > +
> > +     name = dev_name(dev);
> > +     return etm_perf_add_symlink_group(dev, &csdev->ea, name, "sinks");
> > +}
> > +
> > +void etm_perf_del_symlink_group(struct dev_ext_attribute *ea, const char *group_name)
>
> void etm_perf_del_from_group(group, ea)
>
> >
> > +/* string to contain the attribute value */
> > +#define CSCFG_EVENT_STR_SIZE 32
> > +
> > +static ssize_t etm_perf_cscfg_event_show(struct device *dev,
> > +                                      struct device_attribute *dattr,
> > +                                      char *buf)
> > +{
> > +     struct dev_ext_attribute *ea;
> > +
> > +     ea = container_of(dattr, struct dev_ext_attribute, attr);
> > +     return scnprintf(buf, PAGE_SIZE, "%s\n", (const char *)(ea->var));
> > +}
>
> "configid=0x%lx", (unsigned long)ea->var ?
>

ea->var _is_ "configid=0x%lx" due to the way perf handles the events
sub-dir entries.

> > +
> > +static int etm_perf_add_cscfg_event(struct device *dev, struct cscfg_config_desc *cs_cfg)
> > +{
> > +     struct dev_ext_attribute *ea;
> > +     unsigned long hash;
> > +     int ret;
> > +     struct device *pmu_dev = etm_pmu.dev;
> > +
> > +     ea = devm_kzalloc(dev, sizeof(*ea), GFP_KERNEL);
> > +     if (!ea)
> > +             return -ENOMEM;
> > +
> > +     hash = (unsigned long)cs_cfg->id_ea->var;
> > +
> > +     sysfs_attr_init(&ea->attr.attr);
> > +     ea->attr.attr.name = devm_kstrdup(dev, cs_cfg->name, GFP_KERNEL);
> > +     if (!ea->attr.attr.name)
> > +             return -ENOMEM;
> > +
> > +     /*
> > +      * attribute value is "configid=<hash>".
> > +      * this will be what perf evaluates when the config name is used
> > +      * on the command line.
> > +      */
> > +     ea->var = devm_kzalloc(dev, CSCFG_EVENT_STR_SIZE, GFP_KERNEL);
> > +     if (!ea->var)
> > +             return -ENOMEM;
>
> Could we drop this string and use the "hash" instead ?
>

No. My understanding is that we have added an events directory to
cs_etm, and add the configurations in there:-

cs_etm/events/autofdo

Now the contents of autofdo are "configid=0x<hash-value>" - where
hash-value is the hash of "autofdo".

On the perf command line:-

perf record -e cs_etm/autofdo/ .....

will result in perf parsing autofdo, looking in the events dir for
cs_etm, seeing the configid=-string, and parsing that to assign to
configid attribute - which we have allocated to config2:63:32 - this
will then appear as a value in the perf_event and we can load the
configuration when starting up the event on the ETM etc.


> > +
> > +     scnprintf(ea->var, CSCFG_EVENT_STR_SIZE, "configid=0x%lx", hash);
> > +     ea->attr.attr.mode = 0444;
> > +     ea->attr.show = etm_perf_cscfg_event_show;
> > +
> > +     ret = sysfs_add_file_to_group(&pmu_dev->kobj,
> > +                                   &ea->attr.attr, "events");
> > +     if (!ret)
> > +             cs_cfg->event_ea = ea;
> > +     return ret;
> > +}
> > +
> > +int etm_perf_add_symlink_cscfg(struct device *dev, struct cscfg_config_desc *cs_cfg)
>
> etm_perf_add_cscfg() ?
>
> > +{
> > +     int err;
> > +
> > +     if (cs_cfg->id_ea != NULL)
> > +             return 0;
> > +
> > +     err = etm_perf_add_symlink_group(dev, &cs_cfg->id_ea,
> > +                                      cs_cfg->name, "configurations");
> > +
> > +     if (!err)
> > +             err = etm_perf_add_cscfg_event(dev, cs_cfg);
> > +
> > +     return err;
> > +}
> > +
> > +void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *cs_cfg)
>
> etm_perf_del_cscfg() ?
>

Both these seem reasonable.

Regards

Mike


> Suzuki



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
