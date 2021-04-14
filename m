Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A8335F49F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351218AbhDNNOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:14:49 -0400
Received: from mail-02.mail-europe.com ([51.89.119.103]:52738 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351219AbhDNNOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:14:46 -0400
Date:   Wed, 14 Apr 2021 13:14:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1618406058;
        bh=olHYGD/+qRRBrTz0M5cjLhZvmOSg8gRLp8qgu6mqBUg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=XfstOvvPZaa9f0+b//efUhV34hF7JRAVXZD53rs91xLLtmVJpdwx8zRjhN1l2yQ4e
         nkO8E108rZtJPqKZdWh8cuzA9SKwChKdrn+ubayQsfrvG8xG6H4ZsZ5j7rPpJ+lD+x
         O6H7kAnUwONJ1queKtOcNcd9lyML5PvezXJgeCeI=
To:     Thorsten Leemhuis <linux@leemhuis.info>
From:   w4v3 <vv4v3@protonmail.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Reply-To: w4v3 <vv4v3@protonmail.com>
Subject: Re: "Reporting issues" document feedback
Message-ID: <wqM80O49houE3ZJHpxjcrNxijZ_h9pMjxZU2OCL-ZpsdwMhIVFcGXZb9qe93r2AY0qd0dB-94ZVQaF-Xb-i-zqX5DIO5S4C6UTBpVkxvszA=@protonmail.com>
In-Reply-To: <dff6badf-58f5-98c8-871c-94d901ac6919@leemhuis.info>
References: <vaWPnw1Txo_MD5Sf-BnMmq3pBTkITza0W5p_jAi8JIy3hBAbCsKPXZ5g5IHKYGqK6zLjzUNgJ59xMCHvhREBUq6Vc1105b8yCIVDgaPABqE=@protonmail.com> <dff6badf-58f5-98c8-871c-94d901ac6919@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

Thanks for the quick and illuminating response :)

> Links to your bug report and the thread on the mailing list would have
> helped here to understand better what's going on, but whatever, they are
> not that important.

Here you go: https://bugzilla.kernel.org/show_bug.cgi?id=3D212643
https://marc.info/?l=3Dlinux-acpi&m=3D161824910030600&w=3D2

> But it should, otherwise the subsystem should remove the line starting
> with B: ("bugs:" in the webview).
>
> Rafael might be able to clarify things.
>
> But afais it's appropriate there is a B: line: just a few weeks ago I
> took a quick look at bugzilla and ACPI bugs in particular, and back then
> most of the bug reports there got handled by the maintainers. That's why
> I assume you were just unlucky and your report fall through the cracks
> (but obviously I might be wrong here). And maybe your report even did
> help: the developer that fixed the issue might have seen both the bug
> entry and the mailed report, but simply forget to close the former.

Good to know. It does seem like many recent ACPI bug reports on bugzilla
have been processed by maintainers. Maybe it is the ACPI-subcomponent I
chose for the bug: in Config-Tables, only two other bugs were submitted
and they did not attract comments. Anyways, I understand now that it's
not an issue with the document so thanks for forwarding it to Rafael.

> But your mail showed me that indeed there is one aspect that
> reporting-issues currently does not cover: in cases like yours reporters
> are better off checking both the mailing list archives and the bug
> tracker before reporting a bug.

Certainly: currently, it says
    Search the archives of the bug tracker or mailing list in question ...
but it is probably a good idea to suggest always searching both.

Have a nice day too
Patrick

