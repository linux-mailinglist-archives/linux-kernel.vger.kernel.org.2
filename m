Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02EC41A178
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbhI0VsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbhI0VsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:48:07 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01410C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:46:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l8so27335315edw.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DOP/Ae5E9+UV8DIgGaqmjsByOHA/I7bBHXk1O5MJK8E=;
        b=QBHbAdymDlS/J9zNuaqHQjn/TgKrA8fLv0aRI/pjpv/THNI3Wrbrrpk8Hg5og3Ly2f
         dRpiPxuymihaOMPOkI/88ZNe61IQEDCiqW4s73pabQveX4Th0GP6UICfQNReRoVLY3YB
         QZSeM/rs0XK7+vE2Cf0yF1guQbXxUNcIuTyADUjKW4Od4Jfmg+k2OPM1ag495oZyvRa+
         E2sBLgkv8+s/mVWTnLacm1vSUsKfHHkZVF/GnXdsWWmDbpKaTjtmkEax9Bn2SVbR5c7t
         fB78k/eVri9T7OQUXmte4LJR+Kvt14OccdqaC8E3ujCnKBw4LEliHERec+6CIfcDKM20
         QHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DOP/Ae5E9+UV8DIgGaqmjsByOHA/I7bBHXk1O5MJK8E=;
        b=iA/q/49rEybmpF5KlQmwhd7Xhy2FYibqstZL+N5i3B4vGC3nWNEPuauTG5/pfBoU3K
         uONWOZCCvs6J+kntFpyWka0RMEohyuTSkyxI4a78Fs42XFs19tInAH5SDapRl4nuWsxY
         XE0vBx/ZBye1WvFgkh8s4w9MPC6+W4nWLXNN1UNyg6FR3No2q4Bql2zoLPgq0i83HJuI
         oshCcmdAtUbcq3tCqySMjoXITwM93NIna6uel2iYtMl0rZ0tSzfta/f2PTlhh3nbvqrE
         Ha8P3517mO/Vwr+SbgTiKnY4QG0aJ6j2uD3i/X/cAxUDAnZviLSIQht2mnPIXwaEoULl
         tBlg==
X-Gm-Message-State: AOAM532eSfnAhqqq8Tu0sSDA2zVW4Ga5hkzCzBl2KVZz6VIuZG7LZCml
        eR9LJdU1WJ+WmY70/cYI+J0=
X-Google-Smtp-Source: ABdhPJygP6DFsyKuuwHTabv/EZBjElcQwMgRmriFU8y/gd2CT+BaPatgKynSn4QtQojsSmX2pk3zSA==
X-Received: by 2002:a17:906:1b54:: with SMTP id p20mr178229ejg.133.1632779187626;
        Mon, 27 Sep 2021 14:46:27 -0700 (PDT)
Received: from tom-desktop (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id h13sm11325045edr.4.2021.09.27.14.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 14:46:26 -0700 (PDT)
Date:   Mon, 27 Sep 2021 23:46:24 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] staging: vt6655: fix camelcase in ldBmThreshold
Message-ID: <20210927214624.GB6953@tom-desktop>
References: <20210926162527.21462-1-tomm.merciai@gmail.com>
 <20210926162527.21462-3-tomm.merciai@gmail.com>
 <YVHirHixyOIgvqKB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVHirHixyOIgvqKB@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 05:26:36PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Sep 26, 2021 at 06:25:19PM +0200, Tommaso Merciai wrote:
> > Replace camel case variable ldBmThreshold with snake case
> > variable ld_bm_threshold.
> 
> Same here, what exactly does this name mean and why did you pick it?
>
  You are right the same here. What do you think about "bm_threshold"?

  Thanks,
  Tommaso

> thanks,
> 
> greg k-h
