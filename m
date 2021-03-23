Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A68F3459E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 09:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhCWIhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCWIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:37:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EABC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 01:37:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y5so13562337pfn.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 01:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2UDvDvrwNygiNBNdDDUmH/QN+dj2qcYSQH9HRRGdEOk=;
        b=SLNwafZy0xcSPD5uY7lz/RH6XJoPG/MseCkxjRuF8M9qhLEPtOA+dsKB9Ikh2GUEBm
         REFv2EOT0YcMtK/4AR7cprD9yr9yt3Y8L8oyfA5NVKiEuu0JMkHMHXEefyratw5cemFw
         vSM4+qX7u/q3NurNi0yYonAj1EbUFKF9FufIDjSDW5YARjcXR8+OVMNQ+nc90OZw3eGM
         Q0YicuyU0iR8BE05YiX7CNU0dbeTBlICIyNb9vnwGjij7IOcHVFnO7GHacMSwR4OwoKb
         aRezGkUkHiKJFRrxCzRufEOsle61IGbom6qvKF+nV83r9NvmD+HgR5FRWOpQh67IbAdC
         ldxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2UDvDvrwNygiNBNdDDUmH/QN+dj2qcYSQH9HRRGdEOk=;
        b=tkdlNT9N+UySdzKXdcl68zlMKolWaAUwzGA2wlNUDe7RNa/jO6S21EI20ICkD+a5wd
         EmIGe8SurUKF7fV/9Xrdr/wI1eQJ8OkA2061VYALGZeYjBGPxkwBYdWv6dEek3v6VE7F
         xhCXJpVfmRY00c7S1YL/RFvg8hO/xijdTXMIsQxNCmdtPlVr10I1DEnMYV8OkJRvuxly
         Uyo9WIYXh3Vdu515we9dXc1WB664FmeM8FJOt0jIgoGB2ohrohV40On72jZIA/FaDjcZ
         5RaP0ahXEY81iitERG0C7sR0wiFrNNppgPWOUOROcY7SgwnIe2JttGzFbQj7APr3NFmp
         dWZA==
X-Gm-Message-State: AOAM532vjG5rIhNu1G/YP1LxDdkx7JTdtOFC3cWczjb4VvCwxWcXNZ7H
        fHZaXDIeXEmlWS20OmADvz3SMA==
X-Google-Smtp-Source: ABdhPJz/zwj9z1WUsC5b4AeWaauQC4n9UBbYFCUBsm/BCstO4dvgiMURH9qAsBpl9caVZaL1OvpKpQ==
X-Received: by 2002:a62:e119:0:b029:1f8:a4c1:ac9c with SMTP id q25-20020a62e1190000b02901f8a4c1ac9cmr3872976pfh.55.1616488624212;
        Tue, 23 Mar 2021 01:37:04 -0700 (PDT)
Received: from localhost ([122.172.6.13])
        by smtp.gmail.com with ESMTPSA id x69sm7638740pfd.161.2021.03.23.01.37.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Mar 2021 01:37:03 -0700 (PDT)
Date:   Tue, 23 Mar 2021 14:07:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jie Deng <jie.deng@intel.com>
Cc:     linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, wsa@kernel.org,
        jasowang@redhat.com, wsa+renesas@sang-engineering.com,
        andriy.shevchenko@linux.intel.com, conghui.chen@intel.com,
        arnd@arndb.de, kblaiech@mellanox.com,
        jarkko.nikula@linux.intel.com, Sergey.Semin@baikalelectronics.ru,
        rppt@kernel.org, loic.poulain@linaro.org, tali.perry1@gmail.com,
        u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
        yu1.wang@intel.com, shuo.a.liu@intel.com, stefanha@redhat.com,
        pbonzini@redhat.com
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210323083701.aqc2qmktoaunnp4b@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <20210323072704.rgoelmq62fl2wjjf@vireshk-i7>
 <a2994a8f-bbf9-b26f-a9d2-eb02df6623b8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2994a8f-bbf9-b26f-a9d2-eb02df6623b8@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-21, 16:33, Jie Deng wrote:
> On 2021/3/23 15:27, Viresh Kumar wrote:
> 
> > On 23-03-21, 22:19, Jie Deng wrote:
> > > +static int __maybe_unused virtio_i2c_freeze(struct virtio_device *vdev)
> > > +{
> > > +	virtio_i2c_del_vqs(vdev);
> > > +	return 0;
> > > +}
> > > +
> > > +static int __maybe_unused virtio_i2c_restore(struct virtio_device *vdev)
> > > +{
> > > +	return virtio_i2c_setup_vqs(vdev->priv);
> > > +}
> > Sorry for not looking at this earlier, but shouldn't we enclose the above two
> > within #ifdef CONFIG_PM_SLEEP instead and drop the __maybe_unused ?
> 
> 
> I remembered I was suggested to use "__maybe_unused" instead of "#ifdef".
> 
> You may check this https://lore.kernel.org/patchwork/patch/732981/
> 
> The reason may be something like that.

Ahh, thanks for the link Jie. Okay you can leave it as is.

-- 
viresh
