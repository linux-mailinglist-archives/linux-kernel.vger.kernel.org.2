Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA1E32BCC1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383511AbhCCOjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842999AbhCCKXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:35 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61624C0698CA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:08:15 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id p15so18735276ljc.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VgVOuS1QdOahuh5eYdd3kUCTER6wTGX5ASCqQ/qR98c=;
        b=PV84WwDH6AoIAOjPzcHF9gE4Neg+FF/n1iEVa9iM65O+VfmQa9SUJspvze3Ds0xmtY
         VNut1Zk3DzlViqxwSvsvuf2JVU9tvSiu8Jd7xGnmvLBgUU3puYPJhikl0UX+4XXieKWa
         0rBqqTyvMMomXbLELCv8FgnG/eoUUWmsOtdry2CoDH+WMqGh6PqtEV4hXY+zKsXY4MnH
         jlaX4DJR0JZO3wuG0cuLJAjfoZFo9/JgjIpSy3d5HhWgLztRgRmdt/Tf3ka3ih1qDVBg
         0Lfnm/rCtgSa17A7JRAqFsZsNDEhZYxVttvZ2/NEaXX+V2IObPQuwhqk1B/N3edNREZt
         vxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgVOuS1QdOahuh5eYdd3kUCTER6wTGX5ASCqQ/qR98c=;
        b=fYZt8EdcSrAame2OebLCRuxtblgIkVCd4GZESPPcL9jPoqylelRu08oLPNQNanNKAG
         TZJr6jXWqPOIyDMPuc0nsmH0XmsDceQxvZNB9arhmOSlNz6cPe9k8BloEO/zuPv9VPFy
         SKCotn+z9XLVK7RIJU4b/GA/vEXSPHjzXknqirfRCS1LIMhR1COBTNIuPvKD9ITAbvLN
         zOLBgaCcWq858XbRjP2Lmfe8jAACHPpJony1lB+uN0h8NLMP41lVPZzO1Bh6v9egri1H
         O/YaNlQyHgpkp2IxWhcYa7zgNOPg2am9b4Y9A4/KkMgHqrTtREjfzas1PvLbtcb43iV/
         Ej7w==
X-Gm-Message-State: AOAM531vfOSd3kIBgbEiaW6lZ/h02IjG0j4CJUKNCrqwUZdNVJBss+hF
        liKqSdvKoY0nLMnzgDGlTZG949e/GyZN1mHco3qilw==
X-Google-Smtp-Source: ABdhPJzxigEaNt73mce53qjrn+MUEA/hhuJIqtZPEfomrycZI5NTqHmk7gTM6ml+qt1aKlxGUv4AZijNTpYhNfnk8J0=
X-Received: by 2002:a2e:7001:: with SMTP id l1mr1351194ljc.200.1614762493875;
 Wed, 03 Mar 2021 01:08:13 -0800 (PST)
MIME-Version: 1.0
References: <1614303297-24178-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1614303297-24178-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Mar 2021 10:08:03 +0100
Message-ID: <CACRpkdbC9FZgj-VkZ3hMuKCEsFVfYoBm-OWG2WK2WbubmK=ALw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: ingenic: add missing call to of_node_put()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 2:35 AM Yang Li <yang.lee@linux.alibaba.com> wrote:

> In one of the error paths of the for_each_child_of_node() loop in
> ingenic_gpio_probe, add missing call to of_node_put().
>
> Fix the following coccicheck warning:
> ./drivers/pinctrl/pinctrl-ingenic.c:2485:1-23: WARNING: Function
> "for_each_child_of_node" should have of_node_put() before return around
> line 2489.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Oops applied this rather than v1.

Yours,
Linus Walleij
