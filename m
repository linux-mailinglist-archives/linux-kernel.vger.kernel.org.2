Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1184736B8BF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhDZSM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbhDZSM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:12:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E54C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:12:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id w3so85875658ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T88U1AQpVKHcDhTG6otN61m/NoaWE5roR3G4dcc8hYw=;
        b=GbSaczG7WcdypV5+uVAL4U8HMlh++zxBQSCCZY6jXlubmZnIgB0imuWzytRREUPX9d
         bKfllU6EgBlirCkpm5EZrWFSkswXVXIp4chRxaoj9pMgZ/fLqbdv3d9LeQyvbSfmSmQs
         Ws5LdrcyX+wRmijdcuTWjqxaQmT0BKwk4aDvE6RzqAjZ9snPJpvPLhQu2fm/5kQBri7j
         WAWd6+A8ZSj0qYGlhfzu0cEk5JRbD4xmG/KkL6zyluDgXX1x32eiLbbaJ/gxF7A3A3T7
         j1iC1Hcl29bIE0p8uDFpE3QBw1iESRr2m5TEcr6js2Et0uQikf6ZnKMhwa6nq5fywHeD
         MFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T88U1AQpVKHcDhTG6otN61m/NoaWE5roR3G4dcc8hYw=;
        b=uWZ6KWOsJ3Qxa7YJ61RWAEatciBbmLx60KNFMSRC18qKmUL4vOQRFP9Tnfy7D5NpjA
         366VnCiclgjnzQi0BU626Aci3/AT8KQrkVZAaVv3Dz9byPTQblmksEsu35R5NNVpamsA
         BGgiMi+k8qEub8HIuI9lwHIPA7Bg4QaG3HH5oWLaHgDzIWjGqFZ3h/0G5OCnqFw2CIcn
         Or0/CZyqlHGJzqYF8xYAGlsdPnX6JSoMhXrt+mB5fCCntQFjSrjwdEsf/ApCZ5Vut6VL
         Z0UWnojxX6GlD+IxAJ1g8qok8q9XAj+EgM6JtGYa0lm1AOvmAiZF2xH4mWTqOy0wgehC
         klVw==
X-Gm-Message-State: AOAM533s68qs7BvHaiALlTmQEtnarIW3NLap6nz9VIDrgxdtRep0ZiB6
        hhlzmuGJgvb0kxt8BspN03NyWWMCM8SoL7mpuTBW9w==
X-Google-Smtp-Source: ABdhPJwfhDzZbubwZndtJ2zufuzWGIEJODRfij0DJYZtciYmXiKOLdYaV2eY9womgfQRRtXKxNJpBEy6TBcuLEvGjww=
X-Received: by 2002:a17:906:27c3:: with SMTP id k3mr455279ejc.519.1619460732912;
 Mon, 26 Apr 2021 11:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
 <20210408040537.2703241-4-pasha.tatashin@soleen.com> <480272f8fb3e46d24a0ee1418fb85809@kernel.org>
 <CA+CK2bDc+9EsH_TLTgg9Pqv_-rZfZfPohdZEfsYjT8ss+8skjg@mail.gmail.com>
 <87v98wom5n.wl-maz@kernel.org> <CA+CK2bB9M05UKfvu66_wMK1u_HBvRws4R0KxPgTu4vPdKuGy9w@mail.gmail.com>
 <CA+CK2bADNkoX-Q3tNyjJ7fo6-f4sBPkAVYLiQh-rxFOcHzbJGw@mail.gmail.com>
In-Reply-To: <CA+CK2bADNkoX-Q3tNyjJ7fo6-f4sBPkAVYLiQh-rxFOcHzbJGw@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 26 Apr 2021 14:11:37 -0400
Message-ID: <CA+CK2bDcZiWhQ+xALnQm43zGpv+BE9wkHejMS81v=wk3iJPttA@mail.gmail.com>
Subject: Re: [PATCH v13 03/18] arm64: hyp-stub: Move el1_sync into the vectors
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Please give people a chance to review this lot first. This isn't code
> > > that is easy to digest, and immediate re-spinning does more harm than
> > > good (this isn't targeting 5.13, I would assume).

Sorry for top posting, the previous e-mail intended as a reply to the above.

Pasha
