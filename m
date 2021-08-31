Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF65C3FC26C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbhHaGEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbhHaGE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:04:27 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E42C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 23:03:33 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so21400888otg.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 23:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=RzIkdEm5aJl66a3p0t6hmEQ+Qv+8MFJLxj5JlLxnEbs=;
        b=R4oPerrcHKCim2QGI7q4uTaMlXFTXSsbE4KoKsMHK7QzqM3lIcaBiMt9rhCOkzg5gF
         1+iSJ/0r5aiUTawmCpv9o9kp0/nANFTGdVzj3UyiHklrKq3tXx4FC1bKlH+kX8Kg8ki8
         +67JtsxXkmk8J8BzYPsxQaG3ZOhgd5k+O+UWbgKDNaV/pLkSy5/m4+RJO78d8EXlzkrV
         BrBh0X1HKCH58H3dRObz2ZpdfNlMSaA3wiH60+8V58k8urgyeBlWEoLsynXVeFWwMXv2
         t4R18UdLXhDc51CNhQd5qb5YyBEDbhR76qV8Fcaxn3moD+Yx1+mIlQgryfJ2Q/hlyrTT
         M6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=RzIkdEm5aJl66a3p0t6hmEQ+Qv+8MFJLxj5JlLxnEbs=;
        b=B5yI0+taJcMxNLZq9LM0oQQh0nulgU85QOQ4tkjLB8XHDQ5jAxfGhaxfaeWSRZCMOz
         a61W7roWy2bSO/J47SqNLL84n11dZ0uYd8MZfiolDtH5Ut8Kjzr5hHz7uo+NhQDlPkVf
         pHvRAl7I5TpyCJ5MarsmSeXUjo7owEvChpTg1/ZWCB4jrkpQpz9eedB7Sk5IjRudCYyX
         sD1jTYzdOZnVTNejF8v5R0AGi8cYZnWu5+WMbTClXOw2pRFOOp6kDrYOcaqo99DzBmqU
         Bc+rjVmKh213b5fU0b3RiKg4n7cuLiwVwRQKYLS+VkkAZgtfRR3fIE7vZNJn1kUTv0ex
         hrOA==
X-Gm-Message-State: AOAM532ncQuoMmTUhVlejQ2kD94qxb2Jvdmu4DcX7Wpd3hRs8AilstuS
        aC72/Yf7+huVgz3+knjWAjANyI3IZ3wpN8/SHxY=
X-Google-Smtp-Source: ABdhPJx5R/mRs9TwMdFd3fG7/dOySUGFYjViqGjuh/13TSHRKrzXA/f2nEvZxjPxh08a7vHunU+okNUSQ3S0q5nvZP4=
X-Received: by 2002:a05:6830:13d4:: with SMTP id e20mr22633028otq.218.1630389812350;
 Mon, 30 Aug 2021 23:03:32 -0700 (PDT)
MIME-Version: 1.0
Reply-To: godwinppter@gmail.com
Sender: godwinpeter219@gmail.com
Received: by 2002:ac9:7156:0:0:0:0:0 with HTTP; Mon, 30 Aug 2021 23:03:31
 -0700 (PDT)
From:   Godwin Pete <godwinnpeter@gmail.com>
Date:   Tue, 31 Aug 2021 08:03:31 +0200
X-Google-Sender-Auth: kJ3MnGn4796QVWs637FRxwQGgK0
Message-ID: <CA+8O8-d8m0q+kdoWJBZf3QpZUWSE=Fsi6NQ=8BJFLPUfor0-_A@mail.gmail.com>
Subject: I just want to furnish you with this good news
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just want to use this little opportunity to inform you about my
success towards the transfer. I'm currently out of the country for an
investment with part of my share, after completing the transfer with
an Indian business man. But i will visit your country, next year.
After the completion of my project. Please, contact my secretary to
send you the (ATM) card which I've already credited with the sum of
($500,000.00). Just contact her to help you in receiving the (ATM)
card. I've explained everything to her before my trip. This is what I
can do for you because, you couldn't help in the transfer, but for the
fact that you're the person whom I've contacted initially, for the
transfer. I decided to give this ($500,000.00) as a compensation for
being contacted initially for the transfer. I always try to make the
difference, in dealing with people any time I come in contact with
them. I'm also trying to show that I'm quite a different person from
others whose may have a different purpose within them. I believe that
you will render some help to me when I, will visit your country, for
another investment there. So contact my secretary for the card, Her
contact are as follows,

Full name: Mrs, Jovita Dumuije,
Country: Burkina Faso
Email: jovitadumuije@gmail.com

Thanks, and hope for a good corporation with you in future.

Godwin Peter,
