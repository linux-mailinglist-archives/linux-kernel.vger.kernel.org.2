Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1283241921D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhI0KVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhI0KVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:21:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4273C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:19:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w19so15332842pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lGc/CzSQycY/xWJ1m4mngd/wcGf436LBm02sP257mfQ=;
        b=qQplR5jS4hN+7PorT/8qNQKzvaxsOVzAfshiYTenTPS6Zul05Sq9g8cEvUXNp+gft6
         x7fAY1qmAAgh2Tm9QYFQaG9no+nVQjbBGlAJQJspyXwmaOKBlBkGHafGmfx1iBHbZbNN
         pzoNUMVxOHb9edoBCHKrDnK9IMsweGTJA+0KBbwXpRtmkIFDrvcFJbfz2VCyrqEhK57P
         7LCejOlhGpTnoIh6qH3q37w8GFUr8zbA3vKXudHVe3cxiVsmycd6Ut1NAstbwp65Tmhr
         7oUs1KWKqE6EW8fFCCdxbqSejthDclT/rUxt2jwJToRfuSfxY80Y0/fRrJdORuQiiiJl
         Bo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lGc/CzSQycY/xWJ1m4mngd/wcGf436LBm02sP257mfQ=;
        b=iB1iYXszirvCqWxqrW19+YTZVNNS3YJtEJEH7FlYi2VdfKO6pYgnt1rAoY6yPoIhg0
         +m+IQY26Crc2YulS7/7y7qa6WGtRbulIhGxbLDx0elPnblNbVgYorOULnYGz7kp3Zcwp
         ssKEQyGUeI7sNWsWQpwMmNIAqITNzO0mGt3BBcdOfpy0RByQwcD9JP74rz8k3iRCw+ib
         f3nnab+qgrjcXa+mOJkeKeS4+IQ/cRLWkPDuiysZvr8EV2rDmMxWvn9+RIfkiEo5xutD
         2sqGYAFkCIAaFsbh7kdOuJ23j8zUSCKL+K8VuUcYtjOfNqDhrhT1VUeJgonjiYFl8tHv
         calg==
X-Gm-Message-State: AOAM531R2E/oCH16gkwFYoV2ospdTjz1fhCWpQPt+ViAr8XZAeSzqT8d
        nW77xwDJUydKwISDSl6x15/ESGqaM8I=
X-Google-Smtp-Source: ABdhPJxtAuU6kacR8G0BiV9fnEl5Mzi54ToWnlElpmacJjRU8brXg9lwvSW5WJwE7Ile5u9a/SJcWQ==
X-Received: by 2002:a65:6a0f:: with SMTP id m15mr1444214pgu.298.1632737982252;
        Mon, 27 Sep 2021 03:19:42 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id g11sm18453073pgn.41.2021.09.27.03.19.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 03:19:41 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH] userfaultfd: support control over mm of remote PIDs
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <83827672-0996-4c25-9991-697ad443b6b3@redhat.com>
Date:   Mon, 27 Sep 2021 03:19:40 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <A7E15D2B-FFED-4F21-88F4-227E7228782D@gmail.com>
References: <20210926170637.245699-1-namit@vmware.com>
 <83827672-0996-4c25-9991-697ad443b6b3@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 27, 2021, at 2:29 AM, David Hildenbrand <david@redhat.com> wrote:
> 
> On 26.09.21 19:06, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>> Non-cooperative mode is useful but only for forked processes.
>> Userfaultfd can be useful to monitor, debug and manage memory of remote
>> processes.
>> To support this mode, add a new flag, UFFD_REMOTE_PID, and an optional
>> second argument to the userfaultfd syscall. When the flag is set, the
>> second argument is assumed to be the PID of the process that is to be
>> monitored. Otherwise the flag is ignored.
>> The syscall enforces that the caller has CAP_SYS_PTRACE to prevent
>> misuse of this feature.
> 
> What supposed to happen if the target process intents to use uffd itself?

Thanks for the quick response.

First, sorry that I mistakenly dropped the changes to userfaultfd.h
that define UFFD_REMOTE_PID.

As for your question: there are standard ways to deal with such cases,
similarly to when a debugged program wants to use PTRACE. One way is
to block the userfaultfd syscall, using seccomp. Another way is to do
chaining using ptrace (although using ptrace for anything is
challenging).

It is also possible to add tailor something specific to userfaultfd,
but I think seccomp is a good enough solution. I am open to suggestions.

