Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7691832AE0B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360424AbhCBWUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381629AbhCBVKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:10:50 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D98C0698DF
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 13:02:59 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id e3so10632620pfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 13:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=CB9dY4Lo/FVVsXfU2ohXWUZuVD42ULjyGl9o+tMY6Y8=;
        b=kEn/jTaFtVpFmfCrT7bL4yxMKEL+7/DDc3lsEo5QR+j1n1aCc8f0qujpo0FciT082V
         cmrgOfKTnFLcR9EFh9f0nrroavyJTTeufrRwJidYhJRhmEpKuV78c4BdGQPbXBSC5eK4
         Y5RDspp1l2iVsMqFgSUW7tjeTU0ldBS1jRmNgi1e/PfVqXmMqr+gxEjIGYwukVqTkwEX
         C+2R6FhS9KFt4p/FRw1GL2lgjAdauN/ww9vSNVVgN6/MReGuo0HKLQMeYSyVm6upjzw1
         RiLpJxexbc3CbRSRTU9sAjYah8W3YHb9iheXKfYij/OUvu887kndLu+gFVqv8ljjM/WR
         R07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=CB9dY4Lo/FVVsXfU2ohXWUZuVD42ULjyGl9o+tMY6Y8=;
        b=iU9xlkqhTcKuVwRiA51SDwkByz/tiQj7ezGcasKKeOd46hLV56l8dqbmzWvDYPGes4
         TUQ+l6TYpGewA5p9E7XfrR7vpFas69+HMNjqIBqaFiheIBKL4ZvLRVD0PrqJwLygd8kL
         Z4bXoM8dWv6Zcmi9WklN5JiolC2cTQhZqvoES80GZD9Dv/9jmjXg3jxD0C3VY+DepoLc
         IWw9psAclakCJ7jvCyxYiKP9lkSqE3icMAEZcOoutl7LK3rX3uQqcQ5/MkzsrOwRnqka
         zTMM4oGkqbvrmVwv+wN1tuSswfXFdR1bOAfU2RD8Cb1BbQl6rHpxnAMAadcjtIzmBRdi
         V2KQ==
X-Gm-Message-State: AOAM531EWFvnCZ7bl9jZ7T5ovAwlikbsO000zwylDuenUw2WpXSS11Wz
        IkxA3Z5XCBGKdEUm14e9yMi4uA==
X-Google-Smtp-Source: ABdhPJygZuY9KaqkU4K9gLXIZ9wSlUe7qlBkMj13Bu2eXTZp5/3vDnvFlNMTXcuIUbq2VLW6J4hP5w==
X-Received: by 2002:a63:fb11:: with SMTP id o17mr19763253pgh.282.1614718979407;
        Tue, 02 Mar 2021 13:02:59 -0800 (PST)
Received: from ?IPv6:2600:1010:b02b:fd90:e1d3:88b3:9a99:4873? ([2600:1010:b02b:fd90:e1d3:88b3:9a99:4873])
        by smtp.gmail.com with ESMTPSA id c29sm20427129pgb.58.2021.03.02.13.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 13:02:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Why do kprobes and uprobes singlestep?
Date:   Tue, 2 Mar 2021 13:02:57 -0800
Message-Id: <EECBE373-7CA1-4ED8-9F03-406BBED607FD@amacapital.net>
References: <CAADnVQ+czV6u4CM-A+o5U+WhApkocunZXiCMJBB_Zbs0mvNSwQ@mail.gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, bpf <bpf@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <CAADnVQ+czV6u4CM-A+o5U+WhApkocunZXiCMJBB_Zbs0mvNSwQ@mail.gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 2, 2021, at 12:24 PM, Alexei Starovoitov <alexei.starovoitov@gmail.=
com> wrote:
>=20
> =EF=BB=BFOn Tue, Mar 2, 2021 at 10:38 AM Andy Lutomirski <luto@kernel.org>=
 wrote:
>>=20
>> Is there something like a uprobe test suite?  How maintained /
>> actively used is uprobe?
>=20
> uprobe+bpf is heavily used in production.
> selftests/bpf has only one test for it though.
>=20
> Why are you asking?

Because the integration with the x86 entry code is a mess, and I want to kno=
w whether to mark it BROKEN or how to make sure the any cleanups actually wo=
rk.=
