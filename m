Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6643CBBC2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 20:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhGPSUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:20:43 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:51558
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229611AbhGPSUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:20:40 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 372DE408AC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 18:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626459463;
        bh=iIUxpkpHlT/ujJv35mg4KveIs6ZMWhsNWrIIJdMLdVY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=e1xwD4ESNvubQd7eM1pZkACw+zosSLTI7e2RcEuRoUnrY8ns1kl+lPEJuLrxSfuGQ
         lp+gM0XGjBcCB1GoySZG/QmUUL1rUCCl5syG7ofuImax7frqOcxMu6QzBNLdQmcDgX
         omOwpZSTkX3LGoHZnlEEqESx/kIscW4usm2nItLv3r9c62KHb3VEs8e5bG8W5h8oLI
         TKZpkDl8+A5tEr5bK9ovRDQXePNGBs7ihrDqnAIyxeswhIPY66T8yealO2FbtjvOZe
         V5l4LCIrsvPVJuS+SxV0RlEbgphICylifuA4zllrToscoxhbY2DOwPhcBBfo2kX0Pk
         TMfknsS1YBF7g==
Received: by mail-ed1-f72.google.com with SMTP id v2-20020a50c4020000b02903a6620f87feso5232410edf.18
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 11:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIUxpkpHlT/ujJv35mg4KveIs6ZMWhsNWrIIJdMLdVY=;
        b=qMlTeyYs50SG1cun5AYX/IYyDngnKvKulcoAkhIIDFVCMF1RiVdRRln7ya0TSB9tqV
         wpvJo6BXDG+tSasHT9QH22wWm8KGcuSPmTlzo/L0IN/wZL5ZlFjDBVj0AFxzt3/bauCR
         82uJ8BN6PJd3l8bJaai4fO7LIwbfN8YVRkdTuiW7ua7NWfmS5eO4olSgdPmOFQcVPKUr
         145hIe0xH8AMVGrzTUBXHEbkZj+t7F5xevUzCRK7g0wQtO+b1FGoYk9QJXdqgth+1Ot3
         I0H7NCf94zJKH0cVxwtB3UINnOYR35JljvKN/opRL2XuC+op2iH6UatEyBPjHuGZbJL9
         53vw==
X-Gm-Message-State: AOAM533m8XwWmpcJvaj5sBzDzH2K18MpsXS1QZosOeyvna6lQJL0mZmm
        Jsl2IWhwVZ6+FxwQSLcJEZLq4HRMjKX2XeZHrwUsbv/Zi9Q3B5dbAVfDJbmi02ur8ySxy4WYEHS
        FC6/B7eiaA8+RE5vYmdILicQome3q1QaEZKL+ypdMPyy3r83EOofjjM9eiw==
X-Received: by 2002:a17:906:f104:: with SMTP id gv4mr13185817ejb.193.1626459462969;
        Fri, 16 Jul 2021 11:17:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7df1dhE7FzdafW/owwyXmM1zYUZ7HBRYCPlHWpeQXx6e8+gqubotkBQv3ZT/yzAAMRbSMDc4ayjjFEpa3Tx8=
X-Received: by 2002:a17:906:f104:: with SMTP id gv4mr13185805ejb.193.1626459462770;
 Fri, 16 Jul 2021 11:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210512144319.30852-1-krzysztof.kozlowski@canonical.com>
 <961dc9c5-0eb0-586c-5e70-b21ca2f8e6f3@linaro.org> <d498c949-3b1e-edaa-81ed-60573cfb6ee9@canonical.com>
 <20210512164952.GA222094@animalcreek.com> <df2ec154-79fa-af7b-d337-913ed4a0692e@canonical.com>
 <20210715183413.GB525255@animalcreek.com> <d996605f-020c-95c9-6ab4-cfb101cb3802@canonical.com>
 <20210716171513.GB590407@animalcreek.com>
In-Reply-To: <20210716171513.GB590407@animalcreek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Fri, 16 Jul 2021 20:17:31 +0200
Message-ID: <CA+Eumj7SPFXOMUGRxZqjG-0Jq_1EnWwh9Ny-a=+QsN8tfrrCwg@mail.gmail.com>
Subject: Re: [linux-nfc] Re: [PATCH 1/2] MAINTAINERS: nfc: add Krzysztof
 Kozlowski as maintainer
To:     Mark Greer <mgreer@animalcreek.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-nfc@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 at 19:15, Mark Greer <mgreer@animalcreek.com> wrote:
> > I am happy to move entire development to github and keep kernel.org only
> > for releases till some distro packages notice the change. If Github,
> > then your linux-nfc looks indeed nicer.
>
> Okay, lets do that.  I'm the owner so I can give permissions to whoever
> needs them (e.g., you :).

Then please assign some to the account "krzk" on Github. Thanks!

Best regards,
Krzysztof
