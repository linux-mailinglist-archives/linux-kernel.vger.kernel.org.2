Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A5142678E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 12:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbhJHKUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 06:20:46 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44624
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239538AbhJHKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 06:20:44 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 466C33FFEF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 10:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633688328;
        bh=8OszAYwmyRLKjqkt/vzBzk84xsQhgfNIYVQxorJQ0FE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=kUX2/IOU7O94IaD4MR1ZY6nZxK/OYKykJUA3tnlDQqtYIBtUiVqV8FcyVo2BOLe/f
         NbS4QKmFIDGqNYNJF37g2PzVUBIr9ZOaVgFrQMQfoHS093oCXJSp21jbWuNdBxQjbR
         rZL4VEflMxQM3om5UzBcgx+Ra0j0c0F6+IEpVuGcnfD00y4qaEUn7su1r0FkS088v5
         6USMX2F3U1qtLtO+efxlFH9mQL1a/O2m8jx1fYwWw6N9iUtflF4NHUzpFd3YZm5BX5
         NWC/kmSsbbnWHkb5L0XOvPfrhv2q9y4LrRFV5+Y8EJwm5GQ8C4MkqEuqS4VONpze4a
         5KDW1/L7oPUoA==
Received: by mail-ed1-f72.google.com with SMTP id u24-20020aa7db98000000b003db57b1688aso3370291edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 03:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OszAYwmyRLKjqkt/vzBzk84xsQhgfNIYVQxorJQ0FE=;
        b=Yv0z2+oYORZxF42Pq1sanj0iPiibUvsm9Hrh50qA2aFuhg36ghGb2JJX9LxVEQTszi
         CwGITjtzlnV4u7Y+j2uLJkgt1upKBnUhunt/ftCUJWSBxWFa6e033fgpr/lVfqM+32LA
         0/JrQkDfKYUBWhgNBIdNcgCjmNcIPwADcFGtJmnBwLD6nHVAWVL7fDmwn9Fph2cheBDs
         0F5StX6XqBWqAx+n/S4lWaflnabeSmZVe4L9aD1xWtggE5yY1Osmqg5c4Oy2Hovqigar
         KfVPitKa9fO9hyuRrlC7vETHCt+LlabfwHbkgFhV1AKZ+adeNtIkLmHx7ppKW7rs/YeJ
         IRTA==
X-Gm-Message-State: AOAM5307Ue90Fu7TiqEP36j68PztQnn0nHodpNrkVqy0PapdBjNKryGz
        1a+I0NeLcLWUrAWuXEx9tqxrhry23vOBA7CuiPTnTEGxw5oPj4/9mJaqrGtBJDizbAZAX2ASiwE
        lsbiolZU7vbzqQv7A/Uo2tbYMV9ZX6dIrmajbFGL2gMd3/5paoxkT09cW6g==
X-Received: by 2002:a05:6402:21eb:: with SMTP id ce11mr13601238edb.153.1633688327499;
        Fri, 08 Oct 2021 03:18:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7o7l2UNsnGaraOVKpHhb8tbtKVV+1I4OFVbSEp6Eg/VZ00BTQ9CBhrhN3STNdktZj1NYqnDUwdbEyoGT3BvY=
X-Received: by 2002:a05:6402:21eb:: with SMTP id ce11mr13601210edb.153.1633688327360;
 Fri, 08 Oct 2021 03:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211007133021.32704-1-krzysztof.kozlowski@canonical.com> <20211008.111646.1874039740182175606.davem@davemloft.net>
In-Reply-To: <20211008.111646.1874039740182175606.davem@davemloft.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Fri, 8 Oct 2021 12:18:36 +0200
Message-ID: <CA+Eumj5k9K9DUsPifDchNixj0QG5WrTJX+dzADmAgYSFe49+4g@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/7] nfc: minor printk cleanup
To:     David Miller <davem@davemloft.net>
Cc:     k.opasiak@samsung.com, mgreer@animalcreek.com, kuba@kernel.org,
        linux-nfc@lists.01.org, netdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021 at 12:17, David Miller <davem@davemloft.net> wrote:
>
> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Date: Thu,  7 Oct 2021 15:30:14 +0200
>
> > Hi,
> >
> > This is a rebase and resend of v2. No other changes.
> >
> > Changes since v1:
> > 1. Remove unused variable in pn533 (reported by kbuild).
>
> Please CC: netdev for nfc patches otherwise they will not get tracked
> and applied.

netdev@vger.kernel.org is here. Which address I missed?

Best regards,
Krzysztof
