Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088C144A9C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 09:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244582AbhKII7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 03:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236483AbhKII7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:59:02 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763D8C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 00:56:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d3so31645213wrh.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 00:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hDxc4ORTBbluxxeIIeFMi6TZfMeVfC09o6eJqDhW6Y=;
        b=0KV7+HspyaS3g9zMUH7QkJFoaINFWkKQEXKTAmysFQs4K/Q7hiwfgIRcWRlI3w6Bik
         JaWassP3CHaxn5gcid1HAzTxWzMRo0QZ4+O392zq13ZkI6+GJLlMKmY421Qp98XUBUBy
         75a6Fi0jjlsrSgjvx1dt4H1S+OKBWnnzd4RbYrqVJxKLjXOwpmpa2bWzupDjAnBhXZOX
         tG16LdsSuHC9KfnXTLhbD97YPW0yFzxBsHUGbykaRryttMp6JPnYyt/6xLzEQIe2k8YN
         rC9bg+SGFCRj3xUZR6SEFlNYaQViv68c/HUPQtLcIo0JZQ/xQE9UBWsz6jPKoNIBehbm
         //jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hDxc4ORTBbluxxeIIeFMi6TZfMeVfC09o6eJqDhW6Y=;
        b=w24AOyuCW6e6hir7r65YPczhHZfS5nfWLZ2SVrGIX2StwH5CX9iEE2egpJGyz9Gz77
         4DKAt7c3Vjua6tGhny544FdFfIuKv3AL+mScHqAH3L7xptU/a+aGGXmhvPhxp22sZ/op
         qsL/r0u+JIMzxo4TN3OaCmwMnGwgrNniH+pKB2JsnfK5znFWtjIGpoTfFcEgYniN7b38
         N4AZoLJuqCOmDV4IBMbN+SQvN4pXQC84U/yh1yzrH4GYd5bGZYj0iA37bCSh9fcmMCRH
         KaGNOE6WCgIwpMhSzeFbBi5zGTmOyXefGVcf94YiQrC0fF/RrCd+MJI/jDLPf4WuwsWy
         hVhg==
X-Gm-Message-State: AOAM533oVaSaQTzecyYIxqJe5u4Ec5+5SzIHrDysFxOPelqfrzgzwGlm
        S/71OdGCvrG1OlJZ+ZFN7LqBdKwSkN7lR21nUig9WA==
X-Google-Smtp-Source: ABdhPJxjQyapcmQOZoeGUdSh2ePTETHsHN9v6j2of8gpdEiuV82Z+REWYGnGHSZ8XIcfUkLElR/+U/Hs0YR3DIMNzAQ=
X-Received: by 2002:adf:eece:: with SMTP id a14mr7232192wrp.333.1636448175103;
 Tue, 09 Nov 2021 00:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
 <YYoSPjF3M05dR0PX@kroah.com> <42cea157-55a2-bd12-335b-6348f0ff6525@immu.ne>
In-Reply-To: <42cea157-55a2-bd12-335b-6348f0ff6525@immu.ne>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Date:   Tue, 9 Nov 2021 09:56:03 +0100
Message-ID: <CAHifhD70EEqmwJtZ1dc8=Nd0bknmN9FeYk+z5+ZRJ0gOUMooag@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am really sorry I forgot the link for [1] in my last mail.

[1] https://lkml.org/lkml/2021/6/23/433
