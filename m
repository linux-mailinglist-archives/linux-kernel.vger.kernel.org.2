Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBFB30CD82
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhBBVAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhBBVAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:00:15 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A9BC061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 12:59:35 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id a12so30080946lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 12:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOzKpXWPBo1OpCUm1aLl7QvNKAWbvBkDYSSjgluEfi8=;
        b=p/Aj+yzc+qGVr+WVjVZGd1YOISTerygHb+HA4ZFyyHHzOf0cj7oPmcD4lw5HVWDqMv
         C7JrQi4VJ6mREpwymsccH/dPoAper37lhKrZyN1kS6q1ubK4psUUHfv7nJzjtsszB0U1
         WFyrkei2QNe5DCVhuaW7R+d2H5W8mPyHXoiWJ74aOUNGIMyaQXbGXLuaUhnCQk6lEW5b
         jGs0Bpoj+79sjAbBJRQwAvjoNFj8EgoH/6aSYMNBJY+iwk4rI5gCHIzcZiSOgIEu4PfR
         Y0ACykVD5BClOIreAooRROKziH2pdD8wtovnG6Iikfo+toXOZKklNVOh4ee5rmpivfR5
         vHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOzKpXWPBo1OpCUm1aLl7QvNKAWbvBkDYSSjgluEfi8=;
        b=iexqOidv308tG368s2wbDIWVipBqci18hwM0sC+oJuim/51S4oN3UEV/7+wjTQYW7N
         E6XE65XsE4SQSI27GDNNCOtojZGl/pZ4RVaUvhPreSRu0ib98DO1tiY22+mr7wzhcLAt
         GIobE5h/KKuup2bXy3usT+qdGs1luvjBCpzQcQN8RGKwYwQW+CV6A2I1uOujsV2lW6H+
         Ahpo7j06P+fByiXYuiny801H6SQvFA01mWSlLpW3L/KXyJ3ifm8zaLXe077/1s3RvKvB
         cvF0xXp/QHfykZWeVSyjjv4DkuanKFrEhrnE8++8Qgphm9Uq+B6RIVSblPFdSgeKvpX+
         hwHA==
X-Gm-Message-State: AOAM531DvU/ghnln5dO5fhR2mKI+p8HKbeYqzVokYbsRbpU16Be1SPlv
        slnPsRaFE4hmsYbEl+CGV5jDMQf+vxRWDUH2vVOypQ==
X-Google-Smtp-Source: ABdhPJxFnif05v2wKdOjfPsSyLcaSDkHUUKC2AL/iGQWy24+xtwNC5cKvHHPV+XT+8yYngsHWx/JXnbfBRP+67Q5gH8=
X-Received: by 2002:ac2:5e81:: with SMTP id b1mr12140605lfq.473.1612299573366;
 Tue, 02 Feb 2021 12:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20210121213641.3477522-1-willmcvicker@google.com>
 <CABYd82Yk91u287iZvkUik+UYg2mHMpHimZzsg72cXOK6k8WpRg@mail.gmail.com> <20210202074245.GA3545218@infradead.org>
In-Reply-To: <20210202074245.GA3545218@infradead.org>
From:   Will McVicker <willmcvicker@google.com>
Date:   Tue, 2 Feb 2021 12:59:17 -0800
Message-ID: <CABYd82aZACHeO2XymKbUCbwJ-wj7sVFOqyeiY59G77LvQY7bEQ@mail.gmail.com>
Subject: Re: [PATCH v6] modules: introduce the MODULE_SCMVERSION config
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Did you see Saravana's response to you in version 5? I'd love to hear
your thoughts.

Thanks,
Will

On Mon, Feb 1, 2021 at 11:42 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> Just to deposit my opposition again:  I don't think this hack for your
> out of tree builds has any place in the kernel tree.
