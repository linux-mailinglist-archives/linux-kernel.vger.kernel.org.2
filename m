Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2912C310131
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhBEAA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhBEAA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:00:27 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2616AC06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 15:59:47 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id i6so5006557ybq.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 15:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajugGFTO/TRAW2sAnJSAPf8Ya7Pzauh522ocLH7i6ok=;
        b=ohGfycmdfrxRyY1lmPjrmZyS9N6dc3YFK2yib5ANdl8uFdVdopsh9roTcJt4ov0P5y
         xHO2VpN0aJTR09TZ0hBvwgZkSsYfhUhZTZQtgiXOXWvwazqR7Vu//O0+4cku3m7DE+oR
         HKCEz3OQjvvpg2ZAlebzRVR8TNs6A7zesCsXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajugGFTO/TRAW2sAnJSAPf8Ya7Pzauh522ocLH7i6ok=;
        b=XqlCmkl4zdbQvGumlLpD7G4N2rQIeDuKlzDUJm7Vw77Wq5MzKSOgA9M8WyNW6W3qIM
         ixSNN6m4UXhLkjULdz6g0bUzXZkQIAFY3AfXj+oMQwkx8zTB7v5WjQCxMQoFucH6vvzU
         AualvWNu6VNAQIvf7E/UJAI8jxd2GZpi0qJiZ2686kNjg8cBeAUdt5G8TkgISPpxNMzR
         h7wa/xMx43Oef8kz9hRZxsYn+D0zs14GNpWG0j015oghSyFxmVkfBjs4RQVleebZoBfU
         /ep+DeSdGRoOklk4G71FVVhKfZBdRpXpYzq7maDYHagjyyQon0EGg8W1EAjxvEoNY1jh
         K7NA==
X-Gm-Message-State: AOAM531i21k1jSit/ouTxLzmjapd+PBRtEA8N/kOzgWsmkmR4mTc7mwQ
        LlSvASy1HkNjEeQhpSuVFFsn2Bpby6Wd4A+Vn6rNXQ==
X-Google-Smtp-Source: ABdhPJw2rGyC8Vdna/CSOxDku9YLve+1PHezgBkzuWIEdYSJwFeii4IvU2L9spsPyc3BoeaM/6XobrMWuZNBDeHBrm4=
X-Received: by 2002:a5b:38c:: with SMTP id k12mr2570869ybp.441.1612483186593;
 Thu, 04 Feb 2021 15:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20210115143555.v6.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
 <20210115143555.v6.3.I96134907488f41f358d03f3c1b08194f9547e670@changeid> <161075035048.3661239.6086252465678815045@swboyd.mtv.corp.google.com>
In-Reply-To: <161075035048.3661239.6086252465678815045@swboyd.mtv.corp.google.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Thu, 4 Feb 2021 15:59:35 -0800
Message-ID: <CA+cxXh=tPNRxu_XvYZ7yEBj+HdadS60amXCa7_OChhzTwRnmaQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] dt-bindings: input: Fix the keymap for LOCK key
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maintainers,

Friendly ping - can we actually land patch series v6?
Or do you expect any update from me?

On Fri, Jan 15, 2021 at 2:39 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-01-15 14:36:17)
> > Decouple LOCK from F13 and directly map the LOCK key (KSI3/KSO9) to
> > KEY_SLEEP action key code.
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
