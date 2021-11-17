Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A49453D02
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 01:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhKQADv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 19:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhKQADt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 19:03:49 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E889FC061570;
        Tue, 16 Nov 2021 16:00:51 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id b17so2058285uas.0;
        Tue, 16 Nov 2021 16:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Z4JQefn6FAIzwhnnoXs4XdXDWXlfX4mecu+++W1paSg=;
        b=GkvVTeLFXPLAEnRshHli2RPM+LeUbfYfX2X6ualWGn+IJjn8lBHVLkooIEdaNraSme
         flzf+fDQgmy7KhgSyeCyK/X8k9tRcavwHYTIMHSDIpO0iBKrKq+6uOiE/eH17yvqFdwx
         rcY58PyDKtUhfMW1vQT1d19+5wsSqqkLP0USrfTSW5DIvIRUACkGmC/cHTrTBZtgPOvy
         C4OMs2K+7E0ry4X4RmTUJDe2GVubgkKJoF0bBMSuCi5UVE04eRgOm3p7RrrECP1ODUiJ
         T/NadM5BgGYMI2yo+ZCYwR/orZcj3pTqRwhR3RoQ+lt8OxMRCkiKm39yzaZcI6Na7/Jg
         qmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Z4JQefn6FAIzwhnnoXs4XdXDWXlfX4mecu+++W1paSg=;
        b=As4t2qJRZtgkAPdRBrYZLgFFNIYrvJUVSnIzVqq4nheslZSzcsCl2h5U0eKdTml/Cg
         TSMjb+1wD2wOgmCiBNOsaTLGNL7RUyoguNtfNmsc63/B0KCbzscduVDefJMH/X38xQMJ
         fM0pzidfRkmpkIR78oIuwPg9JAuDO9U9I958i/jBUtGCVvaYFD5Mq8mXcKhQRQYWLjqQ
         6yaQXjbu9kE9OsfVKC63nkWDGT80ltu2sllYwNWxaWx0NFglaHPYk/SW7pixykCvTAqE
         g9rnOR0YKV12i+rJGAsbXmwDEpl4iW1gdKSD5GCWNOJ3cuT01hOKoypRUDa00L5vm4KJ
         juRA==
X-Gm-Message-State: AOAM531n0vBLGaAdnhIk9H+NJV0UOt4NZ00SvKRiEy68qom5HY+YaY8m
        1YrmpOSxJhZ0yxNXieiS1Ha9eIYcCnpyNcShxYN65iUnXbg=
X-Google-Smtp-Source: ABdhPJwJ24ahv4s4pfL8qN7I2E3rK6OkkgttCcAi1PYkf/HRGDOww/8PjOcFh6ZzOGS1BhWV1MqU37NEYVj7H4hPRmo=
X-Received: by 2002:a05:6102:a46:: with SMTP id i6mr61836839vss.19.1637107250953;
 Tue, 16 Nov 2021 16:00:50 -0800 (PST)
MIME-Version: 1.0
From:   mhnx <morphinwithyou@gmail.com>
Date:   Wed, 17 Nov 2021 03:00:40 +0300
Message-ID: <CAE-AtHpv9qq=Bwgpri2OcS2LKfM6UcYDGB06vShwfgfZXXw5Sg@mail.gmail.com>
Subject: I'm want to develop usb/ip protocol for new features
To:     linux-kernel@vger.kernel.org, usbip-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I need to improve the USB/IP protocol for a project and it seems like
the USB/IP project is old and dead now. Development looks like
finished or abandoned few years ago.
This project needs changes, features and a new optimised /improved
version for my usage and I'm willing to work on it.

I'm not familiar yet and I'm in the learning process.
I don't know Is there any way to do Callback Connection (Client to
server) with the latest version. I couldn't find any doc or usage
about it.

- What is the callback connection?
It allows to connect USB devices to remote USB Client located behind
NAT or Firewall. This is accomplished by swapping the server and
client roles. In normal situation, USB client initiates a connection.
With Callback Connection, it is a USB Server who initiates a
connection.

If the Callback Connection is possible please let me know.

Best regards.
