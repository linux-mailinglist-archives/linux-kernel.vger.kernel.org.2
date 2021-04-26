Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB0F36B745
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhDZQye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhDZQyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:54:32 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF269C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:53:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 12so89034999lfq.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZOH7PFah1PWXd/14EzRlo8hcE9iizBijGoSEnbseXw=;
        b=Mr7MK0P8rHr2htFuXbhOu9prFE5WqTBMM04INyNt7JER5eD/qQL40ikevUYgSw058M
         nlz7rxPG1N94FEM355e/vTEw0f2hwExRMZMST1US1lMlC0Uh8lbQaF8hgp1ABPM1fyLX
         GEwTRfpon43nabUzobQ5+mt3IfkPQ4kJqoSuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZOH7PFah1PWXd/14EzRlo8hcE9iizBijGoSEnbseXw=;
        b=bU/9F5hVZgbHOfu8T83LkJoS906Ug54BtYsiZ0fmwXTcbsp11d4I32HXjwD7cGP/Vu
         +quvf7NdbpZtC6JaHQaMsDgJKJMs8WV1etwXwHtUc/wJWp9Fl7DTtr620k9rwqa/RPK0
         3nxvIj1IkbPz6EavhrmLkQFe2bjHJm6juBB1RRn5Ag3wL+Fq1CxDHrTj2EOEUDgiypOS
         tgqonMu5RGnewxrv3uJKV1I+GPcOxHFCx/v66i2EXIZ8wayKV4RZC+O/r066g8H0mClP
         6cJ469Qmfq/Z+AUkqWYqbarOvkASpQWTTLPA4lH9Rgcg6MHWvfkepnQFYPwAaIglHWoL
         MePA==
X-Gm-Message-State: AOAM530JUcJEiKJUP8CNX5wYYp+qoHn55t2yjkSKwF8e9b6mQ8A3U3V7
        sbRpW98PCaBHPzuqfGYL+n1aM1PF+Dr1VPjs
X-Google-Smtp-Source: ABdhPJyQojG/FrIVKgVORTn/zyIGrF5aHbzyMruLqTE12ZLWzLf6YJWgf/JpsCZ90uvELMKu9iLO+A==
X-Received: by 2002:a05:6512:3d2:: with SMTP id w18mr13442219lfp.573.1619456029246;
        Mon, 26 Apr 2021 09:53:49 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id n13sm1466426lfa.209.2021.04.26.09.53.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 09:53:48 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id d27so32464812lfv.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:53:48 -0700 (PDT)
X-Received: by 2002:a05:6512:3147:: with SMTP id s7mr13117633lfi.41.1619456028267;
 Mon, 26 Apr 2021 09:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <YIaWh9VSEMQnn5E2@zn.tnic> <YIbot8szBpbsSGuw@google.com>
In-Reply-To: <YIbot8szBpbsSGuw@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Apr 2021 09:53:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjc3QVocq_2t24_Sv4DZRvDJdb66YkCJOBz+Ptc+PGJhQ@mail.gmail.com>
Message-ID: <CAHk-=wjc3QVocq_2t24_Sv4DZRvDJdb66YkCJOBz+Ptc+PGJhQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/sgx for v5.13
To:     Sean Christopherson <seanjc@google.com>
Cc:     Borislav Petkov <bp@suse.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 9:22 AM Sean Christopherson <seanjc@google.com> wrote:
>
> This is all host side code, there are no guest specific changes required.  Maybe
> "Add the non-KVM kernel bits for SGX support in KVM guests."

Sadly, this comment came in a couple of minutes after I had already
done the merge, so the updated merge message didn't make it..

                Linus
