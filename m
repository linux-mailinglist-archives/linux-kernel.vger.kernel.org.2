Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AE2352A20
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 13:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhDBLMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 07:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbhDBLMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 07:12:38 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7640C0613E6;
        Fri,  2 Apr 2021 04:12:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h3so3391195pfr.12;
        Fri, 02 Apr 2021 04:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2/nhflnKzHvaTQ+vpCIh5osUc/NCcpD8e/rg56e8Bc=;
        b=UrYNRrGWCqGmJUl2NAgBwvMOBVb3L2c3yr+VVCKaJG779szdjI10o/QzX2SCtOjt03
         lhBNAjpm1lM5HNTmv4fvDCARHoZEyveXbIZQgydcfwn6pyZsdy9fpFFe66fq/pDuFuDm
         53J/xOhooNMOpnfaTVw7XDQBZ6hYlD7TLfwmteoO8CTLqPSFD9Nm5/pI04WKhRPT+6FS
         vy9hSYI0IBRemjAxzf0IXDbbdQcRIlEmDcO4GBTcX44IYgj427Be24fDKNFuFWqlPxFa
         nJPdXoyUzX+gam5gOHyPdHg6jcHcvqmeiPlEFoSSExGU5R3UIgylC/jtNMsQtH7XNMjS
         3jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2/nhflnKzHvaTQ+vpCIh5osUc/NCcpD8e/rg56e8Bc=;
        b=Igm13W+V1JIzDyE7V+pXTC22CXm2CvYCT656ziUK1bPs20skCxUj5N6UYNeH9+id3h
         l52AE+q6XjtooQSLt7Jcd+Dt9WC6mekk8ya9Bf9Ztt2EvHI39LC8w9/FU0RyY0PAjksS
         yaT2LKNIbbwuwRdEzR6/MqqRaDDNRfFJ4SiEjEFyEGK9/WjiCPVg2vDERuL12CEP1pLQ
         Oqa7DXqDE7ymZA3HKg6qgDnj43l5Pxbl35vcTxUW33RWwKFKNb609c7fLvhJ+jUZw5Xo
         zWnQb3wvWvdfjuGqUBk4Tti9zGSAA7uUV9GhRjIw9mDiIY11Tkxz/TIUioPZAIz0RjAO
         obEA==
X-Gm-Message-State: AOAM533q0MUY6U2v9gfzOT+1ibWZPMw2leaPzapvOmIbCUrJVydf2Ydm
        ffSL5jVvnVWBaUx2FaDstVtMNydC+3fPnin11AY=
X-Google-Smtp-Source: ABdhPJwVOpl/JXBaO5w+dkYyXadLdNxQiftTG8fEL2Sr55f8Cv3me01iwV982ZyK2BEHiNUWKhcBMWZZVx3gOSWyEz8=
X-Received: by 2002:a62:7c43:0:b029:1ef:20ce:ba36 with SMTP id
 x64-20020a627c430000b02901ef20ceba36mr11907902pfc.40.1617361957170; Fri, 02
 Apr 2021 04:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210401213144.1009224-1-tomas.winkler@intel.com>
In-Reply-To: <20210401213144.1009224-1-tomas.winkler@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Apr 2021 14:12:20 +0300
Message-ID: <CAHp75Vedb4U7yfkjS9KhkcMVb3=rTrP_90xQCbujG-sG9+1YVQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: export platform
 global_reset via sysfs.
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tamar Mashiah <tamar.mashiah@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 2, 2021 at 12:32 AM Tomas Winkler <tomas.winkler@intel.com> wrote:
>
> From: Tamar Mashiah <tamar.mashiah@intel.com>
>
> During PCH manufacturing a global reset has to be induced in order
> for configuration changes take affect upon following platform reset.

effect upon the following ?

> This setting was commonly done by accessing PMC registers via /dev/mem
> but due to security concern /dev/mem access is much restricted, hence
> the reason for exposing this setting via dedicated sysfs interface.
> To prevent post manufacturing abuse the register is protected
> by hardware locking.
>
> The register in MMIO space is defined for Cannon Lake and newer PCHs.
>
> Cc: David E Box <david.e.box@intel.com>

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hmm... okay, I forgot this, so my additional comments above and below.

...

> +static int set_global_reset(struct pmc_dev *pmcdev)
> +{
> +       const struct pmc_reg_map *map = pmcdev->map;
> +       u32 reg;
> +       int err;
> +
> +       mutex_lock(&pmcdev->lock);

> +       if (!map->etr3_offset) {
> +               err = -EOPNOTSUPP;
> +               goto out_unlock;
> +       }

Do we really need this check under the lock?

> +       /* check if CF9 is locked */
> +       reg = pmc_core_reg_read(pmcdev, map->etr3_offset);
> +       if (reg & ETR3_CF9LOCK) {
> +               err = -EACCES;
> +               goto out_unlock;
> +       }
> +
> +       /* write CF9 global reset bit */

Somewhere you use cf9 (small letters) I suggest to be consistent and
use the capitalized version everywhere.

> +       reg |= ETR3_CF9GR;
> +       pmc_core_reg_write(pmcdev, map->etr3_offset, reg);
> +
> +       reg = pmc_core_reg_read(pmcdev, map->etr3_offset);
> +       if ((reg & ETR3_CF9GR) == 0) {

Can be written in a form of !(reg & ETR3_CF9GR).

> +               err = -EIO;
> +               goto out_unlock;
> +       }
> +
> +       err = 0;
> +
> +out_unlock:
> +       mutex_unlock(&pmcdev->lock);
> +       return err;
> +}
> +
> +static ssize_t global_reset_show(struct device *dev,
> +                                struct device_attribute *attr, char *buf)
> +{
> +       struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> +       const struct pmc_reg_map *map = pmcdev->map;
> +       u32 reg;
> +
> +       if (!map->etr3_offset)
> +               return -EOPNOTSUPP;

> +       reg = pmc_core_reg_read(pmcdev, map->etr3_offset);
> +       reg &= ETR3_CF9GR | ETR3_CF9LOCK;

And why no lock here?

> +       return sysfs_emit(buf, "0x%08x", reg);
> +}


-- 
With Best Regards,
Andy Shevchenko
