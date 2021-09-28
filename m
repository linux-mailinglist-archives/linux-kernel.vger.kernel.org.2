Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B741B7C7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242553AbhI1TxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbhI1TxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:53:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75DAC061749
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:51:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x7so72765746edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=bIEnocFRtneXYJ0fHHwX1J2ddQaMD/rrUCnpD/BupmA=;
        b=nuE9fNgZ7qFoihKhXYrtr72Y47rfzcsMuyGXk8hzSd8ZN1alhXva9+NFCk7scuX1fQ
         HvhKH6hK9WmyB9bpTTbHAz6M9sD2DEpxYhBTLBnOnw7FN2o0+5kdepde/CxyG43E5zJ/
         2IwBCwPPBPITcNHWNQJjHIFGBGY2FD5VOL7xjzOKJpTkiBOWR1KOVqy0HuLC8jjSI2It
         UExszG+BcUfEAaMaRnZeX2G1ccSHXWLCtZe3aWg+YByezBJEeVvyp1OWqEQcJJN635oH
         q5JtCxYZEoy4egrSxbKiFJ1AtEbU66rN7uujsnCud8rAkrv4WH1beOvGptFLYv/GF+uu
         XnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=bIEnocFRtneXYJ0fHHwX1J2ddQaMD/rrUCnpD/BupmA=;
        b=QB9i3MDzQJdSoj2t/DiR5RcfwHH6mo+OlB4THkgmzYFOjpY77DSz6lCVsD1wLgPg+1
         3NA7k4TyR50IAjJ0YuIe29ezKmqYcH3w4h7eE0iQ7HfqgnJqXfNY67j53Axv7059yX9r
         7KjtGzG8h01mY9QsbXqpivbi2cw+UnncFbfQUDhwfMPwkmT7766BXvO24dhraHU3lBId
         XOelDYN5mBIBtwbAFz1gCbXDIOzJNj0FZGLxJyPYp7SSgsQC5mNMUxJ4Q+iHub5SphXn
         c6Ltmiy1qVa6Ud4RyGF7s11wsf4TgqFlrt1JDy+oqyzdWJz0Dw/6lnq+qRf7JjbCsSeD
         KOUw==
X-Gm-Message-State: AOAM533ZqjFs/QaU1JhGox3Tv3x7hNv5djWLhk6hBulUJYur7GwB3+lK
        7N2m3q5o9itiKg4MNFLUVk8isPWz4dz73GQw3P8=
X-Google-Smtp-Source: ABdhPJzJCyk6DGHiVw7H19hgduOwAThXvxCVwom6DykPON842GuyHAbw8wnc52Y+DWmBmIveRzUI11xX9MCnzHQAHFk=
X-Received: by 2002:a17:906:38ce:: with SMTP id r14mr8847643ejd.268.1632858697345;
 Tue, 28 Sep 2021 12:51:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:9607:0:0:0:0 with HTTP; Tue, 28 Sep 2021 12:51:36
 -0700 (PDT)
Reply-To: wwwheadofficet@gmail.com
In-Reply-To: <CACRybBZ3ev8a6juUkdUJsXVAepAvbRYrG2FhZVcAuiiLVZsguw@mail.gmail.com>
References: <CACRybBbL7R7Ro83QcWZM6a5K9iA1TFVZep=JU6-M-MBsNhwyKw@mail.gmail.com>
 <CACRybBZ3ev8a6juUkdUJsXVAepAvbRYrG2FhZVcAuiiLVZsguw@mail.gmail.com>
From:   "wwwheadofficet@gmail.com" <infowunion2@gmail.com>
Date:   Tue, 28 Sep 2021 19:51:36 +0000
Message-ID: <CACRybBbDCef4X9G6ay=VNkfLu3hamGaB6XsWafVBWz1+9qL-Pg@mail.gmail.com>
Subject: Bnk
To:     infowunion2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Our office contact, 2554 Road Of Kpalime Face Pharmacy Bet, Lome, Gulf.

This is WU bank director bring notice for you that  International
monetary fund (IMF) who compensation you sum of $850,000.00 because
they found your email address in the list of scam victim . Do you
willing to get this fund or not?

We look forward to hear from you urgently.

Yours faithfully
 Tony  Albert
 BANK DIRECTOR
Whatsapp, +22870077685
