Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018AC455BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344807AbhKRMtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344779AbhKRMtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:49:40 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7AFC061570;
        Thu, 18 Nov 2021 04:46:40 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso10706289ots.6;
        Thu, 18 Nov 2021 04:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDy1jFSdSdEX9dk2+PJhg/eseApJ7w84/Y/oAH27zQA=;
        b=dgkWRvbzUNdw83L0KkR2a6ISJEKEbw3Hw10sZfoomU4jo0yXRSL6vil2PC2uGdD0e1
         X71MEBmzvP3KHi/OmjHZQPqpwbreWVvHuGGz0EmwSgk9wBccdGdt3SgWi6tXL1b5AxKQ
         1Ie+z7Hwn0CeHu+vBlBEgHEfmU8jZgWfQ0fiIPZ+SDcoKGkBwej/p7ah0XX1cAb9bNr2
         iDFSAtfJTc9rjGu2r5U0i+hJW1hnrqqskf8P5MWOMXcxHdXyR7GfK2Ky3p3HtVxgIU8F
         VYyAB5AqOqF1JAXRPlJNhhg5xNzMNvof5li9cAjkY1EaEcSxDonlki9T5/RWne0C+hbQ
         FcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDy1jFSdSdEX9dk2+PJhg/eseApJ7w84/Y/oAH27zQA=;
        b=ELZu/8PpgpPbixCPRWnqHPa+yDTqHQOyEj4AAlJNwA/7nmpXmgW19KrzgLEsRK9afM
         CrkKkHH9ql2YcdtH/l7HPaV10fz/KxqXRZ8/XrIGlEZd91PTSC2PtBQHo5Gzuw2KtiLo
         HZh5m4Bs84xTAacAsk7hbaTYT0HiZ3PgI60ZBa3szhywu2uHRfZ3vHfqZdVSPgvYRKBy
         O8xx+rKRodyuOTwlTjrMKOEs4ixAK46YliKBHMXCWzwR9wnSdkGjIjPWnGRul3HB3oa2
         +B5WgMo/Euw6WhSsGlydrZzIBCwM1F8w/SRDiq8kODDdMlxHq+MIFvALXecMLyel8QUA
         Y40Q==
X-Gm-Message-State: AOAM5306fvc3JwgRb9qC9DjPsHQHZE9vUmR9tuVTHOHZqz256m8WP4TO
        Y/j29HXKg35KeCuwmTl519w+wkAP+v2/5UG2x2a78DW9I9A=
X-Google-Smtp-Source: ABdhPJyXU/MWDnNIlJR8UXymAiR1xubiZGzZ5xsU4aco1Q3a5GCh3CBfWZ/6H3C964FlppmLELSDzxToKwjpiTanub4=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr21115817otq.173.1637239600023;
 Thu, 18 Nov 2021 04:46:40 -0800 (PST)
MIME-Version: 1.0
References: <CAHP4M8UvwsS6QpV6PX-qf=d2u9Qw35Hafv-BTMGUWeSc0nUBXA@mail.gmail.com>
 <CAHP4M8V4ow_JUj9gjcrZoyFtnTcqngHqiD2da-v-w4VZ2WL1hg@mail.gmail.com> <20211117154036.GC172151@rowland.harvard.edu>
In-Reply-To: <20211117154036.GC172151@rowland.harvard.edu>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Thu, 18 Nov 2021 18:16:27 +0530
Message-ID: <CAHP4M8V-wCuDPyhsuefSDCRAS6XzA74tY1naGHqA=X6xTpFeoA@mail.gmail.com>
Subject: Re: Mouse stops working at random intervals in latest kernel
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alan for your time.

> Going just by your description and the log contents, it sounds like the
> wireless dongle's firmware is crashing.  Or possibly something has gone
> wrong with the motherboard's on-board "rate-matching" hub.
>
> To rule out software issues, you could try running an earlier kernel
> version.  If that doesn't show any problems then you may want to perform
> a git bisection.
>
> As far as I know there have been no recent changes to ehci-hcd or
> ehci-pci that could cause this to happen.
>

Thanks for the update, this would help me in narrowing down things.


Thanks and Regards,
Ajay
