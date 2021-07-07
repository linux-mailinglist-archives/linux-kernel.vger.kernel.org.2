Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237103BE9C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 16:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhGGOd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhGGOdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:33:54 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5440C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 07:31:12 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i18so3395322yba.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=ntBSEyFRG5I/qvdfCDZ2UEG+bk7oEzPknG/513aF3fA=;
        b=uzT4sraP6RxAv08cyFUhocZV7sCkukeg8KhzVTzRjhoAgXHWjWos85NZ208pUDvUr2
         xckhpX7dWPlEpE4bCKES55boCA/c+uY3pXCk1EYOl1kL4wclwGRv5zyQzl+lRr6GJKq6
         RGY7Lt3meuSuRM5qGJOG3UmhJKqlpiRrNmWla0xV4IkwqmfNmUkSXBTUm6k6wUe3rgLu
         x6qAsW8wr/Keg+w4eMqWiMWCHzRmxagZAdf7wkcAgfFm9SVPZdl4AY7oZGEfhnIPZrTz
         0l7Vz5zUaPiFfjr5pLs6HmutrQ1DUF3MIyKIUdeqjsO2oSf8vESkP0XXl/ywmaB2JbyO
         3EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=ntBSEyFRG5I/qvdfCDZ2UEG+bk7oEzPknG/513aF3fA=;
        b=TSe1WLMIw+woCuPsoEdb9rN08YY5X2xnW8t6ZABFys1sk+e3Nsv9jq/3C+JHM5ZRYv
         vhjo+sesRtRonY3TOg3z5nO/ErzdNFA5R6iJ3cnjTZ+FrANYVgfe04jc4Yp4wDdSsR2S
         Ea4ERXkzaU9Y5hUsjm3xnyYZYZStktRIcvfjREg80MsKNpPSSPXgY1wRbqO3rMCJ3ZUy
         YqBRZ7l9xUK5dW02ZDt8Hvy9UlSGJdUd1sIxADdr/fSXbUIIGg/5FFx+VZmQ3Rkb+ioW
         PF2txLkdyRIGmsu5ZAIokJcK8ha7PoiVwJ3S62rcvU83lcnr4hn0oRLYixkX35iaxqz8
         it+Q==
X-Gm-Message-State: AOAM5323/cmS9v99FbV5vw9Skhn6ic0BCkZJpuzJN9BM//XRTURA7ZVt
        90DT8X/cuJhFKeVIBi+YRXuwQr3z4Pf80cJEDfc=
X-Google-Smtp-Source: ABdhPJxC03107lcRyvyy163+UxRZY6yuDlABE8uV60NCxxwwLHmr204mtojdoGCr+1khv5O3slNzD0yjBzSwSAFJlyU=
X-Received: by 2002:a25:6c0a:: with SMTP id h10mr30935983ybc.167.1625668271454;
 Wed, 07 Jul 2021 07:31:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:3d9c:b029:bd:e1bb:19f with HTTP; Wed, 7 Jul 2021
 07:31:10 -0700 (PDT)
Reply-To: comlaclement120@gmail.com
In-Reply-To: <CADN868uOeoitYT6qZvDcYX6--rawwQu-mxRdO1d04E9HxvqnoQ@mail.gmail.com>
References: <CADN868uOeoitYT6qZvDcYX6--rawwQu-mxRdO1d04E9HxvqnoQ@mail.gmail.com>
From:   comla clement <basiliajloveusa@gmail.com>
Date:   Wed, 7 Jul 2021 14:31:10 +0000
Message-ID: <CADN868ug=dCCYrxd0_Rfqb4VAWq=RCWiDCr_GLLnfxHsraL0NQ@mail.gmail.com>
Subject: saludos,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mis saludos para ti amigo m=C3=ADo espero que est=C3=A9s bien y bien por fa=
vor
respondeme gracias,
