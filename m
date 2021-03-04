Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0EF32D5A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhCDOrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhCDOrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:47:14 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078FBC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 06:46:34 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d11so27933014wrj.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 06:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPjdoY3IchTxSeEVo8a3bj2scxE+31WbW/AYcYPh3QM=;
        b=rWuP9MybS+aGNANpU21WEPXzBZdbNfgJBQDKLXXyKxTGG0Cz8tNdUtYfvz/OuVuCCl
         CVRGV6hVWxzz6SfQEDifFlLbj/P1hl9an9J4kSJltsh4DorFGVan0EEMGGno5Dmodz1f
         UZt9qqcvs5WUHgMo3cQ8XeiSyLubYIX3riytWVynvcAsOrh11nthtYMtVtvbj1MQA9sN
         tkCW8To5JT3qdfBrBI5MaGPMrFKSURAXdeXkbcO8uqO7qi6spY2caiScQ3iQZY6Y9SVg
         nUZPgSvgt61iAxNbamg3s3Mwr2sR7jAgu+V3pID6X+DSXpgwj5jgDQAQUUXuaLIIk8X9
         GbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPjdoY3IchTxSeEVo8a3bj2scxE+31WbW/AYcYPh3QM=;
        b=F7VUZQCf+1ZD0m7nANn3zAoXH+V5PoJt7JiqO7SUQzkKGVXBxFrEzxifD03mAuqCCM
         Jx0Wgw6GapIM6hNDTe95/u1D1ChSt5x27FpTsukhfKONvn+70qiUc12F9H/BSGM4Tgeg
         dZkJ17uwHD9nYZdEC2xltCdyQ0b8AqKQiKzuARIyRtRSvwEPmwzq61ccqJxazNiSDReG
         S9C8qthH7HhI57dLgDJh+ScAqh0H3CN+ZiAdgT6Yw0vkoze28r64NBDPEzc3B6lGRCZJ
         HJQCk5ZphurIdTt3X55XPq3xJDn4fS8fbqu4v2eI9ijKBrZdImNoexuMpNZDldJxfcwD
         m28A==
X-Gm-Message-State: AOAM532zYj0Nc80dt55mIrumjrFuJ5dG8Yzbjq/HhwoHWtk9Z+2QRI+R
        qr8HHUgrnNClfrIzUdsYhENTlpAUE691GaLaYcH1UA==
X-Google-Smtp-Source: ABdhPJxMrhGvW7HaiafS+5gzz8xlNld8dYnSjUSYnfDHMPCyjqWwP0NmkfwcNhxBxz2381/J9tn7v+J/rwg60YsUCu8=
X-Received: by 2002:a5d:4688:: with SMTP id u8mr4392324wrq.39.1614869192777;
 Thu, 04 Mar 2021 06:46:32 -0800 (PST)
MIME-Version: 1.0
References: <20210128170936.9222-1-mike.leach@linaro.org> <20210128170936.9222-5-mike.leach@linaro.org>
 <641a0d20-bf3d-24e2-8402-d99de9117584@arm.com> <CAJ9a7Vi5dTJTNRNC36UEwAeCayd_HF9jN8rXSggRF_4cPZ1NrA@mail.gmail.com>
 <921225a2-14a8-2a4f-4726-f61224cafa28@arm.com>
In-Reply-To: <921225a2-14a8-2a4f-4726-f61224cafa28@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 4 Mar 2021 14:46:22 +0000
Message-ID: <CAJ9a7VhWqkDeSWeZnGi2JdrYv-d8=R6He_zfd+L3Za3WoPRXOg@mail.gmail.com>
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

Hi

On Thu, 4 Mar 2021 at 14:25, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 3/4/21 2:19 PM, Mike Leach wrote:
> > Hi Suzuki,
> >
> > On Thu, 4 Mar 2021 at 12:13, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> On 1/28/21 5:09 PM, Mike Leach wrote:
> >>> Loaded coresight configurations are registered in the cs_etm\cs_config sub
> >>> directory. This extends the etm-perf code to handle these registrations,
> >>> and the cs_syscfg driver to perform the registration on load.
> >>>
> >>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> >>> ---
> >>>    .../hwtracing/coresight/coresight-config.h    |   5 +-
> >>>    .../hwtracing/coresight/coresight-etm-perf.c  | 164 +++++++++++++++---
> >>>    .../hwtracing/coresight/coresight-etm-perf.h  |   8 +
> >>>    .../hwtracing/coresight/coresight-syscfg.c    |  13 +-
> >>>    4 files changed, 166 insertions(+), 24 deletions(-)
> >>>
>
>
> >>> +static ssize_t etm_perf_cscfg_event_show(struct device *dev,
> >>> +                                      struct device_attribute *dattr,
> >>> +                                      char *buf)
> >>> +{
> >>> +     struct dev_ext_attribute *ea;
> >>> +
> >>> +     ea = container_of(dattr, struct dev_ext_attribute, attr);
> >>> +     return scnprintf(buf, PAGE_SIZE, "%s\n", (const char *)(ea->var));
> >>> +}
> >>
> >> "configid=0x%lx", (unsigned long)ea->var ?
> >>
> >
> > ea->var _is_ "configid=0x%lx" due to the way perf handles the events
> > sub-dir entries.
> >
>
> This must be combined with the suggestion below.
>
> >>> +
> >>> +static int etm_perf_add_cscfg_event(struct device *dev, struct cscfg_config_desc *cs_cfg)
> >>> +{
> >>> +     struct dev_ext_attribute *ea;
> >>> +     unsigned long hash;
> >>> +     int ret;
> >>> +     struct device *pmu_dev = etm_pmu.dev;
> >>> +
> >>> +     ea = devm_kzalloc(dev, sizeof(*ea), GFP_KERNEL);
> >>> +     if (!ea)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     hash = (unsigned long)cs_cfg->id_ea->var;
> >>> +
> >>> +     sysfs_attr_init(&ea->attr.attr);
> >>> +     ea->attr.attr.name = devm_kstrdup(dev, cs_cfg->name, GFP_KERNEL);
> >>> +     if (!ea->attr.attr.name)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     /*
> >>> +      * attribute value is "configid=<hash>".
> >>> +      * this will be what perf evaluates when the config name is used
> >>> +      * on the command line.
> >>> +      */
> >>> +     ea->var = devm_kzalloc(dev, CSCFG_EVENT_STR_SIZE, GFP_KERNEL);
> >>> +     if (!ea->var)
> >>> +             return -ENOMEM;
> >>
> >> Could we drop this string and use the "hash" instead ?
> >>
> >
> > No. My understanding is that we have added an events directory to
> > cs_etm, and add the configurations in there:-
> >
> > cs_etm/events/autofdo
> >
> > Now the contents of autofdo are "configid=0x<hash-value>" - where
> > hash-value is the hash of "autofdo".
> >
> > On the perf command line:-
> >
> > perf record -e cs_etm/autofdo/ .....
> >
> > will result in perf parsing autofdo, looking in the events dir for
> > cs_etm, seeing the configid=-string, and parsing that to assign to
> > configid attribute - which we have allocated to config2:63:32 - this
> > will then appear as a value in the perf_event and we can load the
> > configuration when starting up the event on the ETM etc.
>
> Sorry, I was not explicit in my comments. You could drop the string and
> have ea->var = hash. And the _show() could simply do
>
> "configid=0x%lx" , hash
>
> as mentioned above.
>
> That would avoid another string allocation, with the same interface.
>

OK, that makes sense.

Mike

> Suzuki



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
