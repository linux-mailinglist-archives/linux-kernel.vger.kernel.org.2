Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB36D3ECC90
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 04:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhHPCMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 22:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhHPCMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 22:12:22 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81297C061764;
        Sun, 15 Aug 2021 19:11:51 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id db14so8543415qvb.10;
        Sun, 15 Aug 2021 19:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RCriSD8EWtXhtQKktiE7TncAOMeRWKmTNW5hb/Sa0/g=;
        b=J6xikWU8wKm7Z9E0G7SsPulofLjO9FwDDKk21zs2cS4nuZgEE55Z4YadanEpsD2pRz
         o7ld0W5h6zoOP1Jok3c3wPlHF55eyD2TThWk1jEQRblyp3T56n4LUQ1B/qy3nRYv14g2
         pi6Ng+x6TPfgywj+NB2fiJAZVH1J84ALBpjN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCriSD8EWtXhtQKktiE7TncAOMeRWKmTNW5hb/Sa0/g=;
        b=RWMb7ltCXdySfdS0RookTlYax55/aP7+Hhv8lteWBh088RpCn75aYd5wYgYS9l7JGX
         sgoqclj8+7haFkl7g/5zypUlY3jz5ml9bkHAWHJj0Qg3DAju2p+ISzHA9RC4DiIykL2/
         sD90m9hZPNyeaxP2CBT+PLtfJA3W0j3x9A/id6XvyKukLOJku2Mk4kxVOmWSt3h2pyMN
         0eHFCxXRitlHbRB5Hjp6sfPUAUEsEP1HR7W4Ssw/bj94mATRN4qFbqE4mlHIZ7DBg5NS
         yhibzUztdGyWveQv7rgrkG1BEy5YHvoNC1z5yeIMDKKCEdbWWAcOPfv7ZovOXIGtGxXt
         pGMQ==
X-Gm-Message-State: AOAM5332dLbAlio+sbhAmb/7nBFBr25MpKTV8q1NxFnhlv6bJ4pkYa6T
        n7YkGIMQ46koiA/ZocPo0INH0dLNfYDxKNjdrYs=
X-Google-Smtp-Source: ABdhPJwhXnrmqh156PtVzL9hcyEAfhvLDsdhzqB6+2cdZvwR1531PgQsyNtKhyvPLIGl5qxjxGsdHQDU14nxJs1lA8E=
X-Received: by 2002:a05:6214:8c2:: with SMTP id da2mr10826803qvb.10.1629079909644;
 Sun, 15 Aug 2021 19:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210720002704.7390-1-rentao.bupt@gmail.com> <20210813062435.GA24497@taoren-ubuntu-R90MNF91>
In-Reply-To: <20210813062435.GA24497@taoren-ubuntu-R90MNF91>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 16 Aug 2021 02:11:40 +0000
Message-ID: <CACPK8XcAqU3KASespqS3dPterpzyqD4wYH=qOS8Ok2yUrB_F+Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: minipack: Update flash partition table
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 at 06:24, Tao Ren <rentao.bupt@gmail.com> wrote:
>
> Hi Joel,
>
> Looks like the patch is not included in "dt-for-v5.15". Any comments? Or
> should I send v2 if the email was not delivered?

I had missed it. It's now applied for 5.15.

Cheers,

Joel
