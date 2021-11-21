Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103D345817C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 03:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbhKUCZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 21:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbhKUCZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 21:25:07 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A67AC06173E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 18:22:03 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 28so11976323pgq.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 18:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dcLX5XSyAj/Z/Yrsc0ArVVJPNOvo1GGT6lVIrGqLj3k=;
        b=FZYsjKkMFtA3yngT9XxzmB6an6BxsOv1PcveRaSID0XAqZ1it3EqzUTzGzsJHoVzEo
         1j/DHrF6hOlhknt+2M6o/Itgs1tIuZd4fLaDC7sSyJDdD8h5OwverqtWxX1z8H3AJ1Vr
         g4yyt2KE04jQ08YVF7raDNXsgWcC4yHYS68A2YzcScEl3jm6jF1R2WakeidyOdt8lv9w
         GttuCzXqqnkWeoxsCrNLZV3InxaL1tctX5D4t8/4uatsJTb/e3HYHj23CcZIoLvRwUdC
         YRgkKW2ykoX95q2e1cBoNywohTrY/BDou5UrvzYkqn+cVYemk8cK6qm8h62WNhkdPCKT
         fAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=dcLX5XSyAj/Z/Yrsc0ArVVJPNOvo1GGT6lVIrGqLj3k=;
        b=AHi/f2oB1QON30n1D4QUX4CVvN6MXpmqNQQ/dbvWX5uG5g8XXEF2LM+OJ/Z7akmNgF
         dHC24ygS0S65zHnxFWRS8kRpZHrMFeS+ZfFORcrV72LwID0jopE3gIGFBPsJY2v03lCR
         2NydvR5HEn88ifCzP57Xv/DkkYwxvwsIkIIsCiVB26lfD4Btv4iU/DleHs6yMm/ims0v
         F9nNqvrwpX5ntYTn3YitQi/SJz6UTzA9blbstfe44uXbx1usMMMzEavY0KA/8oy3gTwC
         ZocG4taqRMdYO9b+gANiJViCIyaDPCrqcwxGOgsgEXwUNXZna0mLhVlzYt4CT4ZPT+7C
         jCWA==
X-Gm-Message-State: AOAM530zlit6Ybz+447C1i4kzYUkiyPuoM6N4eMSjccb8sVRBxMy2cLC
        0QemiECqeNk4wqtIXT6oDHn05LamUw3QkhrLSm8=
X-Google-Smtp-Source: ABdhPJzxk7i9XXZXTO9AXkywAIIYTWd5u6uvC+9nKdvesVdHbMtswD553fgmUE3z8jURM823zb6RylhthQSlf5Sx8cI=
X-Received: by 2002:a63:914c:: with SMTP id l73mr4344824pge.184.1637461322492;
 Sat, 20 Nov 2021 18:22:02 -0800 (PST)
MIME-Version: 1.0
Reply-To: sgtkaylamanthey612@gmail.com
Sender: reineassibi403@gmail.com
Received: by 2002:a05:6a10:8c03:0:0:0:0 with HTTP; Sat, 20 Nov 2021 18:22:02
 -0800 (PST)
From:   Kayla Manthey <sgtkaylamanthey612@gmail.com>
Date:   Sun, 21 Nov 2021 02:22:02 +0000
X-Google-Sender-Auth: gQnsD478MCJlNTeGBIYPxEFpTUs
Message-ID: <CA+j7dZpF_SmMUPAV7OJckq4erykjAiHa0BosmMaXOY5NwRuxdg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoj, dostali si moje dva predch=C3=A1dzaj=C3=BAce emaily? pros=C3=ADm skon=
trolujte a
odpovedzte mi.
