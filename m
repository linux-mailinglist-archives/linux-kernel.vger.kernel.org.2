Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245603A0F82
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 11:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbhFIJVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 05:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbhFIJVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 05:21:12 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B2EC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 02:19:08 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id z22so14818800ljh.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2VfAdxpLFSH2lKBrvUpwO3xN3M0sVoWmcLtknql0Nk=;
        b=GkH2boXUs4nV7pBNeoqE9Jw4OjjFDzM1XubJq0jrQJU6aEc2x/USoEPuI016SjJ/Nw
         6Cu1R0eYwGewSVwx/6AJ90lF+PsE8LXM7S5Z+/P/AlS3TZL+/yBmkkItbHS1EGdmEQkS
         oUwpzVaulho1zoLt1Cw3B0SXVZWdSzOzP1uLtM0QXUpgUCAXGxkqUlmaWBtpcA612kgG
         F1vsXlpEbOHvSXKHz0nNGmgN0vg1JnQGJ+tRNmCAIIoxphLHNP7aUf/axk6EbcngoH/1
         6oKbNABh9lJveFpG3XoDp+jEfS5UgZno/3oaiA09N/reROq0VjtTgMDaocKiYrrMPoQf
         6r9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2VfAdxpLFSH2lKBrvUpwO3xN3M0sVoWmcLtknql0Nk=;
        b=JbgQF0vWeHucpYANiFqgiayFqndXZ8BQaZgdNwOW1kQeaOyfmnOvqBnvmhKbkLdC4w
         SEK2JZb3rBfJuuB+Ji4OdUtVuzTdF0ULm/rtnjft8siMKmw4rRaL/8bAdsD6bLie0fVo
         Kj6KhAypizli8AIV5xlYAKL8AsWG6i9BO7PBMX6+YzNooBnvv8Se8H4BPkSe39ol68o3
         GuKwPCGmBSqLmM0GtcEmtFcxJGaJY3EzdDGFvfykmbwM5OQ2huEDadb84Q1O+tklc+g7
         igynZQ4e4FSoswO2le2dN94lnBxOn+p96Yw76tV/XaE5h5+BVwM5OYmvhaZUW5QCT7Yo
         1paA==
X-Gm-Message-State: AOAM5334Q3e6wQQNbZzY8t/fI9+mBGTU0/+J3jQXfQI+xJnKYdG7SqLo
        GNNgePjow5JpbcdSHOSi48s5GMmK+8iIyS93RZTeQA==
X-Google-Smtp-Source: ABdhPJx+9yId/nH8i7TP64z+S9xoaiGdlcTIUWjloG27YUnksxOAk4gXMrytRJ4tF/cdaFmNp/Y/mw1HRTXJ40b9swk=
X-Received: by 2002:a05:651c:1411:: with SMTP id u17mr11002125lje.438.1623230346495;
 Wed, 09 Jun 2021 02:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210605185908.39982-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20210605185908.39982-1-rikard.falkeborn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Jun 2021 11:18:55 +0200
Message-ID: <CACRpkdamjEmV1n+6iKBt+ocTNB=WHZsZ3PggSy20NrtvK6gZqA@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: bcm: Constify static ops structs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 8:59 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:

> Constify a number of pinctrl_ops and pinmux_ops that are never modified
> to allow the compiler to put them in read-only memory.

Patches applied!

Yours,
Linus Walleij
