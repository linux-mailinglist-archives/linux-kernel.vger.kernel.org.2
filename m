Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD25C43BB6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 22:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhJZUSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 16:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbhJZUSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 16:18:17 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3BCC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 13:15:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y26so1227742lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=taV1czNtFBk3wgJIw7/elwcYtGkrQv1vUafu2ZhNsNw=;
        b=R6rNCvUkrnv1vcP2u/6l8kZYVcl8Us6A0UDGpJgmU0GhiKJV6Fu69vxQAqAEpQwoC4
         t8/eb+qQ7ewIHBZ5bsMBsQO9qPcGtOuzkHTVycZTh2tH6wkeHGpwy+J8lWWhemlcxtgD
         VGxO/DHJwgoPMtgyy42h7P8f+HL6STQQzF3mbfBDC6LYis3VSIGQWAx8AO55yL38ywIA
         EYQHv3vziEIoCufRqKRc186y7HE01Ie7ioW88F7ZP9x+zgmRQjlT/9GVabJ0TnAN4Bi/
         2ZZVsFo0TVD+AMzK+aBK8bDSbW49D6w3w2KZKpR0U66uF1SL11SomckOm+ot0oXStRyW
         T6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=taV1czNtFBk3wgJIw7/elwcYtGkrQv1vUafu2ZhNsNw=;
        b=XTTWOiEUl4ZlYH86d6tapKnWGnodfDBEjTlBUz/kwrHgGQIaAhtsuJURzNw7ND3imS
         e2K8thomU31y7UZgMiFDfg++rFsRBjjX8wccIGcvFb5hr944Uthj3ifA7EkuPQO85VYj
         DFcIX4Sw4qC+9P85j0jS1qcrH6a40dd7agkj6GC3gG5autzPdOIHDwfnE5KZX40cHfqI
         hRNQnz15ZPaBpp91RLt57nhQRuvfhpj0tIbtmUdRAnjnjrZ1+tHc/wa0PGmGE2SEbEEI
         lOXYV1QF+smv0EAJg0d/LY+oLqLaVLP563HnpR0qaBSFqa9kuTZ++ybGRYDGVKEi3Ri2
         nLcw==
X-Gm-Message-State: AOAM533HI/h3wuiZyKGQY4yv5lXiqOt//SXY9N4qazJUyrFieIRq+mwb
        MGgbfcipJ0XEr67dybNleYsFV7F2RKlmnq8vcrtFrEllHow=
X-Google-Smtp-Source: ABdhPJxL0E0JjLhlZY6NAkx4UDDNDg+c6ySvSb5EuEvuDMYABT71GtWsWOlq/d0/Rd2hiLwsUraha2ciMhUb4C3I0Vg=
X-Received: by 2002:a19:f106:: with SMTP id p6mr16152171lfh.72.1635279351772;
 Tue, 26 Oct 2021 13:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211026162852.6cf2a2aa@canb.auug.org.au> <DM5PR12MB24064E6B3635CF9EDA7696CBB7849@DM5PR12MB2406.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB24064E6B3635CF9EDA7696CBB7849@DM5PR12MB2406.namprd12.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Oct 2021 22:15:39 +0200
Message-ID: <CACRpkdZdb1wOY0cG4LqY8-JkDxpwe2fii262A2QVXEYXrv2vuQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pinctrl tree
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Kartik ." <kkartik@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 2:30 PM Prathamesh Shete <pshete@nvidia.com> wrote:

> Fixed following warnings and error.
> Attached the patch that fixes the issue.
> Please help apply the Patch.

I applied the patch!

Yours,
Linus Walleij
