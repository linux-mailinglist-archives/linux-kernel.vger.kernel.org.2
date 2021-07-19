Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CA43CD137
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhGSJLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 05:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhGSJLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 05:11:54 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF8FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 01:55:53 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b12so15995893pfv.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yuupvXOnIPmh2WuceNcDgQcZPke3kJz+BOITNCPWDHk=;
        b=e5NF1ASUz+HlmCvhPlQdtpqoMDqw9b9zkYIr6DFn4pZ7ZqZq1QGaHqkyOP3YSzUeAE
         17FQlcqtT1tcEo6Ydt+P59i6loA26qjfB5KvaxcQjhi9R8MxhFAShKbITA/7LyqRzVZN
         1T6hh8F5DitB75jXqmbkww3T9091ou5TcvpVA/agCtIUVTeGeqaJDGHQxY909KjIZJJj
         +z7s7vYGVH1b9I3HSrJ+JivW9xk6RxwjAO0inrAfG1DIDq7sv2+TU8itutBtGuMXmi8V
         kHwQ388lNgZhmwP963bLDpSinonl5rI7bOyY3xoVx2qjIsNqUuKBisoAyS1USbQ55oRi
         qSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=yuupvXOnIPmh2WuceNcDgQcZPke3kJz+BOITNCPWDHk=;
        b=OpK4tq85Cl2IkIOuxZi0bAafnbDQ57AzjysfluhiUoU41lQm0Wtf9WzvPg0rRytKLf
         EyP8fggPr3SU56/lcRgT6oTu7hcBuCH3NN7Qk3qYawPY1IzWP8tzWPrLUADHKbLIJJdX
         xiuc4tMM0v+AwYe6nnFpsGd7fnh3D7JKQD+TeC99jpI45Ho16oyp0F8A0PlRUfeKPj/2
         Nz2VUIwoCF07jjiFIIbhk2QgNXvJ2VNdvPs3tdnjoo3+eBSRPfkDe5r7Lj2u63Am2uQZ
         hQWAPwpe5mI3tps31zFzA7wGHP+NUORUSXEupGdvdUJxbrjCGCyXIibiysWWw4CzRnRs
         cPUA==
X-Gm-Message-State: AOAM533L+ayAdy+pdlIgWrxE6TVP6WR0LrOIb5mwdYaKk73emlJ0H4hl
        gnE0p9ukM5Ti8g7I0vax6dD2FQ==
X-Google-Smtp-Source: ABdhPJyZcNzPY7oSZgbfRV0L4oVL0Cq7qayRlOwUgHLBs/ZmSlLv23W2HflIDnjHC8hp/zh4r/I0DA==
X-Received: by 2002:a62:bd14:0:b029:2de:8bf7:2df8 with SMTP id a20-20020a62bd140000b02902de8bf72df8mr25089236pff.60.1626688354088;
        Mon, 19 Jul 2021 02:52:34 -0700 (PDT)
Received: from anisinha-lenovo ([115.96.137.169])
        by smtp.googlemail.com with ESMTPSA id m18sm19360306pfd.42.2021.07.19.02.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 02:52:33 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <anisinha@anisinha.ca>
Date:   Mon, 19 Jul 2021 15:22:17 +0530 (IST)
X-X-Sender: anisinha@anisinha-lenovo
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Ani Sinha <ani@anisinha.ca>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        anirban.sinha@nokia.com, mikelley@microsoft.com,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: Re: [PATCH v3] checkpatch: add a rule to check general block comment
 style
In-Reply-To: <CAKXUXMyVaQ1CKiLpUAqsj9++H1QoTkP8DmdsHA44ttxOt-ov9Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2107191519070.16360@anisinha-lenovo>
References: <20210714063422.2164699-1-ani@anisinha.ca> <alpine.DEB.2.22.394.2107162145100.3277407@anisinha-lenovo> <CAKXUXMzxyQxYKdnuVbZnUFbYFuKMq+Vc5LxSR-_fKtH2dv-4wA@mail.gmail.com> <alpine.DEB.2.21.2107181853320.55905@ani-ubuntu>
 <c32293fc03a8673ade348ed4451c60dfdf9bb2c1.camel@perches.com> <alpine.DEB.2.22.394.2107191054260.9400@anisinha-lenovo> <CAKXUXMyJ9Ab_Fvpk8WAimEnDjcOhJRe2uODkC=RxCgsN8T0WyQ@mail.gmail.com> <alpine.DEB.2.22.394.2107191221570.12107@anisinha-lenovo>
 <4e42f2580d8b473ac7e25642b039adf73b5efe06.camel@perches.com> <alpine.DEB.2.22.394.2107191324330.14021@anisinha-lenovo> <CAKXUXMyVaQ1CKiLpUAqsj9++H1QoTkP8DmdsHA44ttxOt-ov9Q@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Surely, we need better documentation to point out how to use
> checkpatch, what the reasons for certain rules are, and why some
> simply need to be ignored on certain files. Evaluations and
> contributions are welcome.
>

This has to come from the experienced sr. kernel subsystem maintainers
and checkpatch maintainers so that they can educate us, the novice
contributors, in the right way to use checkpatch and know the rules
associated with it.


