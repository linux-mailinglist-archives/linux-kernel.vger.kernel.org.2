Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1B13717C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhECPWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhECPVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:21:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0351AC06138D;
        Mon,  3 May 2021 08:21:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h10so6673198edt.13;
        Mon, 03 May 2021 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kkqs94+/ybUyNI5rZrs90tbn8fLyNhu7W2OnlMi0z3o=;
        b=Ievrd4IVcRxqnwuDMPx71rpYDu8wesN7ueRNWJMJRO8Mwy2kIFknWE4kJ/z+u46c7l
         gtLyLdWQ1vLk0T3mfWdwhXvbYO1EexlN/T4rHbyy1juHx8x2wiSSS3veV6EECzJR1Cb4
         8L41CD3RP5bGy/Xf1b0QugmWNqjbzc2WA1LagllCFeljI1WOLNQoRospk6UlhcFjtvFJ
         D55jY3dbkIgUIDiuym2tFDyu8t1eRjKOcYK06o/6urSsXVARBjGd/eKUUIq7y8MbuFMb
         LA6IphnWdZ1Yk+i3xeAI1mriu0g8XWuxS+VPqjpjfxulIvGOv5p9sGks06492UFdfWm8
         zWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kkqs94+/ybUyNI5rZrs90tbn8fLyNhu7W2OnlMi0z3o=;
        b=ll7NXZoQklnYd1uK+qIhxd0IGqZqlxTZk4UnynaQXaK0wPz/hWy7//RflXBkDQPQBi
         b1FTXohKqZMoeO3Tut7fRPpGxihQfmJqB7lBt1mcgcdbJSuyfcKEmYxKhQM4s/96E0Fx
         IOYZub+ok4A5iXWSVOpYv+AJI4WBwS3vrZd0ybg3NFprXlICIBbOt09fIVmRlLk8NL4p
         wEuG4ATl6wzth2+jNkF4V9asz7MEu4mZmPUZFbfvfTHsZW/xX4L+tcMNDitvDKXz9MZN
         2z/XbIiqY0zjuo6CDAnmPxq4I61QQ0YFzIyarpSamDYAk15oXc3+rtCs8OBFW86DOp/4
         NDcQ==
X-Gm-Message-State: AOAM533zajRzx9z2PeUKrOYm8lI+sEDOc922tuZDAK2GCSlCBVdKmE9L
        QStBUWUjKOQPrWkYXaZG8IhGue+w4253coZMb9g=
X-Google-Smtp-Source: ABdhPJwAOleGZd/Eez3lx4AEwk1OJQ6JhUvQv+HUuG6q0XvBq/99VHpqLBzZfJZqJpT2VJB7vIvPWyO4LHlM9wVgDEY=
X-Received: by 2002:a05:6402:2548:: with SMTP id l8mr1029117edb.208.1620055258882;
 Mon, 03 May 2021 08:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210503145503.1477-1-linux.amoon@gmail.com> <1jsg336eoo.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jsg336eoo.fsf@starbuckisacylon.baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 3 May 2021 20:50:47 +0530
Message-ID: <CANAwSgTiWhb5+iO0Ro4WO6uH4n_VoihZPsqaNMVx-hQ7kVwagA@mail.gmail.com>
Subject: Re: [PATCHv1 0/9] Added Audio and HDMI power domain for Amlogic SoC
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, 3 May 2021 at 20:35, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Mon 03 May 2021 at 16:54, Anand Moon <linux.amoon@gmail.com> wrote:
>
> > Patch series add Audio and Hdmi power domain for Amlogic SoC.
> >
> > Tested on GXBB - Odroid C2
> >           SM1  - Odroid C4
> >           G12B - Odroid N2
> > -Anand
> >
>
> AFAIK, the audio power domain is a no-op on the g12/sm1. At least this
> is what we've been told by AML. Unless this solves something, I don't
> think it should be done at all.
>

Opps, I unitedly make some assumption,.I will drop these changes.

Thanks
-Anand
