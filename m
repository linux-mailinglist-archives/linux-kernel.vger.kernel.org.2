Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E9B3DDB7C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhHBOtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbhHBOtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:49:01 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7A2C0613D5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 07:48:50 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id x144so853936vsx.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dySXiO64z/OcknsIe2UwAThjfnI5DezTj8C+OPiFnlc=;
        b=v9aZRfoxU30681CCl+iKq2Xe+bDAfeQbOeL4VEz43ScsGGDi4ksNicVf3zjRZUfNBj
         wYTFHdyQlfBg5j3R9Zu9ssNhF7On8ttv1lNy6VOgZgGYzAV4E1sNY6kOSTUyiKKwfO7w
         4Q6uzd4z2Uy4gIOTcXKSCZi8qlIUzQI05NpeNe+u2ehI+DmIthIltnWZJRlOHKSyDoT6
         lERogpp3KQLA5H7tH3ZixqXFmGzfaDlNuBKiWc7LAWq+udz/zC+cwiaKsHhJbH8RMuHi
         xvzNy5tUEQzqGq5YUtBWi6/G10cacSzy7dSKhzfV6REw0XUssJG/mISGVads2VngMekJ
         AgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dySXiO64z/OcknsIe2UwAThjfnI5DezTj8C+OPiFnlc=;
        b=n/+2czIAWQQxoeRt4NFqjt+yrJxAdASV+fJJOxveQ+Ij7xdYLC8UGMhOnrQxpciG34
         aB11vEDMnpJw0y2mdoF1VQKohVjFjaDE5gw3zFbEuJExtP7whIrG75tEvn8WRxZo2NcC
         pnDG1lAl0/Hsimuxs6Y6+zINSizB2YBeJLWHpyl+6QygJrYSXvihxZWBjIaxWkQxU/df
         I4/ZCYnRwjX1F2jCtrdEMYTgtIkb++CXbeiILW9u5AeoX/qyKkjxCE8fQkAWgZ4KaCq5
         1kLbk0dUmYIW9282n77c8pIU8yo9x0eOsstvpMeJ4GSlpaIAGFWf+Y+NFKBXWxTQGkis
         HDkA==
X-Gm-Message-State: AOAM530Ej00qikNCtERPVkQr+JhsAXuqlJj6xyoUUVOowJ3TtHyzBgcl
        Z5EQkz/pDLxdsLTRHqzo9utmSanEhr0luR3tpAJluw==
X-Google-Smtp-Source: ABdhPJz900uxJ3lZZ4kHywmto6JpFC3IWNqol5Y4dVGhJQ8Lg7yOVdQBBX7Afxl6KnNTXd28RaQtQxHfVUovyD42tiI=
X-Received: by 2002:a05:6102:12:: with SMTP id j18mr9869420vsp.55.1627915729609;
 Mon, 02 Aug 2021 07:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210701232728.23591-1-digetx@gmail.com> <20210701232728.23591-3-digetx@gmail.com>
In-Reply-To: <20210701232728.23591-3-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Aug 2021 16:48:13 +0200
Message-ID: <CAPDyKFrtWDYJo_NjS8306Z9ykbg7XZ55jC9hKEBMGkcrx1=4kQ@mail.gmail.com>
Subject: Re: [PATCH v7 02/37] soc/tegra: pmc: Implement attach_dev() of power
 domain drivers
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2021 at 01:28, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Implement attach_dev() callback of power domain drivers that initializes
> the domain's performance state. GENPD core will apply the performance
> state on the first runtime PM resume of the attached device.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/soc/tegra/pmc.c | 147 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 147 insertions(+)
>
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index f63dfb2ca3f9..ebafb818b08e 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -506,6 +506,151 @@ static void tegra_pmc_scratch_writel(struct tegra_pmc *pmc, u32 value,
>                 writel(value, pmc->scratch + offset);
>  }
>
> +static const char * const tegra_emc_compats[] = {
> +       "nvidia,tegra20-emc",
> +       "nvidia,tegra30-emc",
> +       NULL,
> +};
> +
> +/*
> + * This GENPD callback is used by both powergate and core domains.
> + *
> + * We retrieve clock rate of the attached device and initialize domain's
> + * performance state in accordance to the clock rate.
> + */
> +static int tegra_pmc_pd_attach_dev(struct generic_pm_domain *genpd,
> +                                  struct device *dev)
> +{
> +       struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
> +       struct opp_table *opp_table, *pd_opp_table;
> +       struct generic_pm_domain *core_genpd;
> +       struct dev_pm_opp *opp, *pd_opp;
> +       unsigned long rate, state;
> +       struct gpd_link *link;
> +       struct clk *clk;
> +       u32 hw_version;
> +       int ret;
> +
> +       /*
> +        * Tegra114+ SocS don't support OPP yet.  But if they will get OPP
> +        * support, then we want to skip OPP for older kernels to preserve
> +        * compatibility of newer DTBs with older kernels.
> +        */
> +       if (!pmc->soc->supports_core_domain)
> +               return 0;
> +
> +       /*
> +        * The EMC devices are a special case because we have a protection
> +        * from non-EMC drivers getting clock handle before EMC driver is
> +        * fully initialized.  The goal of the protection is to prevent
> +        * devfreq driver from getting failures if it will try to change
> +        * EMC clock rate until clock is fully initialized.  The EMC drivers
> +        * will initialize the performance state by themselves.
> +        */
> +       if (of_device_compatible_match(dev->of_node, tegra_emc_compats))
> +               return 0;
> +
> +       clk = clk_get(dev, NULL);
> +       if (IS_ERR(clk)) {
> +               dev_err(&genpd->dev, "failed to get clk of %s: %pe\n",
> +                       dev_name(dev), clk);
> +               return PTR_ERR(clk);
> +       }
> +
> +       rate = clk_get_rate(clk);
> +       if (!rate) {
> +               dev_err(&genpd->dev, "failed to get clk rate of %s\n",
> +                       dev_name(dev));
> +               ret = -EINVAL;
> +               goto put_clk;
> +       }
> +
> +       if (of_machine_is_compatible("nvidia,tegra20"))
> +               hw_version = BIT(tegra_sku_info.soc_process_id);
> +       else
> +               hw_version = BIT(tegra_sku_info.soc_speedo_id);
> +
> +       opp_table = dev_pm_opp_set_supported_hw(dev, &hw_version, 1);
> +       if (IS_ERR(opp_table)) {
> +               dev_err(&genpd->dev, "failed to set OPP supported HW for %s: %d\n",
> +                       dev_name(dev), ret);
> +               ret = PTR_ERR(opp_table);
> +               goto put_clk;
> +       }
> +
> +       ret = dev_pm_opp_of_add_table(dev);
> +       if (ret) {
> +               /* older DTBs that don't have OPPs will get -ENODEV here */
> +               if (ret != -ENODEV)
> +                       dev_err(&genpd->dev, "failed to get OPP table of %s: %d\n",
> +                               dev_name(dev), ret);
> +               else
> +                       ret = 0;
> +
> +               goto put_supported_hw;
> +       }
> +
> +       /* find suitable OPP for the rate */
> +       opp = dev_pm_opp_find_freq_ceil(dev, &rate);
> +
> +       if (opp == ERR_PTR(-ERANGE))
> +               opp = dev_pm_opp_find_freq_floor(dev, &rate);
> +
> +       if (IS_ERR(opp)) {
> +               dev_err(&genpd->dev, "failed to find OPP for %luHz of %s: %pe\n",
> +                       rate, dev_name(dev), opp);
> +               ret = PTR_ERR(opp);
> +               goto remove_dev_table;
> +       }
> +
> +       if (!list_empty(&genpd->child_links)) {
> +               link = list_first_entry(&genpd->child_links, struct gpd_link,
> +                                       child_node);
> +               core_genpd = link->parent;
> +       } else {
> +               core_genpd = genpd;
> +       }

This looks a bit odd to me. A genpd provider shouldn't need to walk
these links as these are considered internals to genpd. Normally this
needs lockings, etc.

Why exactly do you need this?

> +
> +       pd_opp_table = dev_pm_opp_get_opp_table(&core_genpd->dev);
> +       if (IS_ERR(pd_opp_table)) {
> +               dev_err(&genpd->dev, "failed to get OPP table of %s: %pe\n",
> +                       dev_name(&core_genpd->dev), pd_opp_table);
> +               ret = PTR_ERR(pd_opp_table);
> +               goto put_dev_opp;
> +       }
> +
> +       pd_opp = dev_pm_opp_xlate_required_opp(opp_table, pd_opp_table, opp);
> +       if (IS_ERR(pd_opp)) {
> +               dev_err(&genpd->dev,
> +                       "failed to xlate required OPP for %luHz of %s: %pe\n",
> +                       rate, dev_name(dev), pd_opp);
> +               ret = PTR_ERR(pd_opp);
> +               goto put_pd_opp_table;
> +       }
> +
> +       /*
> +        * The initialized state will be applied by GENPD core on the first
> +        * RPM-resume of the device.  This means that drivers don't need to
> +        * explicitly initialize performance state.
> +        */
> +       state = pm_genpd_opp_to_performance_state(&core_genpd->dev, pd_opp);
> +       gpd_data->rpm_pstate = state;

Could the above be replaced with Rajendra's suggestion [1], which
changes genpd to internally during attach, to set a default
performance state when there is a "required-opp" specified in the
device  node?

[...]

Kind regards
Uffe

[1]
https://lkml.org/lkml/2021/7/20/99
