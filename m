Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89663FCD9F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 21:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbhHaTQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 15:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbhHaTQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 15:16:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B42C061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 12:15:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id t19so1079113ejr.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRu3w/aDjbu6nLXcWdhVb0x5w4DgW1rHwaWns4vHGkU=;
        b=GrVqDCWJ47WFtA6A/pcjE82vFKjlsZc9KXICG7aYWtOShZDbJ0baMSf/Dlzk/7vlSI
         0XBAix2NF04DaYHYtpYbMeILbThYSlInegJ90RrRM4zDkW/tTN+FPIF9W/l5y+xT1ew3
         UhGcbua7lKtiqp73fOVxDaKyLsxBXleFr0wDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRu3w/aDjbu6nLXcWdhVb0x5w4DgW1rHwaWns4vHGkU=;
        b=jzqMYxr+QqrEYs1jZExblMf2N5m2J+t7xH2345Da4zebb/DZfiIN6wjpqLFqzNi/yG
         8OFaRTZh1OfNSMlD+bOpKAJdoM5pwsn+SgPWg9JPHRNiiaNoF2Y/kCBVj49NvHmcqs7w
         E1L+U79B9c2thJkLS9ZiAaF6MXfZj1ecZXH6UfpU2mvSy6f65IXTv59rcuWM8lnBqTJj
         V8HvyJi9l47/A1kwfejn5wd4GmFeIIqV3nwiCpdmrHiqvryeVVSitbjyUzbhnvNB5bRO
         saPSuX97rXLaju+xkwa0hOY57FwGM/jpK9jDwDIfWMAvlYR12mrA/GFA1xP821JexSfU
         uWZA==
X-Gm-Message-State: AOAM5333xbvQZPG8lFm6yzvCrGaPASNo/QgzfQFP3ev1Lkw5mNHfteT9
        ZQoKu10Svn8XO3iOTs/dEuAzpevHkWNMKGVon2NfaQ==
X-Google-Smtp-Source: ABdhPJwDXEk0fhlWloCFjxuKx6dWx6wpwmrkENdBVL0IulLdcZuW7RYsFEQG72VCjSxfpqJiUVnqdLeDbkbx/CG//+Q=
X-Received: by 2002:a17:906:5855:: with SMTP id h21mr31467671ejs.230.1630437348629;
 Tue, 31 Aug 2021 12:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <ff60d9aa-28b9-9c6d-f318-94dd51a95abd.ref@schaufler-ca.com> <ff60d9aa-28b9-9c6d-f318-94dd51a95abd@schaufler-ca.com>
In-Reply-To: <ff60d9aa-28b9-9c6d-f318-94dd51a95abd@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Aug 2021 12:15:37 -0700
Message-ID: <CAADWXX9A-6R13VAekvzvWYGcy990nLxcyz1BiZyeBpKHivtCqg@mail.gmail.com>
Subject: Re: [GIT PULL] Smack patches for v5.15
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Austin Kim <austindh.kim@gmail.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 11:53 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Here is the Smack pull request for v5.15.

Hmm. This went into my spambox.

I have no idea why. Everything looks ok as far as I can tell, although
having a SPF record for the originating host might have helped.

It also doesn't look like you are doing anything new wrt your email
setup, even if that yahoo web mail thing might be a bit unusual.

It *might* help to use "git://" instead of "https://" in case some
spam logic thinks web links might be more suspicious, but who knows..

Anyway, I've caught it and marked it not spam, but this is a note to
let you know that something on the internet hates you and your emails.

              Linus
