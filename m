Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DF5403CB8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349875AbhIHPpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239842AbhIHPpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:45:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD31C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 08:44:07 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lc21so5094559ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 08:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dfWXvWVLK8PdqGgfjMJG/VOHk/WvJvkwHokilz/Z9eU=;
        b=jO73f3thXMB7AZin2T5yH9rpAhsyE29kDnwH4pVjD7xZreIbZ2oa2UCbfcohBNzPA9
         GeT9bHHYS/oq++md1OSactXXPvJfF3071PwlKPanhooOtizBBhjd2TZE8m/T3ImbdYk5
         P9F9Ky1394KQ4+rnV9G6OkW8gOMJKoFqwnF7I7476cvnvELWevR4h25bXkQEGTfm+42j
         nQ7sr9IVCVmrq0+o6216tb0/3HMZPmgcxGPPi14h3n9y6qvXXsTAgcfFoFx2t3SYXqzA
         LLsyX6dE6hpbtxXm7DD5lkrFvNdTDpadkNlAOgKVhK9mLH7AYOYdarNzLAngPJF0nUBV
         EXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=dfWXvWVLK8PdqGgfjMJG/VOHk/WvJvkwHokilz/Z9eU=;
        b=gBTaXTBhgi2PgjTMqE9PjlPCM2u44Mj/U3P2ssjO29QAAPBlYzruq3RFMQgdYQ+n1h
         W6x52mjtJptWeb8baNASVe7iawbqm3accYPW11H0NbV0ACjwbUqrfwZjJai61iS0mVLC
         JGTwB/rQky+V0d2NNDJqKZP0Nwmy/tfJXJvp4ijPAeBc0X+pgksfEqnbOVDl7sANlGHE
         rO53wCvPeFOe8SyqWXmngLcVBugiT/vkJoR6gyj9iW4brxzXrNabUKDWOVh1+nghBaDW
         hN3v0yfdBcUpzVv3ntD8Qul2DsKUaOY4QuVdRWBdhMpKvI/PMKR4jYRQmrahBj9KBd48
         vEEg==
X-Gm-Message-State: AOAM531p37tG1waWDRNkV+pCdE+XaawMGKAj9z0BcHCRHd9BGfu72hUl
        b6AV85RYbOIu4heoMcgLWfQR5L5E3WugdXAgQgI=
X-Google-Smtp-Source: ABdhPJxXJk7kZ6CdBoMwGfxvVWpS2LblgIXVYZ93aRDM+MUEt2okEyOq62OkpMibzdW6tBRMSlFeAl5gDnJABT87FxQ=
X-Received: by 2002:a17:906:3fd7:: with SMTP id k23mr518093ejj.176.1631115845345;
 Wed, 08 Sep 2021 08:44:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:2643:0:0:0:0:0 with HTTP; Wed, 8 Sep 2021 08:44:04 -0700 (PDT)
Reply-To: michaelrachid7@gmail.com
From:   Michael Rachid <lopdylan1818@gmail.com>
Date:   Wed, 8 Sep 2021 16:44:04 +0100
Message-ID: <CABU9XdCpc4FD_t_S65HOmxkp02+23mD8buBJo5qGNpXhLKYD=A@mail.gmail.com>
Subject: =?UTF-8?B?UFJPUE9TQUwv4LiC4LmJ4Lit4LmA4Liq4LiZ4LitIEvMhMSleCBzzIRlbng=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4LmA4Lie4Li34LmI4Lit4LiZ4Lij4Lix4LiBLA0KDQrguInguLHguJnguYDguILguLXguKLguJng
uYDguJ7guLfguYjguK3guYHguIjguYnguIfguYPguKvguYnguITguLjguJPguJfguKPguLLguJrg
uYDguIHguLXguYjguKLguKfguIHguLHguJrguILguYnguK3guYDguKrguJnguK3guJfguLLguIfg
uJjguLjguKPguIHguLTguIjguJfguLXguYjguInguLHguJnguKHguLXguIvguLbguYjguIfguIng
uLHguJnguJXguYnguK3guIfguIHguLLguKPguIjguLHguJTguIHguLLguKPguIHguLHguJrguITg
uLjguJMNCuC4q+C5ieC4suC4quC4tOC4muC4peC5ieC4suC4meC4lOC4reC4peC4peC4suC4o+C5
jOC4oeC4teC4quC5iOC4p+C4meC4o+C5iOC4p+C4oSDguKHguLHguYjguJnguYPguIjguYTguJTg
uYnguKfguYjguLLguJfguLjguIHguK3guKLguYjguLLguIfguJbguLnguIHguIHguI7guKvguKHg
uLLguKLguYHguKXguLDguJvguKPguLLguKjguIjguLLguIHguITguKfguLLguKHguYDguKrguLXg
uYjguKLguIcNCuC4geC4o+C4uOC4k+C4suC4o+C4sOC4muC4uOC4hOC4p+C4suC4oeC4quC4meC5
g+C4iOC4guC4reC4h+C4hOC4uOC4kw0KDQrguYTguKHguYDguITguLTguKUg4Lij4Liy4LiK4Li0
4LiULg0KDQpQaGXhu6XMhMyAeG4gcuG6oWssDQoNCmPMhGjhuqFuIGvMhGhlxKt5biBwaGXhu6XM
hMyAeCBjw6bMgm5nIGjMhMSxzIIga2h14bmHIHRocsSBYiBrZcSrzIB5dyBr4bqhYiBrzITEpXgg
c8yEZW54DQp0aMSBbmcg4bmtaHVya2ljIHRoxKvMgCBjzIRo4bqhbiBtxKsgc+G7pcyAbmcgY8yE
aOG6oW4gdMyCeG5na8SBciBj4bqhZGvEgXIga+G6oWIga2h14bmHDQpozITMgsSBIHPMhGliIGzM
gsSBbiBkeGxsxIFyzJIgbcSrIHPMhMyAd24gcsyAd20gbeG6ocyAbmPEsSBk4buLzIIg4bqBxIEg
dGh1ayB44buzxIFuZyB0zIRoxatrDQpr4biNaMyEbcSBeSBsw6ZhIHByxIHhuaPMhGPEgWsga2h3
xIFtIHPMhGXEq8yAeW5nDQprcnXhuYfEgSByYWJ1IGtod8SBbSBzzIRuY8SxIGvMhGh4bmcga2h1
4bmHDQoNCm3hu4traGVpbCByxIEgY2hpZC4NCg0KDQoNCg0KRGVhciBmcmllbmQsDQoNCkkgd3Jp
dGUgdG8gaW5mb3JtIHlvdSBhYm91dCBhIGJ1c2luZXNzIHByb3Bvc2FsIEkgaGF2ZSB3aGljaCBJ
IHdvdWxkDQpsaWtlIHRvIGhhbmRsZSB3aXRoIHlvdS4NCkZpZnR5IG1pbGxpb24gZG9sbGFycyBp
cyBpbnZvbHZlZC4gQmUgcmVzdCBhc3N1cmVkIHRoYXQgZXZlcnl0aGluZyBpcw0KbGVnYWwgYW5k
IHJpc2sgZnJlZS4NCktpbmRseSBpbmRpY2F0ZSB5b3VyIGludGVyZXN0Lg0KDQpNaWNoYWVsIFJh
Y2hpZA0K
