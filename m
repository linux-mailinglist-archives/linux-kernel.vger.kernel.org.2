Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB88733FFEB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 07:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhCRGwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 02:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhCRGva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:51:30 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDBEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 23:51:30 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id 97so1589217uav.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 23:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nyRCCcxSvFOphW42Gy/nyFFxvC6MdkCLTfkHRSJWJwQ=;
        b=bb5Jpl8pBWSd35DqcK24VxKj9zIM7icFQICOGVBVk3oaXPEeI0STBx0BtcABDWOMOJ
         90VV8mr8aguM4DTcfMq35C9wC5+h7sRt7cnJaMt2wqsBKgHqS/x7/xaQliURpTA5yvK2
         WqY+mayvtNcsUA4mLC2L98RnhCxUeMj6xK7f7msnco5EUAlMi3hlMSoBgtpPKUy8GKTG
         e/KMO8DGqV1YQluVM2sFigCbMzDi1iSVfXiXM2keH8mZwsEAaO0VwMUBUII4AGavXwzO
         MNqwTyIw/su0yUPM2Exz3lKOPxttEEC+hLRPwBoERuSiyYT/+6MbJM4qaNu+7/ivEydi
         WP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nyRCCcxSvFOphW42Gy/nyFFxvC6MdkCLTfkHRSJWJwQ=;
        b=ALyqgkAHDw7UZkRZGqg/F8Z8FfUuA+y7L8jcTckY+hr5xL2kmbuGKCbLGkKgo2TyTr
         Cc0ZVDpUj1tEH0JRyEzo0QWeNQCo8x6cj1GbY4lmM0N+nPH2I9X9/7MKTmUIkGVml3nn
         Fbu9D9/RtwopkFSgS2MhjrhUfO8fZtpTZs44RK8ksdfHNapbVRJAttcS6Qd6V2lfkdW+
         yCdujQzp+fsST/fQvMPjR53dlMI8pBc/0pB9H+Hu08xip5HS9YvsqHRb/oSOir66XHgv
         WMKVC82qqLaBWXZWrfDTN/L3Gwn2HOjv+jdGcMOtVc3NOQPQtJII+i+r19c5GzJAHW5a
         wA5A==
X-Gm-Message-State: AOAM530Xzd03DJDcqZ/9OTrzgnoQsVGQiQtD1swOVEwACYM6U6PyXVps
        7hWExnMHI/ee/WTt4KnOiYmR6qDK2zLnd2QwYF+wiH1DtKD7HA==
X-Google-Smtp-Source: ABdhPJycd4H2PC8TW/X+3ThrVU2P83VbsAEXhuA+u5OL2CuumGsXcw83wwtFz9mcJ1l3U2PyMjjKtj6RjhTn4VWJ4Vk=
X-Received: by 2002:ab0:608a:: with SMTP id i10mr1343990ual.26.1616050289273;
 Wed, 17 Mar 2021 23:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAPncsNOFoUt7uEDEdihDTZY4pJsuPxt146W-L+Ju53SgZ6ezYw@mail.gmail.com>
 <CAPncsNMWCim1kozMyJaT7_suEnWyGadf1Kg1fzjyWfdGDVMZ3A@mail.gmail.com> <CAPncsNOpMhn=N+9+uC8hx0shRE-5uhvHCmZKJ8X3=aAeja1sag@mail.gmail.com>
In-Reply-To: <CAPncsNOpMhn=N+9+uC8hx0shRE-5uhvHCmZKJ8X3=aAeja1sag@mail.gmail.com>
From:   Jarvis Jiang <jarvis.w.jiang@gmail.com>
Date:   Thu, 18 Mar 2021 14:51:17 +0800
Message-ID: <CAPncsNN05T7WyDnANAis_SeOPfC3vc8WaZa1igVBk8FrB9skWw@mail.gmail.com>
Subject: Re:
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jarvis.w.jiang@gmail.com

On Thu, Mar 18, 2021 at 2:49 PM Jarvis Jiang <jarvis.w.jiang@gmail.com> wrote:
> subscribe linex-kernel jarvis.w.jiang@gmail.com
