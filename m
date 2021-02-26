Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C66F32674E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 20:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBZTP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 14:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBZTPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:15:25 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC913C061786
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:14:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id n4so9625481wrx.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RuZp97vmbX3iIDJQaLWaML/+bFGYgXRX8cY/lFqCb0=;
        b=SnBNKxyPwjxV1r4q+dVPz/jQz/ZPn7P571slVmVk1YK1kCiwwyzqHV51yA9tnmUJbB
         paSiXtb5lBKCrElhg1bHAnABFfu1XL5pN5OlvRb+9ORdJibuJ4bxnRja3JbSm1axWX62
         n7WGc2uZmO2o+/HQQGZMmxnnXs9zVW65Lz5UNyaUoueI1SlJNMudcBGQgMhSC7+VjRMm
         mXOof6DQAWCh5jVmiPuor+j0QsmWBvawconkyomG/LMCGIKzClSORwenxdiacvsCrRgG
         dWg0TTHNE0AIBtlDLyZBP4w+MzktYm7VI6dvRlZeUnssCLw7VseKo0sJy/RrswSzY7bP
         cNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RuZp97vmbX3iIDJQaLWaML/+bFGYgXRX8cY/lFqCb0=;
        b=E0tGsbA7aj4LYxzyt2jgSin85nLCkzba6PVPR7bnsKsRuK59gRJXspvAR2/62a8iXA
         DKZin1oLU6AtNrRI6SmfvPcTkIUdvhimIgaOrqzg2RGeGn21aN+4fzaYQpOOgQSQV4tm
         0ejrJfV9KUUz5WYaX95AggvqS+vFDWzhZZ+8eCZ+pNNu0C7XCTsQb+QMBfns44m/8ZgQ
         gGwlcnc5OkXwGhOwkHGlnsLfEa3ElMuoFvIKWeQLx6OCRlvn1MMebSOleHXZw5ZpZc2M
         fU6TLE6bjziwmZH0O1heCV7qlJJx7JHMnrINq1VtnKQqoyVhe8H/oNbxj7SOd6K9n/0+
         97dQ==
X-Gm-Message-State: AOAM5304iRSN1G44xpn/KXt4voSX95Uw6uP5o5MLzZqKzszdlTPeT2Er
        KBluhbXC/MvXu52G+oHWNFgHhSoQUT6P0sPPGquX3Q==
X-Google-Smtp-Source: ABdhPJxSHnkbQV0oSfGegVOoaPiiMqcDhERK3pBj182Gl1wWtE17kVrglCwBzTMER3A2OJEoW7PqwMtI93lYmsfpSvo=
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr4537164wrw.178.1614366883308;
 Fri, 26 Feb 2021 11:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20210128170936.9222-1-mike.leach@linaro.org> <20210128170936.9222-3-mike.leach@linaro.org>
 <20210219184313.GA3065106@xps15>
In-Reply-To: <20210219184313.GA3065106@xps15>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 26 Feb 2021 19:14:32 +0000
Message-ID: <CAJ9a7Vhh5xdbmMgcTLjU3qJEg2nbZoZ5j2HqvenwNGoqo+54Rw@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] coresight: syscfg: Add registration and feature
 loading for cs devices
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
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

Hi Mathieu,

On Fri, 19 Feb 2021 at 18:43, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> [...]
>
> > +/**
> > + * List entry for Coresight devices that are registered as supporting complex
> > + * config operations.
> > + *
> > + * @csdev:   The registered device.
> > + * @match_info: The matching type information.
> > + * @ops:     Operations supported by the registered device.
> > + * @item:    list entry.
> > + */
> > +struct cscfg_csdev_register {
> > +     struct coresight_device *csdev;
> > +     struct cscfg_match_desc match_info;
> > +     struct cscfg_csdev_feat_ops ops;
> > +     struct list_head item;
> > +};
>
> I would call this structure cscfg_registered_csdev and move it to
> coresight-config.h.  That way it is consistent with cscfg_config_csdev and
> cscfg_feature_csdev and located all in the same file.
>

I was trying to separate structures that are used to define
configurations and features, with those that are used to manage the
same. Hence, most things in coresight_config.h define configurations,
or their device loaded instance equivalents, and things in
coresight_syscfg.h are management items. I am happy to change the name
but would prefer is stay in coresight_syscfg.h

Thanks

Mike


> I may have to come back to this patch but for now it holds together.
>
> More comments to come on Monday.
>
> Thanks,
> Mathieu
>
> > +
> >  /* internal core operations for cscfg */
> >  int __init cscfg_init(void);
> >  void __exit cscfg_exit(void);
> > @@ -33,6 +49,10 @@ void __exit cscfg_exit(void);
> >  /* syscfg manager external API */
> >  int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
> >                          struct cscfg_feature_desc **feat_descs);
> > +int cscfg_register_csdev(struct coresight_device *csdev,
> > +                      struct cscfg_match_desc *info,
> > +                      struct cscfg_csdev_feat_ops *ops);
> > +void cscfg_unregister_csdev(struct coresight_device *csdev);
> >
> >  /**
> >   * System configuration manager device.
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index 976ec2697610..d0126ed326a6 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -219,6 +219,8 @@ struct coresight_sysfs_link {
> >   * @nr_links:   number of sysfs links created to other components from this
> >   *           device. These will appear in the "connections" group.
> >   * @has_conns_grp: Have added a "connections" group for sysfs links.
> > + * @feature_csdev_list: List of complex feature programming added to the device.
> > + * @config_csdev_list:  List of system configurations added to the device.
> >   */
> >  struct coresight_device {
> >       struct coresight_platform_data *pdata;
> > @@ -240,6 +242,9 @@ struct coresight_device {
> >       int nr_links;
> >       bool has_conns_grp;
> >       bool ect_enabled; /* true only if associated ect device is enabled */
> > +     /* system configuration and feature lists */
> > +     struct list_head feature_csdev_list;
> > +     struct list_head config_csdev_list;
> >  };
> >
> >  /*
> > --
> > 2.17.1
> >



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
