Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F7E43C5F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 11:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbhJ0JDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbhJ0JDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:03:35 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F72C061570;
        Wed, 27 Oct 2021 02:01:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id s1so7759836edd.3;
        Wed, 27 Oct 2021 02:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FwSpFY7U7Gd4ELBz8g66vgAETa0RnYhonzcZ9AVHumA=;
        b=fUy6bdf0Ab6eD2kRHUso7K4espthSWVlKrzsDF+v9UlWSJCkC1QCFitLCKHpqfU/rb
         AJwnKdSsDzjDNmfnTzbYX1zKJ1z+uIt8CsbfcHWv2zelGb5iJKJMt/E4WCBD8MPBkgBB
         nYWshVa8A2Oo+ExhtL4v0frXvHEgWfIo4GpLiu7jxvEckPrPQieivcaczp+y4ydc+h8I
         BB7wmIwOyuJW9ZCp1ss2p2NHuK7epZ7JHsbEMzJXmxlhEMjtZrVYpl18F9pwBCIwY0oK
         NdCDjdFTRR+DoqwI3xGfJKLtA9/nVmAoaKONnSed6PvnzpYTqwe4bNzIZWcJZPh2eGGH
         Z4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FwSpFY7U7Gd4ELBz8g66vgAETa0RnYhonzcZ9AVHumA=;
        b=YkrABuw4Z0Ng2yVV1zW4nOWbaeodAEPon3SGfUj0MQRISPkFlo4znp+y4dJWKMQO1k
         wRDrN18WFcU/wklnFNF0E1FdNModVUhA5hK1tcdq0cQCArRqZEpTKzfKFrZvI4v4AX5S
         haJrfFqVbOtPaTkQlm7fCjCs13gQ6eA5c1kfPUkmIsnV+GUFfT2KCU6kcyXSBwSgwMYq
         FjxOlXRtkr0xBt6Dd8vRddx+L6uOhLPCg6O5BeavQ5DIIO/kSpO+L18KZl8KyBoGjnnK
         ZDbMFYNRJk4VcFFQc7+2Ki2wyPedwMpPVKg8NbEuvuAAGxhBN6FX0gKVEh5UefUV/6et
         rBug==
X-Gm-Message-State: AOAM533vMeEqe6u7fKVxG+MypoaOWA0fLLDRJKI0yb3Uhwl0dcCrnySe
        HrqLDn8jsAJbSlcHn3pKWi0zNCPCJfi8dvDuA4c=
X-Google-Smtp-Source: ABdhPJwiRlxKN8rVFf+TqHcvaGebMUj7HhFjqA8GrP7Zb1pDbtyaDlm7JREauXbJYDdJAwvNEIBZ86iIUp/JyM9RQFU=
X-Received: by 2002:a05:6402:10da:: with SMTP id p26mr43735894edu.283.1635325268073;
 Wed, 27 Oct 2021 02:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211022200032.23267-1-pauk.denis@gmail.com> <20211022200032.23267-2-pauk.denis@gmail.com>
 <YXcDcXrUo4a/KAsT@smile.fi.intel.com> <YXcHYvleoOr6sqMK@smile.fi.intel.com>
 <YXcKLvRu3gRm3zUF@smile.fi.intel.com> <20211026225805.1504a9f9@penguin.lxd>
In-Reply-To: <20211026225805.1504a9f9@penguin.lxd>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Oct 2021 12:00:32 +0300
Message-ID: <CAHp75VekkKU7ain3f0+fWym6G54+jFYuAau7Bj+E0CrQjv-VBg@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Tor Vic <torvic9@mailbox.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:58 PM Denis Pauk <pauk.denis@gmail.com> wrote:

> Thank you, currently code has returned N/A by some reason. I will search
> place of regression.

The code I issued is a complete draft and basically it's just an idea
on how to improve in the form of a patch.
I'm pretty sure there may be some bugs lurking.

-- 
With Best Regards,
Andy Shevchenko
