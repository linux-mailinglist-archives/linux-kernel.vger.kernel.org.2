Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A603D87E8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhG1G2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhG1G2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:28:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA967C061757;
        Tue, 27 Jul 2021 23:28:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m13so1849563lfg.13;
        Tue, 27 Jul 2021 23:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvGemlcUtE1FTzxvu3oTTvOyrcyl5+uIUOsi8DP/Pn0=;
        b=FAls18xQI87tCZjIJBMai8JV+8KvkFjqMi+xCEcveRFEl1Oayy6pY5ANrhAZSh6GBG
         FnAJa1u/nu1qnqbo7GVM3ajaAWj5hv/dUdFKPQ6bLZyv2Fcarmu/KxRbTxXYiUGsnjtk
         oX+uMNGDKQbKbY5BCpSREpzEesQWOiDAKm52OMO/iZuheIiMYorKjQ93tbNKWt+dWS1o
         3WSQsxn8+9EQuAmXIjoI8EBsFRl/qPMtO91l17QWoXZYNyse00UgkaGgJs3gFY/cn5KF
         3MzNLJEaXIDs/6J+d2f2pY2af/LAUDkRRE815CoCrnZMmWU5UrLyzcMglK8BpnBcEvz0
         Y4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvGemlcUtE1FTzxvu3oTTvOyrcyl5+uIUOsi8DP/Pn0=;
        b=AiLKo1sOQJA4Ptk+zXZAD92I6GxSgov6S4QUq86XUCn95REsOpEZXmsfAZL6NqXlgA
         cH/lmoNL+OsWsAAx56HOGE4CS493vLaR2RcZjdo8073npadpfW8K27D5Ic+UCoSeh+Ta
         SlAdvTR1h2dpVrqW6yXfJcqcO8d4x6Wy573+JJzVaygnBia9Rzk9EUcMk/986uDr2+y6
         dDeeDnWF4GTOiit8pzmkm9alQDQBwbjl6ET5Fe7+17/XOzWsK3DkoELIVYXjXNIQB9sL
         F/UeDuK0GRe8q3I26+tUZtEqWLR4L1/t2QkaZVmGMlgnhXfB7fZzcHUQL4iYzYh4Dym4
         9PHw==
X-Gm-Message-State: AOAM53239+ZGFDB7IaqZVLHurAVoTTP+UNUVAJSW9oBWPmEdDGOUKiMh
        jJMmfGTM9qc1J2Kw7ufWpDA=
X-Google-Smtp-Source: ABdhPJxMMs+1ACgvekmAn9LKVXGeOcSkalcqmj3aIHx1j4T9NnGwwR7q1vdCkjNf9EcNHMgI6ZP1Tg==
X-Received: by 2002:a05:6512:6d1:: with SMTP id u17mr19789558lff.227.1627453698183;
        Tue, 27 Jul 2021 23:28:18 -0700 (PDT)
Received: from reki (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id i25sm436061ljg.20.2021.07.27.23.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 23:28:17 -0700 (PDT)
Date:   Wed, 28 Jul 2021 09:28:16 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, sandeen@redhat.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: idle uses the highest byte for
 duration
Message-ID: <20210728092816.6d06ba3b@reki>
In-Reply-To: <YQD4U67wFqtXBGu1@kroah.com>
References: <20210727185800.43796-1-mdevaev@gmail.com>
        <YQD4U67wFqtXBGu1@kroah.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Greg KH <gregkh@linuxfoundation.org> wrote:
> You forgot to mention what commit this fixes up:
> 
> Fixes: afcff6dc690e ("usb: gadget: f_hid: added GET_IDLE and SET_IDLE handlers")
> 
> I've added it to the patch now, but try to remember it next time.

This is quite new for me, thank you for suggesting it and for your patience.
