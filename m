Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A98A3B6F04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 09:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhF2H6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 03:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhF2H62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 03:58:28 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DBDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 00:56:01 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id k20so2446554uao.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSAyrZd40Wg+7U4SXyC9aQ1jwhxq9gCbvyo3FhleP8I=;
        b=tCVsc+roDkCVTeBie56xhRYhnRI72WRO/aWybbRKvZxXECl+bHhnCYmZMbdYTOzBYq
         N17WcoYl//Bp0+8x6DrM9y4hNNgxpgQ9BNR1wlifJHFYwIXyFXkicPdszzQ5iBrOpy0W
         22yUDcGhtFZbWSXegzecYJ6i08XEVLnBKlN7G9hgV3OUNRsG5nqRuUSua8sBpTZ/HHkT
         BWDBF0L7frPn+Ge8T13pl4uxUL0T/5b4YfgNKu2zg8ZGqPdmPpQ/NLSHiSoRw8Cex1cu
         ohd1lTrY6AhCgwveuWc3A+IE6+dc+Qa/lcSGs3AB1s+lT7dxGF81FgKbCos9aW9kztWD
         ONeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSAyrZd40Wg+7U4SXyC9aQ1jwhxq9gCbvyo3FhleP8I=;
        b=JBtSNrx96E6mGNiQg+9WSwxNpF+cHvTq0MecgTGdOYz2KFjEoL5J7Yb7KBYSgmKGAm
         QYCQJ+xHwHuBmbnpkNAjQUhbqZb0rMCILikRI/psn7R6c5LgFRULNHqkSpmu6gx2AmIu
         hih6cRojUAos339eOx511OfpZJRNsIo3qAWwInHzb2bIpLwdrrK2kS3sc2cgh05ZBFm7
         MuawbpLbOafsgXxhu6/COqOgiXQ3hA5ASpMoFA/5GUo2KkhmY/RY8n1uuLTUZqxRfUdv
         o1F9cEXa4aKxPvkwsFz4AidmWDgVxN42T+/HWMX8IP7j4WFoCas04DbrDqdNSt2Xhn/l
         0olQ==
X-Gm-Message-State: AOAM530q2rai3FbKYjGQ74EPz2JjtSOtG1xnqjmKo10z6W0/VscRE7OY
        aUppz/JfmB6Ktly0RaSM4QBn3pgYK1/ipJVuh9mk2A==
X-Google-Smtp-Source: ABdhPJyEGkyfsvxTkYbEpZtd6e4D/Z/0MzQLLtYqg0wvEQETOjbmMIFQpxCTMVyGpm7r4E6+pZCaSXsoAjZJeJS7IdM=
X-Received: by 2002:ab0:15ec:: with SMTP id j41mr21823613uae.8.1624953361014;
 Tue, 29 Jun 2021 00:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210625125307.330831-1-aardelean@deviqon.com> <20210628145307.GC4492@sirena.org.uk>
In-Reply-To: <20210628145307.GC4492@sirena.org.uk>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Tue, 29 Jun 2021 10:55:49 +0300
Message-ID: <CAASAkoY=pgTE6nVKeoSDVsSEBU2zgckRuE-m4G+7L9-_Q2yUnw@mail.gmail.com>
Subject: Re: [RFC PATCH] regulator: devres: disable regulator on release if
 refcount is 1
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lgirdwood@gmail.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 at 17:53, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jun 25, 2021 at 03:53:07PM +0300, Alexandru Ardelean wrote:
>
> > This means that the last 'regulator_disable()' (on driver remove) becomes
> > optional.
> > If there are any unbalanced regulator_enable()/regulator_disable() calls,
> > the 'enable_count' won't be touched and 'regulator_put()' will print a
> > warning.
>
> This doesn't seem like it's going to make reviewing and debugging
> reference counting issues any easier, it seems even more of a concern
> than a devm version TBH.  It's also not clear why if we were doing this
> we'd restrict it to a single reference.

Yeah, it doesn't make much difference if the refcount is 1 or higher.
For any refcount higher than 1, it's a serious unbalance of reg enable
+ disable.
And I agree that this may complicate reviews, as this would be one
extra subtlety [in the regulator framework] to account for.

Will send an RFC v2 with the short-hand.
I'm not trying to force anything with this, but looking at all the
repetitiveness of the devm_add_action_or_reset() hook to disable
simple regulators, I thought I'd [also] propose a variant or another.
