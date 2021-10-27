Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D539843C4DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240897AbhJ0IQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240838AbhJ0IQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:16:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB56C0613B9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 01:13:58 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n18so1471056plc.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Ft1XPxFVIbWJTs4Ecpf/2qUoKof8ssQDsFByWw2TlxA=;
        b=b+TWZuMA3dQsZIvTqQlQzEzzGSp7Z8UP80iKDVUP3dPYfXh+xfxCfsIJx7ibBZvLWa
         6aEqHSo5ZztXCeHBtl0Hux+FMfSTpe3pBUhrhoZ2uGxzb0L+3KiwDh40zCYkKkj1wfbe
         loKf6Ez4dD0WM699a9enAQO5yTXfqU4OoQlSbwHtyrlzNmNvNRtZ1wAqPaD08hZYch9P
         KgLoOoWWvUTpBdbM/4Y9n3e4iKEpPfj/dpE9idriu7bzd4c/2uQAqGeCyNJty1iKvffp
         Y8GqU7D04BxbjHHDEsDiNIfjd7wKy+jHKzSESIFfNjIiJO4pWqcU1gR6IW2WzrMJhH+B
         FWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Ft1XPxFVIbWJTs4Ecpf/2qUoKof8ssQDsFByWw2TlxA=;
        b=YGv+uymzHd5sx63uQ4yPQQMngfzG4gZz/uO1hD4yP7uOx8BVkyGPfraUUgE9CovUdZ
         ULX8nE1dXl7bRReX498pvlyIXjPxyHstyVwp3G0m5qDrd42aB+sHVdbhTFhmcsylmnmW
         tnloDtK8OnGePn3J7icyH+3UD79uy6LUF0p74aVFUBtZxAyUXoo6qwHcqD5JND2BjNCx
         OL6w8y/3ZFu3YqMOucHFydplOeOdKNYxFXp9x3VzH9ysLePP8250Aijdqt4ersNQVmaA
         j9/O2NtYTzCPHHR51hy+NXkuLk5d+Xnqs5eI9vpUEIpTUnd4A7JGiSZ50DzcXlbIKK3B
         xHBw==
X-Gm-Message-State: AOAM530/qVzaOpEYL5HTOdIchVJ1DzoNLWVAJKcZwUyOIjEWWcRfYMbg
        EwTyKVeVeFBcNrpOtBfRelC5g5n3RGISKFcJqCY=
X-Google-Smtp-Source: ABdhPJxqTAFdj4xwRybxNDcnBHmxCVpbsb1EBOtYLIzJXgoRflds0tPSzDeltozIwJg7qIkM9OAv2cSCRis8Fzg3XL0=
X-Received: by 2002:a17:903:1110:b0:13f:d25c:eac5 with SMTP id
 n16-20020a170903111000b0013fd25ceac5mr27782561plh.5.1635322438192; Wed, 27
 Oct 2021 01:13:58 -0700 (PDT)
MIME-Version: 1.0
Sender: florentmarois953@gmail.com
Received: by 2002:a05:6a20:1d06:b0:51:c25f:a855 with HTTP; Wed, 27 Oct 2021
 01:13:57 -0700 (PDT)
From:   "Dr. Hamza Kabore" <hamzakabore97@gmail.com>
Date:   Wed, 27 Oct 2021 01:13:57 -0700
X-Google-Sender-Auth: ZMEEp9HYAUYcaJS07ukqcbFtrOg
Message-ID: <CAAHQvRexDycVhRnZ8wTvEvDPsPHWZ2CxjnWCpM6pUn6z9quDdw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,

Greetings and hope this email finds you well?

I am Dr. Hamza Kabore, the  chief Medical consultant at a reputable
clinic here in Ouagadougou, Burkina Faso and I have a Patient who
hails from the Republic of philippines but unfortunately is in Coma
right now due to complications from a Cancer disease and she has the
sum of $10.7 Million United States (Ten Million seven Hundred
Thousand) Dollars she wants me to guide you on, so that her Bank can
transfer it to you for charity purposes.

Please, I will like you to contact me on this email
(hamzakabore97@gmail.com) for further details as this is a very
sensitive issue that needs urgent attention from you and I want to
maintain the promised I made to the woman before she entered Coma,
never to betray her by looking for another person other than you that
she choosed and selected for the offer among the people she got their
email contacts in her quest for an honest person oversea to help her
wholeheartedly in handling this project to fulfill her wish.

Best Regards,

Dr. Hamza Kabore on behalf of
Mrs. Sismer Shirley Acojedo
