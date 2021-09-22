Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C6A4153A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 00:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbhIVW5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 18:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbhIVW5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 18:57:43 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F15C061574;
        Wed, 22 Sep 2021 15:56:12 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id h129so5699058iof.1;
        Wed, 22 Sep 2021 15:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=96YsYSvOqcqMmdbkGK6esaNScO63CdNrDersXGEKflo=;
        b=bRWcXic99Hg/Ol4nFnjEKHUYZxT3TGnmVtixjQMxKMKSHdT9XzMjEY3fw8EWBGMQiX
         mAxIerMfBlRASfVTD6Q6gmU6QDJupo8aPf2yutAOtLvzikfbZlhBxuQCcwX3WpCwcFdq
         tFS3YlV6xsWyX7qNPxRh+fatPT1lXrFZ2wohGdV0/HLUI80VsVGM6jDsP5EWxzhFbqSR
         QCtWXWNfDg+c2PW9bVzmBoQFUWXuwvouZ0mqaCF/OwLduLvsJgZFk3pswHMcnGKoyoaz
         xIB9H7A+JmSgaYIqTsL/2Lb34At73BxFaI1q/T3WneFnV3EqkJouvqip1av7zTe/AZQ6
         VXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=96YsYSvOqcqMmdbkGK6esaNScO63CdNrDersXGEKflo=;
        b=KjXwvvLWDGr1OOoIMDywvALJy1xOh3Cs3oNZSbV6fTvD5CPksOhBCkAstEzl7maNqw
         uPLp0ArkFstlTNQ616RlNi8sDeGHEyUGk7sFsVprbRK0Y6VMyLX6DvTsbpqjQA7KBtqG
         tw+gyNoMqFDSiaW0PPSHrvLyhlDnMpp1jD5qsgSaf6N/5o0vgJcB+hCafkznvB8ptgYX
         pMr7CBbJNYVr6HHrLUFJGT3qCB5HQHa7LRwFBrcheZ87YHv60fInFseek2JXOHGQfBDD
         vW515M7C+LHSUWq687JTu3Bt7MALwtVu0ErQlWedWv1w7u+3XAw7rBsUgArkdw9L0+9W
         Y5og==
X-Gm-Message-State: AOAM530/IO4wD/ICPq8IYEqn9CPukXvPdzdL/H2Mqeq/ZkpIXn+IlRXz
        4Rc98ofb8gUW6mx7OVFTZ4gY32waadyUkJ5sphV2uC0f62j8TY1e
X-Google-Smtp-Source: ABdhPJy/ifz+iSycXFjjUeay1s5vEQtHpUoMwHwQRld+Txk8YCSf9ru6HNUGnGOKanienayMK0TtgYGSL16CP62BAbQ=
X-Received: by 2002:a05:6638:d89:: with SMTP id l9mr1308034jaj.46.1632351371845;
 Wed, 22 Sep 2021 15:56:11 -0700 (PDT)
MIME-Version: 1.0
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 23 Sep 2021 00:56:01 +0200
Message-ID: <CANiq72mPu4c5AY5AoiUY3jsmhRX+3EX61NRRnGiR+L2gBn9sZw@mail.gmail.com>
Subject: Rust discussion round in LPC hackroom
To:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

As suggested on Monday, now that most of the related talks are done,
it may be a good idea to have a discussion round in a LPC hackroom to
hear what everyone has to say about Rust, get in touch with other
interested people, discuss maintenance concerns, etc.

I think the best time is tomorrow after the close of the scheduled
sessions to avoid conflicts, i.e. about 18:00 UTC, in Hackroom 4.
Everyone is invited!

Cheers,
Miguel
